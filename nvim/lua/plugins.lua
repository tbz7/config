local augroup = vim.api.nvim_create_augroup('plugins.lua', {})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = { vim.fs.dirname(vim.env.MYVIMRC) .. '/lua/plugins.lua' },
  callback = function(e)
    vim.cmd.source(e.file)
    vim.cmd.PackerCompile()
  end,
})

return require('packer').startup({{
  'wbthomason/packer.nvim',

  'arcticicestudio/nord-vim',
  'cocopon/iceberg.vim',
  'folke/tokyonight.nvim',
  'lifepillar/vim-gruvbox8',
  'whatyouhide/vim-gotham',

  'lambdalisue/suda.vim',
  'udalov/kotlin-vim',

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      vim.opt.showmode = false

      local nerdfont = vim.env.FONT_MODE == 'nerd'
      local powerlinefont = nerdfont or vim.env.FONT_MODE == 'powerline'

      local options = {
        icons_enabled = nerdfont,
      }

      if not powerlinefont then
        options.component_separators = ''
        options.section_separators = ''
      end

      require('lualine').setup {
        options = options
      }

      local old_is_focused = require'lualine.utils.utils'.is_focused
      require'lualine.utils.utils'.is_focused = function()
        if _G.ForceLualineFocus ~= nil then
          return _G.ForceLualineFocus
        end
        return old_is_focused()
      end

      local augroup = vim.api.nvim_create_augroup('plugins.lua-lualine', {})
      vim.api.nvim_create_autocmd('FocusGained', {
        group = augroup,
        callback = function(e) ForceLualineFocus = nil end,
      })
      vim.api.nvim_create_autocmd('FocusLost', {
        group = augroup,
        callback = function(e) ForceLualineFocus = false end,
      })
    end,
  },

  --{
  --  'nvim-telescope/telescope.nvim',
  --  requires = { 'nvim-lua/plenary.nvim' },
  --  config = function() require('telescope').setup() end
  --},

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      local nerdfont = vim.env.FONT_MODE == 'nerd'
      require('nvim-tree').setup({
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = nerdfont,
              folder = nerdfont,
              folder_arrow = nerdfont,
              git = nerdfont,
              modified = nerdfont,
            },
          }
        },
        filters = {
          dotfiles = true,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
    end
  },

  {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers {
        function (server_name)
          require('lspconfig')[server_name].setup {}
        end,
      }
    end
  },

},

config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})
