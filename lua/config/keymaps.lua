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

-- -- Disable lsp signature when pressing up and down arrows
-- local feedkeys = function(keys)
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "i", true)
-- end
-- -- Map Up/Down only in this buffer
-- vim.keymap.set("i", "<Up>", function()
--     feedkeys("<A-x>") -- close signature
--     return "<Up>"
-- end, { expr = true, noremap = true, silent = true, buffer = bufnr })
--
-- vim.keymap.set("i", "<Down>", function()
--     feedkeys("<A-x>") -- close signature
--     return "<Down>"
-- end, { expr = true, noremap = true, silent = true, buffer = bufnr })

-- Remap yanks to use OSC52
local osc52 = require('osc52')

vim.keymap.set('n', '<leader>y', function()
  osc52.copy_register('"')
  end)

  vim.keymap.set('v', '<leader>y', function()
    osc52.copy_visual()
end)
