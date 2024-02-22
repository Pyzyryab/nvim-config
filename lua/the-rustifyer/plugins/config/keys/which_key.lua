-- Configuration for the which-key plugin, which takes care
-- of showing a popup with the keymaps/remaps defined for the setup
--
return {
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 1000
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        local procs = require('the-rustifyer.utils.procedures')
        local wk = require('which-key')

        -- We store here this callback, so we can pass it later to remaps that should be only working on
        -- specific buffers
        local bufnr = vim.api.nvim_get_current_buf()

        local CMD = '<Cmd>'
        local CR = '<CR>'
        local ESC = '<Esc>'

        -- Visual mode ones
        wk.register({
            { mode = 'v' },
            ['<leader>'] = {
                c = {
                    b = {
                        function()
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(ESC, true, true, true), 'n', true)
                            require("Comment.api").toggle.linewise(vim.fn.visualmode())
                        end, 'Comment selection (Visual)'
                    },
                },
            },
        })

        -- The Rust remaps :D
        -- Care! They only work when a buffer of ft = 'Rust' is opened and 'rust-analyzer'
        -- is completly load. Otherwise, an error will be thrown
        wk.register({
            { mode = 'n', buffer = bufnr },
            ['<leader>'] = {
                r = {
                    name = '+Rust LSP actions (care!: only enabled for ft = Rust)',
                    c = {
                        function() vim.cmd.RustLsp('openCargo') end, 'Open cargo.toml'
                    },
                    d = {
                        function() vim.cmd.RustLsp('debuggables') end, 'Show debuggables'
                    },
                    D = {
                        -- Display a hover window with the rendered diagnostic, as displayed during cargo build.
                        -- Useful for solving bugs around borrowing and generics, as it consolidates the important bits
                        -- (sometimes across files) together.
                        function() vim.cmd.RustLsp('renderDiagnostic') end, 'Render diagnostic'
                    },
                    e = {
                        -- My favourite one!
                        -- Display a hover window with explanations from the rust error codes index over error diagnostics
                        -- (if they have an error code).
                        function() vim.cmd.RustLsp('explainError') end, 'Explain error'
                    },
                    h = {
                        -- Replaces Neovim's built-in hover handler with hover actions, so you can also use vim.lsp.buf.hover()
                        function() vim.cmd.RustLsp { 'hover', 'actions' } end, 'Hover actions'
                    },
                    p = {
                        function() vim.cmd.RustLsp('parentModule') end, 'Parent module'
                    },
                    r = {
                        function() vim.cmd.RustLsp('runnables') end, 'Show runnables'
                    },
                    t = {
                        function() vim.cmd.RustLsp('testables') end, 'Show testables'
                    },
                },
                rl = {
                    name = '+last selected',
                    r = {
                        function() vim.cmd.RustLsp { 'runnables', bang = true } end, 'launch previous runnable'
                    },
                    t = {
                        function() vim.cmd.RustLsp { 'testables', bang = true } end, 'launch previous testable'
                    },
                    d = {
                        function() vim.cmd.RustLsp { 'debuggables', bang = true } end, 'launch previous debuggable'
                    },
                },
                rm = {
                    name = '+macros',
                    e = {
                        function() vim.cmd.RustLsp('expandmacro') end, 'Expand macro'
                    },
                    r = {
                        function() vim.cmd.RustLsp('rebuildProcMacros') end, 'Rebuild proc macros'
                    },
                },
                rv = {
                    name = '+view',
                    h = {
                        function() vim.cmd.RustLsp { 'view', 'hir' } end, 'View HIR'
                    },
                    m = {
                        function() vim.cmd.RustLsp { 'view', 'mir' } end, 'View MIR'
                    },
                    s = {
                        function()
                            vim.cmd.RustLsp {
                                'workspaceSymbol',
                                '<onlyTypes|allSymbols>' --[[ optional ]],
                                -- '<query>' --[[ optional ]],
                                bang = true --[[ optional ]]
                            }
                        end, 'Show workspace symbols (with deps)'
                    },
                    t = {
                        function() vim.cmd.RustLsp('syntaxTree') end, 'Show syntax tree'
                    },
                },
            }
        })

        -- General remaps
        wk.register({
            { mode = 'n' },
            ['<A-h>'] = { CMD .. 'BufferLineCyclePrev' .. CR, 'Prev buffer' },
            ['<A-l>'] = { CMD .. 'BufferLineCycleNext' .. CR, 'Next buffer' },
            ['<leader>'] = {
                a = {
                    w = { CMD .. 'AddWorkspace' .. CR, 'Add the CWD to the projects of the workspace' },
                },
                b = {
                    name = '+buffers',
                    p = { CMD .. 'BufferLineTogglePin' .. CR, 'Toggle pin' },
                    P = { CMD .. 'BufferLineGroupClose ungrouped' .. CR, 'Delete non-pinned buffers' },
                    o = { CMD .. 'BufferLineCloseOthers' .. CR, 'Delete other buffers' },
                    r = { CMD .. 'BufferLineCloseRight' .. CR, 'Delete buffers to the right' },
                    l = { CMD .. 'BufferLineCloseLeft' .. CR, 'Delete buffers to the left' },
                    d = { procs.minibufremove, 'Delete Buffer' },
                    D = { function() require("mini.bufremove").delete(0, true) end, 'Delete Buffer (Force)' },
                },
                B = {
                    name = '+breakpoints',
                    B = { CMD .. 'lua require"dap".toggle_breakpoint()' .. CR, 'Set breakpoint' },
                    C = { CMD .. 'lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))' .. CR, 'Set conditional breakpoint' },
                    L = { CMD .. 'lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))' .. CR, 'Set log point' },
                    R = { CMD .. 'lua require"dap".clear_breakpoints()' .. CR, 'Clear breakpoints' },
                    F = { CMD .. 'Telescope dap list_breakpoints' .. CR, 'List breakpoints' },
                },
                c = {
                    b = {
                        function()
                            require("Comment.api").toggle.blockwise.current()
                        end, 'Comment selection'
                    },
                    l = {
                        function()
                            require("Comment.api").toggle.linewise.current()
                        end, 'Comment line'
                    },
                },
                d = {
                    name = '+diagnostics/trouble',
                    t = { CMD .. 'lua require("trouble").toggle() ' .. CR, 'Trouble toogle' },
                    w = { CMD .. 'lua require("trouble").toggle("workspace_diagnostics") ' .. CR, 'Workspace diagnostics' },
                    d = { CMD .. 'lua require("trouble").toggle("document_diagnostics") ' .. CR, 'Document diagnostics' },
                    q = { CMD .. 'lua require("trouble").toggle("quickfix") ' .. CR, 'Diagnostics quickfix' },
                    l = { CMD .. 'lua require("trouble").toggle("loclist") ' .. CR, 'Diagnostics loclist' },
                    r = { CMD .. 'lua require("trouble").toggle("lsp_references") ' .. CR, 'Lsp References' },
                },
                D = {
                    name = '+debugger',
                    C = { CMD .. 'lua require"dap".continue()' .. CR, 'Continue' },
                    J = { CMD .. 'lua require"dap".step_over()' .. CR, 'Step over' },
                    K = { CMD .. 'lua require"dap".step_into()' .. CR, 'Step into' },
                    O = { CMD .. 'lua require"dap".step_out()' .. CR, 'Step out' },
                    D = { CMD .. 'lua require"dap".disconnect()' .. CR, 'Disconnect' },
                    T = { CMD .. 'lua require"dap".terminate()' .. CR, 'Terminate' },
                    R = { CMD .. 'lua require"dap".repl.toggle()' .. CR, 'Open REPL' },
                    L = { CMD .. 'lua require"dap".run_last()' .. CR, 'Run Last' },
                    V = { 'function() require"dap.ui.widgets".hover() end', 'Variables' },
                    s = { function()
                        local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
                    end, 'Scopes' },
                    F = { CMD .. 'Telescope dap frames' .. CR, 'List Frames' },
                    Q = { CMD .. 'Telescope dap commands' .. CR, 'List commands' },
                    U = { function() require("dapui").toggle() end, 'Open debugger UI' },
                    -- Pending to add or to review
                    -- :Telescope dap configurations
                    -- :Telescope dap list_breakpoints
                    -- :Telescope dap variables
                },
                e = {
                    name = 'editor',
                    t = { CMD .. 'Neotree toggle' .. CR, 'toggles neotree depending on its current status' },
                    o = { CMD .. 'Neotree' .. CR, 'opens neotree' },
                    b = { CMD .. 'Neotree toggle show buffers right' .. CR, 'neotree toggle show buffers right' },
                    g = { CMD .. 'Neotree float git status' .. CR, 'neotree show git status' },
                    e = { CMD .. 'Neotree diagnostics reveal bottom' .. CR, 'neotree show workpace diagnostics' },
                },
                f = {
                    name = '+find/file',
                    f = { CMD .. 'Telescope find_files' .. CR, 'find files' },
                    o = { CMD .. 'Telescope oldfiles' .. CR, 'open recent files' },
                    g = { CMD .. 'Telescope git_files' .. CR, 'find files on git repository' },
                    b = { CMD .. 'Telescope buffers' .. CR, 'Find open buffers' },
                    c = { CMD .. 'Telescope commands' .. CR, 'Show commands' },
                    h = { CMD .. 'Telescope help_tags' .. CR, 'Show help tags' },
                    p = { CMD .. 'Telescope projections' .. CR, 'Search projects' },
                    k = { function() require("telescope.builtin").colorscheme() end, 'Show and preview colorschemes' },
                    t = { CMD .. 'TodoTelescope' .. CR, 'Open a TODOs preview' },
                    n = { CMD .. 'Telescope notify' .. CR, 'Displays the notifications triggered' },
                },
                g = {
                    name = '+git',
                    s = { vim.cmd.Git, 'Shows git status via vim-fugitive' },
                    -- gitsigns maps are just labels, since they need to be attached per buffer (ideally)
                    nh = { 'Next Hunk' },
                    ph = { 'Prev Hunk' },
                    hs = { 'Stage Hunk' },
                    hr = { 'Reset Hunk' },
                    sb = { 'Stage Buffer' },
                    us = { 'Undo Stage Hunk' },
                    rb = { 'Reset Buffer' },
                    hp = { 'Preview Hunk Inline' },
                    bl = { 'Blame Line' },
                    hd = { 'Diff This' },
                    hD = { 'Diff This ~' },
                },
                l = {
                    name = '+LSP', --NOTE Not all the LSP remaps are here for now
                    I = { CMD .. 'LspInfo' .. CR, 'Opens the LSP info floating window' },
                    L = { CMD .. 'LspLog' .. CR, 'Opens the LSP log file' },
                    r = { CMD .. 'Telescope lsp_references' .. CR, 'References' },
                    s = { CMD .. 'Telescope lsp_document_symbols' .. CR, 'Symbols' },
                    i = { CMD .. 'Telescope lsp_implementations' .. CR, 'Implementations' },
                    e = { CMD .. 'Telescope diagnostics bufnr=0' .. CR, 'Errors' },
                    m = { CMD .. 'Telescope marks' .. CR, 'Find Mark' },
                    c = { CMD .. 'Telescope lsp_incoming_calls' .. CR, 'Find LSP incoming calls' },
                    o = { CMD .. 'Telescope lsp_outgoing_calls' .. CR, 'Find LSP outgoing calls' },
                    k = { function() require("lsp_signature").toggle_float_win() end, 'toggle signature' },
                },
                o = {
                    name = '+open',
                    d = { CMD .. 'DocsViewToggle' .. CR, 'Toggles a buffer with documentation for the selected item' },
                },
                p = {
                    name = '+persistence',
                    s = { function() require("persistence").load() end, 'Restore Session' },
                    l = { function() require("persistence").load({ last = true }) end, 'Restore Last Session' },
                    d = { function() require("persistence").stop() end, 'Don\'t Save Current Session' },
                },
                q = { CMD .. 'close' .. CR, 'Fires the `Close` cmd' },
                s = {
                    name = '+search',
                    f = { CMD .. 'Telescope live_grep' .. CR, 'Find text in files' },
                    s = { CMD .. 'lua require("spectre").toggle()' .. CR, 'Toggle Spectre' },
                    w = { CMD .. 'lua require("spectre").open_visual({select_word=true})' .. CR, 'Search current word' },
                    p = { CMD .. 'lua require("spectre").open_file_search({select_word=true})' .. CR, 'Search on current file' }
                },
                t = {
                    name = '+terminal',
                    s = { CMD .. 'TermSelect' .. CR, 'Shows opened terminals. Allows to pick them' },
                    o = { CMD .. 'ToggleTerm' .. CR, 'Toggle ToggleTerm' },
                    g = { function()
                        local Terminal = require('toggleterm.terminal').Terminal
                        local lazygit  = Terminal:new({
                            cmd = 'lazygit',
                            dir = 'git_dir',
                            direction = 'float',
                            float_opts = {
                                border = 'double',
                            },
                        })
                        lazygit:toggle() -- TODO Toggle doesn't pick the already opened one
                    end, 'Open Lazy Git on ToggleTerm' },
                },
                ts = {
                    name = '+treessitter',
                    u = {
                        function()
                            local tsc = require('treesitter-context')
                            tsc.toggle()
                        end,
                        'Toggle Treesitter Context',
                    },
                },
                u = {
                    name = '+undo',
                    t = { vim.cmd.UndotreeToggle, 'Toggles ON/OFF the handler of previous changes' },
                    n = { function() require('notify').dismiss({ silent = true, pending = true }) end, 'Dismiss all Notifications', }
                },
                x = {
                    name = '+extra',
                    n = { procs.toggle_line_numbers, 'Toggle between absolute and relative line numbers' },
                }
            },
        })
    end
}
