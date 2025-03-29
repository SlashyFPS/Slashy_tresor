local activeTreasures = {}
local searching = false
local function CreateTreasureBlip(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 501)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Trésor")
    EndTextCommandSetBlipName(blip)
    return blip
end
local function CreateTreasure(coords)
    if not coords or not coords.x or not coords.y or not coords.z then return end
    
    local ground, z = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0)
    if not ground then 
        local found, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z + 10.0, 0)
        z = found and groundZ or coords.z
    end
    
    local adjustedCoords = vector3(coords.x, coords.y, z)
    local model = GetHashKey('prop_box_wood05a')
    
    RequestModel(model)
    local timeout = 0
    while not HasModelLoaded(model) and timeout < 50 do
        Wait(100)
        timeout = timeout + 1
    end
    
    if timeout >= 50 then return end
    
    local blip = CreateTreasureBlip(adjustedCoords)
    local object = CreateObject(model, adjustedCoords.x, adjustedCoords.y, adjustedCoords.z - 1.0, true, true, true)
    
    if not DoesEntityExist(object) then
        RemoveBlip(blip)
        return
    end
    
    SetEntityHeading(object, math.random(0, 360))
    FreezeEntityPosition(object, true)
    SetEntityAsMissionEntity(object, true, true)
    SetModelAsNoLongerNeeded(model)
    SetEntityVisible(object, true)
    SetEntityAlpha(object, 255, false)
    
    local finalCoords = vector3(adjustedCoords.x, adjustedCoords.y, adjustedCoords.z)
    SetEntityCoords(object, finalCoords.x, finalCoords.y, finalCoords.z, false, false, false, false)
    
    table.insert(activeTreasures, {
        coords = finalCoords,
        blip = blip,
        found = false,
        object = object
    })
    
    lib.notify({
        title = 'Chasse au Trésor',
        description = Config.Messages.newTreasure,
        type = 'info'
    })
end
local function RemoveTreasure(treasure)
    RemoveBlip(treasure.blip)
    if DoesEntityExist(treasure.object) then
        DeleteEntity(treasure.object)
    end
    for i, t in ipairs(activeTreasures) do
        if t == treasure then
            table.remove(activeTreasures, i)
            break
        end
    end
end
local function SearchTreasure(coords)
    if searching then return end
    searching = true
    
    lib.progressBar({
        duration = 5000,
        label = Config.Messages.searching
    })

    local playerCoords = GetEntityCoords(PlayerPedId())
    for _, treasure in ipairs(activeTreasures) do
        local distance = #(playerCoords - vector3(treasure.coords.x, treasure.coords.y, treasure.coords.z))
        if distance <= Config.SearchRadius then
            if not treasure.found then
                treasure.found = true
                TriggerServerEvent('slashy_tresor:foundTreasure', treasure.coords)
                RemoveTreasure(treasure)
                lib.notify({
                    title = 'Succès',
                    description = Config.Messages.treasureFound,
                    type = 'success'
                })
            else
                lib.notify({
                    title = 'Information',
                    description = Config.Messages.alreadyFound,
                    type = 'info'
                })
            end
            searching = false
            return
        end
    end

    lib.notify({
        title = 'Information',
        description = Config.Messages.noTreasure,
        type = 'error'
    })
    searching = false
end

CreateThread(function()
    RegisterNetEvent('slashy_tresor:newTreasure')
    AddEventHandler('slashy_tresor:newTreasure', function(coords)
        CreateTreasure(coords)
    end)
    
    exports.ox_target:addModel('prop_box_wood05a', {
        {
            name = 'search_treasure',
            icon = 'fas fa-search',
            label = 'Chercher un trésor',
            onSelect = function()
                local playerCoords = GetEntityCoords(PlayerPedId())
                local entity = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 2.0, GetHashKey('prop_box_wood05a'), false, false, false)
                
                if DoesEntityExist(entity) then
                    local treasureCoords = GetEntityCoords(entity)
                    local distance = #(playerCoords - treasureCoords)
                    
                    if distance <= Config.SearchRadius then
                        SearchTreasure(treasureCoords)
                    else
                        lib.notify({
                            title = 'Information',
                            description = 'Vous êtes trop loin du trésor !',
                            type = 'error'
                        })
                    end
                end
            end
        }
    })
end)
