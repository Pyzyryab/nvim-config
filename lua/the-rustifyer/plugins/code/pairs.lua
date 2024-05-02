-- Autocomplete code delimiters in pairs
--
return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
        disable_filetype = { "TelescopePrompt" , "vim" },
    }
}
