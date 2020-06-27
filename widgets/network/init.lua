local gears = require('gears')
local wibox = require('wibox')
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi
local vicious  = require('vicious')

local net = wibox.widget.textbox()
vicious.register(net, vicious.widgets.wifi, "  ${ssid} ", 30, "wlo1")
local netbg = wibox.container.background(net, beautiful.bg_normal, gears.shape.rectangle)
local networkwidget = wibox.container.margin(netbg, dpi(0), dpi(0), dpi(5), dpi(5))

return networkwidget
