Config = {}

Config.TreasureSpawnInterval = 30

Config.MaxTreasures = 3

Config.SearchRadius = 2.0

Config.Rewards = {
    money = {
        min = 1000,
        max = 5000
    },
    items = {
        {name = "weapon_pistol", chance = 10},
        {name = "weapon_knife", chance = 20},
        {name = "goldbar", chance = 5},
        {name = "diamond", chance = 3},
        {name = "water", chance = 50},
        {name = "bread", chance = 50}
    }
}

Config.SpawnZones = {
    vec3(-1037.74, -2738.12, 20.17),
    vec3(1855.82, 3687.48, 34.27),
    vec3(-1604.52, -1122.23, 2.07),
    vec3(2340.12, 3126.76, 48.21),
    vec3(-275.52, 6635.84, 7.43)
}

Config.Messages = {
    treasureFound = "Vous avez trouvé un trésor !",
    searching = "Vous cherchez un trésor...",
    noTreasure = "Il n'y a pas de trésor ici...",
    newTreasure = "Un nouveau trésor a été signalé dans la région !",
    alreadyFound = "Ce trésor a déjà été trouvé !"
}