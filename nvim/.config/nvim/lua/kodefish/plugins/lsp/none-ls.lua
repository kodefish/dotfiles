return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
            },
        })

        vim.keymap.set("n", "<leader>vff", vim.lsp.buf.format, { desc = "Format current file" })
    end,
}
