-- Configuration for the `persistence` plugin
--
return {
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
}

