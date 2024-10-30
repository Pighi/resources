Lib.getIdentifiers = function(src)
    local types = {"steam", "discord", "license", "xbl", "live", "fivem"}
    local identifiers = {}

    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        for _, idType in ipairs(types) do
            if string.find(id, idType .. ":") then
                identifiers[idType] = id:gsub(idType .. ":", "")
                break
            end
        end
    end

    return identifiers
end

modules.identifier = true