require 'nvim-treesitter.configs' .setup {
  ensure_installed = {
    "c",
    "lua",
    "rust",
    "zig",
  },
  auto_install = false,
  ignore_install = {
    "go",
  },

  rainbow = {
    enable = true,
    extended_mode = true,
  },
}
