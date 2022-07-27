return {
  {
    "nilium/nil.nvim",
    config = function()
      require("nil").init {}
    end,
  },

  {
    "nilium/Smart-Tabs",
    setup = function()
      vim.g.ctab_disable_checkalign = 1
    end,
  },
}
