(local {: plugin} (require :plugins.def))

{:plugins
 [; Treesitter -- usually better syntax highlighting. Required first because all
  ; subsequent plugins depend on it.
  (plugin :nvim-treesitter/nvim-treesitter
          :run (fn []
                 (. (require :nvim-treesitter.install) :update) {:with_sync true}))

  ; Put function signature the cursor is in at the top of the window if it goes
  ; outside the view of the window.
  (plugin :romgrk/nvim-treesitter-context
          :requires [:nvim-treesitter/nvim-treesitter]
          :config #(Plugin.config :treesitter-context
                                  {:enable true
                                   :throttle true
                                   :max_lines 0
                                   :patterns {:default [:class :function :method]}}))

  ; Rainbow brackets, everyone's favorite plugin.
  (plugin :p00f/nvim-ts-rainbow
          :requires [:nvim-treesitter/nvim-treesitter])

  ; Color scheme debugging.
  (plugin :nvim-treesitter/playground
          :requires [:nvim-treesitter/nvim-treesitter]
          :disable true)]

 ; Post-use:
 :setup
 #(Plugin.config
    :nvim-treesitter.configs
    {:ensure_installed [:c
                        :fennel
                        :lua
                        :rust
                        :zig]
     :auto_install false
     :ignore_install [:go]
     :rainbow {:enable true
               :extended_mode true}})}
