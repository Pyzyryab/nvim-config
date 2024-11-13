# My personal `Neovim` configuration and set up

Hello everyone!

This repo is made just to track the progress of the **from O to IDE** creating and configuring from scratch
my own `neovim` set up.

This allows me to keep tracked the changes I introduce over the time, see how my personal configuration evolves over the time and share it with anyone instead while I am able to make some sort of tutorial while I am writing it.

Also, this allows me to have a reference point whenever I got into a new computer or set up, so I can quickly just `git clone` this repository and start to work immediately.

> **Note:** Highlighted blue hyperlinks will lead you to the plugin's or tool author documentation or repository

## Config and Set Up across different OS

I mostly do my coding personal job on `Linux` and `Windows` (like 70% - 30%) and my professional paid job the other way around, `Windows` and `Linux` (like 85% - 15%), and I use `Linux` mostly though `WSL`.

So you won't find any interesting here about `Mac`

For `Unix` users, vim already comes by default on most of the modern distros. And `nvim` is an easy to get one.

But `Windows` is a different kind of thing. You'll need to do some job to get your `nvim` working fine or it,
so I'll let you [here](https://medium.com/nerd-for-tech/neovim-but-its-in-windows-f39f181afaf9) a nice guide of how to get and install it on `Windows`.

## Pre-requisites

### Windows specific ones

There's plugins on the set up that requires special tools to get their installation or job done.

Personally, for me, the easiest way of compatibilizing tools and dependencies workflows between
the `Unix` based tools and Windows, is to use [`Msys2`](https://packages.msys2.org). I really like
the `llvm` powered development set ups, letting `clang` make the build jobs that are required
to be done from scratch. And with `msys2` I just need to download it, add one of the shell environments
to the *Windows PATH*, and I am ready to work with almost everything I need.

This includes tools from a `C++` modern compiler, to static analyzers, unwind libraries, build systems
and a lot of different development tools.

Also, as I said previously, this makes my development tools much more uniform across different *OS*,
which makes me more productive at the end of the day.

> There's other ways of installing these tools, but I'll just document my favourite one

- Open the `clang64` *Msys2* shell, and directly copy paste the following line

```bash
pacman -S \
    mingw-w64-x86_64-{clang,cmake,make,ninja,llvm,llvm-libs,clang-analyzer,lld,libc++,libunwind,clang-tools-extra,compiler-rt,gcc-compat,gcc,diffutils}
```

- Add the `clang64` environment to the Windows **PATH**. Take the path where you
installed `Msys2`, add the binary directory of the `clang64` environment to it,
and add it to your path.

Mine, for example, is: `C:\msys64\clang64\bin`

And you're ready to go!

## Optional ones

### rip-grep

If you'd like to have `live grep`, you'll need to have [`ripgrep`](https://github.com/BurntSushi/ripgrep). The easiest way to install it is via cargo, just by:

```bash
cargo install ripgrep
```

If for some strange reason you don't have `The Rust programming language` in you computer, fix what's wrong with you and install it.
Then, go read the book, start to code in `Rust`. Then, gain knowledge about its ecosystem, and figure out what you've being missing
all this time.

Anyway, you can go to the `ripgrep` link above and install it via any of the other ways listed in their documentation.

### Clipboard tool

In order to allow integration between the system clipboard and some
vim registers, we need a clipboard provider.

I choose ` win32yank` for such purpose.

On `WSL(2)`:

```bash 
    -curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
    unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    chmod +x /tmp/win32yank.exe
    sudo mv /tmp/win32yank.exe /usr/local/bin/
```

On `msys2` (purple terminal):

```bash
    pacman -S unzip

    -curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
    unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    chmod +x /tmp/win32yank.exe
    sudo mv /tmp/win32yank.exe /usr/bin/ (or manually create the /usr/local/bin if doesn't exists)
```

## Package manager

When I first started with `Neovim`, I liked to use `packer` as my package manage. But it went unmaintained, and several candidates raised up as alternatives.

Finally, I decided to go with [lazy.vim](https://github.com/folke/lazy.nvim), since the set of features brings a lot of power to my daily development workflow and also comes
with a lot of predefined niceties that makes it wonderful.

## The **`<leader>`** key and custom Remaps

I like to have the `<leader>` key mapped to the `spacebar` key.
The space bar is extremely fast and comfortable, since I am able to reach it with both hands quickly and without having to make any estrange movements with any of my fingers. `<localleader>` is the `\` key.

All the keymaps and custom remaps configured for this setup are in the [keymaps file](./lua/config/keymaps.lua)
or directly set up in the configuration files or each individual plugin whenever it makes sense, but here's a quick look at the most important ones.

- `Telescope`
  - **`<leader>ff`** ⇒ Lists files in your current working directory. `.git` directory is intentionally disabled from the fuzzy search
  - **`<leader>fg`** ⇒ Fuzzy search through the output of git ls-files command, respects `.gitignore`
  - **`<leader>lg`** ⇒ Search for a string in your current working directory and get results live as you type, respects `.gitignore`
  - **`<leader>fb`** ⇒ Lists open buffers in current *Neovim* instance
  - **`<leader>fc`** ⇒ Lists available plugin/user commands and runs them on `<cr>`
  - **`<leader>fo`** ⇒ Lists previously open files
  - **`<leader>fh`** ⇒ Open *help tags*. This gives you quick documentation about editor elements
  - **`<leader>cs`** ⇒ Preview of locally installed colorschemes

- `Neotree`
  - **`<leader>nt`** ⇒ Starts `Neotree`
  - **`<leader>e`** ⇒ Toggle ON/OFF `Neotree`

## Plugins

Not all the installed plugins to make up this set up are listed here, but there's the most noticeable and kind of important ones

### [alpha](https://github.com/goolord/alpha-nvim)

`alpha` is a fast and fully programmable greeter for **Neovim**

I am using the [dashboard-nvim theme](https://github.com/goolord/alpha-nvim#dashboard-nvim-theme) and a set of custom randomized
**ASCII art** logos shown above the dashboard options. Find them [here](./ascii_art/).

### [which-key](https://github.com/folke/which-key.nvim)

`which-key` is a **Neovim** plugin that displays a popup with possible key bindings for the command that you have started typing.

So if you aren’t quite sure about a given mapping, you can start by typing the `<leader>` key and then see the popup with suggestions for new keys you can type.

![which key example](./assets/which-key-ex.png)

## [bufferline](https://github.com/akinsho/bufferline.nvim)

A snazzy buffer line (with tabpage integration) for `Neovim``

## Telescope

`Telescope` is a **fuzzy-finder** to quickly navigate over lists. This mean, that almost anything that can be stored on a list can be found with telescope, not only your project files!

- `Live grep` - For having the ability of finding content in files directly, we'll need `ripgrep`. This allows us to find and filter text on the pickable files by `telescope`  

### Telescope keymaps picker

For a more detailed view of the available keymaps and remaps, you can use the `:Telescope keymaps` picker. This acts as similarly as `which-key`

![Telescope keymaps finder example](./assets/telescope-keymaps.png)

## [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)

**Neo-tree** is a Neovim plugin to browse the file system and other tree like structures in whatever style suits you, including sidebars, floating windows, `netrw` split style, or all of them at once!

### Best **Neo-tree** keymaps and/or actions

- Create a *new file* or *directory* just by typing the key `a` when `Neo-tree` is active. If the input name ends with a `/`, it will create a directory instead.

- A `.` sets the current highlighted entry as the root directory. `<bs>` will navigate one above the *cwd*. `<CR>` will enter on selection.

![Create file or directory](./assets/nt-create-file-dir.png)

## Other niceties

### [dressing](https://github.com/stevearc/dressing.nvim)

Better `Neovim` UI

### [mini-indentscope](https://github.com/echasnovski/mini.indentscope)

Shows in the editor's UI the current level of indentation where the cursor is with a nice vertical guide

### [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)

Shows indentation guides

### [Mini Animate](https://github.com/echasnovski/mini.animate)

Plugin for animate common `Neovim` actions

## Skipping disturbing notification

UI notifications can be a bit annoying at times, specially when they hide source code. You can type `<leader>un` to delete all notifications
