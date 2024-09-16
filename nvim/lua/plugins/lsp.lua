local augroup = vim.api.nvim_create_augroup("plugins-lsp", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(e)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = e.buf })

    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = augroup,
      buffer = e.buf,
      callback = function()
        vim.diagnostic.open_float { border = "single" }
      end
    })

    if vim.lsp.get_client_by_id(e.data.client_id).server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = augroup,
        buffer = e.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = augroup,
        buffer = e.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    vim.opt_local.signcolumn = "yes:1"
    vim.bo[e.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { silent = true, buffer = e.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<Leader>d", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<Leader>i", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)
  end
})

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = false,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

if vim.env.FONT_MODE == "nerd" then
  local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

if vim.fn.executable("gopls") == 1 then
  require("lspconfig").gopls.setup {}
end

if vim.fn.executable("lua-language-server") == 1 then
  require("lspconfig").lua_ls.setup {}
end

if vim.fn.executable("pyright") == 1 then
  require("lspconfig").pyright.setup {}
end

require("fidget").setup()
