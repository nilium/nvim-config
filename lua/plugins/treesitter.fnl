(local {: plugin} (require :plugins.def))

{:plugins
 [; Treesitter -- usually better syntax highlighting. Required first because all
  ; subsequent plugins depend on it.
  (plugin :nvim-treesitter/nvim-treesitter
          :run (fn []
                 (. (require :nvim-treesitter.install) :update) {:with_sync true}))

  ; Color scheme debugging.
  (plugin :nvim-treesitter/playground
          :requires [:nvim-treesitter/nvim-treesitter]
          :disable true)]

 ; Post-use:
 :setup
 (fn []
  ((require :nvim-treesitter.configs)
   {:ensure_installed [:c
                        :fennel
                        :hcl
                        :lua
                        :rust
                        :zig]
     :auto_install false
     :ignore_install [:go]
     :highlight {:enable true}}))}
