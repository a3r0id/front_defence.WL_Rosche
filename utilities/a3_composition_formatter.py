from json import dump, loads, dumps

### // USAGE // ###
# > Edit MACRO_INIT, MACROS and COMMON_GROUPS in your input file.

# > Edit/create a format file in `composition_formatter/formats/` or use my default example `composition_format_fob.json`.

# > Paste the output array from  `BIS_fnc_objectsGrabber` into file `composition_formatter/in/comp_in.txt`. 
# # https://community.bistudio.com/wiki/BIS_fnc_objectsGrabber

# > Run the script.

# > Output files:
# - composition.json: Json array of your formatted composition array.
# - spawn_composition.sqf: Exec-ready script to spawn your modified composition; PRE_SPAWN_SCRIPT/POST_SPAWN_SCRIPT can be used to add custom code before or after the composition is spawned.
# -- Params: _pos ARRAY, _azimuth NUM, _composition ARRAY, _chance FLOAT;
# - composition_variable.sqf: Script-ready defined variable, simply copy-paste or add the file as a whole to your mission scripts to create a global variable.
### // END USAGE // ###

### // SETTINGS // ###
ROOT_DIR          = "utilities/composition_formatter/"
INPUT_FORMAT      = ROOT_DIR + "formats/composition_format_fob.json"
INPUT_FILE        = ROOT_DIR + "in/comp_in.txt"
ADD_DESCRITPION   = True # Save description defined in macros to object's nameSpace. Example: `_description = _objectSpawnedFromComp getVariable ["DESCRIPTION", "N/A"];`
PRE_SPAWN_SCRIPT  = """_composition = _composition + [
    [
        "ModuleRespawnPosition_F",
        _pos,
        0,
        1,
        0,
        [],
        "respawn_west",
        "",
        true,
        false
    ],
    [
        "ModuleRespawnVehicle_F",
        _pos,
        0,
        1,
        0,
        [],
        "respawn_vehicle_west",
        "",
        true,
        false
    ]
];"""
POST_SPAWN_SCRIPT = ""
### // END SETTINGS // ###

with open (INPUT_FORMAT, "r") as f:
    FORMAT = loads(f.read())

GROUPS        = [[] for i in range(len(FORMAT["COMMON_GROUPS"]))] # Pre-allocate the groups array.
NON_GROUPED   = []

with open (INPUT_FILE, "r") as f:
    t = f.read().replace("\"\"", "\"")
    objects_json  = loads(t)

for object in objects_json:
    
    """
    INFO: https://community.bistudio.com/wiki/BIS_fnc_objectsGrabber#:~:text=The%20format%20of%20each%20entry%20is%20as%20follows%3A
    0: STRING	- Classname
    1: ARRAY	- Position [delta X, delta Y, z]
    2: NUMBER	- Azimuth
    3: NUMBER	- Fuel
    4: NUMBER	- Damage
    5: ARRAY	- Return from BIS_fnc_getPitchBank (only if 2nd param is true)
    6: STRING	- vehicleVarName
    7: STRING	- Initialization commands
    8: BOOLEAN	- Enable simulation
    9: BOOLEAN	- Position is ASL
    """
    
    classname = object[0]
    position  = object[1]
    azimuth   = object[2]
    fuel      = object[3]
    damage    = object[4]
    pitchbank = object[5]
    varname   = object[6]
    initscript= object[7]
    enablesim = object[8]
    posisASL  = object[9]
    
    # Set varname and init script for multiple objects by a classname substring
    for macro in FORMAT["MACROS"]:
        if macro["classname_substring"].lower() in classname.lower():
            
            if macro["overwrite_varname"]:
                varname = macro["varname"]
                
            if not macro["init_is_file"]:
                initscript += macro["init_string"]
            else:
                with open(macro["init_file_name"], "r") as f:
                    initscript += f.read()
                    
            if ADD_DESCRITPION and len(macro["description"]):
                initscript += "this setVariable ['DESCRIPTION', '" + macro["description"] + "', true];"
                    
    # Add the macro init
    initscript += FORMAT["MACRO_INIT"]
    
    # Replace classnames that apply to REPLACE_CLASSNAME (placeholder)
    for r in FORMAT["REPLACE_CLASSNAME"]:
        if r[0].lower() in classname.lower():
            classname = r[1]
                    
    # Group objects by common groups
    isGroupedItem = False
    group_index   = 0
    for sub in FORMAT["COMMON_GROUPS"]:
        if sub.lower() in classname.lower():
            isGroupedItem = True
            GROUPS[group_index].append([
                classname,
                position,
                azimuth,
                fuel,
                damage,
                pitchbank,
                varname,
                initscript,
                enablesim,
                posisASL
            ])
            break
        group_index += 1
    if isGroupedItem:
        continue
        
    # Add the object to the non-grouped list if it is not in a common group.
    if "rabbit_f" not in classname.lower(): # F**king rabbits...
        NON_GROUPED.append([
            classname,
            position,
            azimuth,
            fuel,
            damage,
            pitchbank,
            varname,
            initscript,
            enablesim,
            posisASL
        ])

# Output order:
# [group0, group0, group0, ..., group1, group1, group1, ..., group2, group2, group2, ..., item0, item1, item2, ...]

OUT = []
for group in GROUPS:
    OUT += group
    
OUT += NON_GROUPED

with open(ROOT_DIR + "out/composition.json", "w+") as comp:
    dump(OUT, comp, indent=4)
    
with open(ROOT_DIR + "out/composition_spawn.sqf", "w+") as comp:    
    comp.write(f"""
// Generated by composition_formatter.py - By A3R0 - github.com/hostinfodev
params["_pos", ["_azimuth", 0], ["_chance", 0]];
_composition = {dumps(OUT, indent=4)};
{PRE_SPAWN_SCRIPT}
[_pos, _azimuth, _composition, _chance] call BIS_fnc_objectsMapper;
{POST_SPAWN_SCRIPT}
""")
    
with open(ROOT_DIR + "out/composition_variable.sqf", "w+") as comp:    
    comp.write(f"""
// Generated by composition_formatter.py - By A3R0 - github.com/hostinfodev
_composition = {dumps(OUT, indent=4)};
""")    

print("DONE!")