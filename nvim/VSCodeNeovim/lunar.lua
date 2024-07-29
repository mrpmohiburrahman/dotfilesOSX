local keymap = vim.keymap
local opts = {
    noremap = true,
    silent = true
}

-- <leader> key
-- vim.g.mapleader = ' '

-- save
-- vim.cmd('nmap <leader>w :w<cr>')

-- Select all
-- vim.api.nvim_set_keymap('n', '<leader>a', 'ggVG', opts)

-- keymap.set("n", "<leader>a", "gg<S-v>G")

-- skip folds (down, up)
vim.cmd('nmap j gj')
vim.cmd('nmap k gk')
-- -- Skip folds (down, up) using 'j' and 'k'
-- vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
-- Added { noremap = true, silent = true } to the key mappings to ensure they do not allow rema

-- Prevent cursor jumping back to where selection started on yank
-- map("v", "y", "ygv<Esc>")
-- sync system clipboard
vim.opt.clipboard = 'unnamedplus'

-- sync system clipboard
vim.opt.clipboard = 'unnamedplus'
-- search ignoring case
vim.opt.ignorecase = true

-- disable "ignorecase" option if the search pattern contains upper case characters
vim.opt.smartcase = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({{
    'vscode-neovim/vscode-multi-cursor.nvim',
    event = 'VeryLazy',
    cond = not not vim.g.vscode,
    opts = {}
    -- default mapping of muilti cursor nvim
    -- local cursors = require('vscode-multi-cursor')
    -- local k = vim.keymap.set
    -- k({'n', 'x'}, 'mc', cursors.create_cursor, {
    --     expr = true,
    --     desc = 'Create cursor'
    -- })
    -- k({'n'}, 'mcc', cursors.cancel, {
    --     desc = 'Cancel/Clear all cursors'
    -- })
    -- k({'n', 'x'}, 'mi', cursors.start_left, {
    --     desc = 'Start cursors on the left'
    -- })
    -- k({'n', 'x'}, 'mI', cursors.start_left_edge, {
    --     desc = 'Start cursors on the left edge'
    -- })
    -- k({'n', 'x'}, 'ma', cursors.start_right, {
    --     desc = 'Start cursors on the right'
    -- })
    -- k({'n', 'x'}, 'mA', cursors.start_right, {
    --     desc = 'Start cursors on the right'
    -- })
    -- k({'n'}, '[mc', cursors.prev_cursor, {
    --     desc = 'Goto prev cursor'
    -- })
    -- k({'n'}, ']mc', cursors.next_cursor, {
    --     desc = 'Goto next cursor'
    -- })
    -- k({'n'}, 'mcs', cursors.flash_char, {
    --     desc = 'Create cursor using flash'
    -- })
    -- k({'n'}, 'mcw', cursors.flash_word, {
    --     desc = 'Create selection using flash'
    -- })

}})
