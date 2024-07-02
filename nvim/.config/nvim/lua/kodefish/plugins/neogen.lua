return {
    "danymat/neogen",
    config = function()
        local neogen = require("neogen")
        neogen.setup({
            languages = {
                python = {
                    template = {
                        annotation_convention = "reST"
                    }
                }
            }
        })
    end,
}
