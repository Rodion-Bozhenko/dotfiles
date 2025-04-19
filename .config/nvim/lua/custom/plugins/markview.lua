return {
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("markview").setup({
				code_blocks = {
					style = "language",
					border_hl = "CursorLine",
				},
			})
		end,
	}
}
