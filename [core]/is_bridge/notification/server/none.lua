func = {}

func.show = function(src, data)
    TriggerClientEvent("is_bridge:client:showNotify", src, data)
end

return func