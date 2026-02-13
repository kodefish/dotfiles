return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- for conciness
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- TODO: Detect which LSP / Tools are necessary based on the host os
		-- Python: [basedpyright, ruff_lsp]
		-- Lua: [lua_ls, stylua]

		-- Add default lsp servers
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"basedpyright",
				"ruff",
				"yamlls",
                "terraformls",
			},
			-- auto-install configured servers
			automatic_installation = true,
		})

		-- Install tools
		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"roslyn", -- dotnet compiler
				"actionlint", -- Github action linter
                "debugpy", -- Python debugger
			},
		})
	end,
}
