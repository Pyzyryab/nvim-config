-- Configuration for the jackMort ChatGPT plugin
--
return {
    enabled = false,
    event = "VeryLazy",
    config = function()
        require("chatgpt").setup()
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        --"folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
    }
}

