require("custom.lazy")
require("custom.autocommands")
require("custom.commands")

vim.diagnostic.config({ virtual_text = true })

vim.lsp.enable({ "luals", "gopls", "vtsls", "biome", "just" })
