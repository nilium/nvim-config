return {
  -- Use coc-nvim in place of Neovim's LSP stuff because it just works better.
  {
    "neoclide/coc.nvim",
    branch = 'release',
    cmd = { 'CocInstall', 'CocConfig', 'CocUninstall', 'CocRestart', 'CocCommand' },
    ft = { 'rs', 'rust' },
  },
}
