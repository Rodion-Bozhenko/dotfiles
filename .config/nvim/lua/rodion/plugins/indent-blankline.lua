vim.cmd([[highlight IblScope guifg=#9ccfd8 gui=nocombine]])
require("ibl").setup({
	indent = { char = "▏" },
	scope = { show_start = false },
})
