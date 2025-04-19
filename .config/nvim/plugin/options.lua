local opt = vim.opt

opt.swapfile = false

opt.number = true
opt.relativenumber = true
opt.clipboard = "unnamedplus"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.signcolumn = "yes"

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

opt.scrolloff = 16

opt.guicursor = ""

vim.g.netrw_banner = 0

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"
