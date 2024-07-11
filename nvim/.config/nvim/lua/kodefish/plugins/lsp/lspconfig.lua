return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim", -- Provides lsp completion for neovim config
		"folke/neoconf.nvim", -- Per-project lsp config
	},
	config = function()
		-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
		local neodev = require("neodev")
		neodev.setup()

		-- IMPORTANT: make sure to setup neoconf before lspconfig
		local neoconf = require("neoconf")
		neoconf.setup()

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- set general keymaps
		local opts = { noremap = true, silent = true }

		opts.desc = "Show line diagnostics"
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

		opts.desc = "Show buffer diagnostics"
		vim.keymap.set("n", "<leader>E", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

		opts.desc = "Go to previous diagnostic"
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

		opts.desc = "Go to next diagnostic"
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

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

			if client.name == "ruff_lsp" then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

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

		lspconfig.basedpyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
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

		lspconfig.ruff_lsp.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {},
		})

		lspconfig.gopls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

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
	end,
}
