return {
  -- jq syntax.
  { "vito-c/jq.vim" },

  -- Fennel syntax.
  { "jaawerth/fennel.vim" },

  -- Go.
  {
    "fatih/vim-go",
    setup = function()
      vim.env.GO111MODULE = 'on'
      vim.env.GOFLAGS = '-tags=integration_test'
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_array_whitespace_error = 1
      vim.g.go_highlight_chan_whitespace_error = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_space_tab_error = 1
      vim.g.go_highlight_trailing_whitespace_error = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_structs = 1
      vim.g.go_highlight_types = 1
      vim.g.go_jump_to_error = 0
      vim.g.go_info_mode = 'gopls'
      vim.g.go_def_mode = 'gopls'
      vim.g.go_referrers_mode = 'gopls'
      vim.g.go_implements_mode = 'gopls'
      vim.g.go_doc_popup_window = 1
      vim.g.go_fmt_command = 'gopls'
      vim.g.go_imports_autosave = 1
      vim.g.go_imports_mode = 'gopls'
    end,
  },

  -- Highlight TODO, WARN, etc. comments.
  -- Doesn't handle TODO(ncower) and so on, and updating the pattern it uses to
  -- include those renders poorly, so may do this differently later.
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup {}
    end,
  },

  -- Indent guides that work better.
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end,
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },
}
