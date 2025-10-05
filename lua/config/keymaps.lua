-- lsp binds
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    local map = vim.keymap.set

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "<leader>b", "<C-o>", opts)   -- go back
    map("n", "<leader>f", "<C-i>", opts)   -- go forward
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

-- Force <C-v> into Visual Block mode
vim.keymap.set("n", "<C-v>", "<C-v>", { noremap = true })

-- Insert mode: go to normal + visual block
vim.keymap.set("i", "<C-v>", "<Esc><C-v>", { noremap = true })
