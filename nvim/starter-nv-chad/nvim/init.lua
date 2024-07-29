vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system {"git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath}
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({{
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
        require "options"
    end
}, {
    import = "plugins"
}}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"
require "cmds.autocmds"
require "cmds.usercmds"
vim.schedule(function()
    require "mappings"
end)

-- -- Function to reload NvChad configuration
-- function ReloadNvChad()
--     -- Reload init.lua or chadrc.lua
--     vim.cmd("source ~/dotfilesOSX/nvim/starter-nv-chad/nvim/init.lua")
--     vim.cmd("source ~/dotfilesOSX/nvim/starter-nv-chad/nvim/lua/chadrc.lua")

--     -- Reload autocommand definitions if you have a separate file
--     vim.cmd("source ~/dotfilesOSX/nvim/starter-nv-chad/nvim/lua/cmds/autocmds.lua")

--     -- Reload lazy.nvim plugin configurations
--     require("lazy").reload()
-- end

-- -- Create a custom command to easily call the reload function
-- vim.api.nvim_create_user_command('ReloadConfig', ReloadNvChad, {})
