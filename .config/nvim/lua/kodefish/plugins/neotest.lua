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

		-- Function to dynamically find Python executable based on project setup
		local function get_python_path()
			local cwd = vim.fn.getcwd()

			-- Check for UV workspace (uv.lock at root)
			if vim.fn.filereadable(cwd .. "/uv.lock") == 1 then
				local uv_python = cwd .. "/.venv/bin/python"
				if vim.fn.executable(uv_python) == 1 then
					return uv_python
				end
			end

			-- Check for Pixi (pixi.lock or .pixi directory)
			if vim.fn.filereadable(cwd .. "/pixi.lock") == 1 or vim.fn.isdirectory(cwd .. "/.pixi") == 1 then
				-- Pixi can have multiple environments, try common ones
				local pixi_envs = {
					cwd .. "/.pixi/envs/default/bin/python",
					cwd .. "/.pixi/envs/dev/bin/python",
				}
				for _, pixi_python in ipairs(pixi_envs) do
					if vim.fn.executable(pixi_python) == 1 then
						return pixi_python
					end
				end
			end

			-- Check for devcontainer (usually in .devcontainer)
			if vim.fn.isdirectory(cwd .. "/.devcontainer") == 1 then
				-- In devcontainer, Python is usually on the PATH
				if vim.fn.executable("python") == 1 then
					return "python"
				end
			end

			-- Check for standard venv
			local venv_python = cwd .. "/.venv/bin/python"
			if vim.fn.executable(venv_python) == 1 then
				return venv_python
			end

			-- Fallback to system python
			return "python3"
		end

		neotest.setup({
			log_level = 1,
			adapters = {
				neotest_python({
					dap = { justMyCode = false },
					runner = "pytest",
					args = { "-vv", "--color=no" },
					python = get_python_path,
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
