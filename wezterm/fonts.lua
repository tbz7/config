local wezterm = require('wezterm')

local M = {}

function M.setup(config)
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
