func = {}

func.addItem = function(src, name, amount)
    exports["ox_inventory"]:AddItem(src, name, amount)
end

func.removeItem = function(src, name, amount)
    exports["ox_inventory"]:RemoveItem(src, name, amount)
end

func.hasItem = function(src, name)
    local item = exports["ox_inventory"]:GetItem(src, name)

    if not item or item.count == 0 then return nil end

    return {
        label = item.label,
        count = item.count,
    }
end

return func