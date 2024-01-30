-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

-- To setup mxsdev/nvim-dap-vscode-js:
  -- git clone https://github.com/microsoft/vscode-js-debug
  -- cd vscode-js-debug
  -- npm install --legacy-peer-deps
  -- npx gulp vsDebugServerBundle
  -- mv dist out
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'mxsdev/nvim-dap-vscode-js',
  },
  config = function ()
    local dap, dapui, dapjs = require('dap') require('dapui') require('dap-vscode-js')

    dapui.setup()
    dapjs.setup({
      debugger_path = '$USER/etc/vscode-js-debug'
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })
    vim.keymap.set('n', '<leader>bp', dap.toggle_breakpoint, {})
    vim.keymap.set('n', '<leader>ds', dap.continue, {})

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end
}
