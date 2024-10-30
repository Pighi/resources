if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()
Framework = 'qb'

function GetPlayer(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetAccountFunds(source, account)
    if account == 'card' then account = 'bank' end
    if account == 'money' then account = 'cash' end
    local player = GetPlayer(source)
    if not player then return end
    print(player.PlayerData.money[account])
    return player.PlayerData.money[account]
end

function RemoveAccountMoney(source, account, amount)
    if account == 'card' then account = 'bank' end
    if account == 'money' then account = 'cash' end
    local player = GetPlayer(source)
    if not player then return end
    player.Functions.RemoveMoney(account, amount)
end
