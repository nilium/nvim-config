-- Bootstrap packer.
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Plugin configs.
local plugins = {
  -- My personal plugins.
  'nil',
  -- Kanagawa color scheme, customized to look like triplejelly (because I'm too
  -- lazy to update it and I'd rather just use something existing).
  'colorscheme',
  -- Some of Tim pope's collection
  'tpope',
  -- Treesitter packages, together because they often require the top-level
  -- treesitter package.
  'treesitter',
  -- Syntax highlighting and related.
  'syntax',
  -- Editor behavior.
  'editor',
  -- LSP support.
  'lsp',
  -- UI features.
  'ui',
}

local packer = require('packer')
local setupfuncs = {}
packer.startup(function()
  -- Packer
  use "wbthomason/packer.nvim"

  -- Nested plugins.
  for i, name in ipairs(plugins) do
    local spec = require("plugins/" .. name)
    if type(spec) == "table" then
      local pluginset = spec
      if type(spec.plugins) == "table" then
        pluginset = spec.plugins
        if type(spec.setup) == "function" then
          setupfuncs[#setupfuncs + 1] = function() spec:setup() end
        end
      end

      if type(pluginset[1]) == "string" then -- Regular use table.
        use(spec)
      else -- List of use tables.
        for j, req in ipairs(pluginset) do
          use(req)
        end
      end
    else
      error("No spec set for plugin " .. name .. " (type = " .. tostring(spec) .. ")")
    end
  end

  if packer_bootstrap then
    packer.sync()
  end
end)

-- Run post-setup functions.
for i, setup in ipairs(setupfuncs) do
  setup()
end
