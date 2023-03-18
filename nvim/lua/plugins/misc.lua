return {
  {
    'lambdalisue/suda.vim',
    cmd = { 'SudaRead', 'SudaWrite' },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
        },
      }
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    enabled = vim.env.FONT_MODE == 'nerd',
  },
  {
    'udalov/kotlin-vim',
    ft = 'kotlin',
  },
}
