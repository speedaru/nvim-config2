return {
    -- mason.nvim - install/manage lsp servers
    {
        -- "williamboman/mason.nvim",
        "williamboman/mason.nvim",
        config = true,
    },
    -- mason-lspconfig - bridge between mason & lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            -- install lsps here
            ensure_installed = { "lua_ls", "clangd", "pyright" }, 
        },
    },
    -- lsp config - configure lsp servers
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            vim.lsp.config("clangd", {
                -- clangd server specific config
            })
        end,
        opts = {
            servers = {
                clangd = {
                    cmd =  { "clangd" },
                    filetypes = { "c", "cpp", "h", "hpp" },
                    root_dir = function(...)
                        return require("lspconfig.util").root_pattern("compile_commands.json", ".git")(...)
                    end,
                },
            },
        },
    },
    -- nvim cmp auto complete
    {
      "hrsh7th/nvim-cmp",
      version = false, -- last release is way too old
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
      -- Not all LSP servers add brackets when completing a function.
      -- To better deal with this, LazyVim adds a custom option to cmp,
      -- that you can configure. For example:
      --
      -- ```lua
      -- opts = {
      --   auto_brackets = { "python" }
      -- }
      -- ```
      opts = function()
          local cmp = require("cmp")
          return {
              snippet = {
                expand = function(args)
                  require("luasnip").lsp_expand(args.body)
                end,
              },
              mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm { select = true },
              }),
              sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
              }, {
                { name = "buffer" },
                { name = "path" },
              }),
          }
      end,
    },
}
