return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "Issafalcon/neotest-dotnet",
    },
    config = function()
        local neotest_python = require("neotest-python")
        local neotest_dotnet = require("neotest-dotnet")
        local neotest = require("neotest")

        neotest.setup({
            log_level = 1,
            adapters = {
                neotest_python({
                    dap = { justMyCode = false },
                    runner = "pytest",
                    args = { "-vv", "--color=no" },
                    -- nvim is already running in the appropriate environment (e.g. devcontainer / virtual env)
                    python = "python",
                }),
                neotest_dotnet({
                    dap = {
                        -- Extra arguments for nvim-dap configuration
                        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                        args = { justMyCode = false },
                        -- Enter the name of your dap adapter, the default value is netcoredbg
                        adapter_name = "netcoredbg",
                    },
                    dotnet_additional_args = {
                        "--verbosity detailed",
                    },
                    discovery_root = "solution",
                }),
            },
            status = { virtual_text = true },
            output = { open_on_run = true },
        })

        -- Keybindings
        vim.keymap.set("n", "<leader>t", "", { desc = "+test" })
        vim.keymap.set("n", "<leader>tn", neotest.run.run, { desc = "Run Nearest" })
        vim.keymap.set("n", "<leader>tt", function()
            neotest.run.run(vim.fn.expand("%"))
        end, { desc = "Run File" })
        vim.keymap.set("n", "<leader>tT", function()
            neotest.run.run(vim.uv.cwd())
        end, { desc = "Run Project" })
        vim.keymap.set("n", "<leader>tl", neotest.run.run_last, { desc = "Run Last" })
        -- NOTE: The summary is more like a test outline, and the output looks more like a summary, so for mnemonics
        -- it is easier to switch the two panels
        vim.keymap.set("n", "<leader>to", neotest.summary.toggle, { desc = "Toggle Outline" })
        vim.keymap.set("n", "<leader>ts", neotest.output_panel.toggle, { desc = "Toggle Summary" })
        vim.keymap.set("n", "<leader>tS", neotest.run.stop, { desc = "Stop" })
        vim.keymap.set("n", "<leader>tw", function()
            neotest.watch.toggle(vim.fn.expand("%"))
        end, { desc = "Toggle Watch" })

        -- Debug keybindings (debug nearest)
        vim.keymap.set("n", "<leader>td", function()
            neotest.run.run({ strategy = "dap" })
        end, { desc = "Debug Nearest Test" })

        local function debug_nearest_wait()
            local prev = vim.env.VSTEST_HOST_DEBUG
            vim.env.VSTEST_HOST_DEBUG = "1" -- testhost pauses for debugger
            neotest.run.run({ strategy = "dap" })
            vim.defer_fn(function()
                vim.env.VSTEST_HOST_DEBUG = prev
            end, 2000)
        end
        vim.keymap.set("n", "<leader>tD", debug_nearest_wait, { desc = "Debug Nearest (wait)" })
    end,
}
