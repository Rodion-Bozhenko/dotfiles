local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

local null_ls_status, null_ls = pcall(require, "null-ls")
if not null_ls_status then
	return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"ts_ls",
		"html",
		"cssls",
		"dockerls",
		"gopls",
		"templ",
		"clangd",
		"lua_ls",
		"terraformls",
		"pyright",
		"rust_analyzer",
		"sqls",
		"bashls",
		"ocamllsp",
	},
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"revive", -- go linter
		"hadolint", -- dockerfile linter
		"clang-format", -- cpp formatter
		-- "autopep8", -- python formatter
		"ocamlformat", -- ocaml formatter
	},
	automatic_installation = true,
	handlers = {
		-- Hint: see https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		--       to see what sources are available
		-- Hint: see https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		--       to check what we can configure for each source
		ocamlformat = function(source_name, methods)
			null_ls.register(null_ls.builtins.formatting.ocamlformat.with({
				-- Add more arguments to a source's defaults
				-- Default: { "--enable-outside-detected-project", "--name", "$FILENAME", "-" }
				-- Type `ocamlformat --help` in your terminal to check more args
				extra_args = { "--if-then-else", "vertical" },
			}))
		end,
	},
})
