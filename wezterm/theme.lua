local wezterm = require('wezterm')

local M = {}

function M.setup(config)
  config.bold_brightens_ansi_colors = false
  config.show_new_tab_button_in_tab_bar = false
  config.show_tab_index_in_tab_bar = false
  config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

  wezterm.on('user-var-changed', function(win, pane, name, _)
    if name == 'window_overrides' then
      for _, tab in ipairs(win:mux_window():tabs()) do
        for _, p in ipairs(tab:panes()) do
          if p:get_user_vars().window_overrides
              and p:pane_id() < pane:pane_id() then
            pane = p
          end
        end
      end
      win:set_config_overrides(
        wezterm.json_parse(pane:get_user_vars().window_overrides))
    end
  end)
end

return M
