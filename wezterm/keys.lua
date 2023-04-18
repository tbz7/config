local c = require('common')
local wezterm = require('wezterm')

local action = wezterm.action

local M = {}

local function nav(win, pane, motion, force)
  if not force and pane:get_user_vars().nvim == 'true' then
    win:perform_action(action.SendKey { mods = 'ALT', key = motion }, pane)
  else
    pane = win:active_tab():get_pane_direction(c.nav_motions[motion].dir)
    if pane then
      pane:activate()
      if pane:get_user_vars().nvim == 'true' then
        win:perform_action(
          action.SendKey {
            mods = 'ALT',
            key = c.nav_motions[motion].rev:upper(),
          },
          pane)
      end
    end
  end
end

local function nav_action(motion)
  return wezterm.action_callback(function(win, pane)
    nav(win, pane, motion, false)
  end)
end

wezterm.on('user-var-changed', function(win, pane, name, value)
  if name == 'force_nav' then
    nav(win, pane, value, true)
  end
end)

function M.setup(config)
  config.keys = {
    { mods = 'ALT', key = 'h',  action = nav_action('h') },
    { mods = 'ALT', key = 'j',  action = nav_action('j') },
    { mods = 'ALT', key = 'k',  action = nav_action('k') },
    { mods = 'ALT', key = 'l',  action = nav_action('l') },
    { mods = 'ALT', key = '\\', action = action.SplitHorizontal },
    { mods = 'ALT', key = '-',  action = action.SplitVertical },
    {
      mods = 'SHIFT|ALT',
      key = '|',
      action = action.SplitPane { direction = 'Right', top_level = true },
    },
    {
      mods = 'SHIFT|ALT',
      key = '_',
      action = action.SplitPane { direction = 'Down', top_level = true },
    },
  }
end

return M
