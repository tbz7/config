return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      vim.opt.showmode = false

      local nerdfont = vim.env.FONT_MODE == 'nerd'
      local options = {
        component_separators = '',
        icons_enabled = nerdfont,
      }
      if not nerdfont and vim.env.FONT_MODE ~= 'powerline' then
        options.section_separators = ''
      end

      require('lualine').setup {
        options = options,
        sections = {
          lualine_x = {
            { 'encoding',   cond = function() return vim.o.fileencoding ~= 'utf-8' end },
            { 'fileformat', cond = function() return vim.o.fileformat ~= 'unix' end },
            { 'filetype' }
          },
        },
      }

      local augroup = vim.api.nvim_create_augroup('plugins-lualine', {})
      local old_is_focused = require('lualine.utils.utils').is_focused
      vim.api.nvim_create_autocmd('FocusGained', {
        group = augroup,
        callback = function()
          require('lualine.utils.utils').is_focused = old_is_focused
          require('lualine').refresh()
        end,
      })
      vim.api.nvim_create_autocmd('FocusLost', {
        group = augroup,
        callback = function()
          require('lualine.utils.utils').is_focused = function() return false end
          require('lualine').refresh()
        end,
      })
    end,
  }
}
