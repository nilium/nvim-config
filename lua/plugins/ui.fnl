(local {: plugin} (require :plugins.def))

[; Buffer line.
 (plugin :romgrk/barbar.nvim
         :tag "v1.4.0"
         :config #(Plugin.config :bufferline
                                 {:icons false
                                  :tabpages false
                                  :closable false}))

 ; Icons, some things seem to require this.
 (plugin :kyazdani42/nvim-web-devicons
         :config #(Plugin.config :nvim-web-devicons))

 ; Git status info for windline.
 (plugin :lewis6991/gitsigns.nvim)

 ; Windline config.
 (require :plugins.ui.windline)]
