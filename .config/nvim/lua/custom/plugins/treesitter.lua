-- This config taken from https://github.com/sharpchen/nix-config/blob/d357b8026930b9ec380e8cd480bbf983ed984cb0/dotfiles/nvim-config/lua/plugins/treesitter.lua#L55-L66
---@diagnostic disable: missing-fields
---@module 'lazy'
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup {}
      local should_install = {
        "c", "css", "dockerfile", "go", "gomod", "html", "hyprlang", "javascript",
        "json", "tsx",
        "just", "rust", "sql", "templ", "terraform", "toml", "typescript", "lua",
        "vim", "vimdoc", "query", "markdown", "markdown_inline", "xml"
      }

      local result = {}
      local seenInResult = {}
      local lookupSub = {}

      for _, value in ipairs(treesitter.get_installed()) do
        lookupSub[value] = true
      end

      for _, value in ipairs(should_install) do
        if not lookupSub[value] and not seenInResult[value] then
          table.insert(result, value)
          seenInResult[value] = true
        end
      end

      treesitter.install(result)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if
              vim.list_contains(
                treesitter.get_installed(),
                vim.treesitter.language.get_lang(args.match)
              )
          then
            vim.treesitter.start(args.buf)
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          include_surrounding_whitespace = true,
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local context = require("treesitter-context")
      context.setup({
        max_lines = 10,
        multiline_threshold = 5,
      })

      vim.keymap.set("n", "[c", function()
                       context.go_to_context()
                     end, { silent = true })
    end
  },
}
