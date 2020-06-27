local gears = require('gears')
local wibox = require('wibox')
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi
local lain  = require('lain')

local weather = lain.widget.weather({
    timeout = 3600,
    city_id = 3435910,
    settings = function ()
        local city = weather_now["name"]
        local country = weather_now["sys"]["country"]
        local temp = math.floor(weather_now["main"]["temp"])
        widget:set_text(city .. ", " .. country .. " " .. temp .. "°C ")
    end
})
local weatherbg = wibox.container.background(weather.widget, beautiful.bg_normal, gears.shape.rectangle)
local weatherwidget = wibox.container.margin(weatherbg, dpi(0), dpi(0), dpi(5), dpi(5))

return weatherwidget
