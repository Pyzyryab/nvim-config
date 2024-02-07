return {
    lazy = false,
    keys = {
        { "<leader>fp", '<cmd>:Telescope projections<cr>', desc = 'Open Project Manager' },
    },
    opts = {
        -- Workspaces to search for, (table|string)[]
        workspaces = {
            -- Examples:
            { path = "~/.config/*", patterns = { ".git" } },
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
    }
}

