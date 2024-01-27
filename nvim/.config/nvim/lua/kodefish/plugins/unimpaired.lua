return {
    "tummetott/unimpaired.nvim",
    config = function()
        local unimpaired = require("unimpaired")

        unimpaired.setup({
            keymaps = {
                bnext = {
                    mapping = '<leader>n',
                    description = 'Go to [count] next buffer',
                    dot_repeat = true,
                },
                bprevious = {
                    mapping = '<leader>p',
                    description = 'Go to [count] previous buffer',
                    dot_repeat = false,
                },
                bfirst = '<leader>N',
                blast = false,
            }

        })
    end,
}
