return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")
            gitsigns.setup({
                diff_opts = {
                    ignore_whitespace_change_at_eol = true,
                },
            })

            vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
            vim.keymap.set(
                "n",
                "<leader>gb",
                "<cmd>Gitsigns toggle_current_line_blame<cr>",
                { desc = "Git blame toggle " }
            )
        end,
    },
}
