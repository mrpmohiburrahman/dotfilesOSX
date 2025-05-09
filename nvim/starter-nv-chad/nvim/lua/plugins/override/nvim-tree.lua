local map = vim.keymap.set

-- Function to set highlight groups
local function set_highlights()
    -- vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", {
    --     fg = "#61afef"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeFolderName", {
    --     fg = "#61afef"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", {
    --     fg = "#98c379"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", {
    --     fg = "#e5c07b"
    -- })

    vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", {
        fg = "#8891B1"
    })
    -- vim.api.nvim_set_hl(0, "NvimTreeGitDirty", {
    --     fg = "#e06c75"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeGitStaged", {
    --     fg = "#98c379"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeGitMerge", {
    --     fg = "#c678dd"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", {
    --     fg = "#61afef"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeGitNew", {
    --     fg = "#56b6c2"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", {
    --     fg = "#e06c75"
    -- })
    -- vim.api.nvim_set_hl(0, "NvimTreeNormal", {
    --     fg = "#abb2bf"
    --     -- bg = "#1e222a"
    -- }) -- Set background color of NvimTree
    vim.api.nvim_set_hl(0, "NvimTreeStatusLine", {
        bg = "#1e222a"
    })
    -- Set statusline background color
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", {
        fg = "#1e222a"
    }) -- Set end of buffer color to match background

    -- Highlight selected file or folder
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", {
        bg = "#383D4E"
    }) -- Set background color when a file or folder is selected
    vim.api.nvim_set_hl(0, "NvimTreeCursorLineNr", {
        fg = "#abb2bf",
        bg = "#383D4E"
    }) -- Set foreground and background color of line number when a file or folder is selected
end

return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        dofile(vim.g.base46_cache .. "nvimtree")

        local nvtree = require "nvim-tree"
        local api = require "nvim-tree.api"

        -- Set custom highlights
        set_highlights()

        -- Add custom mappings
        local function custom_on_attach(bufnr)
            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true
                }
            end

            api.config.mappings.default_on_attach(bufnr)
            map("n", "+", api.tree.change_root_to_node, opts "CD")
            map("n", "?", api.tree.toggle_help, opts "Help")
            map("n", "<ESC>", api.tree.close, opts "Close")
        end

        -- Automatically open file upon creation
        api.events.subscribe(api.events.Event.FileCreated, function(file)
            vim.cmd("edit " .. file.fname)
        end)

        local HEIGHT_RATIO = 0.8
        local WIDTH_RATIO = 0.5

        nvtree.setup {
            on_attach = custom_on_attach,
            sync_root_with_cwd = true,
            -- hijack_unnamed_buffer_when_opening = false,
            update_focused_file = {
                enable = true,
                update_cwd = true,
                ignore_list = {}
            },
            filters = {
                custom = {"^.git$"}
            },
            git = {
                enable = true
            },
            renderer = {
                indent_markers = {
                    enable = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "├",
                        none = " "
                    }
                },
                highlight_git = "none",
                icons = {
                    glyphs = {
                        folder = {
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = ""
                        },
                        git = {
                            unstaged = "",
                            staged = "",
                            unmerged = "",
                            renamed = "",
                            untracked = "",
                            deleted = "",
                            ignored = "󰴲"
                        }
                    }
                }
            },
            view = {
                width = 30,
                side = "right",
                signcolumn = "no"
            },
            filesystem_watchers = {
                ignore_dirs = {"node_modules"}
            }
        }

        -- Key mappings
        map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {
            desc = "Toggle NvimTree"
        })
        -- map("n", "<leader>f", function()
        --     nvtree.open_float()
        -- end, {
        --     desc = "Open NvimTree Floating"
        -- })

    end
}
