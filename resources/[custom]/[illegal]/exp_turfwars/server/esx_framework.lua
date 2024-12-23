if GetResourceState("es_extended") == "started" then
    print("^5Starting with ESX^0")

    ESX = exports["es_extended"]:getSharedObject()
    -- ESX = nil
    -- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    
    RegisterNetEvent('esx:playerLoaded', function(source)
        local gang = GetPlayerGang(source)
        player_to_gang[source] = gang
        TriggerClientEvent("exp_turfwars:SetPlayerGang", source, gang) -- MUST BE TRIGGERED WHEN CONNECTION
    end)
    
    function GetPlayerGang(player_src)
        local xPlayer = ESX.GetPlayerFromId(player_src)
        local identifier = xPlayer.getIdentifier()
        local result = MySQL.single.await('SELECT gang FROM users WHERE identifier=@identifier', {
            ["@identifier"] = xPlayer.getIdentifier()
        })
    
        return result.gang
    end
    
    function GetPlayerItemCount(player_src, item)
        local xPlayer = ESX.GetPlayerFromId(player_src)
        local item = xPlayer.getInventoryItem(item) 
        return item and item.count or 0
    end
    
    function RemovePlayerItem(player_src, item, amount)
        local xPlayer = ESX.GetPlayerFromId(player_src)
        xPlayer.removeInventoryItem(item, amount)
        return true
    end
    
    function GivePlayerMoney(player_src, amount)
        local xPlayer = ESX.GetPlayerFromId(player_src)
        xPlayer.addAccountMoney("black_money", amount)
        return true
    end
    
    function GetItemLabel(item)
        return ESX.GetItemLabel(item)
    end
    
    function GetPoliceCount()
        local players = ESX.GetPlayers()
        local count = 0
    
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player.job.name == 'lspd' then
                count = count + 1
            end
        end
    
        return count
    end
    
    function DiscordLog(player_src, event)
        -- Connect to your log system
    end
    
    RegisterNetEvent("exp_turfwars:SendPoliceAlert")
    AddEventHandler("exp_turfwars:SendPoliceAlert", function(position)
        for _, server_id in ipairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(server_id)
            if xPlayer.getJob().name == "lspd" then
                xPlayer.triggerEvent("exp_turfwars:ShowPoliceAlert", position)
            end
        end
    end)
end
