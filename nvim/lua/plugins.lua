local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.glob(packer_path) == '' then
  vim.fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    packer_path,
  })
  vim.cmd.packadd('packer.nvim')
end

require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'

    local local_config =
        vim.fn.resolve(vim.fn.stdpath('config') .. '/../local/nvim')
    if vim.fn.glob(local_config) ~= '' then
      use {
        local_config,
        as = 'local',
      }
    end

    use 'arcticicestudio/nord-vim'
    use 'cocopon/iceberg.vim'
    use 'folke/tokyonight.nvim'
    use 'lifepillar/vim-gruvbox8'
    use 'whatyouhide/vim-gotham'

    use 'lambdalisue/suda.vim'
    use 'udalov/kotlin-vim'

    use {
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

        local old_is_focused = require('lualine.utils.utils').is_focused
        require 'lualine.utils.utils'.is_focused = function()
          if _G.ForceLualineFocus ~= nil then
            return _G.ForceLualineFocus
          end
          return old_is_focused()
        end

        local augroup = vim.api.nvim_create_augroup('plugins.lua-lualine', {})
        vim.api.nvim_create_autocmd('FocusGained', {
          group = augroup,
          callback = function() ForceLualineFocus = nil end,
        })
        vim.api.nvim_create_autocmd('FocusLost', {
          group = augroup,
          callback = function() ForceLualineFocus = false end,
        })
      end,
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function() require('telescope').setup() end
    }

    use {
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
    }

    use 'neovim/nvim-lspconfig'

    use {
      'williamboman/mason.nvim',
      requires = { 'williamboman/mason-lspconfig.nvim' },
      config = function()
        require('mason').setup()
        require('mason-lspconfig').setup()
        require('mason-lspconfig').setup_handlers {
          function(server_name)
            require('lspconfig')[server_name].setup {}
          end,
        }
      end
    }

    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
      },
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          snippet = {
            expand = function(args)
              vim.fn['vsnip#anonymous'](args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(4),
            ['<C-f>'] = cmp.mapping.scroll_docs(-4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'vsnip' },
          }, {
            { name = 'buffer' },
          }),
          experimental = {
            ghost_text = true,
          },
        })
      end
    }
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
})

local augroup = vim.api.nvim_create_augroup('plugins.lua', {})

if vim.fn.glob(vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua') == '' then
  vim.api.nvim_create_autocmd('User', {
    group = augroup,
    pattern = 'PackerComplete',
    callback = function()
      vim.cmd.quit()
      vim.cmd.source(vim.env.MYVIMRC)
    end,
    once = true,
    nested = true,
  })
  require('packer').sync()
end

vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = { vim.fn.resolve(vim.fn.stdpath('config') .. '/lua/plugins.lua') },
  callback = function(e)
    vim.cmd.redraw()
    vim.cmd.source(e.file)
    vim.cmd.PackerCompile()
    print('Regenerated packer_compiled.lua!')
  end,
})
