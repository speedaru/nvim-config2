local opt = vim.opt

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- UI
opt.number = true
opt.relativenumber = true
opt.termguicolors = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- lsp
vim.lsp.enable("pyright")

-- colorscheme (can also be in plugin config if it's a plugin)
vim.cmd.colorscheme("catppuccin-macchiato")
