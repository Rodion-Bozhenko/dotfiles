-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- vertical movement with placing cursor in the middle of screen
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })

-- center cursor when going though search
vim.api.nvim_set_keymap("n", "n", "nzz", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzz", { noremap = true })

-- search in current line
keymap.set("n", "<leader>ws", '/\\%<C-R>=line(".")<CR>l\\<', { noremap = true, silent = true })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- paste from clipboard without copying into register
keymap.set("x", "p", '"_dP')

-- delete without copying into register
keymap.set("n", "<leader>dd", '"_dd')
keymap.set("v", "<leader>d", '"_d')

-- changing without yanking
keymap.set("n", "cc", '"_cc')
keymap.set("n", "c", '"_c')
keymap.set("v", "c", '"_c')

-- move selected line(s) down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- move selected line(s) up
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- netrw
keymap.set("n", "<leader>e", ":Explore<CR>")

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
keymap.set("n", "<leader>rh", ":vertical resize +10<CR>") -- increase window width
keymap.set("n", "<leader>rl", ":vertical resize -10<CR>") -- decrease window width
keymap.set("n", "<leader>rk", ":vertical resize +10<CR>") -- increase window height
keymap.set("n", "<leader>rj", ":vertical resize -10<CR>") -- decrease window height

-- Go if err != nil
keymap.set("n", "<leader>ae", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- change word under cursor in whole file
keymap.set("n", "<leader>wfc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- change word under cursor in one line
keymap.set("n", "<leader>wlc", [[:,s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])

-- toggle terminal
keymap.set("n", "<leader>ot", ":lua Toggle_terminal()<CR>", { noremap = true, silent = true })
keymap.set("t", "<leader>ct", "<C-\\><C-n>:lua Toggle_terminal()<CR>", { noremap = true, silent = true })

function _G.Toggle_terminal()
	-- If the terminal is open and valid
	if vim.g.terminal_bufid and vim.api.nvim_buf_is_valid(vim.g.terminal_bufid) then
		-- Check if terminal is visible
		local is_visible = false
		local wins = vim.api.nvim_list_wins()

		for _, win in ipairs(wins) do
			if vim.api.nvim_win_get_buf(win) == vim.g.terminal_bufid then
				is_visible = true
				vim.api.nvim_win_hide(win)
				break
			end
		end

		-- If the terminal is not visible, show it
		if not is_visible then
			vim.api.nvim_command("15split")
			vim.api.nvim_win_set_buf(0, vim.g.terminal_bufid)
			vim.cmd("startinsert")
		end
	else
		-- If the terminal is not open or not valid, open it
		vim.api.nvim_command("15split | terminal")
		vim.cmd("startinsert")
		vim.g.terminal_bufid = vim.api.nvim_get_current_buf()
	end
end

-- quit terminal mode
keymap.set("t", "<ESC>", "<C-\\><C-n>")

vim.g.original_term_height = vim.fn.winheight("%")
vim.g.is_term_maximized = false

function _G.Toggle_term_height()
	if vim.g.is_term_maximized then
		vim.cmd("resize " .. vim.g.original_term_height)
		vim.g.is_term_maximized = false
	else
		vim.g.original_term_height = vim.fn.winheight("%")
		vim.cmd("resize")
		vim.g.is_term_maximized = true
	end
end

-- toggle terminal height
keymap.set("n", "<leader>m", ":lua Toggle_term_height()<CR>", { noremap = true, silent = true })

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- telescope
keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>") -- opens telescope with last search result
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- fugitive
keymap.set("n", "<leader>G", ":Git<CR>", { noremap = true, silent = true })

-- todo-comments
keymap.set("n", "<leader>td", ":TodoTelescope<CR>", { noremap = true, silent = true })

-- folke trouble
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)

-- lsp lines
vim.keymap.set("", "<leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

-- dim inactive portions of the code
vim.keymap.set("n", "<leader>t", "<cmd>Twilight<cr>")
