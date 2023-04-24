local wezterm = require('wezterm')

local M = {}

local function setup_theme(config, theme)
  local palette = require('common.themes.' .. theme)

  config.colors = {
    background = palette.bg,
    foreground = palette.fg,
    cursor_bg = palette.fg,
    cursor_fg = palette.bg,
    cursor_border = palette.fg,
    selection_bg = palette.visual_bg,
    selection_fg = palette.visual_fg,
    tab_bar = {
      active_tab = {
        fg_color = palette.bfg,
        bg_color = palette.bbg,
      },
      inactive_tab = {
        fg_color = palette.bfgi,
        bg_color = palette.bbgi,
      },
      inactive_tab_hover = {
        fg_color = palette.bfg,
        bg_color = palette.bbg,
      },
      inactive_tab_edge = palette.bfgi,
      new_tab = {
        fg_color = palette.bfgi,
        bg_color = palette.bbgi,
      },
      new_tab_hover = {
        fg_color = palette.bfg,
        bg_color = palette.bbg,
      }
    },
  }

  config.window_frame = {
    active_titlebar_fg = palette.cfg,
    active_titlebar_bg = palette.cbg,
    inactive_titlebar_fg = palette.cfgi,
    inactive_titlebar_bg = palette.cbgi,
  }

  return config
end

function M.setup(config)
  config.bold_brightens_ansi_colors = false
  config.show_tab_index_in_tab_bar = false
  config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

  local theme = 'iceberg'
  local f = io.open(os.getenv('HOME') .. '/.local/state/zsh/theme', 'rb')
  if f then
    theme = f:read('a')
    f:close()
  end

  setup_theme(config, theme)

  wezterm.on('user-var-changed', function(win, pane, name, _)
    if name == 'theme' then
      for _, tab in ipairs(win:mux_window():tabs()) do
        for _, p in ipairs(tab:panes()) do
          if p:get_user_vars().theme and p:pane_id() < pane:pane_id() then
            pane = p
          end
        end
      end
      win:set_config_overrides(setup_theme({}, pane:get_user_vars().theme))
    end
  end)
end

return M
