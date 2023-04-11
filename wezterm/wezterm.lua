local c = require('common')
local wezterm = require('wezterm')
local act = wezterm.action

local cfg = wezterm.config_builder()

cfg.bold_brightens_ansi_colors = false
cfg.colors = { cursor_bg = '#cccccc' }
cfg.cursor_blink_ease_in = 'Constant'
cfg.cursor_blink_ease_out = 'Constant'
cfg.cursor_blink_rate = 500
cfg.font_rules = {
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
cfg.front_end = 'WebGpu'
--cfg.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
cfg.initial_cols = 104
cfg.initial_rows = 30
cfg.native_macos_fullscreen_mode = true
cfg.quote_dropped_files = 'Posix'
cfg.scrollback_lines = 10000
cfg.unix_domains = { { name = 'unix' } }
cfg.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

local function maybe_split(key, direction)
  return wezterm.action_callback(function(win, pane)
    if pane:get_user_vars()['process-name'] == 'tmux' then
      win:perform_action(act.SendKey { mods = 'ALT', key = key }, pane)
    else
      pane:split { direction = direction }
    end
  end)
end

cfg.keys = {
  { mods = 'ALT', key = '\\', action = maybe_split('\\', 'Right') },
  { mods = 'ALT', key = '-',  action = maybe_split('-', 'Bottom') },
  {
    mods = 'SHIFT|ALT',
    key = '|',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  {
    mods = 'SHIFT|ALT',
    key = '_',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' }
  },
}

cfg.mouse_bindings = {
  {
    mods = 'SUPER',
    event = { Down = { streak = 1, button = 'Left' } },
    action = act.Nop,
    mouse_reporting = true,
  },
  {
    mods = 'SUPER',
    event = { Drag = { streak = 1, button = 'Left' } },
    action = act.StartWindowDrag,
    mouse_reporting = true,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    action = act.CompleteSelection('ClipboardAndPrimarySelection'),
  },
  {
    mods = 'SUPER',
    event = { Up = { streak = 1, button = 'Left' } },
    action = act.OpenLinkAtMouseCursor,
  },
  {
    mods = 'SUPER',
    event = { Up = { streak = 1, button = 'Left' } },
    action = act.OpenLinkAtMouseCursor,
    mouse_reporting = true,
  },
}

local function nav(win, pane, motion, force)
  if not force
      and ({ nvim = 1, tmux = 1 })[pane:get_user_vars()['process-name']] then
    win:perform_action(act.SendKey { mods = 'ALT', key = motion }, pane)
  else
    win:perform_action(act.ActivatePaneDirection(c.nav_motions[motion].dir), pane)
    wezterm.sleep_ms(5)
    local pane2 = win:active_pane()
    if pane:pane_id() ~= pane2:pane_id()
        and pane2:get_user_vars()['process-name'] == 'nvim' then
      win:perform_action(act.SendKey {
        mods = 'ALT', key = string.upper(c.nav_motions[motion].rev) }, pane2)
    end
  end
end

for _, motion in pairs { 'h', 'j', 'k', 'l' } do
  table.insert(cfg.keys, {
    mods = 'ALT',
    key = motion,
    action = wezterm.action_callback(function(win, pane)
      nav(win, pane, motion, false)
    end)
  })
end

wezterm.on('user-var-changed', function(win, pane, name, value)
  if name == 'force-nav' then
    nav(win, pane, value, true)
  end
end)

return cfg
