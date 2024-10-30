Lib.Callback = function(event, cb, ...)
    local key = Lib.randomString(10)

    cache.callbacks[key] = cb

    TriggerServerEvent("is_lib:Callback", event, key, GetInvokingResource() or "unknown", ...)
end

RegisterNetEvent("is_lib:serverCallback", function(key, invoker, ...)
    if not cache.callbacks[key] then
        return Lib.print(("Callback with the key ^1%s^0 was used by ^5[%s]^0, but it doesn't exist"):format(key, invoker), "error")
    end

    cache.callbacks[key](...)
    cache.callbacks[key] = nil
end)

RegisterNetEvent("is_lib:CallbackDoesntExist", function(key, event, invoker)
    Lib.print(("Callback with the key ^1%s^0 and name ^1%s^0 was invoked by ^5[%s]^0, but it doesn't exist"):format(key, event, invoker), "error")

    cache.callbacks[key] = nil
end)

modules.callbacks = true