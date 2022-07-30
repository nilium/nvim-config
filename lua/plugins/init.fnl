; Ensure plugins.def is loaded ahead of time because it has side effects.
(require :plugins.def)
(local $ (require :com))

(var packer-bootstrap false)
(let [install-path (.. (vim.fn.stdpath :data) "/site/pack/packer/start/packer.nvim")]
  (when (> (vim.fn.empty (vim.fn.glob install-path)) 0)
    (set packer-bootstrap
         (vim.fn.system ["git" "clone" "--depth" "1" "https://github.com/wbthomason/packer.nvim" install-path]))
    (vim.cmd { :cmd :packadd :args [ :packer.nvim]})))

(local plugins
  [:nil
   :colorscheme
   :tpope
   :treesitter
   :syntax
   :editor
   :lsp
   :ui])

(local packer (require :packer))
(local setup-after [])
(packer.startup
  (fn []
    (use :wbthomason/packer.nvim)

    (each [_ name (ipairs plugins)]
      (local spec (require (.. :plugins. name)))
      (let [(use-list post-setup)
            (match spec
              (where {:plugins use-list :setup ?setup-fn} ($.table? use-list))
              (values use-list (when ($.function? setup-fn) #(spec:setup)))
              _ (values spec nil))]
        (if ($.string? (. use-list 1))
          (use use-list)
          (each [_ use-def (ipairs use-list)]
            (use use-def)))
        (when ($.function? post-setup)
          (table.insert setup-after post-setup))))))

(each [_ setup-fn (ipairs setup-after)] (setup-fn))
