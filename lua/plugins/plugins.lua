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
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    -- auto comment
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
    },
}
