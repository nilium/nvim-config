(local {: plugin} (require :plugins.def))

[; Use coc-nvim in place of Neovim's LSP stuff because it works better.
 (plugin :neoclide/coc.nvim
         :branch :release
         :cmd [:CocInstall :CocConfig :CocUninstall :CocRestart :CocCommand]
         :ft [:rust])]
