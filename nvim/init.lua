require("config.clipboard")
require("config.keys")
require("config.options")

if vim.env.FONT_MODE == "nerd" then
  vim.cmd.packadd("nvim-web-devicons")
end

require("plugins.cmp")
require("plugins.formatting")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.misc")
require("plugins.tree")
