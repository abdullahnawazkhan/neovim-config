require('base.set')
require('base.remap')
require('base.lazy') -- This runs first to install everything

-- Now load the settings for those plugins
local custom_configs = { "lsp", "telescope", "dap" }
for _, name in ipairs(custom_configs) do
  local ok, err = pcall(require, "base.plugins." .. name)
  if not ok then print("Config error in " .. name .. ": " .. err) end
end

-- Plugins that don't need a custom file (gitblame, commentary) 
-- work automatically because they are in lazy.lua
require('gitblame').setup({ enabled = true })

-- local copilot_models_loaded = false
-- local copilot_group = vim.api.nvim_create_augroup("CopilotSequelizeLoader", { clear = true })

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   group = copilot_group,
--   callback = function()
--     if vim.bo.filetype == "copilot-chat" and not copilot_models_loaded then
--       local chat = require("CopilotChat")
--       local cwd = vim.fn.getcwd()
--       local models_dir = cwd .. "/server/models"
      
--       if vim.fn.isdirectory(models_dir) ~= 0 then
--         local files = vim.fn.globpath(models_dir, "*.{js,ts}", false, true)
        
--         if #files > 0 then
--           local sticky_resources = {}
--           for _, f in ipairs(files) do
--             table.insert(sticky_resources, "#file:" .. vim.fn.fnamemodify(f, ":."))
--           end

--           vim.defer_fn(function()
--             -- 1. Load the models
--             chat.ask("Context loaded: Sequelize models for court_bookings and participants.", {
--               sticky = sticky_resources,
--             })
            
--             -- 2. Wait a tiny bit more for the text to render, then fold it
--             vim.defer_fn(function()
--               -- Move cursor to top and close the fold (zc)
--               vim.cmd("normal! ggzc")
--               -- Move cursor back to the bottom so you can type
--               vim.cmd("normal! G")
              
--               copilot_models_loaded = true
--               vim.notify("󱁤 Models loaded and collapsed.", vim.log.levels.INFO)
--             end, 200)
            
--           end, 300)
--         end
--       end
--     end
--   end,
-- })


-- Create a real visual cue for the background indexing
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Only run for ts_ls AND only if we haven't done this yet this session
    if client and client.name == "ts_ls" and not _G.lsp_initialized then
      -- Set the flag so it never runs again until you restart Neovim
      _G.lsp_initialized = true

      -- 1. Create the initial "Indexing" popup
      local notify_record = vim.notify("LSP: Indexing project...", "info", {
        title = "JavaScript Engine",
        icon = "⚙️",
        timeout = false,
      })

      -- 2. The 4-second "Truth" timer
      vim.defer_fn(function()
        vim.notify("LSP: Ready! Auto-imports active.", "info", {
          title = "JavaScript Engine",
          icon = "✅",
          replace = notify_record,
          timeout = 3000,
        })
      end, 4000)
    end
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*.js,*.jsx,*.ts,*.tsx", -- Only trigger for JS/TS files
--   callback = function()
--     -- Give the LSP a split second to update diagnostics after save
--     vim.defer_fn(function()
--       local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
--       local err_count = #diagnostics

--       if err_count > 0 then
--         vim.notify("Found " .. err_count .. " ESLint errors.", "error", {
--           title = "ESLint Check",
--           icon = "",
--           render = "compact",
--         })
--       else
--         -- Optional: A "Success" message when the file is clean
--         vim.notify("File clean!", "success", {
--           title = "ESLint Check",
--           icon = "󰄬",
--           timeout = 1000, -- Disappears quickly
--           render = "compact",
--         })
--       end
--     end, 200)
--   end,
-- })

-- Force an override after the entire UI and all plugins have settled
-- vim.defer_fn(function()
--   require('lspconfig').eslint.setup({
--     settings = {
--       workingDirectory = { mode = "location" },
--     }
--   })
--   -- Restart the server to apply the new settings
--   vim.cmd("LspRestart eslint")
-- end, 500)
