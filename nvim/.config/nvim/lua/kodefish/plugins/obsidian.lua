return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	-- Load obsidian for markdown files in obsidian vault only
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes/**.md",
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local obsidian = require("obsidian")

		obsidian.setup({
			workspaces = {
				{
					name = "Notes",
					path = vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes",
				},
			},
			notes_subdir = "inbox",
			new_notes_location = "notes_subdir",
			disable_frontmatter = true,
			templates = {
				subdir = "templates",
				date_format = "%Y-%m-d",
				time_format = "%H:%M:%S",
			},
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
		})

        -- keymaps
        -- convert note to template
        vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate<cr>", { desc =  "Apply template" })
	end,
}
