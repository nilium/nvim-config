require "packer".startup(function()
  -- Packer
  use "wbthomason/packer.nvim"

  -- My personal plugins.
  use {
    "nilium/nil.nvim",
    config = function()
      require 'nil' .init {}
    end,
  }

  -- My fork of Smart-Tabs to fix some quirks around indentation handling.
  use {
    "nilium/Smart-Tabs",
    config = function()
      vim.g.ctab_disable_checkalign = 1
    end,
  }

  -- :Bdelete
  use "moll/vim-bbye"

  -- The Tim Pope collection
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"
  use "tpope/vim-repeat"

  -- Pairs of brackets / parens
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end,
  }

  -- Comment stuff, similar to vim-commentary
  use {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup {} end,
  }

  -- Buffer line
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require "bufferline" .setup {
        options = {
          show_close_icon = false,
          show_buffer_close_icons = false,
          separator_style = 'thin',
          always_show_bufferline = true,
          name_formatter = function(buf)
            return buf.bufnr .. ": " .. buf.name
          end,
          number = function(num)
            -- { ordinal, id, lower, raise }
            return num.ordinal .. "/" .. num.id
          end,
        },
      }
    end,
  }

  -- Register peeking via "
  use "junegunn/vim-peekaboo"

  -- :Tabularize.
  use "godlygeek/tabular"

  -- jq syntax.
  use { "vito-c/jq.vim" }

  -- Undo graph visualization, replaces Gundo.
  use { "mbbill/undotree" }

  -- Rainbow brackets, everyone's favorite plugin.
  use { "p00f/nvim-ts-rainbow" }

  -- Highlight word under cursor.
  use {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
      vim.api.nvim_command("augroup END")
    end
  }

  -- Highlight TODO, WARN, etc. comments.
  -- Doesn't handle TODO(ncower) and so on, and updating the pattern it uses to
  -- include those renders poorly, so may do this differently later.
  use {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup {}
    end,
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }

  -- Put function context at top of screen if it goes outside the window at the
  -- top. No effect on bottom.
  use {
    "romgrk/nvim-treesitter-context",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  }

  -- Signature float:
  use {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  }

  -- Indent guides:
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  }

  -- rust-analyzer additions:
  -- { -- For inlay hints:
  --   "simrat39/rust-tools.nvim",
  --   -- branch = "modularize_and_inlay_rewrite",
  --   config = function()
  --     require('rust-tools').setup {}
  --   end
  -- },

  -- coc-nvim
  use {
    "neoclide/coc.nvim",
    branch = 'release',
    cmd = { 'CocInstall', 'CocConfig', 'CocUninstall', 'CocRestart', 'CocCommand' },
    ft = { 'rs', 'rust' },
  }

  -- YankRing replacement:
  use {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup {}
    end,
  }

  -- fzf
  use {
    "junegunn/fzf"
  }
  use {
    "junegunn/fzf.vim",
    require = { "junegunn/fzf" },
    setup = function()
      vim.g.fzf_command_prefix = 'Fzf'
      vim.env.FZF_DEFAULT_COMMAND = 'fd -tf'
    end,
  }

  -- Color scheme
  use {
    "rebelot/kanagawa.nvim",
    config = function()
      -- Tweak colors to resemble triplejelly, since I don't feel like updating
      -- the hightlight groups for it to match all of Treesitter.
      local colors = {
        bg = '#040404',
        fg = '#C6CFD2',
        fg_comment = '#74737E',
        kw = '#DBCD5D',
        st = '#BBE16C',
        fn = '#00D2E5',
        id = '#47AEE8',
        ns = '#FB97D2',
        nu = '#99CC66',
        ty = '#FB97D2',
        tb = '#EC7967',
        inc = '#E160B4',
        macro = '#BB95EF',
        cursorline = '#202026',
        cursorlinenr = '#4a4a5a',
        context = '#294d49',
      }
      colors.sp2 = colors.tb
      colors.pp = colors.macro
      colors.br = colors.fg

      local overrides = {
        CursorLine = { bg = colors.cursorline },
        LineNr = { fg = colors.cursorline },
        CursorLineNr = { fg = colors.cursorlinenr },
        MatchParen = { fg = colors.kw, bg = '', underline = true },
        Include = { fg = colors.inc },
        Macro = { fg = colors.macro },
        Namespace = { fg = colors.ns },
        Variable = { fg = colors.id },
        TSConstMacro = { link = 'Macro' },
        TSField = { fg = colors.fg },
        TSFuncMacro = { link = 'Macro' },
        TSInclude = { link = 'Include' },
        TSNamespace = { link = 'Namespace' },
        TSTypeBuiltin = { fg = colors.tb },
        TSVariable = { link = 'Variable' },
        TSConstructor = { fg = colors.fg },
        TreesitterContext = { bg = colors.context },
        TreesitterContextLineNumber = { fg = colors.context },
      }

      require('kanagawa').setup({
        undercurl = true, -- enable undercurls
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = false },
        statementStyle = { bold = false },
        typeStyle = {},
        variablebuiltinStyle = { italic = false },
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        globalStatus = false, -- adjust window separators highlight for laststatus=3
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = colors,
        overrides = overrides,
      })

      -- If I don't add this here, LunarVim fails to correctly set the
      -- colorscheme. No idea why. Not interested in debugging it -- the way it
      -- handles color schemes is super broken already.
      vim.cmd({ cmd = "colorscheme", args = { "kanagawa" } })
    end,
  }

  -- Color scheme debugging
  use {
    -- Treesitter playground -- enable for grabbing treesitter highlight groups
    -- with :TSHighlightCapturesUnderCursor.
    "nvim-treesitter/playground",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
    disable = false
  }

  -- neo-tree -- File tree thing.
  -- use {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v2.x",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "kyazdani42/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   setup = function()
  --     vim.g.neo_tree_remove_legacy_commands = 1
  --   end,
  --   config = function()
  --     require('neo-tree').setup {
  --       close_if_last_window = true,
  --       sort_case_insensitive = true,
  --       filesystem = {
  --         follow_current_file = true,
  --       },
  --     }
  --   end,
  -- }

  -- Fennel
  use {
    "rktjmp/hotpot.nvim",
    config = function()
      require("hotpot").setup {
        provide_require_fennel = true,
        enable_hotpot_diagnostics = true,
        compiler = {
          modules = {
            correlate = true,
          },
          macros = {
            env = "_COMPILER",
          },
        },
      }
    end,
  }

  -- Fennel highlighting
  use {
    "jaawerth/fennel.vim"
  }

  -- Parinfer
  use {
    "eraserhd/parinfer-rust",
    fg = { 'scheme', 'chicken', 'clojure', 'lisp' },
    run = 'cargo build --release',
  }

  use {
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
  }

  use {
    "koenverburg/peepsight.nvim",
    config = function()
      require('peepsight').setup {}
    end
  }

  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup {}
    end,
  }

  use {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require('trouble').setup {}
    end,
  }
end)

require "hotpot"
