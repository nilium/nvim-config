(local {: plugin} (require :plugins.def))

[; Use coc-nvim in place of Neovim's LSP stuff because it works better.
 (plugin :neoclide/coc.nvim
         :branch :release
         :setup (fn []
                 (set vim.g.coc_global_extensions
                      [:coc-pairs
                       :coc-rust-analyzer])))]

