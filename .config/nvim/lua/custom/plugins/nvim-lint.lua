return {
  {
    "mfussenegger/nvim-lint",
    filetype = "go",
    config = function()
      require("lint").linters_by_ft = {
        go = { "revive" }
      }

      -- revive config
      local revive = require("lint.linters.revive")
      local config_file = vim.fn.getcwd() .. "/revive.toml"
      local args = {}
      if vim.fn.filereadable(config_file) == 1 then
        args = { "-config=" .. config_file, "-formatter", "json", "./..." }
      end
      args = { "-formatter", "json", "./..." }
      revive.args = args

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  }
}
