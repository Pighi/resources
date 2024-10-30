Lib.registerCallback = function(event, cb)
    local invoker = GetInvokingResource()

    cache.callbacks[event] = cb

    if invoker then resources[invoker].callbacks[event] = event end
end

Lib.deleteCallback = function(event, invoker)
    local invoker = invoker or GetInvokingResource()

    if not cache.callbacks[event] then return end

    cache.callbacks[event] = nil

    if not resources[invoker] or not resources[invoker].callbacks[event] then return end

    resources[invoker].callbacks[event] = nil
end

RegisterNetEvent("is_lib:Callback", function(event, key, invoker, ...)
    local src = source

    if not cache.callbacks[event] then
        TriggerClientEvent("is_lib:CallbackDoesntExist", src, key, event, invoker)
        return Lib.print(("Callback with the key ^1%s^0 and name ^1%s^0 was invoked by ^5[%s]^0, but it doesn't exist"):format(key, event, invoker), "error")
    end

    cache.callbacks[event](src, function(...)
        TriggerClientEvent("is_lib:serverCallback", src, key, invoker, ...)
    end, ...)
end)

modules.callbacks = true