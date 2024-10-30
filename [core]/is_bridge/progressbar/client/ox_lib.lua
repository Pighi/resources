func = {}

func.show = function(data, finish, cancel)
    if lib.progressBar({
        duration = data.duration,
        label = data.title,
        useWhileDead = data.useWhileDead,
        canCancel = data.canCancel,
        anim = data.animation and {
            dict = data.animation.dict,
            clip = data.animation.anim,
            flag = data.animation.flag,
        } or nil,
        disable = data.disable and {
            move = data.disable.move,
            car = data.disable.car,
            combat = data.disable.combat,
            mouse = data.disable.mouse,
            sprint = data.disable.sprint,
        } or nil,
    }) then finish() else cancel() end
end

func.isActive = function()
    return lib.progressActive()
end

func.cancel = function()
    lib.cancelProgress()
end

return func