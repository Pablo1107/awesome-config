local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local lain      = require("lain")
local dpi       = require("beautiful.xresources").apply_dpi
local markup    = lain.util.markup
local space3 = markup.font("Roboto 3", " ")

local text = wibox.widget.textbox(
  markup("#fafafa", "Search" .. markup.font("Roboto 4", " "))
)
text.font = beautiful.font
local textbg = wibox.container.background(text, beautiful.bg_focus, gears.shape.rectangle)
local rofiwidget = wibox.container.margin(textbg, dpi(5), dpi(475), dpi(5), dpi(5))

local rofiwidget = wibox.widget {
    {
      {
        {
          markup = markup("#FAFAFA", "Search"),
          forced_width = dpi(500),
          buttons = gears.table.join(
            awful.button({}, 1, nil, function ()
              awful.spawn('rofi -show drun -theme desktop')
            end)
            ), 
          widget = wibox.widget.textbox
        },
        -- {
        --   {
        --     image = "./search.svg",
        --     widget = wibox.widget.imagebox
        --   },
        --   bg = '#fff',
        --   widget = wibox.container.background,
        -- },
        left = dpi(5),
        right = dpi(5),
        layout = wibox.container.margin
      },
      bg = "#007CA6",
      widget = wibox.container.background,
    },
    left = dpi(5),
    right = dpi(5),
    layout = wibox.container.margin
}

return rofiwidget
