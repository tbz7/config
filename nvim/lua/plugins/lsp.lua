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
        vim.lsp.buf.format({ timeout_ms = 3000 })
      end
    end,
  })

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<M-Enter>', vim.lsp.buf.code_action, bufopts)
end

return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      if vim.fn.executable('gopls') then
        require('lspconfig').gopls.setup { on_attach = on_attach }
      end

      if vim.fn.executable('lua-language-server') then
        require('lspconfig').lua_ls.setup { on_attach = on_attach }
      end

      if vim.fn.executable('pyright') then
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
            condition = function() return vim.fn.executable('black') end
          },

          null_ls.builtins.formatting.gofmt.with {
            condition = function()
              return vim.fn.executable('gofmt')
                  and not vim.fn.executable('gopls')
            end,
          },

          null_ls.builtins.formatting.google_java_format.with {
            condition = function() return vim.fn.executable('google-java-format') end
          },

          null_ls.builtins.formatting.prettier.with {
            condition = function() return vim.fn.executable('prettier') end,
            filetypes = { 'css', 'html', 'javascript', 'json', 'typescript' },
            extra_args = { '--single-quote' },
          },

          null_ls.builtins.formatting.jq.with {
            condition = function()
              return vim.fn.executable('jq')
                  and not vim.fn.executable('prettier')
            end
          },
        },
        on_attach = on_attach,
      }
    end,
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end
  },
}
