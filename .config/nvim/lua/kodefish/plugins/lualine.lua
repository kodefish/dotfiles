return {
    "nvim-lualine/lualine.nvim",
    opts = {
        options = {
            theme = "dracula"
        },
        sections = {
            lualine_x = { "whichpy", "encoding", "fileformat", "filetype" },
        },
    }
}
