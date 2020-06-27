local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local lain      = require("lain")
local dpi   = require("beautiful.xresources").apply_dpi
local markup = lain.util.markup

local mpd_icon = awful.widget.launcher({ image = beautiful.mpdl, command = beautiful.musicplr })
local prev_icon = wibox.widget.imagebox(beautiful.prev)
local next_icon = wibox.widget.imagebox(beautiful.nex)
local stop_icon = wibox.widget.imagebox(beautiful.stop)
local pause_icon = wibox.widget.imagebox(beautiful.pause)
local play_pause_icon = wibox.widget.imagebox(beautiful.play)
beautiful.mpd = lain.widget.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
            mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
            widget:set_markup(markup.font("Roboto 4", " ")
                              .. markup.font(beautiful.taglist_font,
                              " " .. mpd_now.artist
                              .. " - " ..
                              mpd_now.title .. "  ") .. markup.font("Roboto 5", " "))
            play_pause_icon:set_image(beautiful.pause)
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font("Roboto 4", " ") ..
                              markup.font(beautiful.taglist_font, " MPD PAUSED  ") ..
                              markup.font("Roboto 5", " "))
            play_pause_icon:set_image(beautiful.play)
        else
            widget:set_markup("")
            play_pause_icon:set_image(beautiful.play)
        end
    end
})
local musicbg = wibox.container.background(beautiful.mpd.widget, beautiful.bg_normal, gears.shape.rectangle)
local musicwidget = wibox.container.margin(musicbg, dpi(0), dpi(0), dpi(5), dpi(5))

return musicwidget
