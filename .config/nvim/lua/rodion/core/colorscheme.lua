require("rose-pine").setup({
	disable_italics = true,
	highlight_groups = {
		Function = { fg = "#94B3FD", bg = "none" },
		Type = { fg = "rose", bg = "none" },
		Operator = { fg = "love", bg = "none" },
		Boolean = { fg = "love", bg = "none" },
		["@keyword.operator"] = { fg = "love", bg = "none" },
		["@type.builtin"] = { fg = "rose", bg = "none" },
		["@keyword.operator.tsx"] = { fg = "love", bg = "none" },
		["@method"] = { fg = "foam", bg = "none" },
		["@namespace.go"] = { fg = "love", bg = "none" },
		["@function.builtin.go"] = { fg = "#9ccfd8", bg = "none" },
		["@tag.delimiter.css"] = { fg = "iris", bg = "none" },
		["@number.css"] = { fg = "iris", bg = "none" },
		["@string.css"] = { fg = "iris", bg = "none" },

		Pmenu = { fg = "none", bg = "none" },
		CmpItemKind = { fg = "love", bg = "none" },
		CmpItemKindFunction = { fg = "#94B3FD", bg = "none" },

		NotifyINFOBorder = { fg = "pine", bg = "none" },

		GitSignsAdd = { bg = "none" },
		GitSignsChange = { bg = "none" },
		GitSignsDelete = { bg = "none" },
	},
})

local status, _ = pcall(vim.cmd, "colorscheme rose-pine")
if not status then
	print("Colorscheme not found!")
	return
end

vim.cmd([[
  hi Normal guibg=NONE ctermbg=NONE ctermfg=NONE
  hi NormalFloat guibg=NONE ctermbg=NONE ctermfg=NONE
  hi FloatBorder guibg=NONE ctermbg=NONE ctermfg=NONE
  hi NvimTreeNormal guibg=NONE ctermbg=NONE ctermfg=NONE
  hi TelescopeNormal guibg=NONE ctermbg=NONE ctermfg=NONE
  hi TelescopeBorder guibg=NONE ctermbg=NONE ctermfg=NONE
  hi TelescopePromptNormal guibg=NONE ctermbg=NONE ctermfg=NONE
  hi LspSagaHoverBorder ctermbg=NONE ctermfg=NONE guifg=NONE
  hi LspSagaSignatureHelpBorder ctermbg=NONE ctermfg=NONE guifg=NONE
  hi LspSagaCodeActionBorder ctermbg=NONE ctermfg=NONE guifg=NONE
  hi LspSagaRenameBorder ctermbg=NONE ctermfg=NONE guifg=NONE
  hi LspSagaDefPreviewBorder ctermbg=NONE ctermfg=NONE guifg=NONE
  hi LspSagaLspFinderBorder ctermbg=NONE ctermfg=NONE guifg=NONE
]])
