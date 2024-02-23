-- clangd_extensions config, overpowering the clangd LSP for our C/C++ code sessions
--
return {
    config = function() end,
    opts = {
        inlay_hints = {
            inline = true,
            only_current_line = true,
            only_current_line_autocmd = { 'CursorHold' },
        },
        ast = {
            --These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },
            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },
        },
    },
}

