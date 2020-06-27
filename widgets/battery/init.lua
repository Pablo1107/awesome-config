local lain = require('lain')

local bat = lain.widget.bat({
    settings = function()
        bat_p = bat_now.perc .. "%"
        if bat_now.ac_status == 1 then
            bat_p = bat_p .. "~"
        end
        bat_p = bat_p .. " "
        widget:set_text(bat_p)
    end
})

return bat
