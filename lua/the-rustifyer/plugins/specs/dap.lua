-- Plugins for enable debugging sessions within Neovim
--

return {
    nvim_dap = {
        'mfussenegger/nvim-dap',
        no_extra_config = true,
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
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
    },
    nvim_dap_ui = { 'rcarriga/nvim-dap-ui' }
}
