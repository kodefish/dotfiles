-- Better code folding
return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
        local ufo = require("ufo")

        ufo.setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { "lsp", "indent" }
            end,
        })

        -- Setup fold options for vim
        vim.o.foldcolumn = "1" -- Enable fold column
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Keymaps
        vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "(R)eveal all folds" })
        vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "(M)inimize all folds" })
        vim.keymap.set("n", "zp", ufo.peekFoldedLinesUnderCursor, { desc = "(P)eek fold" })
    end,
}
