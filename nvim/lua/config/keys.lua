vim.g.mapleader = ' '

vim.keymap.set({ 'n', 'v' }, 'k', 'gk')
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')

vim.keymap.set('n', '<C-w>\\', '<C-w>v')
vim.keymap.set('n', '<C-w>-', '<C-w>s')

local function nav(motion, reverse, direction)
  local old = vim.fn.winnr()
  vim.cmd.wincmd(motion)
  if old == vim.fn.winnr() then
    if vim.env.TMUX then
      vim.fn.system { 'tmux', 'run', '-C', '#{@force-select-pane-' .. direction .. '}' }
    else
      vim.cmd.wincmd { reverse, count = 10 }
    end
  end
end

vim.keymap.set({ 'n', 'i', 'v' }, '<M-h>', function() nav('h', 'l', 'l') end)
vim.keymap.set({ 'n', 'i', 'v' }, '<M-j>', function() nav('j', 'k', 'd') end)
vim.keymap.set({ 'n', 'i', 'v' }, '<M-k>', function() nav('k', 'j', 'u') end)
vim.keymap.set({ 'n', 'i', 'v' }, '<M-l>', function() nav('l', 'h', 'r') end)
vim.keymap.set({ 'n', 'i', 'v' }, '<M-H>', function() vim.cmd.wincmd { 'h', count = 10 } end)
vim.keymap.set({ 'n', 'i', 'v' }, '<M-J>', function() vim.cmd.wincmd { 'j', count = 10 } end)
vim.keymap.set({ 'n', 'i', 'v' }, '<M-K>', function() vim.cmd.wincmd { 'k', count = 10 } end)
vim.keymap.set({ 'n', 'i', 'v' }, '<M-L>', function() vim.cmd.wincmd { 'l', count = 10 } end)

vim.keymap.set('n', '/', '/\\v')

local function unless_alpha(replacement, orig)
  return function()
    return string.find(vim.fn.getcmdline(), '%a') and orig or replacement
  end
end

vim.keymap.set('c', 's/', unless_alpha('s/\\v', 's/'), { expr = true })
vim.keymap.set('c', 'p/', unless_alpha("!perl -pe 's/'<Left>", 'p/'), { expr = true })

vim.keymap.set('n', '<Enter>', '<C-l>j', { remap = true })

vim.keymap.set('n', '<Leader>l', function() vim.o.number = not vim.o.number end)
vim.keymap.set('n', '<Leader>w', function() vim.o.wrap = not vim.o.wrap end)

vim.keymap.set('c', 'w!!', 'SudaWrite')

vim.keymap.set('n', '<Leader>t', function() vim.cmd.NvimTreeFindFileToggle() end)
vim.keymap.set('n', '<Leader>ff', function() vim.cmd.Telescope('find_files') end)
vim.keymap.set('n', '<Leader>fg', function() vim.cmd.Telescope('live_grep') end)
