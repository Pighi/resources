local Server = lib.load('sv_config')

lib.callback.register('randol_grandma:server:useGrandma', function(source, index)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local gparent = Server.locations[index]
    local pos = gparent.coords

    if #(coords - vec3(pos.x, pos.y, pos.z)) > 10 then
        return false
    end

    if gparent.busy then
        DoNotification(src, ("%s is busy right now."):format(gparent.name), "error")
        return false
    end

    local Player = GetPlayer(src)
    local hasPaid = RemovePlayerMoney(Player, Server.cost, Server.moneyType)


    if not hasPaid then
        DoNotification(src, ("You don't have enough %s to pay the fee. ($%s)"):format(Server.moneyType, Server.cost), "error")
        return false
    end

    Server.locations[index].busy = true
    
    CreateThread(function()
        local plys = lib.getNearbyPlayers(pos.xyz, 30.0)
        if plys then
            for i = 1, #plys do
                local player = plys[i]
                TriggerClientEvent('randol_grandma:client:syncAnim', player.id, index)
            end
        end

        Wait(Server.duration + 3000) -- This is to account for people who may crash/quit during the progress bar. Gotta make sure that grandparent resets.
        Server.locations[index].busy = false
    end)

    TriggerClientEvent('randol_grandma:client:attemptRevive', src, index)
    return true
end)

lib.callback.register('randol_grandma:server:revivePlayer', function(source, index)
    if not index then return false end
    if Server.locations[index].busy then
        handleRevive(source)
        return true
    end
    return false
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    SetTimeout(2000, function()
        TriggerClientEvent('randol_grandma:client:cacheConfig', -1, Server)
    end)
end)

function PlayerHasLoaded(source)
    local src = source
    SetTimeout(2000, function()
        TriggerClientEvent('randol_grandma:client:cacheConfig', src, Server)
    end)
end
