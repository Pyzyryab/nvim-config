-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
--
local jdtls = require('jdtls')

local procs = require('the-rustifyer.utils.procedures')
local globals = require('the-rustifyer.core.globals')
local consts = require('the-rustifyer.core.constants')

local p_sep = globals.path.sep
local mason_path = consts.dirs.nvim_data .. p_sep .. 'mason' .. p_sep .. 'packages'

local jdtls_path = mason_path .. p_sep .. 'jdtls'
local jdtls_jar_path = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
-- local root_dir = require('jdtls.setup').find_root({ '.gitignore', 'code/', '.gitattributtes', 'README.md' })

local on_attach = function(_client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- Java extensions provided by jdtls
    procs.nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
    procs.nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
    procs.nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
    vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })
end

local bundles = {
  -- Path to the Microsoft's Java debug plugin
  vim.fn.glob(mason_path .. p_sep .. 'java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1),
}
-- Extending the bundles table to add the plugin that allows us to debug Java tests within Neovim
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. p_sep .. "java-test/extension/server/*.jar", 1), "\n"))

local config = {
    flags = {
        debounce_text_changes = 80,
    },
    on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
    root_dir = vim.fn.getcwd(), -- Set the root directory to our found root_marker
    -- Here you can configure eclipse.jdt.ls specific settings
    -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options

    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- The command that starts the language server

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir

    init_options = {
        bundles = bundles,
    },

    cmd = {
        -- 💀
        'java', -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. jdtls_path .. '/lombok.jar',
        -- 💀
        '-jar', jdtls_jar_path,
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version


        -- 💀 I only work with Java on Windows or Linux, no need to check anything else
        '-configuration', jdtls_path .. '/config_' .. (globals.sys.is_windows and 'win' or 'linux'),
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.


        -- 💀
        -- See `data directory configuration` section in the README
        '-data',
        -- project_root_dir
        vim.fn.getcwd()
    },

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
            -- Specify any completion options
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999;
                    staticStarThreshold = 9999;
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },

        }
    },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

