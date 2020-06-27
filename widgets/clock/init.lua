local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local lain      = require("lain")
local dpi       = require("beautiful.xresources").apply_dpi
local markup    = lain.util.markup
local space3 = markup.font("Roboto 3", " ")

local mytextclock = wibox.widget.textclock(markup("#FFFFFF", space3 .. " %a %d %b,  %H:%M" .. markup.font("Roboto 4", " ")))
mytextclock.font = beautiful.font
local clock_icon = wibox.widget.imagebox(beautiful.clock)
local clockbg = wibox.container.background(mytextclock, beautiful.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(3), dpi(5), dpi(5))

return clockwidget
