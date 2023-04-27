local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500
config.front_end = 'WebGpu'
config.initial_cols = 104
config.initial_rows = 30
config.native_macos_fullscreen_mode = true
config.quote_dropped_files = 'Posix'
config.scrollback_lines = 10000
config.unix_domains = { { name = 'unix' } }

require('fonts').setup(config)
require('keys').setup(config)
require('mouse').setup(config)
require('theme').setup(config)

if next(wezterm.glob(wezterm.config_dir .. '/local.lua')) ~= nil then
  require('local').setup(config)
end

return config
