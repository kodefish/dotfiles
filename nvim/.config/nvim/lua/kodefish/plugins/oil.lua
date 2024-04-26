return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")
		oil.setup({
			keymaps = {
				["<C-h>"] = false, -- disable horizontal split
			},
			-- This function defines what will never be shown, even when `show_hidden` is set
			is_always_hidden = function(name, bufnr)
                if vim.startswith(name, "__pycache__") then
                    return true
                end
				return false
			end,
		})
		vim.keymap.set("n", "<leader>-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
	end,
}
