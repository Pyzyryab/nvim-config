-- Plugin for having a cheatsheet of all our custom remaps.
-- It will be triggered after pressing some key and waiting for a second, showing all the available
-- combinations for the pressed key

return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        delay = function()
            -- NOTE: To make `<Leader>d` and `<Leader>dd` keymaps work
            --       make sure that opts.delay >= timeoutlen.
            --       - https://github.com/folke/which-key.nvim/issues/648#issuecomment-2226881346
            local delay = 2000
            return delay < vim.o.timeoutlen and vim.o.timeoutlen or delay
        end,
    },
    config = function()
        local procs = require('the-rustifyer.utils.procedures')
        local wk = require('which-key')

        local is_win = require('the-rustifyer.core.globals').sys.is_windows

        -- We store here this callback, so we can pass it later to remaps that should be only working on
        -- specific buffers
        local bufnr = vim.api.nvim_get_current_buf()

        local CMD = '<Cmd>'
        local CR = '<CR>'
        local ESC = '<Esc>'

        -- General remaps

        wk.add({
            { "<A-h>",      "<Cmd>BufferLineCyclePrev<CR>",                                desc = "Prev buffer" },
            { "<A-l>",      "<Cmd>BufferLineCycleNext<CR>",                                desc = "Next buffer" },
            { "<leader>aw", "<Cmd>AddWorkspace<CR>",                                       desc = "Add the CWD to the projects of the workspace" },

            { "<leader>r",  group = "Rust LSP actions (care!: only enabled for ft = Rust)" },
            {
                "<leader>rD",
                -- Display a hover window with the rendered diagnostic, as displayed during cargo build.
                -- Useful for solving bugs around borrowing and generics, as it consolidates the important bits
                -- (sometimes across files) together.
                function() vim.cmd.RustLsp('renderDiagnostic') end,
                desc = "Render diagnostic"
            },
            { "<leader>rc", function() vim.cmd.RustLsp('openCargo') end,   desc = "Open cargo.toml" },
            { "<leader>rd", function() vim.cmd.RustLsp('debuggables') end, desc = "Show debuggables" },
            {
                "<leader>re",
                -- My favourite one!
                -- Display a hover window with explanations from the rust error codes index CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" over error diagnostics
                -- (if they have an error code).
                function() vim.cmd.RustLsp('explainError') end,
                desc = "Explain error"
            },
            {
                "<leader>rh",
                -- Replaces Neovim's built-in hover handler with hover actions, so you can also use vim.lsp.buf.hover()
                function() vim.cmd.RustLsp { 'hover', 'actions' } end,
                desc = "Hover actions"
            },

            { "<leader>rl",  group = "last selected" },
            { "<leader>rld", function() vim.cmd.RustLsp { 'debuggables', bang = true } end, desc = "launch previous debuggable" },
            { "<leader>rlr", function() vim.cmd.RustLsp { 'runnables', bang = true } end,   desc = "launch previous runnable" },
            { "<leader>rlt", function() vim.cmd.RustLsp { 'testables', bang = true } end,   desc = "launch previous testable" },

            { "<leader>rm",  group = "macros" },
            { "<leader>rme", function() vim.cmd.RustLsp('expandmacro') end,                 desc = "Expand macro" },
            { "<leader>rmr", function() vim.cmd.RustLsp('rebuildProcMacros') end,           desc = "Rebuild proc macros" },

            { "<leader>rp",  function() vim.cmd.RustLsp('parentModule') end,                desc = "Parent module" },
            { "<leader>rr",  function() vim.cmd.RustLsp('runnables') end,                   desc = "Show runnables" },
            { "<leader>rt",  function() vim.cmd.RustLsp('testables') end,                   desc = "Show testables" },

            { "<leader>rv",  group = "+/Rust view" },
            { "<leader>rvh", function() vim.cmd.RustLsp { 'view', 'hir' } end,              desc = "View HIR" },
            { "<leader>rvm", function() vim.cmd.RustLsp { 'view', 'mir' } end,              desc = "View MIR" },
            {
                "<leader>rvs",
                function()
                    vim.cmd.RustLsp {
                        'workspaceSymbol',
                        '<onlyTypes|allSymbols>' --[[ optional ]],
                        -- '<query>' --[[ optional ]],
                        bang = true --[[ optional ]]
                    }
                end,
                desc = "Show workspace symbols (with deps)"
            },
            {
                "<leader>rvt",
                function()
                    vim.cmd.RustLsp(
                        'syntax CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME" CMAKE_INSTALL_PREFIX="$HOME"Tree'
                    )
                end,
                desc = "Show syntax tree"
            },

            { "<leader>b",  group = "buffers" },
            { "<leader>bd", procs.minibufremove,                                                                       desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,                                  desc = "Delete Buffer (Force)" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>",                                                 desc = "Delete non-pinned buffers" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",                                                            desc = "Delete buffers to the left" },
            { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",                                                          desc = "Delete other buffers" },
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",                                                            desc = "Toggle pin" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",                                                           desc = "Delete buffers to the right" },

            { "<leader>B",  group = "breakpoints" },
            { "<leader>BB", '<Cmd>lua require("persistent-breakpoints.api").toggle_breakpoint()<CR>',                  desc = "Set breakpoint" },
            { "<leader>BC", '<Cmd>lua require("persistent-breakpoints.api").set_conditional_breakpoint()<CR>',         desc = "Set conditional breakpoint" },
            { "<leader>BF", "<Cmd>Telescope dap list_breakpoints<CR>",                                                 desc = "List breakpoints" },
            { "<leader>BL", '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', desc = "Set log point" },
            { "<leader>BR", '<Cmd>lua require("persistent-breakpoints.api").clear_all_breakpoints()<CR>',              desc = "Clear breakpoints" },

            { "<leader>c",  group = "comments/+CMake" },
            {
                "<leader>cb",
                function()
                    require("Comment.api").toggle.blockwise.current()
                end,
                desc = "Comment line/selection"
            },
            {
                "<leader>cl",
                function()
                    require("Comment.api").toggle.linewise.current()
                end,
                desc = "Comment line"
            },
            { "<leader>cmb", CMD .. "CMakeBuild" .. CR,                                    desc = "Runs <CMakeBuild>" },
            { "<leader>cmg", CMD .. "CMakeGenerate" .. CR,                                 desc = "Runs <CMakeGenerate>" },
            { "<leader>cmr", "<Cmd>CMakeRun<CR>",                                          desc = "Runs <CMakeRun>" },
            { "<leader>cmt", "<Cmd>CMakeRunTest<CR>",                                      desc = "Runs <CMakeRunTest>" },

            { "<leader>d",   group = "diagnostics/+trouble" },
            { "<leader>dd",  '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',           desc = "Document diagnostics" },
            { "<leader>dl",  '<cmd>Trouble loclist toggle<cr>',                            desc = "Diagnostics loclist" },
            { "<leader>dq",  '<cmd>Trouble qflist toggle<cr>',                             desc = "Diagnostics quickfix" },
            { "<leader>dr",  '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = "Lsp References" },
            { "<leader>cs",  "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },

            { "<leader>D",   group = "debugger" },
            { "<leader>DC",  '<Cmd>lua require"dap".continue()<CR>',                       desc = "Continue" },
            { "<leader>DD",  '<Cmd>lua require"dap".disconnect()<CR>',                     desc = "Disconnect" },
            { "<leader>DF",  "<Cmd>Telescope dap frames<CR>",                              desc = "List Frames" },
            { "<leader>DJ",  '<Cmd>lua require"dap".step_into()<CR>',                      desc = "Step into" },
            { "<leader>DK",  '<Cmd>lua require"dap".step_over()<CR>',                      desc = "Step over" },
            { "<leader>DL",  '<Cmd>lua require"dap".run_last()<CR>',                       desc = "Run Last" },
            { "<leader>DO",  '<Cmd>lua require"dap".step_out()<CR>',                       desc = "Step out" },
            { "<leader>DQ",  "<Cmd>Telescope dap commands<CR>",                            desc = "List commands" },
            { "<leader>DR",  '<Cmd>lua require"dap".repl.toggle()<CR>',                    desc = "Open REPL" },
            {
                "<leader>DS",
                function()
                    local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
                end,
                desc = "Scopes"
            },
            { "<leader>DT",  '<Cmd>lua require"dap".terminate()<CR>',                                           desc = "Terminate" },
            { "<leader>DU",  function() require("dapui").toggle() end,                                          desc = "Toggles the debugger UI" },
            { "<leader>DV",  'function() require"dap.ui.widgets".hover() end',                                  desc = "Variables" },
            { "<leader>DY",  "<Cmd>Telescope dap configurations<CR>",                                           desc = "List (auto)discovered DAP configurations" },

            { "<leader>e",   group = "editor" },
            { "<leader>eb",  "<Cmd>Neotree toggle show buffers right<CR>",                                      desc = "neotree toggle show buffers right" },
            { "<leader>ee",  "<Cmd>Neotree diagnostics reveal bottom<CR>",                                      desc = "neotree show workpace diagnostics" },
            { "<leader>eg",  "<Cmd>Neotree float git status<CR>",                                               desc = "neotree show git status" },
            { "<leader>eo",  "<Cmd>Neotree<CR>",                                                                desc = "opens neotree" },
            { "<leader>et",  "<Cmd>Neotree toggle<CR>",                                                         desc = "toggles neotree depending on its current status" },

            { "<leader>f",   group = "find" },
            { "<leader>fb",  "<Cmd>Telescope buffers<CR>",                                                      desc = "Find open buffers" },
            { "<leader>fc",  "<Cmd>Telescope commands<CR>",                                                     desc = "Show commands" },
            { "<leader>fd",  "<Cmd>Telescope dap commands<CR>",                                                 desc = "Displays the DAP available commands" },
            { "<leader>ff",  "<Cmd>Telescope find_files<CR>",                                                   desc = "find files" },

            { "<leader>fg",  "<Cmd>Telescope git_files<CR>",                                                    desc = "find files on git repository" },
            { "<leader>fh",  "<Cmd>Telescope help_tags<CR>",                                                    desc = "Show help tags" },
            { "<leader>fk",  function() require("telescope.builtin").colorscheme() end,                         desc = "Show and preview colorschemes" },
            { "<leader>fn",  "<Cmd>Telescope notify<CR>",                                                       desc = "Displays the notifications triggered" },
            { "<leader>fo",  "<Cmd>Telescope oldfiles<CR>",                                                     desc = "open recent files" },
            { "<leader>fp",  "<Cmd>Telescope projections<CR>",                                                  desc = "Search projects" },
            { "<leader>ft",  "<Cmd>TodoTelescope<CR>",                                                          desc = "Open a TODO-'s preview" },

            -- Flutter
            { "<leader>fl",  group = "flutter" },
            { "<leader>flr", "<Cmd>FlutterRun<CR>",                                                             desc = "Run the current project. This needs to be run from within a flutter project" },
            { "<leader>fld", "<Cmd>FlutterDevices<CR>",                                                         desc = "Brings up a list of connected devices to select from" },
            { "<leader>fle", "<Cmd>FlutterEmulators<CR>",                                                       desc = "Similar to devices but shows a list of emulators to choose from" },
            { "<leader>flr", "<Cmd>FlutterReload<CR>",                                                          desc = "Reload the current project" },
            { "<leader>flR", "<Cmd>FlutterRestart<CR>",                                                         desc = "Restart the current project" },
            { "<leader>flq", "<Cmd>FlutterQuit<CR>",                                                            desc = "Ends a Flutter running session" },
            { "<leader>flo", "<Cmd>FlutterOutlineToggle<CR>",                                                   desc = "Toggle the outline window showing the widget tree for the given file" },
            { "<leader>fld", "<Cmd>FlutterDevTools<CR>",                                                        desc = "Start a Dev Tools Server" },

            -- git
            { "<leader>g",   group = "git" },
            { "<leader>ga",  "<Cmd>GhActions<CR>",                                                              desc = "Opens GitHub Actions on buffer" },
            { "<leader>gbl", desc = "Blame Line" },
            { "<leader>gcw", function() require('telescope').extensions.git_worktree.create_git_worktree() end, desc = "Create a new git worktree via Telescope" },
            { "<leader>gdp", "<Cmd>diffput | diffupdate<CR>",                                                   desc = "Put the changes on the working copy from the target or merge version and updates the indexes" },
            { "<leader>ggm", "<Cmd>diffget // 3 | diffupdate<CR>",                                              desc = "Get changes from the merge version and updates the indexes" },
            { "<leader>ggt", "<Cmd>diffget // 2 | diffupdate<CR>",                                              desc = "Get changes from target version of the document and updates the indexes" },
            { "<leader>ghD", desc = "Diff This ~" },
            { "<leader>ghd", desc = "Diff This" },
            { "<leader>ghp", desc = "Preview Hunk Inline" },
            { "<leader>ghr", desc = "Reset Hunk" },
            { "<leader>ghs", desc = "Stage Hunk" },
            { "<leader>gmu", "<Cmd>diffupdate<CR>",                                                             desc = "Updates the changes in the gitmergetool" },
            { "<leader>gnh", desc = "Next Hunk" },
            { "<leader>gph", desc = "Prev Hunk" },
            { "<leader>grb", desc = "Reset Buffer" },
            { "<leader>gs",  vim.cmd.Git,                                                                       desc = "Shows git status via vim-fugitive" },
            { "<leader>gsb", desc = "Stage Buffer" },
            { "<leader>gus", desc = "Undo Stage Hunk" },
            { "<leader>gw",  function() require('telescope').extensions.git_worktree.git_worktrees() end,       desc = "Show git worktrees via Telescope" },

            -- Java
            { "<leader>j",   group = "Java" },
            { "<leader>jc",  "<Cmd>JdtCompile<CR>",                                                             desc = "Compile Java File/Project with JDTLS" },
            { "<leader>juc", "<Cmd>JdtUpdateConfig<CR>",                                                        desc = "Updates the configurations for the current projects" },
            { "<leader>jud", "<Cmd>JdtUpdateDebugConfig<CR>",                                                   desc = "Scan for autodetect running configurations for debug builds" },

            -- LSP
            { "<leader>l",   group = "LSP" },
            { "<leader>lI",  "<Cmd>LspInfo<CR>",                                                                desc = "Opens the LSP info floating window" },
            { "<leader>lL",  "<Cmd>LspLog<CR>",                                                                 desc = "Opens the LSP log file" },
            { "<leader>lc",  "<Cmd>Telescope lsp_incoming_calls<CR>",                                           desc = "Find LSP incoming calls" },
            { "<leader>le",  "<Cmd>Telescope diagnostics bufnr=0<CR>",                                          desc = "Errors" },
            { "<leader>li",  "<Cmd>Telescope lsp_implementations<CR>",                                          desc = "Implementations" },
            { "<leader>lk",  function() require("lsp_signature").toggle_float_win() end,                        desc = "toggle signature" },
            { "<leader>lm",  "<Cmd>Telescope marks<CR>",                                                        desc = "Find Mark" },
            { "<leader>lo",  "<Cmd>Telescope lsp_outgoing_calls<CR>",                                           desc = "Find LSP outgoing calls" },
            { "<leader>lr",  "<Cmd>Telescope lsp_references<CR>",                                               desc = "References" },
            { "<leader>ls",  "<Cmd>Telescope lsp_document_symbols<CR>",                                         desc = "Symbols" },

            -- Maven
            { "<leader>m",   group = "maven" },
            { "<leader>mc",  "<Cmd>Maven<CR>",                                                                  desc = "Choose Maven command to execute" },
            { "<leader>mp",  "<Cmd>Glow<CR>",                                                                   desc = "Preview current Mardown file" },

            { "<leader>o",   group = "open" },
            { "<leader>oa",  "<Cmd>Alpha<CR>",                                                                  desc = "Opens the setup Dashboard, Alpha" },
            { "<leader>oc",  "<Cmd>URLOpenHighlightAllClear<CR>",                                               desc = "Clears all the highlighter URLs" },
            { "<leader>od",  "<Cmd>DocsViewToggle<CR>",                                                         desc = "Toggles a buffer with documentation for the selected item" },
            { "<leader>oh",  "<Cmd>URLOpenHighlightAll<CR>",                                                    desc = "Highlights all the URLs present on the current buffer" },
            { "<leader>ou",  "<Cmd>URLOpenUnderCursor<CR>",                                                     desc = "Opens the URL under the cursor" },

            { "<leader>p",   group = "persistence" },
            { "<leader>pd",  function() require("persistence").stop() end,                                      desc = "Don't Save Current Session" },
            { "<leader>pl",  function() require("persistence").load({ last = true }) end,                       desc = "Restore Last Session" },
            { "<leader>ps",  function() require("persistence").load() end,                                      desc = "Fires the 'Close' command" },

            { "<leader>s",   group = "search" },
            { "<leader>sf",  "<Cmd>Telescope live_grep<CR>",                                                    desc = "Find text in files" },
            { "<leader>sp",  '<Cmd>lua require("spectre").open_file_search({select_word=true})<CR>',            desc = "Search on current file" },
            { "<leader>ss",  '<Cmd>lua require("spectre").toggle()<CR>',                                        desc = "Toggle Spectre" },
            { "<leader>sw",  '<Cmd>lua require("spectre").open_visual({select_word=true})<CR>',                 desc = "Search current word" },

            { "<leader>ts",  group = "treessitter" },
            {
                "<leader>tsu",
                function()
                    local tsc = require('treesitter-context')
                    tsc.toggle()
                end,
                desc = "Toggle Treesitter Context"
            },

            { "<leader>u",   group = "update/undo" },
            { "<leader>ul",  CMD .. 'Lazy update' .. CR,                                                  desc = "Triggers the Lazy update" },
            { "<leader>un",  function() require('notify').dismiss({ silent = true, pending = true }) end, desc = "Dismiss all Notifications" },
            { "<leader>ut",  vim.cmd.UndotreeToggle,                                                      desc = "Toggles ON/OFF the handler of previous changes" },

            { "<leader>x",   group = "extra" },
            { "<leader>xf",  procs.toggle_folding_column,                                                 desc = "Shows/Hides the folding column" },
            { "<leader>xm",  "<Cmd>messages<CR>",                                                         desc = "Show Nvim Cmd messages" },
            { "<leader>xn",  procs.toggle_line_numbers,                                                   desc = "Toggle between absolute and relative line numbers" },
            { "<leader>xom", "<Cmd>Mason<CR>",                                                            desc = "Opens the Mason GUI" },
            { "<leader>xs",  "<Cmd>ASToggle<CR>",                                                         desc = "Toggle ON/OFF autosave" },
            { "<leader>xt",  "<Cmd>TransparentToggle<CR>",                                                desc = "Toggle ON/OFF transparency" },
        })
    end
}
