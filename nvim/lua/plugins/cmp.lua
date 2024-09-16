local cmp = require("cmp")
cmp.setup {
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = vim.env.FONT_MODE == "nerd" and "symbol_text" or "text",
    })
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm(),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources(
    { { name = "nvim_lsp" }, { name = "vsnip" } },
    { { name = "path" }, { name = "buffer" }, }
  ),
  window = {
    completion = {
      border = "single",
      winhighlight = "FloatBorder:FloatBorder",
    },
    documentation = {
      border = "single",
      winhighlight = "FloatBorder:FloatBorder",
    },
  }
}
