(local {: leader
        : nnoremap : nmap
        : vnoremap : vmap
        : inoremap : imap
        : onoremap : omap
        : xnoremap : xmap}
  (require :core.map))

(leader ",")

; Old formatting keys
(nnoremap :<Leader>=i "mzvip=`z") ; Format paragraph with =.
(nnoremap :<Leader>=g "mzgg=G`z") ; Format buffer with =.
(nnoremap :<Leader>wi "mzgqip`z") ; Foramt paragraph with gq.
(nnoremap :<Leader>wg "mzgggqG`z") ; Format document with gq.

; Reset hlsearch
(nnoremap :<Leader><Leader> ":nohlsearch<CR>:echo ''<CR>")

; Toggles
(nnoremap :<Leader>sl "<Cmd>set list!<CR>")
(nnoremap :<Leader>sw "<Cmd>set wrap!<CR>")
(nnoremap :<Leader>sr "<Cmd>set relativenumber!<CR>")

; Buffers
(nnoremap :<Leader>bn "<Cmd>bnext<CR>")
(nnoremap :<Leader>bp "<Cmd>bprev<CR>")
(nnoremap :<Leader>q "<Cmd>BufferClose<CR>")
(nnoremap :<Leader>b "<Cmd>BufferPick<CR>")

; Emacs keys
(nnoremap :<C-a> "^")
(nnoremap :<C-e> "$")
(vnoremap :<C-a> "^")
(vnoremap :<C-e> "$")
(inoremap :<C-a> "<C-o>^")
(inoremap :<C-e> "<C-o>$")

; Operator waiting mode, oddly missing in lvim.keys.
(onoremap :<C-a> "^")
(onoremap :<C-e> "$")

; Fzf
(nnoremap :<Leader>t "<Cmd>FzfFiles<CR>")
; (nnoremap :<Leader>b "<Cmd>FzfBuffers<CR>")
(nnoremap :<Leader>r "<Cmd>FzfRg<CR>")
(nnoremap :<Leader>c "<Cmd>FzfCommands<CR>")

; undotree -- feels like there should be a way to set this in a config function
; but it didn"t work and I"m not trying that hard.
(nnoremap :<Leader>u "<Cmd>UndotreeToggle<CR>")

; A handful of special bindings for jumping up/down visually in wrapped text.
; Pretty much makes j/k move up and down visually. This might work better if it
; checked if wrap was set, but is it necessary? Nah.
(nnoremap :j "(v:count > 3 ? \"m'\" .. v:count . 'j' : 'gj')" {:expr true})
(nnoremap :k "(v:count > 3 ? \"m'\" .. v:count . 'k' : 'gk')" {:expr true})
(vnoremap :j "(v:count > 3 ? \"m'\" .. v:count . 'j' : 'gj')" {:expr true})
(vnoremap :k "(v:count > 3 ? \"m'\" .. v:count . 'k' : 'gk')" {:expr true})

; Similar, but for insert mode:
(inoremap :<C-h> :<C-o>h)
(inoremap :<C-j> :<C-o>j)
(inoremap :<C-k> :<C-o>k)
(inoremap :<C-l> :<C-o>l)

; Yanky
(nmap :p "<Plug>(YankyPutAfter)")
(nmap :P "<Plug>(YankyPutBefore)")
(xmap :p "<Plug>(YankyPutAfter)")
(xmap :P "<Plug>(YankyPutBefore)")
(nmap :gp "<Plug>(YankyGPutAfter)")
(nmap :gP "<Plug>(YankyGPutBefore)")
(xmap :gp "<Plug>(YankyGPutAfter)")
(xmap :gP "<Plug>(YankyGPutBefore)")
(nmap :<c-p> "<Plug>(YankyCycleForward)")
(nmap :<c-n> "<Plug>(YankyCycleBackward)")

; Stamp
(nnoremap :S "<Cmd>lua require(\"stamp\").stamp(vim.v.register)<CR>")

{}
