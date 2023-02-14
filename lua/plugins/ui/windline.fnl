(local {: plugin} (require :plugins.def))

(plugin :windwp/windline.nvim
        :requires [:lewis6991/gitsigns.nvim]
        :config
        (fn windline/config []
          (local windline (require :windline))
          (local helper (require :windline.helpers))
          (local cmp/basic (require :windline.components.basic))
          (local cmp/git (require :windline.components.git))
          (local breakpoint-width 90)

          (local state _G.WindLine.state)

          (local hl-list {:Black [:white :black]
                          :White [:black :white]
                          :Inactive [:InactiveFg :InactiveBg]
                          :Active [:ActiveFg :ActiveBg]})

          (local mode-colors {:Normal [:red :black]
                              :Insert [:green :black]
                              :Visual [:yellow :black]
                              :Replace [:blue_light :black]
                              :Command [:magenta :black]})

          (local basic
            {:divider [cmp/basic.divider ""]
             :bg [" " :StatusLine]

             :vi_mode
             {:name :vi_mode
              :hl_colors mode-colors
              :text #(values [[" ● " (. state.mode 2)]])}

             :square_mode
             {:hl_colors mode-colors
              :text #(values [["▊" (. state.mode 2)]])}

             :file
             {:name :file
              :hl_colors {:default hl-list.Black
                          :white [:white :black]
                          :magenta [:magenta :black]}
              :text (fn [_ _ width]
                      (local name [(cmp/basic.cache_file_name "[No Name]" :unique) :magenta])
                      (local empty [" " ""])
                      (local modified [(cmp/basic.file_modified "☀") :magenta])
                      (if (> width breakpoint-width)
                        [name
                         [cmp/basic.line_col_lua :white]
                         [cmp/basic.progress_lua ""]
                         empty
                         modified]
                        ; Else
                        [name empty modified]))}

             :file_right
             {:hl_colors {:default hl-list.Black
                          :white [:white :black]
                          :magenta [:magenta :black]}
              :text (fn [_ _ width]
                      (when (< width breakpoint-width)
                        [[cmp/basic.line_col_lua :white]
                         [cmp/basic.progress_lua ""]]))}

             :git
             {:name :git
              :hl_colors {:green [:green :black]
                          :red [:red :black]
                          :blue [:blue :black]}
              :width breakpoint-width
              :text (fn [bufnr]
                      (if (cmp/git.is_git bufnr)
                        (let [fmt {:format "+%s" :show_zero true}]
                          [[(cmp/git.diff_added fmt) :green]
                           [(cmp/git.diff_removed fmt) :red]
                           [(cmp/git.diff_changed fmt) :yellow]])
                        ""))}})

          (local default
            {:filetypes [:default]

             :active
             [basic.square_mode
              basic.vi_mode
              basic.file
              basic.divider
              basic.file_right
              basic.git
              [(cmp/git.git_branch) [:magenta :black] breakpoint-width]
              [" " hl-list.Black]
              basic.square_mode]

             :inactive
             [[cmp/basic.full_file_name hl-list.Inactive]
              basic.file_name_inactive
              basic.divider
              basic.divider
              [cmp/basic.line_col hl-list.Inactive]
              [cmp/basic.progress hl-list.Inactive]]})

          (windline.setup
            {:colors_name #(values $1)
             :statuslines [default]})))

