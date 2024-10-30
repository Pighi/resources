if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports['es_extended']:getSharedObject()
Framework = 'esx'


function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function GetPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function GetAccountFunds(source, account)
    if account == 'card' then account = 'bank' end
    if account == 'cash' then account = 'money' end
    local player = GetPlayer(source)
    if not player then return end
    return player.getAccount(account).money
end

function RemoveAccountMoney(source, account, amount)
    if account == 'card' then account = 'bank' end
    if account == 'cash' then account = 'money' end
    local player = GetPlayer(source)
    if not player then return end
    player.removeAccountMoney(account, amount)
end
