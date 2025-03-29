local activeTreasures = {}
local function IsLocationValid(coords)
    for _, treasureCoords in ipairs(activeTreasures) do
        if #(treasureCoords - coords) < 100.0 then
            return false
        end
    end
    return true
end
local function GenerateReward()
    local rewards = {}
    local money = math.random(Config.Rewards.money.min, Config.Rewards.money.max)
    table.insert(rewards, {type = 'money', amount = money})
    
    for _, item in ipairs(Config.Rewards.items) do
        if math.random(100) <= item.chance then
            table.insert(rewards, {type = 'item', name = item.name, amount = 1})
        end
    end
    
    return rewards
end
local function SpawnNewTreasure()
    if #activeTreasures >= Config.MaxTreasures then return end
    
    local attempts = 0
    local maxAttempts = 10
    local coords
    
    repeat
        local randomZone = Config.SpawnZones[math.random(#Config.SpawnZones)]
        coords = vector3(
            randomZone.x + math.random(-50, 50),
            randomZone.y + math.random(-50, 50),
            randomZone.z
        )
        attempts = attempts + 1
    until IsLocationValid(coords) or attempts >= maxAttempts
    
    if attempts < maxAttempts then
        table.insert(activeTreasures, coords)
        TriggerClientEvent('slashy_tresor:newTreasure', -1, coords)
    end
end

CreateThread(function()
    Wait(1000)
    SpawnNewTreasure()
    while true do
        Wait(Config.TreasureSpawnInterval * 60 * 1000)
        SpawnNewTreasure()
    end
end)

RegisterNetEvent('slashy_tresor:foundTreasure')
AddEventHandler('slashy_tresor:foundTreasure', function(coords)
    local source = source
    local rewards = GenerateReward()
    
    for _, reward in ipairs(rewards) do
        if reward.type == 'money' then
            exports.ox_inventory:AddItem(source, 'money', reward.amount)
        elseif reward.type == 'item' then
            exports.ox_inventory:AddItem(source, reward.name, reward.amount)
        end
    end
    
    for i, treasureCoords in ipairs(activeTreasures) do
        if #(treasureCoords - coords) < 1.0 then
            table.remove(activeTreasures, i)
            break
        end
    end
end)
