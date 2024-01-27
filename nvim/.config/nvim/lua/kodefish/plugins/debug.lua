return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        -- "nvim-telescope/telescope-dap.nvim",
        "leoluz/nvim-dap-go",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        dapui.setup()

        -- Hook dapui into dap events
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

        -- Configure adapters
        local dap_go = require("dap-go")
        dap_go.setup({
            delve = {
                -- delve installed via mason to $XDG_DATA_HOME/nvim/mason/bin/
                path = vim.fn.stdpath("data") .. "/mason/bin" .. "/dlv"
            }
        })

        -- Keymaps
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continue" })

        -- Visuals
        vim.fn.sign_define("DapBreakpoint", {text='🛑', texthl='', linehl='', numhl=''})
	end,
}
