-- lvim.leader does not immediately set <Leader> (a little surprised it's not
-- a metatable or something), so set it here as well.

-- NOTE: lvim.keys.* does not use metatables, assignments do not immediately
-- take effect, so what <Leader> means to this is whatever the *last* value of
-- lvim.leader is. To use <Leader> immediately, set vim.o.leader and use
-- nvim_set_keymap.

local function leader(str)
  vim.g.mapleader = str
  vim.g.maplocalleader = str
end

local function map(mode, key, expr, options)
  local cb = {}
  if type(expr) == 'function' then
    cb.callback = expr
    expr = ''
  end
  options = vim.tbl_extend('force', {}, options or {}, cb)
  return vim.api.nvim_set_keymap(mode, key, expr, options)
end

local function mapfn(mode)
  return function(key, expr, options)
    return map(mode, key, expr, options)
  end
end

local function noremapfn(mode)
  return function(key, expr, options)
    options = vim.tbl_extend('force', { noremap = true, silent = true }, options or {})
    return map('n', key, expr, options)
  end
end

local imap     = mapfn 'i'
local inoremap = noremapfn 'i'
local nmap     = mapfn 'n'
local nnoremap = noremapfn 'n'
local omap     = mapfn 'o'
local onoremap = noremapfn 'o'
local vmap     = mapfn 'v'
local vnoremap = noremapfn 'v'
local xmap     = mapfn 'x'
local xnoremap = noremapfn 'x'

leader ','

-- Old formatting keys
nnoremap('<Leader>=i', 'mzvip=`z') -- Format paragraph with =.
nnoremap('<Leader>=g', 'mzgg=G`z') -- Format buffer with =.
nnoremap('<Leader>wi', 'mzgqip`z') -- Foramt paragraph with gq.
nnoremap('<Leader>wg', 'mzgggqG`z') -- Format document with gq.

-- Reset hlsearch
nnoremap('<Leader><Leader>', ":nohlsearch<CR>:echo ''<CR>")

-- Toggles
nnoremap('<Leader>sl', '<Cmd>set list!<CR>')
nnoremap('<Leader>sw', '<Cmd>set wrap!<CR>')
nnoremap('<Leader>sr', '<Cmd>set relativenumber!<CR>')

-- Buffers
nnoremap('<Leader>bn', '<Cmd>bnext<CR>')
nnoremap('<Leader>bp', '<Cmd>bprev<CR>')
nnoremap('<Leader>q', '<Cmd>Bdelete<CR>')
-- Switch to buffer given by count.
-- vim.cmd("nnoremap <silent> <expr> ,b (v:count > 0 ? ':b'.v:count : ':ls').'<CR>'")

-- Emacs keys
nnoremap('<C-a>', '^')
nnoremap('<C-e>', '$')
vnoremap('<C-a>', '^')
vnoremap('<C-e>', '$')
inoremap('<C-a>', '<C-o>^')
inoremap('<C-e>', '<C-o>$')

-- Operator waiting mode, oddly missing in lvim.keys.
onoremap('<C-a>', '^')
onoremap('<C-e>', '$')

-- Fzf
nnoremap('<Leader>t', '<Cmd>FzfFiles<CR>')
nnoremap('<Leader>b', '<Cmd>FzfBuffers<CR>')
nnoremap('<Leader>r', '<Cmd>FzfRg<CR>')
nnoremap('<Leader>c', '<Cmd>FzfCommands<CR>')

-- Disable A-up/down for moving lines up/down, A-left/right, A-[jk], and jk.
-- for i, dir in ipairs({ "<A-Up>", "<A-Down>", "<A-Left>", "<A-Right>", "<A-j>", "<A-k>", "jk", "jj", "kj", "$", "^" }) do
-- lvim.keys.insert_mode[dir] = false
-- lvim.keys.normal_mode[dir] = false
-- lvim.keys.visual_mode[dir] = false
-- end

-- Disable LunarVim's sticky visual shift. They call it better, I disagree.
-- lvim.keys.visual_mode['>'] = false
-- lvim.keys.visual_mode['<'] = false

-- undotree -- feels like there should be a way to set this in a config function
-- but it didn't work and I'm not trying that hard.
nnoremap('<Leader>u', '<Cmd>UndotreeToggle<CR>')

-- A handful of special bindings for jumping up/down visually in wrapped text.
-- Pretty much makes j/k move up and down visually. This might work better if it
-- checked if wrap was set, but is it necessary? Nah.
-- local function jumpy(dir)
--   return function()
--     if vim.v.count > 3 then
--       vim.cmd("norm! m'" .. vim.v.count .. dir)
--     else
--       vim.cmd("norm! " .. vim.v.count .. 'g' .. dir)
--     end
--   end
-- end

vim.cmd [[vnoremap <silent> <expr> j (v:count > 3 ? "m'" .. v:count . 'j' : 'gj')]]
vim.cmd [[vnoremap <silent> <expr> k (v:count > 3 ? "m'" .. v:count . 'k' : 'gk')]]
vim.cmd [[nnoremap <silent> <expr> j (v:count > 3 ? "m'" .. v:count . 'j' : 'gj')]]
vim.cmd [[nnoremap <silent> <expr> k (v:count > 3 ? "m'" .. v:count . 'k' : 'gk')]]

vim.cmd [[inoremap <silent> <C-h> <C-o>h]]
vim.cmd [[inoremap <silent> <C-j> <C-o>j]]
vim.cmd [[inoremap <silent> <C-k> <C-o>k]]
vim.cmd [[inoremap <silent> <C-l> <C-o>l]]

-- vnoremap('j', jumpy('j'))
-- vnoremap('k', jumpy('k'))
-- nnoremap('j', jumpy('j'))
-- nnoremap('k', jumpy('k'))

-- inoremap('C-j', jumpy('j'))
-- inoremap('C-k', jumpy('k'))
-- inoremap('C-h', function() vim.cmd({ cmd = 'norm!', args = { vim.v.count .. 'h' } }) end)
-- inoremap('C-l', function() vim.cmd({ cmd = 'norm!', args = { vim.v.count .. 'l' } }) end)

-- Yanky
nmap("p", "<Plug>(YankyPutAfter)")
nmap("P", "<Plug>(YankyPutBefore)")
xmap("p", "<Plug>(YankyPutAfter)")
xmap("P", "<Plug>(YankyPutBefore)")
nmap("gp", "<Plug>(YankyGPutAfter)")
nmap("gP", "<Plug>(YankyGPutBefore)")
xmap("gp", "<Plug>(YankyGPutAfter)")
xmap("gP", "<Plug>(YankyGPutBefore)")
nmap("<c-p>", "<Plug>(YankyCycleForward)")
nmap("<c-n>", "<Plug>(YankyCycleBackward)")

-- Stamp
nnoremap('S', '<Cmd>lua require("stamp").stamp(vim.v.register)<CR>')

-- Neotree
-- require("neo-tree")
-- nnoremap('<Leader>g', '<Cmd>Neotree toggle reveal<CR>')
-- nnoremap('<Leader>G', '<Cmd>Neotree toggle reveal float<CR>')
-- nnoremap('<Leader>H', '<Cmd>Neotree toggle reveal float source=git_status<CR>')

-- Peepsight
nnoremap('<Leader>f', '<Cmd>Peepsight<CR>')
