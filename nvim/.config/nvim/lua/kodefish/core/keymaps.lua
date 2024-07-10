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

-- Split navigation defaults (may be overriden by vim-tmux-navigation)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate split left" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate split down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate split up" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate split right" })

-- Split management (increase / decrease)
-- NOTE: On MacOS, in iTerm2 make sure to bind option to Esc+
-- https://www.reddit.com/r/vim/comments/u1kppk/comment/i4ecygu/
keymap.set("n", "<M-h>", "<C-w>5>", { desc = "Increase split size to the left" })
keymap.set("n", "<M-l>", "<C-w>5<")
keymap.set("n", "<M-j>", "<C-w>+")
keymap.set("n", "<M-k>", "<C-w>-")
