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
                              -- Take only the part before the first "("
                              local clean_label = item.label:match("^[^(]+") or item.label

                              -- remove bullets and weird Unicode chars
                              local label = clean_label:gsub("[%z\1-\127\194-\244][\128-\191]*", function(c)
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
                      fallback()
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
        event = "InsertEnter",
        opts = {
            bind = true,
            fix_pos = false,
            floating_window = true, -- must be true to move dynamically
            floating_window_above_cur_line = false, -- allow to appear below if more space
            always_trigger = true,
            hint_enable = true, -- disable inline hint
            hint_prefix = "👑",
            handler_opts = { border = "single" },
            wrap = false,
            hi_parameter = "LspSignatureActiveParameter",
            max_height = 12, -- max height of signature floating_window, include borders
            max_width = function ()
                return math.floor(math.max(18, vim.api.nvim_win_get_width(0) * 0.6))
            end,

            doc_lines = 4,
            transparency = 20,
            close_timeout = 2000,
            timer_interval = 100,

            -- The key fix: dynamic offset
            floating_window_off_x = 5,
            floating_window_off_y = function()
                local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
                local pumheight = vim.o.pumheight
                local winline = vim.fn.winline() -- line number in the window
                local winheight = vim.fn.winheight(0)

                -- window top
                if winline - 1 < pumheight then
                    return pumheight
                end

                -- window bottom
                if winheight - winline < pumheight then
                    return -pumheight
                end
                return 0
            end,

            -- binds
            toggle_key = '<M-x>',   -- example
            move_cursor_key = '<M-n>', -- next signature
        },
    },
}
