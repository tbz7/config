local wezterm = require('wezterm')

local M = {}

function M.setup(config)
  if wezterm.target_triple == 'aarch64-apple-darwin'
      and next(wezterm.glob(wezterm.home_dir .. '/Library/Fonts/'
        .. 'JetBrains Mono Regular Nerd Font Complete Mono.ttf')) ~= nil then
    config.font = wezterm.font('JetBrainsMono Nerd Font')
  end

  config.font_rules = {
    {
      intensity = 'Half',
      italic = false,
      font = wezterm.font('JetBrains Mono', { weight = 'Thin' }),
    },
    {
      intensity = 'Half',
      italic = true,
      font = wezterm.font('JetBrains Mono', { weight = 'Thin' }),
    },
    {
      intensity = 'Bold',
      italic = false,
      font = wezterm.font('JetBrains Mono', { weight = 'ExtraBold' }),
    },
    {
      intensity = 'Bold',
      italic = true,
      font = wezterm.font('JetBrains Mono', { weight = 'ExtraBold' }),
    },
  }
end

return M
