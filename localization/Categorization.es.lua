if GetLocale() ~= "esES" then return end

local o = WardrobeHelper
local c = {}
o.categorization = c
o.EXPS = {'Vanilla', 'Burning Crusade', 'WotLK', 'Cataclysm', 'Mists of Pandaria', 'Draenor', 'Legion'}
o.PARTY = {'Dungeon', 'Raid'}

c["Ahn'kahet: El Antiguo Reino"] = {3, 1, "Ahn'kahet: The Old Kingdom"}
c["Asalto al Bastión Violeta"] = {7, 1, "Assault on Violet Hold"}
c["Criptas Auchenai"] = {2, 1, "Auchenai Crypts"}
c["Auchindoun"] = {6, 1, "Auchindoun"}
c["Azjol-Nerub"] = {3, 1, "Azjol-Nerub"}
c["Bastión de Baradin"] = {4, 2, "Baradin Hold"}
c["Torreón Grajo Negro"] = {7, 1, "Black Rook Hold"}
c["Templo Oscuro"] = {2, 2, "Black Temple"}
c["Cavernas de Brazanegra"] = {1, 1, "Blackfathom Deeps"}
c["Cavernas Roca Negra"] = {4, 1, "Blackrock Caverns"}
c["Profundidades de Roca Negra"] = {1, 1, "Blackrock Depths"}
c["Fundición Roca Negra"] = {6, 2, "Blackrock Foundry"}
c["Descenso de Alanegra"] = {4, 2, "Blackwing Descent"}
c["Guarida de Alanegra"] = {1, 2, "Blackwing Lair"}
c["Minas Machacasangre"] = {6, 1, "Bloodmaul Slag Mines"}
c["Islas Abruptas"] = {7, 2, "Broken Isles"}
c["Corte de las Estrellas"] = {7, 1, "Court of Stars"}
c["Arboleda Corazón Oscuro"] = {7, 1, "Darkheart Thicket"}
c["Minas de la Muerte"] = {1, 1, "Deadmines"}
c["La Masacre"] = {1, 1, "Dire Maul"}
c["Draenor"] = {6, 2, "Draenor"}
c["Alma de Dragón"] = {4, 2, "Dragon Soul"}
c["Fortaleza de Drak'Tharon"] = {3, 1, "Drak'Tharon Keep"}
c["Fin de los Días"] = {4, 1, "End Time"}
c["Ojo de Azshara"] = {7, 1, "Eye of Azshara"}
c["Tierras de Fuego"] = {4, 2, "Firelands"}
c["Puerta del Sol Poniente"] = {5, 1, "Gate of the Setting Sun"}
c["Gnomeregan"] = {1, 1, "Gnomeregan"}
c["Grim Batol"] = {4, 1, "Grim Batol"}
c["Terminal Malavía"] = {6, 1, "Grimrail Depot"}
c["Guarida de Gruul"] = {2, 2, "Gruul's Lair"}
c["Gundrak"] = {3, 1, "Gundrak"}
c["Cámaras de Relámpagos"] = {3, 1, "Halls of Lightning"}
c["Cámaras de los Orígenes"] = {4, 1, "Halls of Origination"}
c["Cámaras de Reflexión"] = {3, 1, "Halls of Reflection"}
c["Cámaras de Piedra"] = {3, 1, "Halls of Stone"}
c["Cámaras del Valor"] = {7, 1, "Halls of Valor"}
c["Corazón del Miedo"] = {5, 2, "Heart of Fear"}
c["Ciudadela del Fuego Infernal"] = {6, 2, "Hellfire Citadel"}
c["Murallas del Fuego Infernal"] = {2, 1, "Hellfire Ramparts"}
c["Ogrópolis"] = {6, 2, "Highmaul"}
c["Hora del Crepúsculo"] = {4, 1, "Hour of Twilight"}
c["Ciudadela de la Corona de Hielo"] = {3, 2, "Icecrown Citadel"}
c["Puerto de Hierro"] = {6, 1, "Iron Docks"}
c["Karazhan"] = {2, 2, "Karazhan"}
c["Ciudad Perdida de los Tol'vir"] = {4, 1, "Lost City of the Tol'vir"}
c["Cumbre de Roca Negra Inferior"] = {1, 1, "Lower Blackrock Spire"}
c["Bancal del Magister"] = {2, 1, "Magisters' Terrace"}
c["Guarida de Magtheridon"] = {2, 2, "Magtheridon's Lair"}
c["Tumbas de Maná"] = {2, 1, "Mana-Tombs"}
c["Maraudon"] = {1, 1, "Maraudon"}
c["Fauce de Almas"] = {7, 1, "Maw of Souls"}
c["Palacio Mogu'shan"] = {5, 1, "Mogu'shan Palace"}
c["Cámaras Mogu'shan"] = {5, 2, "Mogu'shan Vaults"}
c["Núcleo de magma"] = {1, 2, "Molten Core"}
c["Naxxramas"] = {3, 2, "Naxxramas"}
c["Guarida de Neltharion"] = {7, 1, "Neltharion's Lair"}
c["Antiguas Laderas de Trabalomas"] = {2, 1, "Old Hillsbrad Foothills"}
c["Guarida de Onyxia"] = {3, 2, "Onyxia's Lair"}
c["Pandaria"] = {5, 2, "Pandaria"}
c["Foso de Saron"] = {3, 1, "Pit of Saron"}
c["Sima Ígnea"] = {1, 1, "Ragefire Chasm"}
c["Zahúrda Rajacieno"] = {1, 1, "Razorfen Downs"}
c["Horado Rajacieno"] = {1, 1, "Razorfen Kraul"}
c["Ruinas de Ahn'Qiraj"] = {1, 2, "Ruins of Ahn'Qiraj"}
c["Cámaras Escarlata"] = {1, 1, "Scarlet Halls"}
c["Monasterio Escarlata"] = {1, 1, "Scarlet Monastery"}
c["Scholomance"] = {1, 1, "Scholomance"}
c["Caverna Santuario Serpiente"] = {2, 2, "Serpentshrine Cavern"}
c["Salas Sethekk"] = {2, 1, "Sethekk Halls"}
c["Monasterio del Shadopan"] = {5, 1, "Shado-Pan Monastery"}
c["Laberinto de las Sombras"] = {2, 1, "Shadow Labyrinth"}
c["Castillo de Colmillo Oscuro"] = {1, 1, "Shadowfang Keep"}
c["Cementerio de Sombraluna"] = {6, 1, "Shadowmoon Burial Grounds"}
c["Asedio del Templo de Niuzao"] = {5, 1, "Siege of Niuzao Temple"}
c["Asedio de Orgrimmar"] = {5, 2, "Siege of Orgrimmar"}
c["Trecho Celestial"] = {6, 1, "Skyreach"}
c["Cervecería del Trueno"] = {5, 1, "Stormstout Brewery"}
c["Stratholme"] = {1, 1, "Stratholme"}
c["Meseta de La Fuente del Sol"] = {2, 2, "Sunwell Plateau"}
c["Templo de Ahn'Qiraj"] = {1, 2, "Temple of Ahn'Qiraj"}
c["Templo del Dragón de Jade"] = {5, 1, "Temple of the Jade Serpent"}
c["Veranda de la Primavera Eterna"] = {5, 2, "Terrace of Endless Spring"}
c["El Arcatraz"] = {2, 1, "The Arcatraz"}
c["La Arquería"] = {7, 1, "The Arcway"}
c["El Bastión del Crepúsculo"] = {4, 2, "The Bastion of Twilight"}
c["La Batalla del Monte Hyjal"] = {2, 2, "The Battle for Mount Hyjal"}
c["La Ciénaga Negra"] = {2, 1, "The Black Morass"}
c["El Horno de Sangre"] = {2, 1, "The Blood Furnace"}
c["El Invernáculo"] = {2, 1, "The Botanica"}
c["La Matanza de Stratholme"] = {3, 1, "The Culling of Stratholme"}
c["Pesadilla Esmeralda"] = {7, 2, "The Emerald Nightmare"}
c["El Vergel Eterno"] = {6, 1, "The Everbloom"}
c["El Ojo"] = {2, 2, "The Eye"}
c["El Ojo de la Eternidad"] = {3, 2, "The Eye of Eternity"}
c["La Forja de Almas"] = {3, 1, "The Forge of Souls"}
c["El Mechanar"] = {2, 1, "The Mechanar"}
c["El Nexo"] = {3, 1, "The Nexus"}
c["Bastión Nocturno"] = {7, 2, "The Nighthold"}
c["El Sagrario Obsidiana"] = {3, 2, "The Obsidian Sanctum"}
c["El Oculus"] = {3, 1, "The Oculus"}
c["El Sagrario Rubí"] = {3, 2, "The Ruby Sanctum"}
c["Las Salas Arrasadas"] = {2, 1, "The Shattered Halls"}
c["Recinto de los Esclavos"] = {2, 1, "The Slave Pens"}
c["La Cámara de Vapor"] = {2, 1, "The Steamvault"}
c["Las Mazmorras"] = {1, 1, "The Stockade"}
c["El Núcleo Pétreo"] = {4, 1, "The Stonecore"}
c["El Templo de Atal'Hakkar"] = {1, 1, "The Temple of Atal'hakkar"}
c["La Sotiénaga"] = {2, 1, "The Underbog"}
c["El Bastión Violeta"] = {3, 1, "The Violet Hold"}
c["La Cumbre del Vórtice"] = {4, 1, "The Vortex Pinnacle"}
c["Solio del Trueno"] = {5, 2, "Throne of Thunder"}
c["Trono de los Cuatro Vientos"] = {4, 2, "Throne of the Four Winds"}
c["Trono de las Mareas"] = {4, 1, "Throne of the Tides"}
c["Prueba del Campeón"] = {3, 1, "Trial of the Champion"}
c["Prueba del Cruzado"] = {3, 2, "Trial of the Crusader"}
c["Uldaman"] = {1, 1, "Uldaman"}
c["Ulduar"] = {3, 2, "Ulduar"}
c["Cumbre de Roca Negra Superior"] = {6, 1, "Upper Blackrock Spire"}
c["Fortaleza de Utgarde"] = {3, 1, "Utgarde Keep"}
c["Pináculo de Utgarde"] = {3, 1, "Utgarde Pinnacle"}
c["La Cámara de Archavon"] = {3, 2, "Vault of Archavon"}
c["Cámara de las Celadoras"] = {7, 1, "Vault of the Wardens"}
c["Cuevas de los Lamentos"] = {1, 1, "Wailing Caverns"}
c["Pozo de la Eternidad"] = {4, 1, "Well of Eternity"}
c["Zul'Aman"] = {4, 1, "Zul'Aman"}
c["Zul'Farrak"] = {1, 1, "Zul'Farrak"}
c["Zul'Gurub"] = {4, 1, "Zul'Gurub"}
