local map = vim.keymap.set
return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        dofile(vim.g.base46_cache .. "nvimtree")

        local nvtree = require "nvim-tree"
        local api = require "nvim-tree.api"

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
            filters = {
                custom = {"^.git$"}
            },
            git = {
                enable = true
            },
            renderer = {
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
        map("n", "<leader>f", function()
            nvtree.open_float()
        end, {
            desc = "Open NvimTree Floating"
        })

        -- Autocommand to open nvim-tree on startup
        -- vim.api.nvim_create_autocmd("VimEnter", {
        --     callback = function()
        --         local api = require "nvim-tree.api"
        --         api.tree.open()
        --     end
        -- })
    end
}
