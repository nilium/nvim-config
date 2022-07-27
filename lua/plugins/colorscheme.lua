local M = { "rebelot/kanagawa.nvim" }

function M.config()
  -- Tweak colors to resemble triplejelly, since I don't feel like updating
  -- the hightlight groups for it to match all of Treesitter.
  local colors = {
    bg             = '#040404',
    bgl            = '#151519',
    fg             = '#C6CFD2',
    fg_comment     = '#74737E',
    kw             = '#DBCD5D',
    st             = '#BBE16C',
    fn             = '#00D2E5',
    id             = '#47AEE8',
    ns             = '#FB97D2',
    nu             = '#99CC66',
    ty             = '#FB97D2',
    tb             = '#EC7967',
    inc            = '#E160B4',
    macro          = '#BB95EF',
    cursorline     = '#202026',
    cursorlinenr   = '#4a4a5a',
    context        = '#294d49',

    -- Barbar
  }
  colors.sp2 = colors.tb
  colors.pp = colors.macro
  colors.br = colors.fg
  -- Barbar
  colors.bb_fg_current = colors.fg
  colors.bb_fg_visible = colors.fg
  colors.bb_fg_subtle = colors.fg
  colors.bb_fg_modified = colors.kw
  colors.bb_fg_target = colors.macro
  colors.bb_fg_inactive = colors.fg_comment

  local overrides = {
    CursorLine                    = { bg = colors.cursorline },
    LineNr                        = { fg = colors.cursorline },
    CursorLineNr                  = { fg = colors.cursorlinenr },
    MatchParen                    = { fg = colors.kw, bg = '', underline = true },
    Include                       = { fg = colors.inc },
    Macro                         = { fg = colors.macro },
    Namespace                     = { fg = colors.ns },
    Variable                      = { fg = colors.id },
    TSConstMacro                  = { link = 'Macro' },
    TSField                       = { fg = colors.fg },
    TSFuncMacro                   = { link = 'Macro' },
    TSInclude                     = { link = 'Include' },
    TSNamespace                   = { link = 'Namespace' },
    TSTypeBuiltin                 = { fg = colors.tb },
    TSVariable                    = { link = 'Variable' },
    TSConstructor                 = { fg = colors.fg },
    TreesitterContext             = { bg = colors.context },
    TreesitterContextLineNumber   = { fg = colors.context },

    -- Barbar
    BufferCurrent          = { fg = colors.bb_fg_current,  bg = colors.bgl },
    BufferCurrentIndex     = { fg = colors.bb_fg_special,  bg = colors.bgl },
    BufferCurrentMod       = { fg = colors.bb_fg_modified, bg = colors.bgl },
    BufferCurrentSign      = { fg = colors.bb_fg_special,  bg = colors.bgl },
    BufferCurrentTarget    = { fg = colors.bb_fg_target,   bg = colors.bgl, bold = true, underline = true },
    BufferVisible          = { fg = colors.bb_fg_visible,  bg = colors.bgl },
    BufferVisibleIndex     = { fg = colors.bb_fg_visible,  bg = colors.bgl },
    BufferVisibleMod       = { fg = colors.bb_fg_modified, bg = colors.bgl },
    BufferVisibleSign      = { fg = colors.bb_fg_visible,  bg = colors.bgl },
    BufferVisibleTarget    = { fg = colors.bb_fg_target,   bg = colors.bgl, bold = true, underline = true },
    BufferInactive         = { fg = colors.bb_fg_inactive, bg = colors.bg },
    BufferInactiveIndex    = { fg = colors.bb_fg_subtle,   bg = colors.bg },
    BufferInactiveMod      = { fg = colors.bb_fg_modified, bg = colors.bg },
    BufferInactiveSign     = { fg = colors.bb_fg_subtle,   bg = colors.bg },
    BufferInactiveTarget   = { fg = colors.bb_fg_target,   bg = colors.bg, bold = true, underline = true },
    BufferTabpages         = { fg = colors.bb_fg_special,  bg = colors.bg },
    BufferTabpageFill      = { fg = colors.bb_fg_inactive, bg = colors.bg },
    BufferCurrentIcon      = { link = 'BufferCurrent' },
    BufferVisibleIcon      = { link = 'BufferVisible' },
    BufferInactiveIcon     = { link = 'BufferInactive' },
    BufferOffset           = { link = 'BufferTabpageFill' },
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
end

return M
