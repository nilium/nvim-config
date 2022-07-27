local plugins = {
  -- Treesitter -- better syntax highlighting, where grammars are available.
  {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  },

  -- Put function context at top of screen if it goes outside the window at the
  -- top. No effect on bottom.
  {
    "romgrk/nvim-treesitter-context",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },

  -- Rainbow brackets, everyone's favorite plugin, using Treesitter.
  {
    "p00f/nvim-ts-rainbow",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Plugin to highlight only the current function using Treesitter.
  {
    "koenverburg/peepsight.nvim",
    config = function()
      require('peepsight').setup {}
    end
  },

  -- Color scheme debugging. Disabled by default.
  {
    -- Treesitter playground -- enable for grabbing treesitter highlight groups
    -- with :TSHighlightCapturesUnderCursor.
    "nvim-treesitter/playground",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
    disable = true,
  },
}

local M = {
  plugins = plugins,
}

function M.setup(...)
  return require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "c",
      "lua",
      "rust",
      "zig",
    },
    auto_install = false,
    ignore_install = {
      "go", -- Prefer vim-go
    },

    rainbow = {
      enable = true,
      extended_mode = true,
    },
  }
end

return M
