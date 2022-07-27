local cursorword = {
  "itchyny/vim-cursorword",
  event = { "BufEnter", "BufNewFile" },
}

function cursorword.config()
  local group = vim.api.nvim_create_augroup("user_plugin_cursorword", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "NvimTree", "lspsagafinder", "dashboard", "vista" },
    callback = function(info) vim.b.cursorword = 0 end,
  })
  vim.api.nvim_create_autocmd({ "WinEnter", "InsertEnter", "InsertLeave" }, {
    group = group,
    pattern = "*",
    callback = function(info)
      if info.event == "InsertEnter" or (info.event == "WinEnter" and (vim.o.diff or vim.o.previewwindow)) then
        vim.b.cursorword = 0
      elseif info.event == "InsertLeave" then
        vim.b.cursorword = 1
      end
    end,
  })
end

return {
  -- Pairs of brackets / parens
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end,
  },

  -- Comment stuff, similar to vim-commentary
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup {} end,
  },

  -- Register peeking via "
  { "junegunn/vim-peekaboo" },

  -- :Tabularize.
  { "godlygeek/tabular" },

  -- Undo graph visualization, replaces Gundo.
  { "mbbill/undotree" },

  -- Highlight word under cursor.
  cursorword,

  -- YankRing replacement.
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup {}
    end,
  },

  -- Fuzzy finder
  { "junegunn/fzf" },
  {
    "junegunn/fzf.vim",
    require = { "junegunn/fzf" },
    setup = function()
      vim.g.fzf_command_prefix = 'Fzf'
      vim.env.FZF_DEFAULT_COMMAND = 'fd -tf'
    end,
  },

  -- Parinfer, for editing Lisp without going mad.
  {
    "eraserhd/parinfer-rust",
    fg = { 'scheme', 'chicken', 'clojure', 'lisp' },
    run = 'cargo build --release',
  },
}
