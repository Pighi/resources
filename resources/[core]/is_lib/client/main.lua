Lib = {}

modules = {["functions"] = false, ["blip"] = false, ["callbacks"] = false, ["entity"] = false}
resources = {}
cache = {
    blips = {},
    entities = {},
    callbacks = {},
}

local function libLoaded()
    for _, loaded in pairs(modules) do
        if not loaded then return false end
    end

    return true
end

exports("GetLibObject", function()
    local invoker = GetInvokingResource()

    while not libLoaded() do
        Wait(5)
    end

    if not resources[invoker] then 
        resources[invoker] = {
            blips = {},
            entities = {},
        } 
    end

    return Lib
end)

AddEventHandler("onResourceStop", function(resource)
    if not resource or type(resource) ~= "string" or not resources[resource] then return end

    for _, blip in pairs(resources[resource].blips) do
        Lib.print(("Removing Blip ^3%s^0 from resource ^5[%s]^0"):format(blip, resource), "info")
        Lib.removeBlip(blip, resource)
    end

    for _, entity in pairs(resources[resource].entities) do
        Lib.print(("Removing Entity ^3%s^0 from resource ^5[%s]^0"):format(entity.id, resource), "info")
        Lib.deleteEntity(entity.id, resource)
    end
end)