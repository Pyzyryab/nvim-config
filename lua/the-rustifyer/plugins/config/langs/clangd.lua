-- Configuration for the `clangd` extra tools, that enhaces the workflow with clangd within Neovim
--
return {
    config = function() end,
    opts = {
        inlay_hints = {
            inline = false,
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
