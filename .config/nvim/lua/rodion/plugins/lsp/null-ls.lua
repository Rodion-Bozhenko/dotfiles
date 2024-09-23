local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		formatting.gofmt, -- go formatter
		formatting.goimports, -- go formatter
		formatting.clang_format, -- cpp formatter
		-- formatting.autopep8, -- python formatter
		diagnostics.hadolint,
		-- diagnostics.eslint_d.with({ -- js/ts linter
		-- 	condition = function(utils)
		-- 		return utils.root_has_file(".eslintrc") or utils.root_has_file(".eslintrc.js")
		-- 	end,
		-- }),
		diagnostics.revive.with({ -- go linter
			args = function()
				local config_file = vim.fn.getcwd() .. "/revive.toml"
				if vim.fn.filereadable(config_file) == 1 then
					return { "-config=" .. config_file, "-formatter", "json", "./..." }
				end
				return { "-formatter", "json", "./..." }
			end,
		}),
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
