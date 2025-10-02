-- lsp binds
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    local map = vim.keymap.set

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})


-- -- auto complete binds
-- local cmp = require("cmp")
--
-- cmp.setup({
--     -- formatting = {
--     --     format = function(entry, vim_item)
--     --         -- Use cmp.lsp.CompletionItemKind mapping
--     --         local kind = vim_item.kind
--     --         if kind == cmp.lsp.CompletionItemKind.Function or kind == cmp.lsp.CompletionItemKind.Method then
--     --             -- vim_item.abbr = vim_item.abbr:match("^[^(]+") -- strip parameters
--     --             vim_item.abbr = "nigger"
--     --         end
--     --         return vim_item
--     --     end,
--     -- },
-- })
