if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()
Framework = 'qb'

function ShowNotification(msg, type)
    if type == 'inform' then type = 'primary' end
    QBCore.Functions.Notify(msg, type, 5000)
end

function SpawnCar(model, coords, heading, cb)
    local model = (type(model) == 'number' and model or GetHashKey(model))
    local heading = heading or GetEntityHeading(PlayerPedId())
    local vehicle = nil
    QBCore.Functions.SpawnVehicle(model, function(veh)
        vehicle = veh
        SetEntityHeading(vehicle, heading)
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleNumberPlateText(vehicle, 'LOL')
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        cb(vehicle)
    end, coords, true)
end