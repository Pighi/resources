if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports['es_extended']:getSharedObject()
Framework = 'esx'

function ShowNotification(msg)
    ESX.ShowNotification(msg)
end

function SpawnCar(model, coords, heading, cb)
    ESX.Game.SpawnVehicle(model, coords, heading, cb)
end