local exclude = {
  "**/yarn.lock",
  "**/package-lock.json",
  "**/node_modules/**",
  "**/.terraform/**",
  "**/*.log",
  "**/dist/**",
  "**/build/**",
  "**/debug",
  "**/release",
  "**/Cargo.lock",
  "**/.git/**",
  "**/venv",
  "**/.idea",
  "**/.next",
}
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        layout = {
          preset = "ivy", layout = { position = "bottom", height = 0.8 }
        },
      },
      explorer = {},
      bigfile = {},
      indent = {
        -- animate scopes. Enabled by default for Neovim >= 0.10
        -- Works on older versions but has to trigger redraws during animation.
        ---@class snacks.indent.animate: snacks.animate.Config
        ---@field enabled? boolean
        --- * out: animate outwards from the cursor
        --- * up: animate upwards from the cursor
        --- * down: animate downwards from the cursor
        --- * up_down: animate up or down based on the cursor position
        ---@field style? "out"|"up_down"|"down"|"up"
        animate = {
          enabled = false, -- vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 20,   -- ms per step
            total = 100, -- maximum duration
          },
        },
      }
    },
    keys = {
      { "<leader>fs", function() Snacks.picker.smart() end,   desc = "Smart Find Files" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep({
            hidden = true,
            ignored = true,
            exclude = exclude
          })
        end,
        desc = "Grep"
      },
      { "<leader>:",  function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n",  function() Snacks.picker.notifications() end,   desc = "Notification History" },
      { "<leader>fe", function() Snacks.explorer() end,               desc = "File Explorer" },
      { "<leader>fb", function() Snacks.picker.buffers() end,         desc = "Buffers" },
      {
        "<leader>fc",
        function()
          Snacks.picker.files({
            cwd = vim.fn.stdpath("config")
          })
        end,
        desc = "Find Config File"
      },
      {
        "<leader>fd",
        function()
          Snacks.picker.files({
            hidden = true,
            ignored = true,
            exclude = exclude
          })
        end,
        desc = "Find Files"
      },
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>fh", function() Snacks.picker.help() end,    desc = "Help Pages" }
    },
  }
}
