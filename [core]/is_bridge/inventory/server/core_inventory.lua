func = {}

func.addItem = function(src, name, amount)
    local PlayerData = bridge.framework.getPlayerData(src)

    exports["core_inventory"]:addItem("primary-"..PlayerData.identifier, name, amount, {}, "primary")
end

func.removeItem = function(src, name, amount)
    local PlayerData = bridge.framework.getPlayerData(src)

    exports["core_inventory"]:removeItemExact("primary-"..PlayerData.identifier, name, amount)
end

func.hasItem = function(src, name)
    local PlayerData = bridge.framework.getPlayerData(src)
    local item = exports["core_inventory"]:getItem("primary-"..PlayerData.identifier, name)

    if not item or item.count == 0 then return nil end

    return {
        label = item.label,
        count = item.count,
    }
end

return func