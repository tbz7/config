local nav = require('common.nav')

vim.g.mapleader = ' '

vim.keymap.set({ 'n', 'v' }, 'k', 'gk')
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')

vim.keymap.set('n', '<C-w>\\', '<C-w>v')
vim.keymap.set('n', '<C-w>-', '<C-w>s')

local function do_nav(motion)
  local old = vim.fn.winnr()
  vim.cmd.wincmd(motion)
  if old == vim.fn.winnr() and vim.env.TERM == 'wezterm' then
    vim.loop.new_tty(1, false):write(
      '\x1b]1337;SetUserVar=force_nav=' .. nav.motions[motion].var .. '\a')
  end
end

local augroup = vim.api.nvim_create_augroup('config-keys', {})
vim.api.nvim_create_autocmd('UIEnter', {
  group = augroup,
  callback = function()
    vim.loop.new_tty(1, false):write('\x1b]1337;SetUserVar=nvim=dHJ1ZQ==\a')
  end,
})
vim.api.nvim_create_autocmd('UILeave', {
  group = augroup,
  callback = function()
    vim.loop.new_tty(1, false):write('\x1b]1337;SetUserVar=nvim=\a')
  end,
})

for _, motion in pairs { 'h', 'j', 'k', 'l' } do
  vim.keymap.set({ 'n', 'i', 'v' }, '<M-' .. motion .. '>', function()
    do_nav(motion)
  end)
  vim.keymap.set({ 'n', 'i', 'v' }, '<M-' .. motion:upper() .. '>', function()
    vim.cmd.wincmd { motion, count = 10 }
  end)
end

local function unless_alpha(replacement, orig)
  return function()
    return vim.fn.getcmdline():find('%a') and orig or replacement
  end
end

vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', 's/', unless_alpha('s/\\v', 's/'), { expr = true })
vim.keymap.set('c', 'p/', unless_alpha("!perl -pe 's/'<Left>", 'p/'), { expr = true })

vim.keymap.set('n', '<Enter>', '<C-l>j', { remap = true })

vim.keymap.set('n', '<Leader>l', function() vim.o.number = not vim.o.number end)
vim.keymap.set('n', '<Leader>w', function() vim.o.wrap = not vim.o.wrap end)

vim.keymap.set('c', 'w!!', 'SudaWrite')

vim.keymap.set('n', '<Leader>t', function() vim.cmd.NvimTreeFindFileToggle() end)
vim.keymap.set('n', '<Leader>ff', function() vim.cmd.Telescope('find_files') end)
vim.keymap.set('n', '<Leader>fg', function() vim.cmd.Telescope('live_grep') end)
vim.keymap.set('n', '<Leader>F', function() vim.lsp.buf.format { timeout_ms = 3000 } end)
