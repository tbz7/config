vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', extends = '❯', precedes = '❮' }
vim.opt.modeline = false
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.scrolloff = 2
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.termguicolors = vim.env.COLORTERM == 'truecolor'
vim.opt.textwidth = 80
vim.opt.updatetime = 500

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('config-options', {}),
  callback = function()
    vim.opt_local.colorcolumn = { vim.o.textwidth }
  end,
})
