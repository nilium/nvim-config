vim.opt.modeline = false

-- Mouse
if vim.fn.has('mouse') then
  vim.opt.mouse = 'a'
end

-- Dark background.
vim.opt.background = 'dark'

-- Clipboard.
vim.opt.clipboard = 'unnamedplus'

-- Limit syntax highlighting when excessive.
vim.opt.synmaxcol = 400 -- Bail on too much work for syntax highlighting.

-- Keyboard timeouts.
vim.opt.timeout = true
vim.opt.timeoutlen = 200
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200

-- Misc stuff from vimrc
vim.opt.undofile = true
vim.opt.undolevels = 2000
vim.opt.undoreload = 10000

vim.opt.joinspaces = false
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.formatoptions = 'crqn1j'

vim.opt.wildignore = '*/node_modules/*,*.so,*.swp,*/.git/*,*.zip,*.dmg,*/*.sparsebundle/*'

-- Split down and to the right.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keep context around the cursor (3 lines, 5 columns)
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

-- Disable audio bell
vim.opt.visualbell = true

vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.expandtab = false
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.softtabstop = 8
vim.opt.textwidth = 120

vim.opt.incsearch = true
vim.opt.hlsearch = false

-- For some reason LunarVim makes Vim's default visual mode behavior of
-- selecting the end of a line not work, and I haven't figure out why. For now,
-- turn on virtualedit / selection to emulate it.
-- vim.opt.virtualedit = 'block,onemore'
-- vim.opt.selection = 'inclusive'
vim.opt.whichwrap = 'b,s'

vim.opt.listchars = 'tab:│·,trail:·,extends:→,precedes:←,nbsp:·'
vim.opt.list = false

vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.completeopt = vim.opt.completeopt - { "preview" }
