return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
        local neo_tree = require("neo-tree")

        neo_tree.setup({
            filesystem = {
                filtered_items = {
                    visible = false, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        ".git",
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                        ".gitignore",
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        ".DS_Store",
                    },
                },
            },
        })
		vim.keymap.set("n", "<C-n>", "<cmd>Neotree filesystem toggle left<cr>", {})
	end,
}
