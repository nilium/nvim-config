(local {: nmap : nnoremap
        : imap : inoremap
        : xmap : xnoremap
        : vmap : vnoremap}
  (require :core.map))

(fn setup []
  ; Use [g and ]g to navigate diagnostics.
  (nnoremap "[g" "<Plug>(coc-diagnostic-prev)")
  (nnoremap "]g" "<Plug>(coc-diagnostic-next)")

  ; Go-to navigation.
  (nnoremap :gd "<Plug>(coc-definition)")
  (nnoremap :gt "<Plug>(coc-type-definition)")
  (nnoremap :gi "<Plug>(coc-implementation)")
  (nnoremap :gr "<Plug>(coc-references)")

  ; Show documentation via Shift-K.
  (fn show-docs []
    (if (vim.fn.CocAction :hasProvider :hover)
      (vim.fn.CocActionAsync :doHover)
      (vim.fn.feedkeys :K :in)))

  (nnoremap :K show-docs)

  ; C-space for completion:
  (inoremap :<C-space> vim.fn.coc#refresh)

  ; Highlight symbol and references under cursor.
  (vim.api.nvim_create_autocmd
    :CursorHold
    {:pattern [:*]
     :callback #(vim.fn.CocActionAsync :highlight)})

  ; Rename action:
  (nnoremap :<Leader>rn "<Plug>(coc-rename)")
  ; Format selection:
  (nnoremap :<Leader>f "<Plug>(coc-format-selected)")
  (xnoremap :<Leader>f "<Plug>(coc-format-selected)")

  ; Apply code action to selection:
  (nnoremap :<Leader>a "<Plug>(coc-codeaction-selected)")
  (xnoremap :<Leader>a "<Plug>(coc-codeaction-selected)")

  ; Select a command:
  (nnoremap :<Leader>c "<Cmd>CocCommand<CR>")

  ; Remap keys for code actions:
  (nnoremap :<Leader>ac "<Plug>(coc-codeaction)")
  ; Apply quick fix:
  (nnoremap :<Leader>qf "<Plug>(coc-fix-current)")
  ; Run code lens action:
  (nnoremap :<Leader>cl "<Plug>(coc-codelens-action)")

  ; Scrolling for popups
  (let [opts {:silent true :nowait true :expr true}]
    (nnoremap :<C-f> "coc#float#has_scroll() ? coc#float#scroll(1) : \"\\<C-f>\"" opts)
    (nnoremap :<C-b> "coc#float#has_scroll() ? coc#float#scroll(0) : \"\\<C-b>\"" opts)
    (inoremap :<C-f> "coc#float#has_scroll() ? \"\\<c-r>=coc#float#scroll(1)\\<cr>\" : \"\\<Right>\"" opts)
    (inoremap :<C-b> "coc#float#has_scroll() ? \"\\<c-r>=coc#float#scroll(0)\\<cr>\" : \"\\<Left>\"" opts)
    (vnoremap :<C-f> "coc#float#has_scroll() ? coc#float#scroll(1) : \"\\<C-f>\"" opts)
    (vnoremap :<C-b> "coc#float#has_scroll() ? coc#float#scroll(0) : \"\\<C-b>\"" opts)))

{: setup}
