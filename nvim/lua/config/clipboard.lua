vim.opt.clipboard = { 'unnamed', 'unnamedplus' }

if vim.env.SSH_CONNECTION
    or vim.endswith(vim.env.WEZTERM_EXECUTABLE or '', 'wezterm-mux-server') then
  local function copy(str)
    vim.cmd.wshada()
    vim.fn.chansend(vim.v.stderr, vim.fn.system('clip', str))
  end

  local function paste()
    vim.cmd.rshada()
    return { vim.fn.getreg('', 1, true), 'V' }
  end

  vim.g.clipboard = {
    name = 'osc52',
    copy = {
      ['*'] = copy,
      ['+'] = copy,
    },
    paste = {
      ['*'] = paste,
      ['+'] = paste,
    }
  }
end
