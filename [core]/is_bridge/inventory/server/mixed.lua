func = {}

func.addItem = function(src, name, amount)
    exports[bridge.inventory.name]:AddItem(src, name, amount)
end

func.removeItem = function(src, name, amount)
    exports[bridge.inventory.name]:RemoveItem(src, name, amount)
end

func.hasItem = function(src, name)
    local item = exports[bridge.inventory.name]:GetItemByName(src, name)

    if not item or item.amount == 0 then return nil end

    return {
        label = item.label,
        count = item.amount,
    }
end

return func