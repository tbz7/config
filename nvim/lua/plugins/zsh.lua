return {
  {
    'junegunn/fzf',
    cond = false,
    build = function()
      vim.loop.fs_symlink(
        '../nvim/lazy/fzf',
        vim.fn.resolve(vim.fn.stdpath('data') .. '/../zsh/fzf')
      )
    end,
  },
  {
    'zsh-users/zsh-syntax-highlighting',
    cond = false,
    build = function()
      vim.loop.fs_symlink(
        '../nvim/lazy/zsh-syntax-highlighting',
        vim.fn.resolve(vim.fn.stdpath('data') .. '/../zsh/zsh-syntax-highlighting')
      )
    end,
  },
}
