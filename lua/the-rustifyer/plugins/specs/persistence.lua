-- Plugins for handling user projects and store the
-- state of `Neovim` sessions
--
return {
    persistence = 'folke/persistence.nvim',
    projections = { 'gnikdroy/projections.nvim' },
    undotree = { 'mbbill/undotree', cmd = 'UndotreeToggle',  no_extra_config = true }
}

