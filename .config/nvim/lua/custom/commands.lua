vim.api.nvim_create_user_command("LspRestart", function(info)
                                   local client_names = info.fargs

                                   -- Default to restarting all active servers
                                   if #client_names == 0 then
                                     client_names = vim
                                         .iter(vim.lsp.get_clients())
                                         :map(function(client)
                                           return client.name
                                         end)
                                         :totable()
                                   end

                                   for name in vim.iter(client_names) do
                                     if vim.lsp.config[name] == nil then
                                       vim.notify(("Invalid server name '%s'")
                                         :format(name))
                                     else
                                       vim.lsp.enable(name, false)
                                       if info.bang then
                                         vim.iter(vim.lsp.get_clients({
                                           name =
                                               name
                                         })):each(function(client)
                                           client:stop(true)
                                         end)
                                       end
                                     end
                                   end

                                   local timer = assert(vim.uv.new_timer())
                                   timer:start(500, 0, function()
                                     for name in vim.iter(client_names) do
                                       vim.schedule_wrap(vim.lsp.enable)(name)
                                     end
                                   end)
                                 end,
                                 {
                                   desc = "Restart the given client",
                                   nargs = "?",
                                   bang = true,
                                 })
