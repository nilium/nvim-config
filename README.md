nvim-config
===

This is a sort of experimental Neovim config as an alternative to either
LunarVim (currently stuck in a gist) and my regular Vim 8.x dotfiles. If it
proves to be stable enough, it'll eventually move to my dotfiles. Until then,
I'm unsure if I'll maintain it.

The only required part of this should be [packer.nvim][], although some parts
also assume, for example, node.js is installed (coc-nvim), compilers are
installed (fzf), additional tools (e.g, `fd` for fzf), and so on. These are
mostly guaranteed by my package setups on machines, but are mentioned briefly
ere if I forget. Packer will try to bootstrap itself. The Fennel compiler is
included under lua/fennel.lua as well to ensure Fennel sources can be required
without precompilation (though that may later be necessary for speed, it hasn't
come up).

[packer.nvim]: https://github.com/wbthomason/packer.nvim
