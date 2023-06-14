local augroup = vim.api.nvim_create_augroup('plugins-lsp', {})

local function on_attach(client, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup,
    buffer = bufnr,
    callback = function()
      if vim.o.filetype == 'go'
          or vim.o.filetype == 'java'
          or vim.o.filetype == 'lua'
          or vim.o.filetype == 'kotlin' then
        vim.lsp.buf.format { timeout_ms = 3000 }
      end
    end,
  })

  vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float { border = 'single' }
    end
  })

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  vim.opt_local.signcolumn = 'yes:1'

  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<M-Enter>', vim.lsp.buf.code_action, opts)
end

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = false,
}

vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

if vim.env.FONT_MODE == 'nerd' then
  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

local function is_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      if is_executable('gopls') then
        require('lspconfig').gopls.setup { on_attach = on_attach }
      end

      if is_executable('lua-language-server') then
        require('lspconfig').lua_ls.setup { on_attach = on_attach }
      end

      if is_executable('pyright') then
        require('lspconfig').pyright.setup { on_attach = on_attach }
      end
    end
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup {
        sources = {
          null_ls.builtins.diagnostics.zsh,

          null_ls.builtins.formatting.black.with {
            condition = function() return is_executable('black') end
          },

          null_ls.builtins.formatting.gofmt.with {
            condition = function()
              return is_executable('gofmt')
                  and not is_executable('gopls')
            end,
          },

          null_ls.builtins.formatting.google_java_format.with {
            condition = function() return is_executable('google-java-format') end
          },

          null_ls.builtins.formatting.prettier.with {
            condition = function() return is_executable('prettier') end,
            filetypes = { 'css', 'html', 'javascript', 'json', 'typescript' },
            extra_args = { '--single-quote' },
          },

          null_ls.builtins.formatting.jq.with {
            condition = function()
              return is_executable('jq') and not is_executable('prettier')
            end
          },
        },
        on_attach = on_attach,
      }
    end,
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function()
      require('fidget').setup()
    end
  },
}
