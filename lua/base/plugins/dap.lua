local dap, dapui = require("dap"), require("dapui")

-- 1. Setup UI
dapui.setup()

-- 2. Define the Adapter (Verified path)
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      "/Users/abdullahnawaz/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  }
}

-- 3. Load launch.json
require("dap.ext.vscode").load_launchjs(nil, { 
  ["pwa-node"] = {"javascript", "typescript"} 
})

-- 4. UI Listeners
-- Auto-open when starting, but we handle closing manually via our toggle
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- 5. Keymaps
vim.keymap.set('n', '<leader>tb', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>tr', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)

-- THE SMART TOGGLE
-- If UI is open: Close it + Terminate Session
-- If UI is closed: Open it
vim.keymap.set('n', '<leader>td', function()
  -- Check if any DAP UI windows are open
  local widgets = require("dapui.windows")
  local is_open = false
  
  -- Logic to check if UI is visible
  for _, win in pairs(widgets.layouts) do
    if win:is_open() then
      is_open = true
      break
    end
  end

  if is_open then
    -- Clean up everything
    if dap.session() then
      dap.terminate()
    end
    pcall(function() vim.cmd("CopilotChatStop") end)
    dapui.close()
    print("DAP Closed")
  else
    -- Just open the UI
    dapui.open()
    print("DAP Opened")
  end
end)
