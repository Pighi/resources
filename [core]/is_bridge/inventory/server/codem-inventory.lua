func = {}

func.addItem = function(src, name, amount)
    exports["codem-inventory"]:AddItem(src, name, amount)
end

func.removeItem = function(src, name, amount)
    exports["codem-inventory"]:RemoveItem(src, name, amount)
end

func.hasItem = function(src, name)
    local count = exports["codem-inventory"]:GetItemsTotalAmount(src, name)

    if not count or count == 0 then return nil end

    return {
        label = exports["codem-inventory"]:GetItemLabel(name),
        count = count,
    }
end

return func