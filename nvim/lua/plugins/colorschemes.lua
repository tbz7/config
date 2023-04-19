local initial_specs = {
  gotham = { 'whatyouhide/vim-gotham' },
  gruvbox = { 'ellisonleao/gruvbox.nvim' },
  iceberg = { 'cocopon/iceberg.vim' },
  nord = { 'arcticicestudio/nord-vim' },
  tokyonight = { 'folke/tokyonight.nvim' },
}

if not initial_specs[vim.env.THEME] then
  vim.cmd.colorscheme('habamax')
end

local specs = {}
for scheme, spec in pairs(initial_specs) do
  table.insert(specs, spec)
  if scheme == vim.env.THEME then
    spec.lazy = false
    spec.priority = 1000
    spec.config = function() vim.cmd.colorscheme(scheme) end
  else
    spec.lazy = true
  end
end
return specs
