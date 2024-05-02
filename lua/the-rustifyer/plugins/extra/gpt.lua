-- ChatGPT is a Neovim plugin that allows you to effortlessly utilize the OpenAI ChatGPT API,
-- empowering you to generate natural language responses from OpenAI's ChatGPT directly
-- within the editor in response to your inquiries
--

return {
    'jackMort/ChatGPT.nvim',
    enabled = false,
    -- TODO: non enabled since I am not pretending to spend money on the ChatGPT API...
    -- TODO: required more setup than the one here if some day I pretend to use it
    event = "VeryLazy",
    config = function()
        require("chatgpt").setup()
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
    }
}
