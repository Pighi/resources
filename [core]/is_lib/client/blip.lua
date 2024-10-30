Lib.createBlip = function(coords, args)
    local invoker = GetInvokingResource()

    local coords = coords or vector3(0.0, 0.0, 0.0)

    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, args.sprite or 1)
    SetBlipDisplay(blip, args.display or 2)
    SetBlipScale(blip, args.scale or 0.6)
    SetBlipColour(blip, args.color or 1)
    SetBlipAlpha(blip, args.alpha or 255)
    SetBlipAsShortRange(blip, args.shortRange or false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(args.name or "Example Blip")
    EndTextCommandSetBlipName(blip)

    cache.blips[blip] = blip

    if invoker then resources[invoker].blips[blip] = blip end

    return blip
end

Lib.createBlipRadius = function(coords, args)
    local invoker = GetInvokingResource()

    local coords = coords or vector3(0.0, 0.0, 0.0)

    local blip = AddBlipForRadius(coords.x, coords.y, coords.z, args.radius or 50.0)
    SetBlipColour(blip, args.color or 1)
    SetBlipAlpha(blip, args.alpha or 255)
    SetBlipAsShortRange(blip, args.shortRange or false)

    cache.blips[blip] = blip

    if invoker then resources[invoker].blips[blip] = blip end

    return blip
end

Lib.removeBlip = function(blip, invoker)
    local invoker = invoker or GetInvokingResource()

    if not cache.blips[blip] then return end

    RemoveBlip(blip)
    cache.blips[blip] = nil

    if not resources[invoker] or not resources[invoker].blips[blip] then return end

    resources[invoker].blips[blip] = nil
end

modules.blip = true