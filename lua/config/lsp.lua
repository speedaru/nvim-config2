-- Load user clangd config
local clangd_cfg = require("lsp.clangd")

-- Register clangd manually with new API
vim.lsp.config("clangd", clangd_cfg)

-- Register PHP (Intelephense)
-- empty for default settings
vim.lsp.config("intelephense", {}) 

vim.lsp.config("zls", {
  settings = {
    zls = {
      enable_autofix = true, -- Auto-fix minor issues like missing try/catch
      enable_snippets = true,
      warn_style = true,     -- Warn about style guide violations
    },
  },
})

vim.lsp.enable({
    "clangd",
    "lua_ls",
    "pyright",
    "intelephense",
    -- "phpactor"
    "zls",
})

-- INIT LSP SIGNATURE
-- recommended:
local sig_cfg = require("config.lsp_sig")
require'lsp_signature'.setup(sig_cfg) -- no need to specify bufnr if you don't use toggle_key


-- show errors/warnings
vim.keymap.set("n", "<C-b>", function() -- CTRL + b to show error message
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show diagnostics at cursor" })

vim.diagnostic.config({
    virtual_text = false, -- inline text
    signs = true,
    underline = true
})
