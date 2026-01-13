local lsp_zero = require('lsp-zero')

-- 1. Attach Logic (Keymaps & Definition)
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})

  -- Vertical split for definitions
  vim.keymap.set('n', 'gD', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end, { buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'ts_ls' },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

-- require('mason').setup({})
-- require('mason-lspconfig').setup({
--   ensure_installed = { 'ts_ls' }, -- this is correct
--   handlers = {
--     function(server_name)
--       local opts = {}

--       -- Only override ts_ls settings
--       if server_name == "ts_ls" then
--         opts.settings = {
--           javascript = {
--             preferences = {
--               autoImportFileExcludePatterns = {
--                 "**/node_modules/**/types/**",
--                 "**/node_modules/**/lib/**",
--               }
--             },
--             checkJs = false,
--           },
--           typescript = {
--             preferences = {
--               autoImportFileExcludePatterns = {
--                 "**/node_modules/**/types/**",
--                 "**/node_modules/**/lib/**",
--               }
--             },
--             checkJs = false,
--           }
--         }
--       end

--       require('lspconfig')[server_name].setup(opts)
--     end,
--   },
-- })



-- 3. Autocompletion (Clean & Modern)
local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  })
})

-- 4. Diagnostic Look
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

---
-- FOREST THEME POPUPS
---
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "ts_ls" and not _G.lsp_initialized then
      _G.lsp_initialized = true
      local notify_record = vim.notify("LSP: Starting Express Engine...", "info", {
        title = "Node.js Backend",
        icon = "⚙️",
        timeout = false,
      })
      vim.defer_fn(function()
        vim.notify("LSP: Ready! Rules & Auto-imports loaded.", "info", {
          title = "Node.js Backend",
          icon = "✅",
          replace = notify_record,
          timeout = 3000,
        })
      end, 3000)
    end
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*.js,*.jsx,*.ts,*.tsx",
--   callback = function()
--     vim.defer_fn(function()
--       local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
--       if errors > 0 then
--         vim.notify("ESLint: " .. errors .. " project errors found.", "error", {
--           title = "Forest Audit",
--           icon = "🌲",
--           render = "compact",
--         })
--       else
--         vim.notify("File clean!", "success", {
--           title = "Forest Audit",
--           icon = "🌿",
--           timeout = 1000,
--           render = "compact",
--         })
--       end
--     end, 400)
--   end,
-- })
