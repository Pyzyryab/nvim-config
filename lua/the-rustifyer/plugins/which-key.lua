-- Plugin for having a cheatsheet of all our custom remaps.
-- It will be triggered after pressing some key and waiting for a second, showing all the available
-- combinations for the pressed key

return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
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

        local is_win = require('the-rustifyer.core.globals').sys.is_windows

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
                    B = { CMD .. 'lua require("persistent-breakpoints.api").toggle_breakpoint()' .. CR, 'Set breakpoint' },
                    C = { CMD .. 'lua require("persistent-breakpoints.api").set_conditional_breakpoint()' .. CR, 'Set conditional breakpoint' },
                    L = { CMD .. 'lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))' .. CR, 'Set log point' },
                    R = { CMD .. 'lua require("persistent-breakpoints.api").clear_all_breakpoints()' .. CR, 'Clear breakpoints' },
                    F = { CMD .. 'Telescope dap list_breakpoints' .. CR, 'List breakpoints' },
                },
                c = {
                    b = {
                        function()
                            require("Comment.api").toggle.blockwise.current()
                        end, 'Comment line/selection'
                    },
                    l = {
                        function()
                            require("Comment.api").toggle.linewise.current()
                        end, 'Comment line'
                    },
                    -- CMake plugin actions
                    mg = { CMD .. 'CMakeGenerate' .. CR, 'Runs <CMakeGenerate>' },
                    mb = { CMD .. 'CMakeBuild' .. CR, 'Runs <CMakeBuild>' },
                    mr = { CMD .. 'CMakeRun' .. CR, 'Runs <CMakeRun>' },
                    mt = { CMD .. 'CMakeRunTest' .. CR, 'Runs <CMakeRunTest>' },
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
                    t = { CMD .. 'TodoTelescope' .. CR, 'Open a TODO-\'s preview' },
                    n = { CMD .. 'Telescope notify' .. CR, 'Displays the notifications triggered' },
                },
                g = {
                    name = '+git',
                    s = { vim.cmd.Git, 'Shows git status via vim-fugitive' },
                    a = { CMD .. 'GhActions' .. CR, 'Opens GitHub Actions on buffer' },
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
                    w = { function() require('telescope').extensions.git_worktree.git_worktrees() end, 'Show git worktrees via Telescope' },
                    cw = { function() require('telescope').extensions.git_worktree.create_git_worktree() end, 'Create a new git worktree via Telescope' },
                    gt = { CMD .. 'diffget // 2 | diffupdate' .. CR, 'Get changes from target version of the document and updates the indexes' },
                    gm = { CMD .. 'diffget // 3 | diffupdate' .. CR, 'Get changes from the merge version and updates the indexes' },
                    dp = { CMD .. 'diffput | diffupdate' .. CR, 'Put the changes on the working copy from the target or merge version and updates the indexes' },
                    mu = { CMD .. 'diffupdate' .. CR, 'Updates the changes in the gitmergetool' },
                },
                j = {
                    name = '+Java',
                    -- TODO: /code isn't default for all Java project's. Review this
                    -- TODO: Wrap everything in a custom function
                    sr = {
                        function()
                            if is_win then vim.opt.shellcmdflag = "-s -c" end
                            local Terminal = require('toggleterm.terminal').Terminal
                            local lazygit  = Terminal:new({
                                cmd = 'mvn spring-boot:run',
                                dir = vim.fn.getcwd() .. '/code',
                                direction = 'float',
                                close_on_exit = true,
                                float_opts = { border = 'double', },
                            })
                            lazygit:toggle()
                        end,
                        'Run Java Spring Boot Project with Maven'
                    },
                    sR = {
                        function()
                            if is_win then vim.opt.shellcmdflag = "-s -c" end
                            local Terminal = require('toggleterm.terminal').Terminal
                            local lazygit  = Terminal:new({
                                cmd = 'mvn spring-boot:run',
                                dir = vim.fn.getcwd() .. '/code',
                                direction = 'tab',
                                close_on_exit = true,
                                float_opts = { border = 'double', },
                            })
                            lazygit:toggle()
                        end,
                        'Run Java Spring Boot Project with Maven (new tab)'
                    },
                    sd = {
                        function()
                            if is_win then vim.opt.shellcmdflag = "-s -c" end
                            local Terminal = require('toggleterm.terminal').Terminal
                            local lazygit  = Terminal:new({
                                cmd = "mvn spring-boot:run -Dspring-boot.run.jvmArguments='-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=*:5005'",
                                dir = vim.fn.getcwd() .. '/code',
                                direction = 'float',
                                close_on_exit = true,
                                float_opts = { border = 'double', },
                            })
                            lazygit:toggle()
                        end,
                        'Debug Java Spring Boot Project with Maven'
                    },
                    sD = {
                        function()
                            if is_win then vim.opt.shellcmdflag = "-s -c" end
                            local Terminal = require('toggleterm.terminal').Terminal
                            local lazygit  = Terminal:new({
                                cmd = "mvn spring-boot:run -Dspring-boot.run.jvmArguments='-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=*:5005'",
                                dir = vim.fn.getcwd() .. '/code',
                                direction = 'float',
                                close_on_exit = true,
                                float_opts = { border = 'double', },
                            })
                            lazygit:toggle()
                        end,
                        'Debug Java Spring Boot Project with Maven (new tab)'
                    },
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
                mp = { -- TODO: Correct this so the description can be shown correctly
                    CMD .. 'Glow' .. CR, 'Preview current Mardown file'
                },
                m = {
                    name = '+maven',
                    -- c = { CMD .. 'Maven' .. CR, 'Choose Maven command to execute' },
                    c = { CMD .. 'Maven' .. CR, 'Choose Maven command to execute' },
                },
                o = {
                    name = '+open',
                    d = { CMD .. 'DocsViewToggle' .. CR, 'Toggles a buffer with documentation for the selected item' },
                    u = { CMD .. 'URLOpenUnderCursor' .. CR, 'Opens the URL under the cursor' },
                    h = { CMD .. 'URLOpenHighlightAll' .. CR, 'Highlights all the URLs present on the current buffer' },
                    c = { CMD .. 'URLOpenHighlightAllClear' .. CR, 'Clears all the highlighter URLs' },
                    m = { CMD .. 'Mason' .. CR, 'Opens the Mason GUI' },
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
                    a = { CMD .. 'ToggleTermToggleAll' .. CR, 'Toggles all terminals' },
                    o = { (function()
                        if is_win then vim.opt.shellcmdflag = "-s" end
                        return CMD .. 'ToggleTerm' .. CR
                    end)(), 'Opens a new terminal' },
                    g = {
                        -- CMD .. 'TermExec cmd="lazygit" direction=float name="lazygit" go_back=1 close_on_exit=true' .. CR,
                        function() --TODO: The above line it's kinda provisonal conf while knowing what's going wrong between different windows hosts
                            if is_win then vim.opt.shellcmdflag = "-s -c" end
                            local Terminal = require('toggleterm.terminal').Terminal
                            local lazygit  = Terminal:new({
                                cmd = 'lazygit',
                                dir = 'git_dir',
                                direction = 'float',
                                close_on_exit = true,
                                float_opts = {
                                    border = 'double',
                                },
                            })
                            lazygit:toggle() -- TODO: Toggle doesn't pick the already opened one
                        end,
                        'Open Lazygit on a floating window'
                    },
                    G = {
                        function()
                            if is_win then vim.opt.shellcmdflag = "-s -c" end
                            local Terminal = require('toggleterm.terminal').Terminal
                            local lazygit  = Terminal:new({
                                cmd = 'lazygit',
                                dir = 'git_dir',
                                direction = 'tab',
                                close_on_exit = true,
                                float_opts = {
                                    border = 'double',
                                },
                            })
                            lazygit:toggle() -- TODO: Toggle doesn't pick the already opened one
                        end,
                        'Open Lazygit on a new Tab'
                    },
                    j = {
                        function()
                            local Terminal   = require('toggleterm.terminal').Terminal
                            local float_term = Terminal:new({
                                dir = 'git_dir',
                                direction = 'float',
                                close_on_exit = true,
                                float_opts = {
                                    border = 'double',
                                },
                            })
                            float_term:toggle()
                        end,
                        'Open/Toggle a float terminal'
                    },
                    k = {
                        function()
                            local Terminal = require('toggleterm.terminal').Terminal
                            local float_term = Terminal:new({
                                dir = 'git_dir',
                                direction = 'tab',
                                close_on_exit = false,
                            })
                            float_term:toggle()
                        end,
                        'Open/Toggle a float terminal'
                    },
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
                    f = { procs.toggle_folding_column, 'Shows/Hides the folding column' },
                    t = { CMD .. 'TransparentToggle' .. CR, 'Toggle ON/OFF transparency' },
                    s = { CMD .. 'ASToggle' .. CR, 'Toggle ON/OFF autosave' },
                    m = { CMD .. 'messages' .. CR, 'Show Nvim Cmd messages' },
                }
            },
        })
    end
}
