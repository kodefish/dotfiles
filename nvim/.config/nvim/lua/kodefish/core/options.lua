local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true         -- show absolute line number on cursor line

-- tabs & indentation (4 spaces for tab)
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true   -- expand tab to spaces
opt.autoindent = true  -- copy indent from previous line when starting a new one
opt.smartindent = true -- smart indent when startin a new line
opt.scrolloff = 8      -- keep padding

-- line wrapping
opt.wrap = false -- disable line wrapping

-- cursor line
opt.cursorline = true -- highlight current cursor line

-- line length
opt.colorcolumn = "121"

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-insensitive

-- appearance
if vim.env.COLORTERM == "truecolor" then
    vim.o.termguicolors = true -- turn on termguicolors
end
opt.signcolumn = "yes"      -- show sign column so text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the right

-- turn off swapfile
opt.swapfile = false

-- auto read (reload buffer if file changes on disk outside of vim)
opt.autoread = true

-- enable mouse
opt.mouse = "a"
