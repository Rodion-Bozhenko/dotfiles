local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local theme = require("lualine.themes.nightfly")

local new_colors = {
	blue = "#31748f",
	green = "#9ccfd8",
	violet = "#eb6f92",
	yellow = "#f6c177",
	black = "#191724",
}

theme.normal.a.bg = new_colors.blue
theme.insert.a.bg = new_colors.green
theme.visual.a.bg = new_colors.violet
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
})
