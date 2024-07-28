require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Enter cmd mode with ";"
map("n", ";", ":", { desc = "CMD enter command mode" })
-- Exit insert mode with "jj"
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Prevent cursor jumping back to where selection started on yank
map("v", "y", "ygv<Esc>")
-- Select all
map("n", "<Leader>a", "gg<S-v>G") -- Ctrl+a selects all text in the buffer by going to the top (gg), starting visual line mode (<S-v>), and going to the bottom (G)

-- searchbox
-- map("n", "<leader>s", "<cmd> SearchBoxIncSearch <CR>", { desc = "Enter Searchbox" })
-- map("n", "<leader>r", "<cmd> SearchBoxReplace <CR>", { desc = "Enter Replace Searchbox" })

-- Term
-- Escape terminal mode
map("t", "<leader>x", "<C-\\><C-N>", {
  desc = "Escape terminal mode",
})

-- Toggle vertical split terminal
map({ "n", "t" }, "<leader>tv", function()
  require("nvchad.term").toggle {
    pos = "vsp",
    id = "vtoggleTerm",
  }
end, {
  desc = "Toggle vertical split terminal",
})

-- Toggle vertical split terminal in buffer location
map({ "n", "t" }, "<leader>tvb", function()
  require("nvchad.term").toggle {
    pos = "vsp",
    id = "vtoggleTermLoc",
    cmd = "cd " .. vim.fn.expand "%:p:h",
  }
end, {
  desc = "Toggle vertical split terminal in buffer location",
})

-- Toggle horizontal split terminal
map({ "n", "t" }, "<leader>th", function()
  require("nvchad.term").toggle {
    pos = "sp",
    id = "htoggleTerm",
  }
end, {
  desc = "Toggle horizontal split terminal",
})

-- Toggle horizontal split terminal in buffer location
map({ "n", "t" }, "<leader>thb", function()
  require("nvchad.term").toggle {
    pos = "sp",
    id = "htoggleTermLoc",
    cmd = "cd " .. vim.fn.expand "%:p:h",
  }
end, {
  desc = "Toggle horizontal split terminal in buffer location",
})

-- Toggle floating terminal
map({ "n", "t" }, "<leader>tf", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
  }
end, {
  desc = "Toggle floating terminal",
})

-- Toggle floating terminal in buffer location
map({ "n", "t" }, "<leader>tfb", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTermLoc",
    cmd = "cd " .. vim.fn.expand "%:p:h",
  }
end, {
  desc = "Toggle floating terminal in buffer location",
})
