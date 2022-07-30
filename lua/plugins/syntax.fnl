(local {: plugin} (require :plugins.def))

[; jq syntax.
 (plugin :vito-c/jq.vim)

 ; Fennel syntax.
 (plugin :jaawerth/fennel.vim)

 ; Vim syntax, commands, LSP.
 (plugin :fatih/vim-go
         :setup
         (fn []
           (doto vim.env
                 (tset :GO111MODULE :on)
                 (tset :GOFLAGS "-tags=integration_test"))
           (local config
             {:go_highlight_function_calls 1
              :go_highlight_fields 1
              :go_highlight_array_whitespace_error 1
              :go_highlight_chan_whitespace_error 1
              :go_highlight_extra_types 1
              :go_highlight_space_tab_error 1
              :go_highlight_trailing_whitespace_error 1
              :go_highlight_operators 1
              :go_highlight_functions 1
              :go_highlight_methods 1
              :go_highlight_structs 1
              :go_highlight_types 1
              :go_jump_to_error 0
              :go_info_mode :gopls
              :go_def_mode :gopls
              :go_referrers_mode :gopls
              :go_implements_mode :gopls
              :go_doc_popup_window 1
              :go_fmt_command :gopls
              :go_imports_autosave 1
              :go_imports_mode :gopls})
           (collect [k v (pairs config) :into vim.g] k v)))

 ; Highlight TODO, WARN, etc. comments.
 ; Doesn't handle TODO(ncower) and so on, and updating the pattern it uses to
 ; include those renders poorly, so may do this differently later.)
 (plugin :folke/todo-comments.nvim
         :event :BufRead
         :config #(Plugin.config :todo-comments))

 ; Indent guides that work better.
 (plugin :lukas-reineke/indent-blankline.nvim
         :event :BufRead
         :setup (fn []
                  (local config
                    {:indentLine_enabled 1
                     :indent_blankline_char "▏"
                     :indent_blankline_filetype_exclude [:help :terminal :dashboard]
                     :indent_blankline_buftype_exclude [:terminal]
                     :indent_blankline_show_trailing_blankline_indent false
                     :indent_blankline_show_first_indent_level false})
                  (collect [k v (pairs config) :into vim.g] k v))
         :config #(Plugin.config :indent_blankline
                                 {:show_current_context true
                                  :show_current_context_start true}))]




