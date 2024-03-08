-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General keymaps --
-- clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "Clear search highlights" })

-- yank to system clipboard using leader key
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

-- Move up and down by visual (wrapped) lines
keymap.set("n", "j", "gj", { noremap = true, silent = true })
keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- Toggle wrap mode
local function toggle_wrap_mode()
	local window_options = vim.wo -- for conciseness

	-- Toggle options
	window_options.wrap = not window_options.wrap
	window_options.linebreak = not window_options.linebreak
	window_options.cursorline = not window_options.cursorline

	print("Toggled wrap", window_options.wrap)
end

keymap.set("n", "<leader>w", toggle_wrap_mode, { desc = "Toggle wrap" })

-- Buffer management
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
