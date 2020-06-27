local awful     = require('awful')
local gears     = require("gears")
local wibox     = require("wibox")
local naughty   = require("naughty")
local beautiful = require("beautiful")
local bluetooth = require("widgets/bluetooth/bluetooth")
async = require("widgets/bluetooth/async") -- must be global
local dpi   = require("beautiful.xresources").apply_dpi

function string.trim(s)
    if s then
        return (s:gsub("^%s*(.-)%s*$", "%1"))
    else
        return ""
    end
end

function sortpairs(t, lt)
    local u = { }
    for k, v in pairs(t) do table.insert(u, { key = k, value = v }) end
    table.sort(u, lt)
    return u
end

local icondir = os.getenv("HOME") .. "/.config/awesome/widgets/bluetooth/icons/"

-- Create widget
local btimage = wibox.widget.imagebox(icondir .. "bluetooth.png")
local btbg = wibox.container.background(btimage, beautiful.bg_normal, gears.shape.rectangle)
local btwidget = wibox.container.margin(btbg, dpi(0), dpi(0), dpi(3), dpi(3))
local btmenu = nil
btwidget:buttons(awful.util.table.join(
	awful.button({}, 1, nil, function()
		if btmenu ~= nil and btmenu.wibox.visible then
			btmenu:hide()
			btmenu = nil
			return
		end
		local items = {}
		for i, iv in ipairs(sortpairs(bluetooth.devices(), function(a,b) return a.key < b.key end)) do
			local path = iv.key
			local v = iv.value
			items[#items+1] = {
				v.Alias, function() -- onclick
					local action = v.Connected and "disconnect" or "connect"
					-- Hack to allow non-blocking execution
					async.execute(string.format("cd %s/.config/awesome ; ./widgets/bluetooth/bluetooth.lua %s %s", os.getenv("HOME"), action, path),
					function(str)
						str = string.trim(str)
						if str ~= "OK" then
							naughty.notify({
								title = "Bluetooth connection failed",
								text = string.format("Could not connect to »%s«.<br />%s", v.Alias, str)
							})
						end
					end)
				end,
				string.format(icondir .. "btprofiles/%s%s.png", v.Icon, v.Connected and "_connected" or "")
			}
		end
		btmenu = awful.menu({items = items, theme = { width = 250 }})
		btmenu:show()
	end),
	awful.button({}, 3, nil, function()
		if btmenu ~= nil then
			btmenu:hide()
			btmenu = nil
		end
	end)
))

-- Use awesome's dbus lib to listen on dbus for bluetooth events
dbus.add_match("system", "interface='org.freedesktop.DBus.Properties'")
dbus.connect_signal('org.freedesktop.DBus.Properties', function (data, interface, chprop)
	if interface == "org.bluez.Device1" then
		if chprop.Connected ~= nil then
			local path = data.path
			local devices = bluetooth.devices()
			if devices == nil or devices[path] == nil then
				return
			end
			local name = devices[path].Alias
			naughty.notify({
				title = string.format("Bluetooth deviced %s", chprop.Connected and "connected" or "disconnected"),
				text = string.format(
					chprop.Connected and "You are now connected to »%s«."
					or "»%s« has disconnected.", name)
			})
		end
	end
end)

return btwidget
