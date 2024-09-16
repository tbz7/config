vim.opt.clipboard = { "unnamed", "unnamedplus" }

vim.cmd.runtime("autoload/provider/clipboard.vim")

if vim.g.loaded_clipboard_provider == 1 then
  vim.g.loaded_clipboard_provider = nil

  local function copy(lines, _)
    vim.cmd.wshada()

    local stdout = vim.loop.new_tty(1, false)
    stdout:set_blocking(true)
    stdout:write {
      "\027]52;c;",
      vim.fn.system("base64 | tr -d '\\n\\r'", table.concat(lines, "\n")),
      "\027\\",
    }
  end

  local function paste()
    vim.cmd.rshada()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end

  vim.g.clipboard = {
    name = "osc52",
    copy = {
      ["*"] = copy,
      ["+"] = copy,
    },
    paste = {
      ["*"] = paste,
      ["+"] = paste,
    }
  }

  vim.cmd.runtime("autoload/provider/clipboard.vim")
end
