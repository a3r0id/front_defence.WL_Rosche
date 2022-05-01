# Mission Editor Prerequisites:

- Create Initial Respawn Point - IE: `respawn_west`. [Respawn](https://community.bistudio.com/wiki/Arma_3:_Respawn)

- Create Zeus Gamemaster module - #adminLogged.

- (Optional) Multiplayer Settings: Set Gamemode to Capture The Island.

- (Optional) Multiplayer Settings: Disable AI.

- (Optional) Multiplayer Settings: Respawn Options: Allow respawn on custom position. (optional)

- Add an object w/ classname consistent w/ the COMMANDER_TERMINAL variable. This object will be used by the commander to create the first FOB. It is recommended to use the default `Land_Laptop_device_F`.

- [i] Any vehicles that are added via mission editor will NOT be persistent!

- If you add new BLUFOR units, be sure to set their control to "playable" and disable AI.


# File Changes:

> initPlayerLocal.sqf
- Change `COMMANDER_NAME` to your desired name.
- (Optional) Change `COMMANDER_TERMINAL` to your desired object. Default: `Land_Laptop_device_F`. This is what command will use to do FOB/FOP actions. Other units can also use this to teleport to the current Forward Outpost (FOP).

------------------------------------------------------

> server/compositions/fobs/fob.sqf
- (Optional) Change `COMMANDER_TERMINAL` to the same classname as `initPlayerLocal.sqf`.

------------------------------------------------------

> initServer.sqf
- Change `RESTART_MISSION` to true. [i] ONCE RAN AS TRUE, CHANGE TO FALSE TO REMAIN PERSISTENT AFTER RESTART!

- Change `DEBUG` to false to disable debug messages and extra map markers.

- Change `MAX_ACTIVE_SECTORS` to the maximum number of sectors allowed to be active at any given time.

- Change `MAX_PEDESTRIANS` to the number of pedestrians you want to have active at any given time.

- Change `MAX_MOTORISTS` to the number of motorists you want to have active at any given time.






