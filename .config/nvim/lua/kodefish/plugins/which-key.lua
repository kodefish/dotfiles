return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        defaults = {},
    },
    config = function()
        local wk = require("which-key")

        wk.add({
            { "<leader>b", group = "buffer" },
            { "<leader>c", group = "code" },
            { "<leader>d", group = "debug" },
            { "<leader>f", group = "file" },
            { "<leader>g", group = "git" },
            { "<leader>l", group = "lint" },
            { "<leader>r", group = "refactor" },
            { "<leader>t", group = "tests" },
            { "<leader>x", group = "trouble" },
        })
    end,
}
