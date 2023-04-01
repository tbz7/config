local c = require('common')
local wezterm = require('wezterm')
local act = wezterm.action

local cfg = {
  bold_brightens_ansi_colors = false,
  colors = { cursor_bg = '#cccccc' },
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  cursor_blink_rate = 500,
  font_rules = {
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
  },
  front_end = 'WebGpu',
  --harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  hide_tab_bar_if_only_one_tab = true,
  initial_cols = 104,
  initial_rows = 30,
  scrollback_lines = 10000,
}

local function process_name(pane)
  return (pane:get_foreground_process_name() or ''):gsub('(.*[/\\])(.*)', '%2')
end

local function maybe_split(key, direction)
  return wezterm.action_callback(function(win, pane)
    if ({ ssh = 1, tmux = 1 })[process_name(pane)] then
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

local function active_pane(win)
  for _, ti in pairs(win:mux_window():tabs_with_info()) do
    if ti.is_active then
      for _, pi in pairs(ti.tab:panes_with_info()) do
        if pi.is_active then
          return pi.pane
        end
      end
    end
  end
end

local function nav(win, pane, motion, force)
  if not force and ({ nvim = 1, ssh = 1, tmux = 1 })[process_name(pane)] then
    win:perform_action(act.SendKey { mods = 'ALT', key = motion }, pane)
  else
    win:perform_action(act.ActivatePaneDirection(c.nav_motions[motion].dir), pane)
    wezterm.sleep_ms(5)
    local pane2 = active_pane(win)
    if pane:pane_id() ~= pane2:pane_id() and process_name(pane2) == 'nvim' then
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
