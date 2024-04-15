-- <leader> key
vim.g.mapleader = ' '


-- Select all
vim.api.nvim_set_keymap('n', '<leader>a', 'ggVG', { noremap = true, silent = true })

-- keymap.set("n", "<leader>a", "gg<S-v>G")


-- skip folds (down, up)
vim.cmd('nmap j gj')
vim.cmd('nmap k gk')

-- -- Skip folds (down, up) using 'j' and 'k'
-- vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
-- Added { noremap = true, silent = true } to the key mappings to ensure they do not allow rema

-- sync system clipboard
vim.opt.clipboard = 'unnamedplus'

-- search ignoring case
vim.opt.ignorecase = true

-- disable "ignorecase" option if the search pattern contains upper case characters
vim.opt.smartcase = true