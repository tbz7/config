local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

local nvim_local = vim.fn.resolve(vim.fn.stdpath('config') .. '/../local/nvim')

require('lazy').setup({
  spec = {
    { import = 'plugins' },
    {
      import = 'local.plugins',
      enabled = vim.fn.filereadable(nvim_local .. '/lua/local/plugins.lua') == 1,
    },
  },
  install = { colorscheme = { vim.env.THEME, 'habamax' } },
  ui = {
    icons = vim.env.FONT_MODE == 'nerd' and {} or {
      cmd = '',
      config = '',
      event = '',
      ft = '',
      init = '',
      keys = '',
      lazy = '',
      plugin = '',
      runtime = '',
      source = '',
      start = '',
      task = '',
    },
  },
  performance = {
    rtp = {
      paths = { nvim_local },
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
