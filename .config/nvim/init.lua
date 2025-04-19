require("custom.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual" })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf,
                                { autotrigger = true })
    end

    if client:supports_method("textDocument/formatting") or client.name == "biome" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

vim.diagnostic.config({ virtual_text = true })

vim.lsp.enable({ "luals", "gopls", "vtsls", "biome" })
