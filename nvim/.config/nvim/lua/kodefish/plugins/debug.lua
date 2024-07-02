return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        -- "nvim-telescope/telescope-dap.nvim",
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
        {
            "stevearc/overseer.nvim",
            config = function()
                local overseer = require("overseer")
                overseer.setup({
                    dap = false,
                    log = {
                        {
                            type = "notify",
                            level = vim.log.levels.WARN,
                        },
                    },
                })

                vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "Show task run menu" })
                vim.keymap.set("n", "<leader>to", "<cmd>OverseerToggle<cr>", { desc = "Show task runs" })
            end,
        },
        {
            "Weissle/persistent-breakpoints.nvim",
            config = function()
                local persistent_breakpoints = require("persistent-breakpoints")
                persistent_breakpoints.setup({
                    load_breakpoints_event = { "BufReadPost" },
                })
            end,
        },
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        -- Setup dap-ui
        dapui.setup({
            -- Custom layout with no console
            -- Console only supports an integrated terminal, which is empty when attaching to a remote debugger
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.25,
                        },
                        {
                            id = "breakpoints",
                            size = 0.25,
                        },
                        {
                            id = "stacks",
                            size = 0.25,
                        },
                        {
                            id = "watches",
                            size = 0.25,
                        },
                    },
                    position = "left",
                    size = 40,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 1,
                        },
                    },
                    position = "bottom",
                    size = 15,
                },
            },
        })
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

        -- Keymaps
        vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Dap UI" })
        vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval" })

        -- Configure adapters
        local dap_go = require("dap-go")
        dap_go.setup({
            delve = {
                -- delve installed via mason to $XDG_DATA_HOME/nvim/mason/bin/
                path = vim.fn.stdpath("data") .. "/mason/bin" .. "/dlv",
            },
        })

        local dap_python = require("dap-python")
        dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

        -- Keymaps
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
        vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Conditional breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
        vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
        vim.keymap.set("n", "<leader>dg", dap.goto_, { desc = "Go to line (no execute)" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
        vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Down" })
        vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Up" })
        vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
        vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
        vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
        vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
        vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
        vim.keymap.set("n", "<leader>ds", dap.session, { desc = "Session" })
        vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })

        -- Visuals
        vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

        -- Setup overseer
        require("dap.ext.vscode").json_decode = require("overseer.json").decode
        require("overseer").patch_dap(true)

        -- Load launch.json
        if vim.fn.filereadable(".vscode/launch.json") then
            require("dap.ext.vscode").load_launchjs(".vscode/launch.json")
        end
    end,
}
