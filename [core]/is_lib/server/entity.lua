Lib.getNearbyPlayers = function(coords, maxDistance)
    local nearby = {}
    local maxDistance = maxDistance or 10.0

    for _, id in ipairs(GetPlayers()) do
        local id = tonumber(id)

        local player = GetPlayerPed(id)
        local player_coords = GetEntityCoords(player)
        local inDistance = #(player_coords - coords) <= maxDistance

        if inDistance then
            table.insert(nearby, id)
        end
    end

    return nearby
end

RegisterNetEvent("is_lib:playAnim", function(netId, args)
    local ped = NetworkGetEntityFromNetworkId(netId)

    if not ped or ped == 0 then return end

    local nearbyPlayers = Lib.getNearbyPlayers(GetEntityCoords(ped), 50.0)

    for _, id in ipairs(nearbyPlayers) do
        TriggerClientEvent("is_lib:playAnim", id, netId, args)
    end
end)

RegisterNetEvent("is_lib:playSpeech", function(netId, args)
    local ped = NetworkGetEntityFromNetworkId(netId)

    if not ped or ped == 0 then return end

    local nearbyPlayers = Lib.getNearbyPlayers(GetEntityCoords(ped), 50.0)

    for _, id in ipairs(nearbyPlayers) do
        TriggerClientEvent("is_lib:playSpeech", id, netId, args)
    end
end)

modules.entity = true