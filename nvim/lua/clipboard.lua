vim.opt.clipboard = { 'unnamed', 'unnamedplus' }

if vim.env.TMUX then
  vim.g.clipboard = {
    name = 'tmux',
    copy = {
      ['*'] = { 'tmux', 'load-buffer', '-w', '-' },
      ['+'] = { 'tmux', 'load-buffer', '-w', '-' },
    },
    paste = {
      ['*'] = { 'tmux', 'show-buffer' },
      ['+'] = { 'tmux', 'show-buffer' },
    },
  }
elseif vim.env.SSH_CONNECTION then
  vim.g.clipboard = {
    name = 'ssh',
    copy = {
      ['*'] = function(s) vim.fn.chansend(vim.v.stderr, vim.fn.system('clip', s)) end,
      ['+'] = function(s) vim.fn.chansend(vim.v.stderr, vim.fn.system('clip', s)) end,
    },
    paste = {
      ['*'] = function() return { vim.fn.getreg('', 1, true), 'V' } end,
      ['+'] = function() return { vim.fn.getreg('', 1, true), 'V' } end,
    },
  }
end
