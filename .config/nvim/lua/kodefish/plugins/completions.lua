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
			-- Improved sorting to prioritize relevant items
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			-- Optimized source configuration with priorities
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 }, -- highest priority for LSP
				{ name = "luasnip", priority = 750 }, -- snippets second
				{ name = "buffer", priority = 500, keyword_length = 3 }, -- buffer requires 3 chars
				{ name = "path", priority = 250 }, -- paths lowest priority
			}),
			-- Performance tuning
			performance = {
				debounce = 60,
				throttle = 30,
				fetching_timeout = 500,
			},
		})
	end,
}
