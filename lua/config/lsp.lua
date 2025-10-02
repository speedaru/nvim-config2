vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
      },
    },
  },
})


-- code completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("clangd", {
  capabilities = capabilities,
})

-- show errors/warnings
vim.keymap.set("n", "<C-b>", function() -- CTRL + b to show error message
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show diagnostics at cursor" })

vim.diagnostic.config({
    virtual_text = true, -- inline text
    signs = true,
    underline = true
})
