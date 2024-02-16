--  Files and directories explorer plugins
--
return {
    neo_tree = 'nvim-neo-tree/neo-tree.nvim',
    neo_tree_diagnostics = {
        'mrbjarksen/neo-tree-diagnostics.nvim',
        requires = 'nvim-neo-tree/neo-tree.nvim',
        module = 'neo-tree.sources.diagnostics', -- for lazy loading
    }
}

