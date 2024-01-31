return {
    {
        "folke/todo-comments.nvim"
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup()
        end,
    },
}
