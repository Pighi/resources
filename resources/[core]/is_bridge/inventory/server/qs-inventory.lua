func = {}

func.addItem = function(src, name, amount)
    exports["qs-inventory"]:AddItem(src, name, amount)
end

func.removeItem = function(src, name, amount)
    exports["qs-inventory"]:RemoveItem(src, name, amount)
end

func.hasItem = function(src, name)
    local count = exports["qs-inventory"]:GetItemTotalAmount(src, name)

    if not count or count == 0 then return nil end

    return {
        label = exports["qs-inventory"]:GetItemLabel(name),
        count = count,
    }
end

return func
