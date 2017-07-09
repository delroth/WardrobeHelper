local o = mOnWardrobe
if o.additionalData == nil then o.additionalData = {} end
local a = o.additionalData

-- Difficulties: LFR, N, H, M, 10, 25, 10H, 25H
-- LinkDifficulties: LFR, N - default, H, M

---------------------------------------------------------------
--  WoD - Raids
---------------------------------------------------------------

a["Blackrock Foundry"] = {}
a["Blackrock Foundry"]["N"] = {items = {Trash = {119332, 119342, 119333, 119340, 119334, 119339, 119331, 119341}}}
a["Blackrock Foundry"]["H"] = {items = {Trash = {119332, 119342, 119333, 119340, 119334, 119339, 119331, 119341}}, linkDifficulty = "H"}
a["Blackrock Foundry"]["M"] = {items = {Trash = {119332, 119342, 119333, 119340, 119334, 119339, 119331, 119341}}, linkDifficulty = "M"}

a["Hellfire Citadel"] = {}
a["Hellfire Citadel"]["N"] = {items = {Trash = {124182, 124150, 124277, 124252, 124311, 124288, 124350, 124323}}}
a["Hellfire Citadel"]["H"] = {items = {Trash = {124182, 124150, 124277, 124252, 124311, 124288, 124350, 124323}}, linkDifficulty = "H"}
a["Hellfire Citadel"]["M"] = {items = {Trash = {124182, 124150, 124277, 124252, 124311, 124288, 124350, 124323}}, linkDifficulty = "M"}

a["Highmaul"] = {}
a["Highmaul"]["N"] = {items = {Trash = {119343, 119347, 119346, 119344, 119345, 119336, 119335, 119338, 119337}}}
a["Highmaul"]["H"] = {items = {Trash = {119343, 119347, 119346, 119344, 119345, 119336, 119335, 119338, 119337}}, linkDifficulty = "H"}
a["Highmaul"]["M"] = {items = {Trash = {119343, 119347, 119346, 119344, 119345, 119336, 119335, 119338, 119337}}, linkDifficulty = "M"}

---------------------------------------------------------------
--  MoP - Raids
---------------------------------------------------------------

a["Heart of Fear"] = {}
a["Heart of Fear"]["LFR"] = {items = {Trash = {86850, 86844, 86841, 86845, 86843, 86847, 86842, 86846, 86849, 86848}}}
a["Heart of Fear"]["10"]  = {items = {Trash = {86192, 86186, 86183, 86187, 86185, 86189, 86184, 86188, 86191, 86190}}}
a["Heart of Fear"]["25"] = a["Heart of Fear"]["10"]

a["Throne of Thunder"] = {}
a["Throne of Thunder"]["10"] = {items = {
  Trash = { 95207, 95208, 95224, 95223, 95210, 95209, 95221, 95219, 95211, 95212,
            95220, 95222, 95215, 95214, 95213, 95218, 95217, 95216},
  ['Shared Loot'] = { 95061, 95067, 95066, 95065, 95062, 95060, 95064, 95068, 95063,
                      95069, 95498, 95507, 95502, 95501, 95505, 95499, 95500, 95503,
                      95506, 97126, 95504, 95516}}}
a["Throne of Thunder"]["25"] = a["Throne of Thunder"]["10"]
a["Throne of Thunder"]["10H"] = {items = {
  ['Shared Loot'] = { 96607, 96609, 96608, 96612, 96613, 96614, 96615, 96618, 96617,
                      96616, 96621, 96606, 96620, 96604, 96619, 96602, 96611, 96603,
                      96610, 97127, 96605, 96622}}}
a["Throne of Thunder"]["25H"] = a["Throne of Thunder"]["10H"]
a["Throne of Thunder"]["LFR"] = {items = {
  ['Shared Loot'] = { 95863, 95865, 95864, 95868, 95869, 95870, 95871, 95874, 95873,
                      95872, 95877, 95862, 95876, 95860, 95875, 95858, 95867, 95859,
                      95866, 97129, 95861, 95878, 95961, 95962, 95965, 95963, 95971,
                      95970, 95966, 95959, 95972, 95973, 95960, 95967, 95976, 95975,
                      95974, 95979, 95978, 95968 }}}

a["Siege of Orgrimmar"] = {}
a["Siege of Orgrimmar"]["N"] = {items = {
  Trash = {113224, 113231, 113226, 113230, 113223, 113225, 113218,
           113220, 113221, 113222, 113227, 113228, 113219, 113229,
           105745, 105747, 105743, 105748, 105744, 105741, 105746,
           105742}}}
a["Siege of Orgrimmar"]["H"] = {items = {
  Trash = {113224, 113231, 113226, 113230, 113223, 113225, 113218,
           113220, 113221, 113222, 113227, 113228, 113219, 113229,
           105745, 105747, 105743, 105748, 105744, 105741, 105746,
           105742}}, linkDifficulty = "H"}
a["Siege of Orgrimmar"]["M"] = {items = {
  Trash = {113224, 113231, 113226, 113230, 113223, 113225, 113218,
           113220, 113221, 113222, 113227, 113228, 113219, 113229,
           105745, 105747, 105743, 105748, 105744, 105741, 105746,
           105742}}, linkDifficulty = "M"}
a["Siege of Orgrimmar"]["LFR"] = {items = {
  ['Shared Loot'] = {113224, 113231, 113226, 113230, 113223, 113225, 113218,
                     113220, 113221, 113222, 113227, 113228, 113219, 113229}}, linkDifficulty = "LFR"}

---------------------------------------------------------------
--  Cataclysm - Raids
---------------------------------------------------------------

a["Blackwing Descent"] = {}
a["Blackwing Descent"]["10"] = {items = {Trash = {59466, 59468, 59467, 59465, 59464, 59462, 59463, 63537, 63538, 68601, 59460}}}
a["Blackwing Descent"]["25"] = a["Blackwing Descent"]["10"]

a["The Bastion of Twilight"] = {}
a["The Bastion of Twilight"]["10"] = {items = {Trash = {60211, 60202, 60201, 59901, 59521, 59525, 60210}}}
a["The Bastion of Twilight"]["25"] = a["The Bastion of Twilight"]["10"]

a["Dragon Soul"] = {}
a["Dragon Soul"]["10"] = {items = {Trash = {78879, 78884, 78882, 78886, 78885, 78887, 78888, 78889, 78878, 77192, 77938}}}
a["Dragon Soul"]["25"] = a["Dragon Soul"]["10"]

a["Firelands"] = {}
a["Firelands"]["10"] = {items = {['Shared Loot'] = {71779, 71787, 71785, 71780, 71776, 71782, 71775},
  Trash = {71640, 71365, 71359, 71362, 71361, 71360, 71366}}}
a["Firelands"]["25"] = a["Firelands"]["10"]
a["Firelands"]["10H"] = {items = {['Shared Loot'] = {71778, 71786, 71784, 71781, 71777, 71783, 71774},
  Vendor = {71641, 71561, 71560, 71562, 71557, 71559, 71558, 71579, 71575}}}
a["Firelands"]["25H"] = a["Firelands"]["10H"]

---------------------------------------------------------------
--  Cataclysm - Dungeons
---------------------------------------------------------------

a["Blackrock Caverns"] = {}
a["Blackrock Caverns"]["N"] = {items = {Trash = {55790, 55789}}}

a["End Time"] = {}
a["End Time"]["H"] = {items = {Trash = {76154, 76156}}}

a["Grim Batol"] = {}
a["Grim Batol"]["N"] = {items = {Trash = {56219, 56218}}}

a["Halls of Origination"] = {}
a["Halls of Origination"]["N"] = {items = {Trash = {56109}}}

a["Hour of Twilight"] = {}
a["Hour of Twilight"]["N"] = {items = {Trash = {76160, 76161}}}

a["Lost City of the Tol'vir"] = {}
a["Lost City of the Tol'vir"]["N"] = {items = {Trash = {55882}}}

a["The Stonecore"] = {}
a["The Stonecore"]["N"] = {items = {Trash = {55824, 55822, 55823}}}

a["The Vortex Pinnacle"] = {}
a["The Vortex Pinnacle"]["N"] = {items = {Trash = {55855}}}

a["Throne of the Tides"] = {}
a["Throne of the Tides"]["N"] = {items = {Trash = {55260}}}

a["Well of Eternity"] = {}
a["Well of Eternity"]["N"] = {items = {Trash = {76158, 76157, 76159}}}

a["Zul'Aman"] = {}
a["Zul'Aman"]["N"] = {items = {Trash = {69797, 69801},
  ["Time Chest"] = {69584, 69585, 69589, 69586, 69590, 69593, 69587, 69588, 69591, 69592}}}

a["Zul'Gurub"] = {}
a["Zul'Gurub"]["N"] = {items = {Trash = {69800, 69796, 69798, 69803}}}

---------------------------------------------------------------
--  WotLK - Raids
---------------------------------------------------------------

a["Icecrown Citadel"] = {}
a["Icecrown Citadel"]["25"] = {items = {Trash = {50449, 50450, 50451, 50444}}}

a["Naxxramas"] = {}
a["Naxxramas"]["10"] = {items = {Trash = {39467, 39427, 39468, 39473}}}
a["Naxxramas"]["25"] = {items = {Trash = {40410, 40409, 40414, 40408, 40407, 40406}}}

a["Ulduar"] = {}
a["Ulduar"]["10"] = {items = {Trash = {46341, 46347, 46344, 46346, 46345, 46340, 46339, 46351, 46350, 46342}}}
a["Ulduar"]["25"] = {items = {Trash = {45541, 45549, 45547, 45548, 45543, 45544, 45542, 45605}}}

---------------------------------------------------------------
--  WotLK - Dungeons
---------------------------------------------------------------

a["Ahn'kahet: The Old Kingdom"] = {}
a["Ahn'kahet: The Old Kingdom"]["N"] = {items = {Trash = {35616, 35615}}}
a["Ahn'kahet: The Old Kingdom"]["H"] = {items = {Trash = {37625}}}

a["Azjol-Nerub"] = {}
a["Azjol-Nerub"]["H"] = {items = {Trash = {37243, 37625}}}

a["Drak'Tharon Keep"] = {}
a["Drak'Tharon Keep"]["N"] = {items = {Trash = {35641, 35640, 35639}}}
a["Drak'Tharon Keep"]["H"] = {items = {Trash = {37799, 37800, 37801}}}

a["Gundrak"] = {}
a["Gundrak"]["N"] = {items = {Trash = {35594, 35593}}}
a["Gundrak"]["H"] = {items = {Trash = {37647, 37648}}}

a["Halls of Lightning"] = {}
a["Halls of Lightning"]["N"] = {items = {Trash = {36997, 37000, 36999}}}
a["Halls of Lightning"]["H"] = {items = {Trash = {37858, 37857, 37856}}}

a["Halls of Reflection"] = {}
a["Halls of Reflection"]["N"] = {items = {Trash = {49832, 49828, 49830, 49831, 49829, 49827}}}
a["Halls of Reflection"]["H"] = {items = {Trash = {50292, 50293, 50295, 50294, 50290, 50291}}}

a["Halls of Stone"] = {}
a["Halls of Stone"]["N"] = {items = {Trash = {35682, 35681}}}
a["Halls of Stone"]["H"] = {items = {Trash = {37673, 37672, 37671}}}

a["Pit of Saron"] = {}
a["Pit of Saron"]["N"] = {items = {Trash = {49854, 49855, 49853, 49852}}}
a["Pit of Saron"]["H"] = {items = {Trash = {50318, 50315, 50319}}}

a["The Culling of Stratholme"] = {}
a["The Culling of Stratholme"]["N"] = {items = {Trash = {37117, 37116, 37115}}}

a["The Forge of Souls"] = {}
a["The Forge of Souls"]["N"] = {items = {Trash = {49854, 49855, 49853, 49852}}}
a["The Forge of Souls"]["H"] = {items = {Trash = {50318, 50315, 50319}}}

a["The Oculus"] = {}
a["The Oculus"]["N"] = {items = {Trash = {36978, 36977, 36976}}}
a["The Oculus"]["H"] = {items = {Trash = {37366, 37365, 37364}}}

a["The Violet Hold"] = {}
a["The Violet Hold"]["N"] = {items = {Trash = {35654, 35653, 35652}}}
a["The Violet Hold"]["H"] = {items = {Trash = {35654, 37890, 37891, 35653, 37889, 35652}}}

a["Utgarde Keep"] = {}
a["Utgarde Keep"]["N"] = {items = {Trash = {35580, 35579}}}
a["Utgarde Keep"]["H"] = {items = {Trash = {37197, 37196}}}

a["Utgarde Pinnacle"] = {}
a["Utgarde Pinnacle"]["N"] = {items = {Trash = {37070, 37069, 37068}}}
a["Utgarde Pinnacle"]["H"] = {items = {Trash = {37587, 37590}}}

---------------------------------------------------------------
--  TBC - Raids
---------------------------------------------------------------

a["Black Temple"] = {}
a["Black Temple"]["N"] = {items = {Trash = {32590, 34012, 32609, 32593, 32592, 32608, 32606, 34009, 32943, 34011}}}

a["The Battle for Mount Hyjal"] = {}
a["The Battle for Mount Hyjal"]["N"] = {items = {Trash = {32590, 34010, 32609, 32592, 34009, 32946, 32945}}}

a["Karazhan"] = {}
a["Karazhan"]["N"] = {items = {Trash = {30642, 30668, 30673, 30644, 30674, 30643, 30641}}}

a["Serpentshrine Cavern"] = {}
a["Serpentshrine Cavern"]["N"] = {items = {Trash = {30027, 30021}}}

a["Sunwell Plateau"] = {}
a["Sunwell Plateau"]["N"] = {items = {Trash = {34351, 34407, 34350, 34409, 34183, 34346, 34348, 34347}}}

a["The Eye"] = {}
a["The Eye"]["N"] = {items = {Trash = {30024, 30020, 30029, 30026, 30030}}}

a["Outland"] = {}
a["Outland"]["N"] = {items = {['Doom Lord Kazzak'] = {30735, 30734, 30737, 30739, 30740, 30741, 30733, 30732},
  ['Doomwalker'] = {30729, 30725, 30727, 30730, 30728, 30731, 30723, 30722, 30724}}}

---------------------------------------------------------------
--  Vanilla - Raids
---------------------------------------------------------------

a["Blackwing Lair"] = {}
a["Blackwing Lair"]["N"] = {items = {Trash = {19436, 19437, 19438, 19439, 19362, 19354, 19358, 19435}}}

a["Molten Core"] = {}
a["Molten Core"]["N"] = {items = {Trash = {16802, 16817, 16806, 16827, 16828, 16851, 16838, 16864, 16858,
                                           16799, 16819, 16804, 16825, 16830, 16850, 16840, 16861, 16857}}}

a["Temple of Ahn'Qiraj"] = {}
a["Temple of Ahn'Qiraj"]["N"] = {items = {Trash = {21838, 21888, 21889, 21856, 21837}}}

---------------------------------------------------------------
--  Vanilla - Dungeons
---------------------------------------------------------------

a["Blackfathom Deeps"] = {}
a["Blackfathom Deeps"]["N"] = {items = {Trash = {1486, 3416, 3413, 2567, 3417, 1454, 1481, 3414, 3415, 2271}}}

a["Blackrock Depths"] = {}
a["Blackrock Depths"]["N"] = {items = {Trash = {12552, 12551, 12542, 12546, 12550, 12547, 12549, 12555, 12531, 12535, 12527, 12528, 12532}}}

a["Deadmines"] = {}
a["Deadmines"]["N"] = {items = {Trash = {1930, 1951, 1926}}}

a["Dire Maul"] = {}
a["Dire Maul"]["N"] = {items = {Trash = {18295, 18344, 18298, 18296, 18338},
  ["Tribute Chest"] = {18538, 18495, 18532, 18475, 18528, 18478, 18477,
                       18476, 18479, 18530, 18480, 18533, 18529, 18481,
                       18531, 18534, 18499, 18482}}}

a["Gnomeregan"] = {}
a["Gnomeregan"]["N"] = {items = {Trash = {9508, 9491, 9509, 9510, 9490, 9485, 9486, 9488, 9487}}}

a["Razorfen Downs"] = {}
a["Razorfen Downs"]["N"] = {items = {Trash = {10574, 10581, 10578, 10583, 10582, 10584, 10573, 10570, 10571, 10567, 10572}}}

a["Razorfen Kraul"] = {}
a["Razorfen Kraul"]["N"] = {items = {Trash = {2264, 1978, 1488, 4438, 776, 1727, 1975, 1976, 2549}}}

a["Shadowfang Keep"] = {}
a["Shadowfang Keep"]["N"] = {items = {Trash = {1974, 3194, 1483, 2807, 1318, 1484}}}

a["Stratholme"] = {}
a["Stratholme"]["N"] = {items = {Trash = {18743, 17061, 18745, 18744, 18736, 18742, 18741}}}

a["The Temple of Atal'hakkar"] = {}
a["The Temple of Atal'hakkar"]["N"] = {items = {Trash = {10630, 10629, 10632, 10631, 10633, 10623, 10625, 10628, 10626, 10627, 10624}}}

a["Uldaman"] = {}
a["Uldaman"]["N"] = {items = {Trash = {9397, 9431, 9429, 9420, 9430, 9406, 9428,
                                       9396, 9432, 9393, 9384, 9392, 9424, 9465,
                                       9383, 9425, 9386, 9427, 9423, 9391, 9381,
                                       9426, 9422},
  ["The Lost Dwarves"] = {9401, 9400, 9394, 9398, 9404, 9403}}}

a["Wailing Caverns"] = {}
a["Wailing Caverns"]["N"] = {items = {Trash = {10413}}}

a["Zul'Farrak"] = {}
a["Zul'Farrak"]["N"] = {items = {Trash = {9512, 9484, 5616, 9511, 9481, 9480, 9482, 9483, 2040}}}
