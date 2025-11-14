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
                easing_function = "cubic", -- makes it smooth
                hide_cursor = true,
                stop_eof = true,
                respect_scrolloff = false,
                duration_multiplier = 0.7
            })
        end,
    }
}
