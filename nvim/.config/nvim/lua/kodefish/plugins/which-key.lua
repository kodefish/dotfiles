return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		defaults = {},
	},
	config = function()
		local wk = require("which-key")
		wk.register({
			["<leader>"] = {
				b = { name = "+buffer" },
                c = { name = "+code" },
				d = { name = "+debug" },
                f = {name = "+file"},
                g = {name = "+git"},
                t = {name = "+tasks"},
			},
		})
	end,
}
