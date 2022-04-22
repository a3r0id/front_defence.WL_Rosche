# Mission Editor Prerequisites:

- Create Initial Respawn Point - IE: `respawn_west`. [Respawn](https://community.bistudio.com/wiki/Arma_3:_Respawn)

- Create Zeus Gamemaster module - #adminLogged.

- Multiplayer Settings: Set Gamemode to Capture The Island.

- Multiplayer Settings: Disable AI.

- Multiplayer Settings: Respawn Options: Allow respawn on custom position.

- Name an object `FOB_TELEPORTER`. This is so we can teleport players to the FOB and add addactions to it. This is your INITIAL FOB until you set one up. Once a new FOB is set up, the old teleporter will be deleted and a new one (us_flag) will be created at the new FOB.

- [i] Any vehicles that are added via mission editor should contain `[this] setVariable ["IS_ASSET", true]` in their init.

- Spawn your BLUFOR units and set their control to "playable" and disable AI.


# File Changes:

> initPlayerLocal.sqf
- Change `COMMANDER_NAME` to your desired name.

------------------------------------------------------

> initServer.sqf
- Change `RESTART_MISSION` to true. [i] ONCE RAN AS TRUE, CHANGE TO FALSE TO REMAIN PERSISTENT AFTER RESTART!

- Change `DEBUG` to false to disable debug messages.

- Change `MAX_ACTIVE_SECTORS` to the number of sectors you want to have active at any given time.

- Change `MAX_PEDESTRIANS` to the number of pedestrians you want to have active at any given time.

- Change `MAX_MOTORISTS` to the number of motorists you want to have active at any given time.

- Change `IS_FRONT_DEFENCE` to true if you want to use the front defence system (default is true). Some features, including civilians, will not work if this is false.

> fob.sqf
- Add anything to array (editor variable name/vehicle object etc..): `_things_to_delete` that you want deleted when the FOB is deployed.






