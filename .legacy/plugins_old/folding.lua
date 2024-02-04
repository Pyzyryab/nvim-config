-- Folding plugin
--
return {
    {'kevinhwang91/promise-async', lazy = true},
    {'kevinhwang91/nvim-ufo', run = ':TSUpdate', requires = 'kevinhwang91/promise-async', lazy = true}
}
