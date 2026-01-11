return {
	-- catppuccin colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
    },
    -- autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        -- config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    -- auto comment
    {
        'numToStr/Comment.nvim',
        opts = {
            pre_hook = function(ctx)
                local ft = require("Comment.ft")
                ft.asm = "; %s"
            end,
        },
    },
    -- smooth scrolling
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup({
                easing_function = "linear", -- makes it smooth
                hide_cursor = true,
                stop_eof = true,
                respect_scrolloff = false,
                duration_multiplier = 0.2
            })
        end,
    },
    -- clipboard forwarding ssh
    {
        "ojroques/nvim-osc52",
        config = function()
            require("osc52").setup()
        end,
    },
    -- telescope
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },

        config = function()
            require('telescope').setup({
                defaults = {
                    make_relative = true,
                },
            })

            -- keymaps
            vim.keymap.set("n", "<space>ff", function()
                require("telescope.builtin").find_files{
                    cwd = vim.loop.cwd(),
                }
            end)

            vim.keymap.set("n", "<space>lg", function()
                require("telescope.builtin").live_grep{
                    cwd = vim.loop.cwd(),
                }
            end)
        end
    }
}
