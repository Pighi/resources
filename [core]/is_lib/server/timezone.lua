local time = {                 -- The time is retrieved directly from the Server, not the local Client's Computer, ensuring uniform time for all system users, regardless of their local time settings
    zone_count = 0,            -- time in seconds -3600 or 3600
    format = 24,               -- 12, 24
}

local units = {
    ["s"] = 1,          -- seconds
    ["m"] = 60,         -- minutes
    ["h"] = 3600,       -- hours
    ["d"] = 86400,      -- days
    ["w"] = 604800,     -- weeks
}

local function convertData(timestamp)
    return time.format == 24 and os.date("%d/%m/%Y %H:%M", timestamp) or time.format == 12 and os.date("%m/%d/%Y %I:%M %p", timestamp)
end

Lib.getDate = function(timestamp, args)
    if not timestamp or tonumber(timestamp) == nil then
        Lib.print("You did not provide or provided an incorrect time", "error")
        return 
    end

    local addTime = 0

    if args and args.unit and args.count and units[args.unit] then
        addTime = units[args.unit] * args.count
    end

    local offsetTime = timestamp + time.zone_count + addTime

    return {
        time = offsetTime,
        date = convertData(offsetTime),
    }
end

modules.timezone = true