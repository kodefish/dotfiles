return {
	"RRethy/vim-illuminate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
    config = function ()
        local illuminate = require("illuminate")

        illuminate.configure({
            providers = {
                -- Only rely on lsp and treesitter, not regex (makes writing regular text easier)
                "lsp",
                "treesitter"
            },
            filetypes_denylist = {
                'dirbuf',
                'dirvish',
                'fugitive',
                'markdown',
            },
        })
    end
}
