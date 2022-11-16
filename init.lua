-- Add config/lua to search path.
package.path = (vim.fn.stdpath("config") .. "/lua/?.lua;") ..
    (vim.fn.stdpath("config") .. "/lua/?/init.lua;") ..
    package.path
-- Set up Fennel.
local fennel = require("fennel")
-- Set up Fennel's search path.
fennel.path = string.gsub(package.path, "%.lua", "%.fnl")
-- Allow loading Fennel via require.
table.insert(package.loaders, fennel.makeSearcher({ allowedGlobals = false }))
-- Include Fennel debug info in errors.
debug.traceback = fennel.traceback
-- Load init.
require "core"

-- test more
