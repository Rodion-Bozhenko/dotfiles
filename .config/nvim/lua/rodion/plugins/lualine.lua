local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local theme = require("lualine.themes.rose-pine")

local new_colors = {
	blue = "#31748f",
	green = "#9ccfd8",
	yellow = "#f6c177",
	black = "#191724",
}

theme.normal.a.bg = new_colors.blue
theme.normal.b.fg = new_colors.blue
theme.insert.a.bg = new_colors.green
theme.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black, -- black
	},
}

lualine.setup({
	options = {
		theme = theme,
	},
	sections = {
		lualine_c = { { "filename", path = 1 } },
	},
})
