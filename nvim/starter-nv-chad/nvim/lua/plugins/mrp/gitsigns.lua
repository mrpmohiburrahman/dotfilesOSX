return {
    "lewis6991/gitsigns.nvim",
    dependencies = "sindrets/diffview.nvim",
    init = function()
        local map = vim.keymap.set
        -- Key mappings for gitsigns functionalities
        map("n", "<leader>bl", "<cmd>Gitsigns blame_line<CR>", {
            desc = "Gitsigns blame line"
        })
        map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>", {
            desc = "Gitsigns toggle deleted"
        })
        map("n", "<leader>tb", function()
            require("gitsigns").toggle_current_line_blame()
        end, {
            desc = "Toggle inline git blame"
        })
    end,
    opts = {
        preview_config = {
            border = "rounded"
        },
        current_line_blame = true, -- Enable inline git blame by default
        current_line_blame_opts = {
            delay = 1000,
            virt_text_pos = 'eol'
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>'
    },
    config = function(_, opts)
        require('gitsigns').setup(opts)

        -- Set custom highlight for git blame line
        vim.cmd [[highlight GitSignsCurrentLineBlame guifg=#5D657D guibg=#34394A]]
    end
}
