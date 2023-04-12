local c = require('common')
local wezterm = require('wezterm')

local action = wezterm.action

local M = {}

local function maybe_split(key, direction)
  return wezterm.action_callback(function(win, pane)
    if pane:get_user_vars()['process_name'] == 'tmux' then
      win:perform_action(action.SendKey { mods = 'ALT', key = key }, pane)
    else
      pane:split { direction = direction }
    end
  end)
end

local function nav(win, pane, motion, force)
  if not force
      and ({ nvim = 1, tmux = 1 })[pane:get_user_vars()['process_name']] then
    win:perform_action(action.SendKey { mods = 'ALT', key = motion }, pane)
  else
    pane = win:active_tab():get_pane_direction(c.nav_motions[motion].dir)
    if pane then
      pane:activate()
      if pane:get_user_vars()['process_name'] == 'nvim' then
        win:perform_action(
          action.SendKey {
            mods = 'ALT',
            key = string.upper(c.nav_motions[motion].rev),
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
    { mods = 'ALT', key = '\\', action = maybe_split('\\', 'Right') },
    { mods = 'ALT', key = '-',  action = maybe_split('-', 'Bottom') },
    {
      mods = 'SHIFT|ALT',
      key = '|',
      action = action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
      mods = 'SHIFT|ALT',
      key = '_',
      action = action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
  }
end

return M
