

local targets, found = { 'qtarget', 'qb-target', 'ox_target' }, nil

for i = 1, #targets do
    if GetResourceState(targets[i]) == 'started' then
        found = true
        break
    end
end

if not found then
    print('bridge/target/client.lua: No target script found, please install the latest one of the following: ' ..
        table.concat(targets, ', '))
    return
end

-- function AddTargetBox(identifier, coords, width, length, data)
local boxes = {}
function AddTargetBox(name, coords, width, length, params, data)
    if boxes[name] then
        -- print('bridge/target/client.lua: Box with name ' .. name .. ' already exists')
        return
    end
    exports.qtarget:AddBoxZone(name, coords, width, length, params, data)
    boxes[name] = true
end

function RemoveTargetZone(id)
    exports.qtarget:RemoveZone(id)
end