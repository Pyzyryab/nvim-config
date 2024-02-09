-- This file holds my personal keymaps and remaps, along as the configuration for the leader key
--
-- Not all remaps may be configured here, as they could be directly configured in the plugins

local procs = require('the-rustifyer.utils.procedures')
local wk = require('which-key')
local trouble = require('trouble')

wk.register({
    ["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", "Prev buffer" },
    ["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", "Next buffer" },
}, { mode = "n" })

wk.register({
    ["<leader>"] = {
        a = {
            w = { '<cmd>AddWorkspace<cr>', 'Add the CWD to the projects of the workspace' },
        },
        b = {
            name = '+buffers',
            p = { "<Cmd>BufferLineTogglePin<CR>", "Toggle pin" },
            P = { "<Cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" },
            o = { "<Cmd>BufferLineCloseOthers<CR>", "Delete other buffers" },
            r = { "Cmd>BufferLineCloseRight<CR>", "Delete buffers to the right" },
            l = { "<Cmd>BufferLineCloseLeft<CR>", "Delete buffers to the left" },
            d = { procs.minibufremove, "Delete Buffer" },
            D = { function() require("mini.bufremove").delete(0, true) end, "Delete Buffer (Force)" },
        },
        d = {
            name = '+diagnostics/trouble',
            t = { function() trouble.toggle() end, "Trouble toogle" },
            w = { function() trouble.toggle("workspace_diagnostics") end, "Workspace diagnostics" },
            d = { function() trouble.toggle("document_diagnostics") end, "Document diagnostics" },
            q = { function() trouble.toggle("quickfix") end, "Diagnostics quickfix" },
            l = { function() trouble.toggle("loclist") end, "Diagnostics loclist" },
            r = { function() trouble.toggle("lsp_references") end, "Lsp References" },
        },
        f = {
            name = "+file",
            f = { "<cmd>Telescope find_files<cr>", "Find Files" },
            o = { "<cmd>Telescope oldfiles<cr>", "Open Recent Files" },
            g = { "<cmd>Telescope git_files<cr>", "Find files on git repository" },
            b = { "<cmd>Telescope buffers<cr>", "Find open buffers" },
            c = { "<cmd>Telescope commands<cr>", "Show commands" },
            h = { "<cmd>Telescope help_tags<cr>", "Show help tags" },
            p = { "<cmd>Telescope projections<cr>", "Search projects" },
            k = { "<cmd>Telescope colorscheme<cr>", "Show and preview colorschemes" },
        },
        g = {
            name = '+git',
            -- gitsigns maps are just labels, since they need to be attached per buffer (ideally)
            nh = { "Next Hunk" },
            ph = { "Prev Hunk" },
            hs = { "Stage Hunk" },
            hr = { "Reset Hunk" },
            sb = { "Stage Buffer" },
            us = { "Undo Stage Hunk" },
            rb = { "Reset Buffer" },
            hp = { "Preview Hunk Inline" },
            bl = { "Blame Line" },
            hd = { "Diff This" },
            hD = { "Diff This ~" },
        },
        l = {
            name = '+line/live',
            n = { procs.toggle_line_numbers, 'Toggle between absolute and relative line numbers' },
            g = { "<cmd>Telescope live_grep<cr>", "Find text in files" },
        },
        e = {
            name = 'editor',
            t = { '<cmd>Neotree toggle<CR>', 'Toggles Neotree depending on its current status' },
            o = { '<cmd>Neotree<CR>', 'Opens Neotree' },
            b = { '<cmd>Neotree toggle show buffers right<cr>', 'Neotree toggle show buffers right' },
            g = { '<cmd>Neotree float git status<cr>', 'Neotree show git status' },
        },
        p = {
            name = '+persistence',
            s = { function() require("persistence").load() end, "Restore Session" },
            l = { function() require("persistence").load({ last = true }) end, "Restore Last Session" },
            d = { function() require("persistence").stop() end, "Don't Save Current Session" },
        },
        t = {
            name = '+treessitter',
            u = {
                function()
                    local tsc = require("treesitter-context")
                    tsc.toggle()
                end,
                "Toggle Treesitter Context",
            },
        }
    },
}, { mode = "n" })


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
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Yank the selected text to the system clipboard ("+y).
-- In Visual mode, it yanks the visually selected text
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

-- Yank from the cursor position to the end of the line
-- and copies it to the system clipboard ("+Y)
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- In summary, pressing <leader>d in Normal or Visual mode will delete
-- the selected text and place it into the black hole register,
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
