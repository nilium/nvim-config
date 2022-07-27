return {
  -- Buffer line
  {
    "romgrk/barbar.nvim",
    config = function()
      require("bufferline").setup {
        icons = false,
        tabpages = false,
        closable = false,
      }
    end,
  },

  -- Icons, some things seem to require this.
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {}
    end,
  },

  -- Git status info for windline.
  { "lewis6991/gitsigns.nvim" },

  -- Windline config.
  require("plugins/ui/windline"),
}
