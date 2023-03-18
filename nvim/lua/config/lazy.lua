local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = { import = 'plugins' },
  install = { colorscheme = { vim.env.NVIM_COLORSCHEME, 'habamax' } },
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
      paths = { vim.fn.resolve(vim.fn.stdpath('config') .. '/../local/nvim') },
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
