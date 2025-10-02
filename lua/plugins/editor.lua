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
        }
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
        "L3MON4D3/LuaSnip",         -- snippet engine
        "saadparwaiz1/cmp_luasnip", -- bridge between luasnip & cmp
        -- "hrsh7th/cmp-nvim-lsp-signature-help", -- function params
      },
      opts = function ()
          local cmp = require("cmp")
          return {
              snippet = {
                  expand = function (args)
                      require("luasnip").lsp_expand(args.body)
                  end,
              },
              mapping = cmp.mapping.preset.insert({
                  ["<C-Space>"] = cmp.mapping.complete(),
                  -- ["<S-Tab>"] = cmp.mapping.confirm({ select = true }),
                  ["<S-Tab>"] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                          local entry = cmp.get_entries()[1] -- by default set entry to first
                          if cmp.get_selected_entry() then -- if a specific entry is selected use that one
                              entry = cmp.get_selected_entry()
                          end

                          local item = entry.completion_item

                          -- Override textEdit for functions/methods
                          if item.kind == 3 or item.kind == 2 then -- Function or Method
                              local label = item.label
                              -- remove bullets and weird Unicode chars
                              label = label:gsub("[%z\1-\127\194-\244][\128-\191]*", function(c)
                                  -- keep ASCII printable only
                                  if c:match("[%g%p]") then return c else return "" end
                              end)
                              item.insertText = label .. "()" -- fn name + ()
                              item.textEdit = nil   -- remove original textEdit
                          end

                          cmp.confirm({ select = true })
                          
                          -- Move cursor inside the parentheses only if auto compl func or method
                          if item.kind == 3 or item.kind == 2 then -- Function or Method
                              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", true)
                          end
                      else
                          fallback()
                      end
                  end, { "i", "s" }),
                  ["<C-n>"] = cmp.mapping.select_next_item(),
                  ["<C-p>"] = cmp.mapping.select_prev_item(),
                  ["<C-e>"] = cmp.mapping.abort(),

                  -- Disable arrow keys for completion
                  ["<Up>"] = function(fallback) fallback() end,
                  ["<Down>"] = function(fallback) fallback() end,

                  -- make enter do a LF if no suggestiosn selected
                  ["<CR>"] = cmp.mapping(function(fallback)
                      if cmp.visible() and cmp.get_selected_entry() then
                          cmp.confirm({ select = false })
                      else
                          fallback()
                      end
                  end, { "i", "s" }),
              }),
              sources = cmp.config.sources({
                  { name = "nvim_lsp" },
                  { name = "luasnip" },
                  { name = "nvim_lsp_signature_help"},-- function params
              }, {
                  { name = "buffer" },
                  { name = "path" },
              }),
              formatting = {
                  fields = { "abbr", "kind" },
                  format = function(entry, vim_item)
                      if vim_item.kind == "Function" or vim_item.kind == "Method" then
                          vim_item.abbr = vim_item.abbr:match("^[^(~]+")
                      end
                      return vim_item
                  end,
              },
          }
      end,
    },
    -- code snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function ()
            require("luasnip.loaders.from_vscode").lazy_load() -- load snippets
        end,
    },
    -- show function signature when typing arguments
    {
        "ray-x/lsp_signature.nvim",
        config = {
            bind = true,
            doc_lines = 0,
            hint_enable = false,    -- disable inline virtual text hints
            floating_window = true, -- show in a floating window
            toggle_key = '<M-x>',   -- example
            handler_opts = { border = "rounded" },
            transparency = 10,
        },
    },
}
