require("custom.lazy")
require("custom.autocommands")

vim.diagnostic.config({ virtual_text = true })

vim.lsp.enable({ "luals", "gopls", "vtsls", "biome", "just" })
