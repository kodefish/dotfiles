return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to previous result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-l>"] = actions.send_to_qflist + actions.open_qflist, -- send items to quickfix list
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		-- Use fzf to fuzzy find
		-- telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

        -- Small wrapper around git_files to fallback on find_files when not in git repo
        local function is_git_repo()
            local handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
            local result = handle:read("*a")
            handle:close()
            return result:match('true')
        end

        local function project_files()
            if is_git_repo() then
                builtin.git_files()
            else
                builtin.find_files()
            end
        end

		-- Keymaps
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		vim.keymap.set("n", "<leader>fg", project_files, { desc = "Fuzzy find files in git files" })
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Fuzzy find string in files in cwd" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Show open buffers" })
		vim.keymap.set({ "n", "v" }, "<leader>fc", builtin.grep_string, { desc = "Search string under cursor in cwd" })
	end,
}
