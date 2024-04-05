local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

require("treesitter-context").setup({
	max_lines = 10,
	multiline_threshold = 5,
})

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context()
end, { silent = true })

treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"svelte",
		"graphql",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"hcl",
		"rust",
		"go",
		"cpp",
		"gomod",
		"sql",
		"terraform",
	},
	-- auto install above language parsers
	auto_install = true,
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
			},
		},
	},
})
