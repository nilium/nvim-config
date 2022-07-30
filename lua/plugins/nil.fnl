(local {: plugin} (require :plugins.def))

[(plugin :nilium/nil.nvim
         :config #(Plugin.config :nil))
 (plugin :nilium/Smart-Tabs
         :setup (fn [] (set vim.g.ctab_disable_checkalign 1)))]
