# My personal NVIM configuration and set up

Hello everyone.

This repo is made just to track the progress of the **from O IDE** creating and configuring from scratch
my own `vim/nvim` set up.

This allows me to keep tracked the changes I introduce over the time, see how my personal configuration evolves over the time and share it with anyone instested while I am able to make some sort of tutorial while I am writing it.

Also, this allows me to have a reference point whenever I got into a new computer or set up, so I can quickly just `git clone` this repository and start to work inmmediatly.

## References (WIP)

- The primagean videos
- The guy on medium

## Config and Set Up across different OS

I mostly do my coding personal job on `Linux` and `Windows` (like 70% - 30%) and my professional paid job the other way around, `Windows` and `Linux` (like 85% - 15%), and I use `Linux` mostly though `WSL`.

So you won't find any interesting here about `Mac`

For `Unix` users, vim already comes by default on most of the modern distros. And `nvim` is an easy to get one.
But `Windows` is a different kind of thing. You'll need to do some job to get your `nvim` working fine or it, so I'll let you [here](TODO link to the medium guide) a nice guide of how to get and install it on `Windows`.

## The **<leader>** key and custom Remaps 

For convenience, in my set up I like to have the `<leader >` key mapped to the `spacebar` key.
The spacebar is extremely fast and confortable, since I am able to reach it with both hands quickly and without having to make any extrange movements with any of my fingers.

All the remaps configured for this setup are in the [remap.lua](./lua/therustifyer/remap.lua)
or directly set up in the configuration files or each individual plugin whenever it makes sense.

Even tho, the most notorious one for me are:

- `<leader>pv`: Goes back to `Netrw` from the source origin `:so`
- `<leader>pf`: Launches the project files navigator  
- `<leader>ps`: Performns a search for the input text on the project files 
- `<C-p>`: Launches the project files navigator but only for files tracked by **git**
- `<leader>a`: Adds a new entry to `Harpoon`
- `<C-e>`: Opens `Harpoon` selector
- `<C-h>`: `Harpoon` select (1)
### TODO remaining `Harpoon` pickers, but I am not confortable with the ThePrimagean ones

## Plugins 

- Vim/Neovim plugin manager [Packer](https://github.com/wbthomason/packer.nvim)
- Project files navigation [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- Base Editor Theme: [Rose-Pine](https://github.com/rose-pine/neovim)
- The Neovim abstraction layer for `tree-sitter`, the parser generator tool and incremental parsing library: [Tree Siter Nvim](https://github.com/nvim-treesitter/nvim-treesitter)
 - Faster files switcher and picker [Harpoon 2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
 - Track all the changes made on the current project [UndoTree](https://github.com/mbbill/undotree)
 - Manage the git local repository of the project within Nvim [vim fugitive](https://github.com/tpope/vim-fugitive)

 - Lsp with lsp-zero configuration:

 ```lua
 -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'}
 ```

