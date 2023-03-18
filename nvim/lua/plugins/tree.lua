return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = {
      'NvimTreeFindFile',
      'NvimTreeFindFileToggle',
      'NvimTreeOpen',
      'NvimTreeToggle',
    },
    config = function()
      require('nvim-tree').setup {
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = vim.env.FONT_MODE == 'nerd' and {} or {
              file = false,
              folder = false,
              folder_arrow = false,
              git = false,
              modified = false,
            },
          }
        },
        filters = {
          dotfiles = true,
        },
        git = {
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      }
    end
  }
}
