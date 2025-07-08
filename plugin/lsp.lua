local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr
  })
end)


require("lsp_signature").setup({
  hint_enable = false,
  handler_opts = {
    border = "none"   -- double, rounded, single, shadow, none, or a table of borders
  },
})


-- Define a function to go to definition in a vertical split
local function go_to_definition_split()
  vim.cmd('vsplit')                -- Open a new vertical split
  vim.lsp.buf.definition()         -- Go to the definition in the new split
end

vim.keymap.set('n', 'gD', go_to_definition_split, { noremap = true, silent = true })

local function go_to_first_definition()
  vim.lsp.buf.definition({
    on_list = function(options)
      if options.items and #options.items > 1 then
        -- Jump to first item. You can do whatever you want here, such as filtering out React d.ts.
        vim.fn.setqflist({}, " ", options) -- Close quicifix list
        vim.cmd("cfirst") -- Jump to first
      elseif options.items and #options.items == 1 then
        local item = options.items[1]
        vim.fn.setqflist({ item }, "r")
        vim.cmd("cfirst")
      else
        print("No definition found")
      end
    end,
  })
end

-- usage
vim.keymap.set("n", "gd", go_to_first_definition)

lsp.setup()

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select_opts),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})

