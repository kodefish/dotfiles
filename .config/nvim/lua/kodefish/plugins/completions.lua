return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-buffer", -- source for text from buffer
		"hrsh7th/cmp-nvim-lsp", -- source for completions from language server
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			dependencies = {
				"saadparwaiz1/cmp_luasnip", -- luasnip completion source
				"rafamadriz/friendly-snippets", -- set of preconfigured snippets for different languages
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll docs backwards
				["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll docs forwards
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- lsp completions
				{ name = "luasnip" }, -- text from buffer
				{ name = "buffer" }, -- text from buffer
				{ name = "path" }, -- file system paths
			}),
		})
	end,
}
