require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"/Users/abdullahnawaz/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}/bin/www",
  },
}

local dap, dapui = require("dap"), require("dapui")

-- hiding the require variable from the variables view
dap.listeners.after.variables["dapui_config"] = function(session, body)
  if body and body.variables then
    for i = #body.variables, 1, -1 do
      local var_name = body.variables[i].name
      local var_value = body.variables[i].value

      -- Filter out known require-based modules (like 'http') or customize as needed
      if var_value:find("require") then
        table.remove(body.variables, i)
      end
    end
  end
end

dapui.setup()

-- vim.keymap.set('n', '<leader>td', '<cmd>lua require"dap".terminate()<cr><cmd>lua require"dapui".toggle()<cr>', {})
vim.keymap.set('n', '<leader>tb', '<cmd>lua require"dap".toggle_breakpoint()<cr>', {})

vim.keymap.set('n', '<leader>td', function()
  -- Disable Copilot (if active)
  if vim.fn.exists(":CopilotChatStop") == 2 then
    vim.cmd("CopilotChatStop")
  end

  -- Terminate DAP and toggle DAP UI
  require("dap").terminate()
  require("dapui").toggle()
end, {})
