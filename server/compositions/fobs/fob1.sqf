/*
Grab data:
Mission: front_defence
World: WL_Rosche
Anchor position: [6886.17, 14923.4]
Area size: 150
Using orientation of objects: no
*/

/*
[[6364.04, 13528.2, 64.74], 150, false] call BIS_fnc_objectsGrabber;

TODO:
> respawn needs to be renamed to respawn_west in this file
> vehicle respawn needs to be renamed to vehicle_respawn_west in this file
> vehicles should be spawned on available CUP_A1_Road_VoidPathXVoidPath's
> 
*/

private _things_to_delete = [OTHER_FLAG1, INITIAL_CRATE, OTHER_FLAG, OTHER_TABLE, OTHER_LAPTOP, respawn_west, respawn_vehicle_west];

deleteMarker "fob_marker";
{
	deleteVehicle _x;
} forEach _things_to_delete;

params["_pos"];

//////// Start Composition ////////////////////////////////////////////////////////

_composition = [
    [
        "Land_HBarrierWall6_F",
        [
            -2.41211,
            -1.93359,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall6_F",
        [
            5.91553,
            -1.67969,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall_corner_F",
        [
            -8.03027,
            -3.67773,
            0
        ],
        270.636,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall6_F",
        [
            -9.21533,
            -11.0186,
            0
        ],
        273.088,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall_corner_F",
        [
            13.3345,
            -2.67969,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall6_F",
        [
            15.0732,
            -8.16211,
            0
        ],
        90.9902,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall6_F",
        [
            -9.1748,
            -19.4883,
            0
        ],
        271.272,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall_corridor_F",
        [
            16.4004,
            -15.0459,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrier_1_F",
        [
            21.4434,
            -12.3535,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall6_F",
        [
            15.4927,
            -21.0732,
            0
        ],
        90.9902,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierTower_F",
        [
            27.0415,
            -14.875,
            0
        ],
        270.253,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall_corridor_F",
        [
            -10.4478,
            -25.6436,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrier_1_F",
        [
            21.5073,
            -17.9805,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall6_F",
        [
            0.0981445,
            -30.6758,
            0
        ],
        181.525,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall6_F",
        [
            8.59033,
            -30.4707,
            0
        ],
        178.408,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall_corner_F",
        [
            -7.44678,
            -29.7373,
            0
        ],
        179.223,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierWall_corner_F",
        [
            14.4561,
            -28.6182,
            0
        ],
        88.9796,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -31.5005,
            -11.7109,
            0
        ],
        270.748,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -34.7832,
            -6.56055,
            0
        ],
        183.007,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -43.3169,
            -6.39648,
            -0.000179291
        ],
        181.352,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -49.8208,
            -6.36328,
            -0.000911713
        ],
        182.105,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -31.959,
            -38.7246,
            0
        ],
        271.829,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -35.1816,
            -44.1611,
            0
        ],
        180.321,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -58.3003,
            -6.41309,
            -0.0014801
        ],
        180.321,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -43.7773,
            -44.2617,
            0
        ],
        182.255,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -66.9282,
            -6.51367,
            -0.00204468
        ],
        182.255,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -52.1895,
            -44.1904,
            -0.000236511
        ],
        182.256,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -60.7007,
            -44.0752,
            0.00056076
        ],
        182.619,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -75.3003,
            -6.41602,
            3.8147e-06
        ],
        182.256,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -66.5518,
            -43.9277,
            7.62939e-05
        ],
        180.321,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -83.8193,
            -6.30957,
            3.8147e-06
        ],
        182.619,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -75.104,
            -44.0088,
            0.00209427
        ],
        182.256,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -92.0566,
            -6.18262,
            0
        ],
        182.619,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -83.5068,
            -43.9541,
            0.000801086
        ],
        182.256,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -99.8218,
            -6.19727,
            -9.53674e-05
        ],
        0.393953,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -92.0259,
            -43.8584,
            0
        ],
        182.619,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -103.041,
            -11.6318,
            -0.000896454
        ],
        91.9004,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -100.271,
            -43.7969,
            0
        ],
        3.08011,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_HBarrierBig_F",
        [
            -103.547,
            -38.6426,
            0
        ],
        90.8208,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -24.6411,
            -5.73438,
            -1.14441e-05
        ],
        271.154,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -28.0894,
            -2.18457,
            -1.14441e-05
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -24.772,
            -13.5811,
            -1.14441e-05
        ],
        271.154,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -35.9165,
            -2.17969,
            -1.14441e-05
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -43.707,
            -2.11035,
            -0.00675583
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -24.981,
            -37.0732,
            -1.14441e-05
        ],
        270.251,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -25.0601,
            -44.9756,
            -1.14441e-05
        ],
        270.251,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -51.5649,
            -2.07715,
            0.00985718
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -28.6313,
            -48.5732,
            -1.14441e-05
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -59.3896,
            -2.05371,
            0.00709534
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -36.4644,
            -48.5674,
            -1.14441e-05
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -44.2827,
            -48.4209,
            -1.14441e-05
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -67.2939,
            -1.97754,
            0.11462
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -52.0947,
            -48.3857,
            0.00745392
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -75.0322,
            -1.9043,
            0.0056076
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -59.9375,
            -48.3906,
            -0.000148773
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -82.8809,
            -1.86133,
            -6.10352e-05
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -67.8281,
            -48.3008,
            -0.0634346
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -75.6343,
            -48.1787,
            -0.0697021
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -90.7148,
            -1.82422,
            0.00252914
        ],
        180.191,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -83.437,
            -48.1719,
            -0.0426369
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -98.5313,
            -1.82031,
            -0.00799942
        ],
        180.428,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -91.2627,
            -48.1768,
            -1.14441e-05
        ],
        0.354801,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -106.35,
            -1.83398,
            -0.0721817
        ],
        180.428,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -109.928,
            -5.40918,
            0.127151
        ],
        90.3242,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -99.1431,
            -48.1787,
            -1.14441e-05
        ],
        0.264131,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -110.029,
            -13.2744,
            0.0290947
        ],
        90.3242,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -110.273,
            -36.7637,
            -1.14441e-05
        ],
        91.2265,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -106.97,
            -48.165,
            -1.14441e-05
        ],
        0.264131,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Mil_WiredFence_F",
        [
            -110.414,
            -44.6094,
            -1.14441e-05
        ],
        91.2265,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -39.8164,
            -17.7061,
            3.8147e-06
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -40.0215,
            -28.9014,
            3.8147e-06
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -48.7637,
            -17.6904,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -39.7827,
            -41.0977,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -48.9688,
            -28.8857,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -56.3569,
            -17.7041,
            3.8147e-06
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -48.73,
            -41.082,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -56.562,
            -28.8994,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -56.3232,
            -41.0957,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -71.1416,
            -17.4805,
            3.8147e-06
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -71.3467,
            -28.6758,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -71.1079,
            -40.8721,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -80.0889,
            -17.4648,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -80.2939,
            -28.6602,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -80.0552,
            -40.8564,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -87.6821,
            -17.4785,
            3.8147e-06
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -87.8872,
            -28.6738,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A1_Road_VoidPathXVoidPath",
        [
            -87.6484,
            -40.8701,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['DESCRIPTION', 'Experimental, Dynamic Vehicle Spawn-Points', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Cargo_Tower_V1_No1_F",
        [
            5.09277,
            -22.5732,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "FlagCarrierRedCross_EP1",
        [
            12.0864,
            -7.56348,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Laptop_device_F",
        [
            1.69336,
            -7.41699,
            -3.8147e-06
        ],
        180,
        1,
        0,
        [],
        "FOB_TELEPORTER",
        "[this, true, [0,1,1], 0, true] call ace_dragging_fnc_setCarryable;this setVariable ['DESCRIPTION', 'Our FOB teleporter / Command Terminal', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        true
    ],
    [
        "B_supplyCrate_F",
        [
            -3.34961,
            -7.52148,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "[this, true] call ace_arsenal_fnc_initBox;this setVariable ['DESCRIPTION', 'Ace Arsenal Crate', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "US_WarfareBVehicleServicePoint_Base_EP1",
        [
            -11.8516,
            -5.09473,
            0
        ],
        0,
        1,
        0,
        [],
        "FOB_SERVICE_POINT",
        "this setVariable['ACE_isRepairFacility', true, true];this setVariable ['DESCRIPTION', 'Multipurpose Service Point (crates, repair facility)', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "Land_Cargo_House_V1_F",
        [
            7.77979,
            -7.84668,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['ace_medical_isMedicalFacility', true, true];this setVariable ['DESCRIPTION', 'Medical Facility Inside of FOB, can also pull static weapons from it (code is clientside and may change soon).', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "B_Slingload_01_Repair_F",
        [
            -11.854,
            -13.7676,
            0
        ],
        180.331,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_6konec",
        [
            -17.8931,
            3.85547,
            0
        ],
        181.479,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "B_Slingload_01_Fuel_F",
        [
            -11.856,
            -20.125,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "[this, 100] call ace_refuel_fnc_makeSource;this setVariable ['DESCRIPTION', 'Huron Fuel Tank', true];this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_0_2000",
        [
            -18.1528,
            -19.8213,
            0
        ],
        0,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "FlagCarrierUSA",
        [
            -11.7437,
            -29.1729,
            0
        ],
        87.9399,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "FlagCarrierGermany_EP1",
        [
            -11.6807,
            -29.9219,
            0
        ],
        87.9399,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_22_50",
        [
            -14.1821,
            -38.9141,
            0
        ],
        337.142,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_60_10",
        [
            -28.4229,
            -24.4971,
            0
        ],
        88.1943,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_6konec",
        [
            -16.2842,
            -34.501,
            0
        ],
        328.097,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_6konec",
        [
            -34.668,
            -24.6338,
            0
        ],
        88.6528,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_10_25",
        [
            -12.1865,
            -42.7891,
            0
        ],
        327.281,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_6konec",
        [
            -8.7876,
            -48.0205,
            0
        ],
        327.238,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_6konec",
        [
            -100.251,
            -25.2529,
            0
        ],
        270.622,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ],
    [
        "CUP_A2_Road_grav_6konec",
        [
            -112.748,
            -25.1221,
            0
        ],
        90.5098,
        1,
        0,
        [],
        "",
        "this setVariable ['IS_FOB', true, true];this allowDamage false;",
        true,
        false
    ]
];

_composition = _composition + [
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
];

//////// End Composition ////////////////////////////////////////////////////////


fnc_hasObstruction = {
	params["_pos", ["_radius", 1]]; // Default Radius: 1 meter
	_hasObstruction = false;
	private _nearbyObjects = nearestObjects [_pos, [], _radius];
	systemChat format ["NEARBY OBSTRUCTIONS: %1", _nearbyObjects];
	if ((count _nearbyObjects) > 1 ) then {
		_hasObstruction = true;
	};
	_hasObstruction
};

fnc_getEmptySpawnPad = {
    private _padPos     = false;
    {
        if (typeOf _x isEqualTo "CUP_A1_Road_VoidPathXVoidPath") then {
			systemChat format ["Obstructed: %1", [getPos _x, 5] call fnc_hasObstruction];
            if !([getPos _x, 5] call fnc_hasObstruction) then {
                _padPos = getPos _x;
                break;
            };
        };
    } forEach allMissionObjects "";
    _padPos
};

profileNameSpace setVariable ["SAVED_FOB_LOCATION", [_pos select 0, _pos select 1, _pos select 2]];
missionNameSpace setVariable ["FOB_LOCATION", [_pos select 0, _pos select 1, _pos select 2], true];

[_pos, 0, _composition, 0] call BIS_fnc_objectsMapper;

private _marker = createMarker ["fob_marker", [_pos select 0, _pos select 1]]; // Not visible yet.
_marker setMarkerType "hd_flag"; // Visible.
_marker setMarkerColor "ColorYellow"; // Blue.
_marker setMarkerText "FOB Alpha"; // Text.

publicVariable "FOB_LOCATION";


// Hotfix for cleaning out nullobjs
_vehClean = [];
_vehicles = [] call fnc_getPurchasedVehicles;
{
    if (typeName _x == "STRING") then {
        _vehClean pushBack _x;
    };
} forEach _vehicles;
[_vehClean] call fnc_setPurchasedVehicles;

// Spawn Purchased Vehicles
private _initScript = "";
{
    // Pop the first available spawn pad from the array of spawnpads
    private _padPos = [] call fnc_getEmptySpawnPad;
    private _randomPosOverflow = [FOB_LOCATION, 1, 100, 5, 0, 20, 0] call BIS_fnc_findSafePos;
    private _finalPos = [];

    if (typeName _padPos != "BOOL") then 
    {
        _finalPos = _padPos;
        systemChat format ["Spawning vehicle %1 on pad: %2", _x, _padPos];
    } else {
        _finalPos = _randomPosOverflow;
        systemChat format ["Spawning vehicle %1 (overflow area): %2", _x, _randomPosOverflow];        
    };

    _vehicle  = _x createVehicle _finalPos;

    // Post-Processing the vic
    // VEHICLES ARE PART OF FOB! 
    // In order for fob to be moved (deleted & rebuilt) all vehicles will also be deleted and rebuilt.
    // Good incentive to prevent FOB location-change spamming by HQ.  
    [_vehicle] execVM "server\asset.sqf";

} forEach ([] call fnc_getPurchasedVehicles);