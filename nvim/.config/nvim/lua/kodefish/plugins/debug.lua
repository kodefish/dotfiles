return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		-- "nvim-telescope/telescope-dap.nvim",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		-- Setup dap-ui
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

        -- Setup virtual text
        local dap_virtual_text = require("nvim-dap-virtual-text")
        dap_virtual_text.setup({
            virt_text_pos = 'eol'
        })

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
        dap_python.setup("python")


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
		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", numhl = "", linehl = "" })
		vim.fn.sign_define("DapStopped", { text = "→", texthl = "", numhl = "", linehl = "" })

		-- Load launch.json
        require("dap.ext.vscode").load_launchjs()
	end,
}
