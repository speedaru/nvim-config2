-- vim.lsp.config("pyright", {
--   settings = {
--     python = {
--       analysis = {
--         typeCheckingMode = "strict",
--       },
--     },
--   },
-- })

-- vim.lsp.config.clangd = {
--   cmd = { 'clangd', '--background-index' },
--   root_markers = { 'compile_commands.json', 'compile_flags.txt' },
--   filetypes = { 'c', 'cpp', 'h', 'hpp' }
-- }

-- load user clangd config
local clangd_cfg = dofile(vim.fn.stdpath("config") .. "/lsp/clangd.lua")

-- explicitly register it
vim.lsp.config("clangd", clangd_cfg)

vim.lsp.enable({
    "clangd",
    "lua_ls",
    "pyright"
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
