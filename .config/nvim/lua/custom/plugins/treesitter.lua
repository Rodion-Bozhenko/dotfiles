return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
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
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = {
          "c", "css", "dockerfile", "go", "gomod", "html", "hyprlang", "javascript", "json",
          "just", "rust", "sql", "templ", "terraform", "toml", "typescript", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline"
        },
        sync_install = false,
        auto_install = false,
        indent = { enable = true },
        autotag = { enable = true },
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat,
                                    vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
            },
          },
        },
      }
    end
  },
}
