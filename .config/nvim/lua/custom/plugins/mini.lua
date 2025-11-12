local check_macro_recording = function()
  if vim.fn.reg_recording() ~= "" then
    return "Recording @" .. vim.fn.reg_recording()
  else
    return ""
  end
end

return {
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      local function content()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local git = MiniStatusline.section_git({ trunc_width = 40 })
        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
        local filename = MiniStatusline.section_filename({ trunc_width = 140 })
        local location = MiniStatusline.section_location({ trunc_width = 75 })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

        local os_symbols = {
          unix = " ", -- e712
          dos = " ", -- e70f
          mac = " ", -- e711
        }
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            :gsub("%[unix%]", os_symbols.unix)
            :gsub("%[dos%]", os_symbols.dos)
            :gsub("%[mac%]", os_symbols.mac)

        return MiniStatusline.combine_groups({
          { hl = mode_hl,                  strings = { string.upper(mode) } },
          { hl = "MiniStatuslineDevinfo",  strings = { git, diff, diagnostics, lsp } },
          { hl = "MiniStatusLineFilename", strings = { check_macro_recording() } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
          { hl = mode_hl,                  strings = { search, location } },
        })
      end
      statusline.setup({
        content = {
          active = content,
          inactive = content,
        },
        use_icons = true,
      })
    end,
  },
}
