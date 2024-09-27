local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"nvim-lua/plenary.nvim",
	-- theme
	"rose-pine/neovim",
	-- a lil nicer netrw
	{
		"prichrd/netrw.nvim",
		config = function()
			require("netrw").setup({
				-- Put your configuration here, or leave the object empty to take the default
				-- configuration.
				icons = {
					symlink = "", -- Symlink icon (directory and file)
					directory = "", -- Directory icon
					file = "", -- File icon
				},
				use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
				mappings = {}, -- Custom key mappings
			})
		end,
	},
	-- essential plugins: add, delete, change surroundings (it's awesome)
	{ "tpope/vim-surround", keys = { "ys", "ds", "cs" } },
	-- add '.' support for Tim Pope plugins
	"tpope/vim-repeat",
	-- moving between splits
	{ "christoomey/vim-tmux-navigator", keys = { "<C-h>", "<C-l>", "<C-j>", "<C-k>" } },
	-- zellij like moving between splits
	{
		"Lilja/zellij.nvim",
		config = function()
			require("zellij").setup({
				replaceVimWindowNavigationKeybinds = false,
				vimTmuxNavigatorKeybinds = false,
			})
		end,
		keys = { "<C-w>h", "<C-w>l", "<C-w>j", "<C-w>k" },
	},
	-- statusline
	"nvim-lualine/lualine.nvim",
	-- fuzzy finding w/ telescope: dependency for better sorting performance
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<M-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
					},
					file_ignore_patterns = {
						"yarn.lock",
						"package-lock.json",
						"node_modules/*",
						".terraform/*",
						"*.log",
						"dist/*",
						"build/*",
						"debug",
						"release",
						"Cargo.lock",
						".git/",
						"venv",
						".idea",
						".next",
					},
					preview = {
						treesitter = true,
						filesize_limit = 1,
						highlight_limit = false,
					},
				},
				pickers = {
					live_grep = {
						min_chars = 3,
					},
					find_files = {
						hidden = true,
						no_ignore = true,
					},
				},
			})

			telescope.load_extension("fzf")
		end,
		cmd = "Telescope",
	},
	-- autocompletion: completion plugin
	{ "hrsh7th/nvim-cmp", event = "InsertEnter" },
	-- source for text in buffer
	{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
	-- source for file system paths
	{ "hrsh7th/cmp-path", event = "InsertEnter" },
	-- for autocompletion to work
	{ "L3MON4D3/LuaSnip", event = "InsertEnter" },
	-- managing & installing lsp servers, linters & formatters: in charge of managing lsp servers, linters & formatters
	{ "williamboman/mason.nvim", event = { "BufRead", "BufNewFile" } },
	-- bridges gap b/w mason & lspconfig
	{ "williamboman/mason-lspconfig.nvim", event = { "BufRead", "BufNewFile" } },
	-- configuring lsp servers: easily configure language servers
	{ "neovim/nvim-lspconfig", event = { "BufRead", "BufNewFile" } },
	-- for autocompletion
	{ "hrsh7th/cmp-nvim-lsp", event = { "BufRead", "BufNewFile" } },
	-- enhanced lsp uis
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "BufRead", "BufNewFile" },
	},
	-- vs-code like icons for autocompletion
	{ "onsails/lspkind.nvim", event = { "BufRead", "BufNewFile" } },
	-- formatting & linting: configure formatters & linters
	{ "nvimtools/none-ls.nvim", event = { "BufReadPre", "BufNewFile" } },
	-- bridges gap b/w mason & null-ls
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			-- autoclose tags
			"windwp/nvim-ts-autotag",
		},
		event = { "BufReadPre", "BufNewFile" },
	},
	{ "nvim-treesitter/nvim-treesitter-context", event = { "BufReadPre", "BufNewFile" } },
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = { "BufReadPre", "BufNewFile" } },
	-- auto closing: autoclose parens, brackets, quotes, etc...
	{ "windwp/nvim-autopairs", event = "InsertEnter" },
	-- git integration: show line modifications on left hand side
	{ "lewis6991/gitsigns.nvim", event = { "BufRead", "BufWritePost" } },
	-- git integration
	{ "tpope/vim-fugitive", cmd = { "Git", "Gstatus", "Gread", "Gwrite" } },
	-- make Go development easier
	{
		"olexsmir/gopher.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("gopher").setup({
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "~/go/bin/gotests",
					impl = "impl",
					iferr = "iferr",
				},
			})
		end,
		ft = "go",
	},
	-- moving to search pattern
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			leap.set_default_keymaps()

			leap.opts.highlight_unlabeled_phase_one_targets = true
			leap.opts.case_sensitive = true
		end,
		keys = { "s", "S" },
	},
	-- highlight all uses of word under cursor
	{
		"RRethy/vim-illuminate",
		config = function()
			vim.g.Illuminate_delay = 0
		end,
		event = { "CursorMoved", "CursorMovedI" },
	},
	-- noice ui
	{
		"folke/noice.nvim",
		enabled = true,
		commit = "d9328ef903168b6f52385a751eb384ae7e906c6f",
		config = function()
			require("notify").setup({
				timeout = 1500,
				stages = "static",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	-- todo list
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble", "TroubleRefresh", "TroubleClose", "TroubleToggle" },
	},
	-- harpoon
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	--undo tree
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
	-- indent lines
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	-- syntax highlighting for terraform
	{ "hashivim/vim-terraform", ft = "terraform" },
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "BufReadPre Cargo.toml",
		config = function()
			local crates = require("crates")
			crates.setup()
			crates.show()
		end,
	},
	{
		"joerdav/templ.vim",
		ft = "templ",
	},
	{ "nanotee/sqls.nvim", ft = "sql" },
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
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
					hl = "CursorLine",
				},
			})
		end,
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
		config = function()
			require("lsp-endhints").setup({
				icons = {
					type = "=> ",
					parameter = "<- ",
					offspec = "", -- hint kind not defined in official LSP spec
					unknown = "", -- hint kind is nil
				},
				label = {
					padding = 1,
					marginLeft = 0,
					bracketedParameters = true,
				},
				autoEnableHints = true,
			})
		end,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
			})
			require("lsp_lines").setup()
		end,
	},
	{ "folke/twilight.nvim", keys = "<leader>t" },
})
