(local {: plugin} (require :plugins.def))

[; Highlight the word under the cursor.
 (plugin :itchyny/vim-cursorword
         :event [:BufEnter :BufNewFile]
         :config
         (fn []
           (local {:nvim_create_augroup augroup
                   :nvim_create_autocmd autocmd}
                  vim.api)
           (let [group (augroup :user_plugin_cursorword {:clear true})
                 put #(set vim.b.cursorword $1)]
             (autocmd
               [:FileType]
               {: group
                :pattern [:NvimTree :lspsagafinder :dashboard :vista]
                :callback #(put 0)})
             (autocmd
               [:WinEnter :InsertEnter :InsertLeave]
               {: group
                :pattern [:*]
                :callback #(match $1
                             {:event :InsertEnter} (put 0)
                             {:event :InsertLeave} (put 1)
                             (where {:event :WinEnter} (#(or $1.diff $1.previewwindow) vim.o)) (put 0))}))))

 ; Comment stuff, similar to vim-commentary.
 (plugin :numToStr/Comment.nvim
         :config #(Plugin.config :Comment))

 ; Register peeking via double-quote.
 (plugin :junegunn/vim-peekaboo)

 ; Tabularize
 (plugin :godlygeek/tabular)

 ; Undo graph visualization -- replaces Gundo.
 (plugin :mbbill/undotree)

 ; YankRing replacement.
 (plugin :gbprod/yanky.nvim
         :config #(Plugin.config :yanky))

 ; fzf
 (plugin :junegunn/fzf)

 (plugin :junegunn/fzf.vim
         :setup (fn [] (set vim.g.fzf_command_prefix :Fzf)
                       (set vim.env.FZF_DEFAULT_COMMAND "fd -tf")))

 ; Parinfer, for editing Lisp without going mad. Or maybe slight madness.
 (plugin :eraserhd/parinfer-rust
         :run "cargo build --release")]
