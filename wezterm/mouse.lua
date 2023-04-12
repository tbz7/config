local wezterm = require('wezterm')

local action = wezterm.action

local M = {}

function M.setup(config)
  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      action = action.CompleteSelection('ClipboardAndPrimarySelection'),
    },
    {
      mods = 'NONE',
      event = { Down = { streak = 4, button = 'Left' } },
      action = action.SelectTextAtMouseCursor('SemanticZone'),
    },
    {
      mods = 'SUPER',
      event = { Up = { streak = 1, button = 'Left' } },
      action = action.OpenLinkAtMouseCursor,
    },
    {
      mods = 'SUPER',
      event = { Down = { streak = 1, button = 'Left' } },
      action = action.Nop,
      mouse_reporting = true,
    },
    {
      mods = 'SUPER',
      event = { Up = { streak = 1, button = 'Left' } },
      action = action.OpenLinkAtMouseCursor,
      mouse_reporting = true,
    },
  }
end

return M
