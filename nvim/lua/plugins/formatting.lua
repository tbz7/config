vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

require("conform").setup {
  default_format_opts = {
    stop_after_first = true,
    timeout_ms = 3000,
  },
  formatters_by_ft = {
    bzl = { "buildifier" },
    css = { "prettier" },
    go = { "gofmt" },
    html = { "prettier" },
    java = { "google-java-format" },
    javascript = { "prettier" },
    json = { "prettier", "jq" },
    kotlin = { "ktfmt" },
    lua = { lsp_format = "fallback" },
    nix = { "alejandra" },
    python = { "black" },
    typescript = { "prettier" },
    yaml = { "prettier" },
  },
  formatters = {
    buildifier = { command = "buildifier" },
    ktfmt = { command = "ktfmt" },
  },
  format_on_save = function(bufnr)
    local filetypes = {
      "bzl", "go", "java", "javascript", "json", "kotlin", "lua", "nix", "typescript",
    }
    return vim.tbl_contains(filetypes, vim.bo[bufnr].filetype) and {}
  end,
}
