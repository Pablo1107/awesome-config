local mpd = require('widgets/mpd')
local clock = require('widgets/clock')
local rofi = require('widgets/rofi')
local battery = require('widgets/battery')
local bluetooth = require('widgets/bluetooth')
local network = require('widgets/network')
local weather = require('widgets/weather')

return {
  mytextclock = clock,
  mpd = mpd,
  rofi = rofi,
  battery = battery,
  bluetooth = bluetooth,
  network = network,
  weather = weather,
}
