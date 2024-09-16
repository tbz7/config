vim.opt.expandtab = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "syntax"
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", extends = "❯", precedes = "❮" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 2
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.termguicolors = vim.env.COLORTERM == "truecolor"
vim.opt.updatetime = 500
vim.opt.guicursor = { "n-v-c-sm:block", "i-ci-ve:ver25", "r-cr-o:hor20",
  "i-ci-ve-r-cr-o:blinkwait175-blinkoff150-blinkon175", "a:Cursor" }

if vim.env.COLORSCHEME and vim.o.termguicolors then
  pcall(vim.cmd.colorscheme, vim.env.COLORSCHEME)
end

local augroup = vim.api.nvim_create_augroup("config-options", {})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitconfig", "go" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.listchars:append { tab = "  " }
    vim.opt_local.softtabstop = 0
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  callback = function()
    vim.opt_local.colorcolumn = { vim.o.textwidth == 0 and 100 or vim.o.textwidth }
  end,
})

vim.filetype.add({
  pattern = {
    [".*/.*\\.*.service"]     = "systemd",
    [".*/git/config"]         = "gitconfig",
    [".*/git/ignore"]         = "gitignore",
    [".*/ssh/config"]         = "sshconfig",
    [".*/zprofile"]           = "zsh",
    [".*/zsh.*/functions/.*"] = "zsh",
    [".*"]                    = {
      priority = -math.huge,
      function(_, bufnr)
        local content = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
        if vim.regex([[^#!.*luafile.*]]):match_str(content) then
          return "lua"
        end
      end,
    },
  },
})
