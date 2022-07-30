(local {: function?} (require :com))

(lambda leader [key]
  (set vim.g.mapleader key)
  (set vim.g.maplocalleader key))

(lambda map [mode key expr ?options]
  (local (callback expr)
    (if (function? expr)
      (values {:callback expr} "")
      (values {} expr)))
  (local options (vim.tbl_extend :force {} (or ?options {}) callback))
  (vim.api.nvim_set_keymap mode key expr options))

(lambda mapfn [mode]
  (partial map mode))

(lambda noremapfn [mode]
  (lambda [key expr ?options]
    (local options (vim.tbl_extend :force {:noremap true :silent true} (or ?options {})))
    (map mode key expr options)))

(local imap     (mapfn :i))
(local inoremap (noremapfn :i))
(local nmap     (mapfn :n))
(local nnoremap (noremapfn :n))
(local omap     (mapfn :o))
(local onoremap (noremapfn :o))
(local vmap     (mapfn :v))
(local vnoremap (noremapfn :v))
(local xmap     (mapfn :x))
(local xnoremap (noremapfn :x))

{: leader
 : map
 : mapfn
 : noremapfn
 : imap
 : inoremap
 : nmap
 : nnoremap
 : omap
 : onoremap
 : vmap
 : vnoremap
 : xmap
 : xnoremap}
