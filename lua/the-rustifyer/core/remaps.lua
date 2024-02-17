-- This file holds my personal keymaps and remaps, along as the configuration for the leader key
--
-- Not all remaps may be configured here, as they could be directly configured in the plugins

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
            -- Pending to add or to review
            -- :Telescope dap commands
            -- :Telescope dap configurations
            -- :Telescope dap list_breakpoints
            -- :Telescope dap variables
            -- :Telescope dap frames
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
            -- Telescope pending to review and add remaps
            --[[ nnoremap("<leader>fm", "<cmd>Telescope marks<cr>", "Find mark")
            nnoremap("<leader>fr", "<cmd>Telescope lsp_references<cr>", "Find references (LSP)")
            nnoremap("<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", "Find symbols (LSP)")
            nnoremap("<leader>fc", "<cmd>Telescope lsp_incoming_calls<cr>", "Find incoming calls (LSP)")
            nnoremap("<leader>fo", "<cmd>Telescope lsp_outgoing_calls<cr>", "Find outgoing calls (LSP)")
            nnoremap("<leader>fi", "<cmd>Telescope lsp_implementations<cr>", "Find implementations (LSP)")
            nnoremap("<leader>fx", "<cmd>Telescope diagnostics bufnr=0<cr>", "Find errors (LSP)") ]]
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
            name = '+line/live',
            n = { procs.toggle_line_numbers, 'Toggle between absolute and relative line numbers' },
            g = { CMD .. 'Telescope live_grep' .. CR, 'Find text in files' },
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
            s = { CMD .. 'lua require("spectre").toggle()' .. CR, 'Toggle Spectre' },
            w = { CMD .. 'lua require("spectre").open_visual({select_word=true})' .. CR, 'Search current word' },
            p = { CMD .. 'lua require("spectre").open_file_search({select_word=true})' .. CR, 'Search on current file' }
        },
        t = {
            name = 'terminal',
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
        }
    },
})


-- Toggleterm on terminal mode
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<C-\><C-n>]], opts)
    --vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    vim.keymap.set('t', '<C-q>', [[<C-\><C-n><C-w>q]], opts)
    -- force close without prompting
    vim.keymap.set("t", "<A-c>", [[<Cmd>q!<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


----------------- General custom remaps -----------------
--

local noremapsilent = { noremap = true, silent = true }

-- Opens `Newtr` file explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Remap tab and shift+tab in normal and visual mode to indent/unindent
vim.api.nvim_set_keymap('n', '<Tab>', '>>', noremapsilent)
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', noremapsilent)
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', noremapsilent)
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', noremapsilent)

-- Move to window using the <ctrl> + hjkl keys
vim.keymap.set('n', "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set('n', "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set('n', "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set('n', "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize the current windows size with <ctr> + arrow keys
vim.keymap.set('n', "<C-Up>", "<Cmd> resize -2<CR>", { desc = "Increase window height" })
vim.keymap.set('n', "<C-Down>", "<Cmd> resize +2<CR>", { desc = "Decrease window height" })
vim.keymap.set('n', "<C-Left>", "<Cmd> vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set('n', "<C-Right>", "<Cmd> vertical resize +2<CR>", { desc = "Increase window width" })

-- Moves the selected lines in Visual mode one down (J) or one up (K)
-- TODO in 'n' and 'v' with Alt - J/K
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')

-- Mantains the cursor of the middle of the screen moving up/down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Search terms stays in the middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Greatest remap ever. Thank you, theprimagean!
vim.keymap.set('x', '<leader>p', "\"_dP")

-- Yank the selected text to the system clipboard ("+y).
-- In Visual mode, it yanks the visually selected text
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

-- Yank from the cursor position to the end of the line
-- and copies it to the system clipboard ("+Y)
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- In summary, pressing <leader>d in Normal or Visual mode will delete
-- the selected text and place it into the black hole register,
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- This is going to get The Primagean cancelled X)
-- But seriously, is not only useful for preserving the content while on vertical visual,
-- but also helps with Telescope to not close it but easily leave insert mode while
-- typing something to search without having to hit <Esc>
vim.keymap.set('i', '<C-c>', '<Esc>')
