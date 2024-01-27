-- set leader key to space
vim.g.mapleader = ' '

local keymap = vim.keymap -- for conciseness

-- General keymaps --
-- clear search highlights
keymap.set('n', '<leader>nh', '<cmd>nohl<cr>', { desc = 'Clear search highlights' })

-- yank to system clipboard using leader key
keymap.set({'n', 'v'}, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
