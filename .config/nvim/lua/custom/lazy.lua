-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none",
    "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
                        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                        { out,                            "WarningMsg" },
                        { "\nPress any key to exit..." },
                      }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "rose-pine/neovim",
      config = function()
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
        vim.cmd.colorscheme "rose-pine"
      end
    },
    { import = "custom.plugins" }
  },
})
