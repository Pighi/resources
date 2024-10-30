Lib = {}

modules = {["functions"] = false, ["callbacks"] = false, ["entity"] = false, ["identifier"] = false, ["timezone"] = false, ["webhook"] = false}
resources = {}
cache = {
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
            callbacks = {},
        } 
    end

    return Lib
end)

AddEventHandler("onResourceStop", function(resource)
    if not resource or type(resource) ~= "string" or not resources[resource] then return end

    for _, callback in pairs(resources[resource].callbacks) do
        Lib.print(("Removing Callback ^3%s^0 from resource ^5[%s]^0"):format(callback, resource), "info")
        Lib.deleteCallback(callback, resource)
    end
end)