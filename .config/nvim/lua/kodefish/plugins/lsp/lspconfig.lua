return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim", -- Provides lsp completion for neovim config
		"folke/neoconf.nvim", -- Per-project lsp config
		"seblyng/roslyn.nvim", -- Advanced dotnet configuration
	},
	config = function()
		-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
		local neodev = require("neodev")
		neodev.setup()

		-- IMPORTANT: make sure to setup neoconf before lspconfig
		local neoconf = require("neoconf")
		neoconf.setup()

		-- Lsp config
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- set general keymaps
		local opts = { noremap = true, silent = true }

		opts.desc = "Show line diagnostics"
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

		opts.desc = "Show buffer diagnostics"
		vim.keymap.set("n", "<leader>E", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

		opts.desc = "Go to previous diagnostic"
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, opts)

		opts.desc = "Go to next diagnostic"
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts)

		local on_attach = function(client, bufnr)
			-- Set buffer specific keymaps
			local bufopts = { noremap = true, silent = false, buffer = bufnr }

			bufopts.desc = "Go to definition"
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)

			bufopts.desc = "Get references"
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

			bufopts.desc = "Show documentation for object under the cursor"
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

			-- bufopts.desc = "List all symbols in the current workspace"
			-- vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, bufopts)

			bufopts.desc = "Open diagnostics float"
			vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, bufopts)

			bufopts.desc = "Show code actions"
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)

			bufopts.desc = "Show LSP references"
			vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", bufopts)

			bufopts.desc = "Smart rename"
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

			bufopts.desc = "Format file"
			vim.keymap.set("n", "<leader>vff", vim.lsp.buf.format, bufopts)

			bufopts.desc = "Show signature help"
			vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, bufopts)

			bufopts.desc = "Restart LSP"
			vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", opts)

			bufopts.desc = "Show completions"
			vim.keymap.set("i", "<c-Space>", vim.lsp.completion.get, opts)
			if client.name == "ruff" then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
						missing_parameters = false, -- disable missing parameters for lua
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		-- Python
		lspconfig.basedpyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				-- python = {
				-- 	for pixi: pythonPath = ".pixi/envs/something/bin/python",
				-- 	for uv: venv = ".venv",
				-- },
				basedpyright = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						typeCheckingMode = "standard",
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		lspconfig.ruff.setup({
			cmd = { "ruff", "server", "--preview" },
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = {
				settings = {
					configurationPreference = "filesystemFirst", -- workspace config takes precedence
					fixAll = false, -- disable source.fixAll action
					lint = {
						extendSelect = {
							"I", -- Import sorting (isort)
							"F", -- Pyflakes (basic linting and static analysis)
							"E", -- Error checking (generally part of pyflakes and pylint)
							"C", -- Cyclomatic complexity and other code complexity checks
							"R", -- Refactor and code quality checks
						},
					},
				},
			},
		})

		-- YAML
		local yamlls_capabilities = cmp_nvim_lsp.default_capabilities()
		yamlls_capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		lspconfig.yamlls.setup({
			capabilities = yamlls_capabilities,
			on_attach = on_attach,
			settings = {
				yaml = {
					format = {
						enable = true,
					},
				},
			},
		})

		-- C# via roslyn.nvim
		local roslyn = require("roslyn")
		roslyn.setup({
			-- plugin-level options (solution discovery, etc.)
			broad_search = true, -- search parent dirs for .sln/.csproj in mono-repos
			lock_target = false, -- allow changing solution/project with :Roslyn target
			silent = false, -- show notifications on events
			ft = { "cs" }, -- only attach to C# files
		})

		vim.lsp.config("roslyn", {
			cmd = {
				vim.fn.stdpath("data") .. "/mason/bin" .. "/roslyn",
				"--stdio",
				"--logLevel=Information",
				"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
			},
			filetypes = { "cs" },
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				["csharp|navigation"] = {
					dotnet_enable_decompilation_support = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
				},
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
					csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_indexer_parameters = true,
					dotnet_enable_inlay_hints_for_literal_parameters = true,
					dotnet_enable_inlay_hints_for_object_creation_parameters = true,
					dotnet_enable_inlay_hints_for_other_parameters = true,
					dotnet_enable_inlay_hints_for_parameters = true,
					dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
				},
			},
		})
	end,
}
