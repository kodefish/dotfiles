return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
	},
	config = function()
		local neotest_python = require("neotest-python")
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				neotest_python({
					dap = { justMyCode = false },
					runner = "pytest",
					python = "python", -- nvim is already running in the appropriate environment
				}),
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>t", "", { desc = "+test" })
		vim.keymap.set("n", "<leader>tn", neotest.run.run, { desc = "Run Nearest" })
		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Debug Nearest" })
		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run File" })
		vim.keymap.set("n", "<leader>tT", function()
			neotest.run.run(vim.uv.cwd())
		end, { desc = "Run Project" })
		vim.keymap.set("n", "<leader>tl", neotest.run.run_last, { desc = "Run Last" })
		vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Toggle Summary" })
		vim.keymap.set("n", "<leader>to", neotest.output_panel.toggle, { desc = "Toggle Ouput" })
		vim.keymap.set("n", "<leader>tS", neotest.run.stop, { desc = "Stop" })
		vim.keymap.set("n", "<leader>tw", function()
			neotest.watch.toggle(vim.fn.expand("%"))
		end, { desc = "Toggle Watch" })
	end,
}
