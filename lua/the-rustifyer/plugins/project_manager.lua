-- Create workspaces to easily navegate them by grouping related projects that you want to quickly browse
-- or change into
--
return {
    {
        'gnikdroy/projections.nvim',
        event = 'VeryLazy',
        branch = 'dev',
        config = function()
            -- Save localoptions to session file
            vim.opt.sessionoptions:append("localoptions")

            require('projections').setup({

                workspaces = {
                    -- { path = "~/repos", patterns = {} }      , -- An empty pattern list indicates that all subdirectories are projects
                    -- i.e patterns are not considered
                    -- { path = "~/dev" },                        -- When patterns is not provided, default patterns is used (specified below)
                },

                -- Default set of patterns, string[]
                -- NOTE: patterns are not regexps
                default_patterns = { ".git", ".svn", ".hg" },

                -- Whether to show preview window via telescope, boolean
                show_preview = true,

                -- If projections will try to auto restore sessions when you start neovim, boolean
                auto_restore = false,
                -- The behaviour is as follows:
                -- 1) If vim was started with arguments, do nothing
                -- 2) If in some project's root, attempt to restore that project's session
                -- 3) If not, restore last stored session

                -- Path to workspaces json file, string?
                workspaces_file = vim.fn.stdpath("data") .. "\\projections_workspaces.json",

                -- Directory where sessions are stored
                sessions_directory = vim.fn.stdpath("cache") .. "\\projections_sessions/",
            })

            -- Autostore session on VimExit
            local Session = require("projections.session")
            vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
                callback = function()
                    local nt = require('neo-tree')
                    vim.cmd('Neotree action=close')
                    -- print('Neotree close on pre store hooks: ', succ)
                    Session.store(vim.loop.cwd())
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "ProjectionsPreStoreSession",
                callback = function()
                    if pcall(require, "neo-tree") then vim.cmd [[Neotree action=close]] end
                end
            })

            -- Switch to project if vim was started in a project dir
            local switcher = require("projections.switcher")
            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = function()
                    if vim.fn.argc() == 0 then switcher.switch(vim.loop.cwd()) end
                end,
            })

            -- Manual Session commands
            vim.api.nvim_create_user_command("StoreProjectSession", function()
                Session.store(vim.loop.cwd())
            end, {})

            vim.api.nvim_create_user_command("RestoreProjectSession", function()
                Session.restore(vim.loop.cwd())
            end, {})

            -- Create `AddWorkspace` command
            local Workspace = require("projections.workspace")

            -- Add workspace command
            vim.api.nvim_create_user_command("AddWorkspace", function()
                Workspace.add(vim.loop.cwd())
            end, {})


            -- Set the neo-tree correct CWD when switching projectss
            vim.api.nvim_create_autocmd("User", {
                pattern = "ProjectionsPostRestoreSession",
                callback = function()
                    local succ, res = pcall(require, "neo-tree")
                    --if succ then vim.cmd [[Neotree dir=vim.loop.cwd()]] end
                    print('Setting neo-tree dir to: ', vim.loop.cwd() .. ' with success: ' .. vim.inspect(succ))
                end
            })
        end
    },
}
