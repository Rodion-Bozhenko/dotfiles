return {
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle)

      if vim.fn.has("persistent_undo") == 1 then
        local target_path = vim.fn.expand("~/.undodir")

        if not vim.fn.isdirectory(target_path) then
          vim.fn.mkdir(target_path, "p", "0700")
        end

        vim.o.undodir = target_path
        vim.o.undofile = true
      end
    end
  }
}
