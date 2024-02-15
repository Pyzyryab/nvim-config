-- This file holds my personal keymaps and remaps, along as the configuration for the leader key
--
-- Not all remaps may be configured here, as they could be directly configured in the plugins

local procs = require('the-rustifyer.utils.procedures')
local wk = require('which-key')

local cmd = '<Cmd>'
local CR = '<CR>'

wk.register({
    ['<S-h>'] = { '<cmd>BufferLineCyclePrev<cr>', 'Prev buffer' },
    ['<S-l>'] = { '<cmd>BufferLineCycleNext<cr>', 'Next buffer' },
}, { mode = 'n' })

wk.register({
    { mode = 'n' },
    ['<leader>'] = {
        a = {
            w = { '<cmd>AddWorkspace<cr>', 'Add the CWD to the projects of the workspace' },
        },
        b = {
            name = '+buffers',
            p = { '<Cmd> BufferLineTogglePin<CR>', 'Toggle pin' },
            P = { '<Cmd> BufferLineGroupClose ungrouped<CR>', 'Delete non-pinned buffers' },
            o = { '<Cmd> BufferLineCloseOthers<CR>', 'Delete other buffers' },
            r = { '<Cmd> BufferLineCloseRight<CR>', 'Delete buffers to the right' },
            l = { '<Cmd> BufferLineCloseLeft<CR>', 'Delete buffers to the left' },
            d = { procs.minibufremove, 'Delete Buffer' },
            D = { function() require("mini.bufremove").delete(0, true) end, 'Delete Buffer (Force)' },
        },
        B = {
            name = '+breakpoints',
            B = { '<cmd>lua require"dap".toggle_breakpoint()<cr>', 'Set breakpoint' },
            C = { '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>', 'Set conditional breakpoint' },
            L = { '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>', 'Set log point' },
            R = { '<cmd>lua require"dap".clear_breakpoints()<cr>', 'Clear breakpoints' },
            F = { '<cmd>Telescope dap list_breakpoints<cr>', 'List breakpoints' },
        },
        d = {
            name = '+diagnostics/trouble',
            t = { '<Cmd> lua require("trouble").toggle() <CR>', 'Trouble toogle' },
            w = { '<Cmd> lua require("trouble").toggle("workspace_diagnostics") <CR>', 'Workspace diagnostics' },
            d = { '<Cmd> lua require("trouble").toggle("document_diagnostics") <CR>', 'Document diagnostics' },
            q = { '<Cmd> lua require("trouble").toggle("quickfix") <CR>', 'Diagnostics quickfix' },
            l = { '<Cmd> lua require("trouble").toggle("loclist") <CR>', 'Diagnostics loclist' },
            r = { '<Cmd> lua require("trouble").toggle("lsp_references") <CR>', 'Lsp References' },
        },
        D = {
            name = '+debugger',
            C = { '<cmd>lua require"dap".continue()<cr>', 'Continue' },
            J = { '<cmd>lua require"dap".step_over()<cr>', 'Step over' },
            K = { '<cmd>lua require"dap".step_into()<cr>', 'Step into' },
            O = { '<cmd>lua require"dap".step_out()<cr>', 'Step out' },
            D = { '<cmd>lua require"dap".disconnect()<cr>', '' },
            T = { '<cmd>lua require"dap".terminate()<cr>', 'Terminate' },
            R = { '<cmd>lua require"dap".repl.toggle()<cr>', 'Open REPL' },
            L = { '<cmd>lua require"dap".run_last()<cr>', 'Run Last' },
            V = { 'function() require"dap.ui.widgets".hover() end', 'Variables' },
            s = { function()
                local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
            end, 'Scopes' },
            F = { '<cmd>Telescope dap frames<cr>', 'List Frames' },
            Q = { '<cmd>Telescope dap commands<cr>', 'List commands' },
        },
        e = {
            name = 'editor',
            t = { '<cmd>Neotree toggle<cr>', 'toggles neotree depending on its current status' },
            o = { '<cmd>Neotree<cr>', 'opens neotree' },
            b = { '<cmd>Neotree toggle show buffers right<cr>', 'neotree toggle show buffers right' },
            g = { '<cmd>Neotree float git status<cr>', 'neotree show git status' },
        },
        f = {
            name = '+find/file',
            f = { '<cmd>Telescope find_files<cr>', 'find files' },
            o = { '<cmd>Telescope oldfiles<cr>', 'open recent files' },
            g = { '<cmd>Telescope git_files<cr>', 'find files on git repository' },
            b = { '<cmd>Telescope buffers<cr>', 'Find open buffers' },
            c = { '<cmd>Telescope commands<cr>', 'Show commands' },
            h = { '<cmd>Telescope help_tags<cr>', 'Show help tags' },
            p = { '<cmd>Telescope projections<cr>', 'Search projects' },
            k = { function() require("telescope.builtin").colorscheme() end, 'Show and preview colorschemes' },
            t = { '<cmd>TodoTelescope<cr>', 'Open a TODOs preview' },
            n = { '<cmd>Telescope notify<cr>', 'Displays the notifications triggered' },
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
            g = { '<cmd>Telescope live_grep<cr>', 'Find text in files' },
        },
        p = {
            name = '+persistence',
            s = { function() require("persistence").load() end, 'Restore Session' },
            l = { function() require("persistence").load({ last = true }) end, 'Restore Last Session' },
            d = { function() require("persistence").stop() end, 'Don\'t Save Current Session' },
        },
        q = { '<cmd>close<CR>', 'Fires the `Close` cmd' },
        s = {
            name = '+search',
            s = { '<cmd>lua require("spectre").toggle()<CR>', 'Toggle Spectre' },
            w = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', 'Search current word' },
            p = { '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', 'Search on current file' }
        },
        t = {
            name = 'terminal',
            s = { cmd .. 'TermSelect' .. CR, 'Shows opened terminals. Allows to pick them' },
            o = { cmd .. 'ToggleTerm' .. CR, 'Toggle ToggleTerm' },
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

--
--

local noremapsilent = { noremap = true, silent = true }

----------------- General custom remaps -----------------
--
-- Opens `Newtr` file explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Remap tab and shift+tab in normal and visual mode to indent/unindent
vim.api.nvim_set_keymap('n', '<Tab>', '>>', noremapsilent)
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', noremapsilent)
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', noremapsilent)
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', noremapsilent)

-- Move to window using the <ctrl> + hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize the current windows size with <ctr> + arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

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

