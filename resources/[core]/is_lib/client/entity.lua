Lib.playAnim = function(entity, args)
    if not args.dict or not args.anim then return end

    local isNetwork = args.isNetwork or false

    if isNetwork then
        if NetworkDoesNetworkIdExist(entity) and NetworkDoesEntityExistWithNetworkId(entity) then
            TriggerServerEvent("is_lib:playAnim", entity, args)
        else
            Lib.print(("Network ID: ^1%s^0 does not exist"):format(entity), "error")
        end

        return
    end

    RequestAnimDict(args.dict)

    while not HasAnimDictLoaded(args.dict) do
        Wait(5)
    end
    
    TaskPlayAnim(entity, args.dict, args.anim, args.blendIn or 3.0, args.blendOut or 3.0, args.duration or -1, args.flag or 49, args.playbackRate or 0, args.lockX or false, args.lockY or false, args.lockZ or false)
end

RegisterNetEvent("is_lib:playAnim", function(netId, args)
    args.isNetwork = false

    if not NetworkDoesNetworkIdExist(netId) or not NetworkDoesEntityExistWithNetworkId(netId) then return end

    local entity = NetworkGetEntityFromNetworkId(netId)

    if not entity or entity == 0 then return end

    Lib.playAnim(entity, args)
end)

Lib.playScenario = function(entity, args)
    local enterAnim = args.enterAnim or true

    TaskStartScenarioInPlace(entity, args.scenario, 0, enterAnim)
end

Lib.playSpeech = function(entity, args)
    if not args.name or not args.param then return end

    local isNetwork = args.isNetwork or false

    if isNetwork then
        if NetworkDoesNetworkIdExist(entity) and NetworkDoesEntityExistWithNetworkId(entity) then
            TriggerServerEvent("is_lib:playSpeech", entity, args)
        else
            Lib.print(("Network ID: ^1%s^0 does not exist"):format(entity), "error")
        end

        return
    end

    PlayPedAmbientSpeechNative(entity, args.name, args.param)
end

RegisterNetEvent("is_lib:playSpeech", function(netId, args)
    args.isNetwork = false

    if not NetworkDoesNetworkIdExist(netId) or not NetworkDoesEntityExistWithNetworkId(netId) then return end

    local entity = NetworkGetEntityFromNetworkId(netId)

    if not entity or entity == 0 then return end

    Lib.playSpeech(entity, args)
end)

Lib.faceToCoords = function(entity, handler)
    local entityCoords = GetEntityCoords(entity)

    if type(handler) ~= "vector3" then
        handler = GetEntityCoords(handler)
    end

    local dx = handler.x - entityCoords.x
    local dy = handler.y - entityCoords.y

    local heading = GetHeadingFromVector_2d(dx, dy)

    return heading
end

Lib.faceToCoordsSmooth = function(ped, targetCoords, delay)
    local targetHeading = Lib.faceToCoords(ped, targetCoords)

    local function normalizeHeadingDifference(heading1, heading2)
        local diff = (heading2 - heading1 + 180) % 360 - 180
        return diff < -180 and diff + 360 or diff
    end

    local faceSet = true
    local currentHeading = GetEntityHeading(ped)
    local headingDifference = normalizeHeadingDifference(currentHeading, targetHeading)

    if ped == PlayerPedId() then
        CreateThread(function()
            while faceSet do
                DisableAllControlActions(0)
                EnableControlAction(0, 1, true)
                EnableControlAction(0, 2, true)
                Wait(1)
            end
        end)
    end

    local timer = 0.0
    local maxTime = delay or 3.0

    while math.abs(headingDifference) > 10.0 and timer < maxTime do
        TaskTurnPedToFaceCoord(ped, targetCoords, 100)

        Wait(100)

        currentHeading = GetEntityHeading(ped)
        headingDifference = normalizeHeadingDifference(currentHeading, targetHeading)

        timer = timer + 0.1
    end

    if timer >= maxTime then SetEntityHeading(ped, targetHeading) end

    ClearPedTasks(ped)

    faceSet = false
end

Lib.createObj = function(hash, coords, isNetwork, options)
    local invoker = GetInvokingResource()
    local hash = type(hash) == "string" and GetHashKey(hash) or hash

    local timer = 0.0
    local maxTime = 3.0

    RequestModel(hash)

    while not HasModelLoaded(hash) and timer < maxTime do
        Wait(10)
        timer = timer + 0.01
    end

    if timer >= maxTime then
        Lib.print(("Failed to load Model ^1%s^0"):format(hash), "error")
        return nil
    end

    local coords = coords or vector3(0.0, 0.0, 0.0)
    local obj = CreateObject(hash, coords.x, coords.y, coords.z, isNetwork, true, false)

    while not DoesEntityExist(obj) do
        Wait(5)
    end

    local options = options or {}

    if options.rotation and options.rotation.p and options.rotation.r and options.rotation.y then
        SetEntityRotation(obj, options.rotation.p, options.rotation.r, options.rotation.y)
    end

    if options.placeOnGround then
        PlaceObjectOnGroundProperly(obj)
    end

    if options.freeze then
        FreezeEntityPosition(obj, true)
    end

    if options.invincible then
        SetEntityInvincible(obj, true)
    end

    if options.disableCollision then
        SetEntityCollision(obj, false, true)
    end

    if options.alpha and tonumber(options.alpha) then
        SetEntityAlpha(obj, options.alpha, false)
    end

    local netId

    if isNetwork then netId = NetworkGetNetworkIdFromEntity(obj) SetNetworkIdCanMigrate(netId, true) end

    local data = {id = obj, netId = netId}

    cache.entities[obj] = data

    if invoker then resources[invoker].entities[obj] = data end

    return data
end

Lib.createPed = function(hash, coords, isNetwork, options)
    local invoker = GetInvokingResource()
    local hash = type(hash) == "string" and GetHashKey(hash) or hash
    
    local timer = 0.0
    local maxTime = 3.0

    RequestModel(hash)

    while not HasModelLoaded(hash) and timer < maxTime do
        Wait(10)
        timer = timer + 0.01
    end

    if timer >= maxTime then
        Lib.print(("Failed to load Model ^1%s^0"):format(hash), "error")
        return nil
    end

    local ped = CreatePed(0, hash, coords.x, coords.y, coords.z, coords.w, isNetwork, true)

    while not DoesEntityExist(ped) do
        Wait(5)
    end

    local options = options or {}

    if options.placeOnGround then
        local found, ground = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)

        if found then
            SetEntityCoords(ped, coords.x, coords.y, ground)
        end
    end

    if options.defaultVariation then
        SetPedDefaultComponentVariation(ped)
    end

    if options.freeze then
        FreezeEntityPosition(ped, true)
    end

    if options.god then
        SetEntityInvincible(ped, true)
        SetPedDiesWhenInjured(ped, false)
    end

    if options.disableRagdoll then
        SetPedCanRagdollFromPlayerImpact(ped, false)
        SetPedCanRagdoll(ped, false)
    end

    if options.cannotTarget then
        SetPedCanBeTargetted(ped, false)
    end

    local netId

    if isNetwork then netId = NetworkGetNetworkIdFromEntity(ped) SetNetworkIdCanMigrate(netId, true) end

    local data = {id = ped, netId = netId}

    cache.entities[ped] = data

    if invoker then resources[invoker].entities[ped] = data end

    return data
end

Lib.createVeh = function(hash, coords, isNetwork, options)
    local invoker = GetInvokingResource()
    local hash = type(hash) == "string" and GetHashKey(hash) or hash

    local timer = 0.0
    local maxTime = 3.0

    RequestModel(hash)

    while not HasModelLoaded(hash) and timer < maxTime do
        Wait(10)
        timer = timer + 0.01
    end

    if timer >= maxTime then
        Lib.print(("Failed to load Model ^1%s^0"):format(hash), "error")
        return nil
    end

    local veh = CreateVehicle(hash, coords.x, coords.y, coords.z, coords.w, isNetwork, true)

    while not DoesEntityExist(veh) do
        Wait(5)
    end

    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, "OFF")

    local options = options or {}

    if options.freeze then
        FreezeEntityPosition(veh, true)
    end

    local netId

    if isNetwork then netId = NetworkGetNetworkIdFromEntity(veh) SetNetworkIdCanMigrate(netId, true) end

    local data = {id = veh, netId = netId}

    cache.entities[veh] = data

    if invoker then resources[invoker].entities[veh] = data end

    return data
end

Lib.deleteEntity = function(entity, invoker)
    local invoker = invoker or GetInvokingResource()
    local entityType = type(entity)

    local entity = entityType == "table" and entity.id or entity

    if not cache.entities[entity] then return end

    DeleteEntity(entity)
    cache.entities[entity] = nil

    if not resources[invoker] or not resources[invoker].entities[entity] then return end

    resources[invoker].entities[entity] = nil
end

Lib.getVehicleFullName = function(hash)
    local hash = type(hash) == "string" and GetHashKey(hash) or hash
    local make = GetLabelText(GetMakeNameFromVehicleModel(hash))
    local model = GetDisplayNameFromVehicleModel(hash)

    if make ~= "NULL" and make ~= "CARNOTFOUND" and model ~= "NULL" and model ~= "CARNOTFOUND" then
        return make .. " " .. Lib.capitalizeFirstLetter(model)
    elseif make ~= "NULL" and make ~= "CARNOTFOUND" and model == "NULL" and model == "CARNOTFOUND" then
        return make
    elseif make == "NULL" and make == "CARNOTFOUND" and model ~= "NULL" and model ~= "CARNOTFOUND" then
        return Lib.capitalizeFirstLetter(model)
    else
        return "UNKNOWN"
    end
end

modules.entity = true