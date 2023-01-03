(local {: function?} (require :com))

(lambda opt [key value ...]
  (tset vim.opt key (if (function? value) (value (. vim.opt key)) value))
  (when (> (select :# ...) 0) (opt ...)))

(local has? vim.fn.has)

; Mouse support
(if (has? :mouse)
  (opt :mouse :a))

; Dark background
(opt :background :dark)

; System clipboard support
(opt :clipboard :unnamedplus)

; Limit excessive syntax highlighting
(opt :synmaxcol 400)

; Keyboard timeouts
(opt
  :timeout true
  :timeoutlen 200
  :ttimeout true
  :ttimeoutlen 200)

; Persistent undo
(opt
  :undofile true
  :undolevels 2000
  :undoreload 10000)

; Misc UI
(opt
  :wildmenu true
  :showcmd true
  :showmode true
  :signcolumn :yes
  :wildignore "*/node_modules/*,*.so,*.swp,*/.git/*,*.zip,*.dmg,*/*.sparsebundle/*")

; Split in the correct directions
(opt
  :splitright true
  :splitbelow true)

; Disable audio bell
(opt
  :visualbell true)

; Misc formatting
(opt
  :autoindent true
  :smarttab true
  :expandtab false
  :shiftwidth 8
  :tabstop 8
  :softtabstop 8
  :textwidth 120
  :joinspaces false
  :wrap false
  :formatoptions "crqn1j")

; Search
(opt
  :incsearch true
  :hlsearch false)

; Movement
(opt :whichwrap "b,s")

; List formatting
(opt
  :list false
  :listchars "tab:│·,trail:·,extends:→,precedes:←,nbsp:·")

; Line numbers
(opt
  :ruler true
  :number true
  :relativenumber true)

; Omnicompletion
; (opt :completeopt #(- $1 [:preview]))
