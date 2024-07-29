return {{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        config = function()
            require'window-picker'.setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    bo = {
                        filetype = {'neo-tree', "neo-tree-popup", "notify"},
                        buftype = {'terminal', "quickfix"}
                    }
                }
            })
        end
    }},
    config = function()
        require("neo-tree").setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = {"terminal", "trouble", "qf"},
            sort_case_insensitive = false,
            default_component_configs = {
                container = {
                    enable_character_fade = true
                },
                indent = {
                    indent_size = 2,
                    padding = 1,
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander"
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                },
                git_status = {
                    symbols = {
                        added = "",
                        modified = "",
                        deleted = "✖",
                        renamed = "󰁕",
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = ""
                    }
                }
            },
            window = {
                position = "left",
                width = 40,
                mapping_options = {
                    noremap = true,
                    nowait = true
                },
                mappings = {
                    ["<space>"] = {
                        "toggle_node",
                        nowait = false
                    },
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["<esc>"] = "cancel",
                    ["P"] = {
                        "toggle_preview",
                        config = {
                            use_float = true,
                            use_image_nvim = true
                        }
                    },
                    ["l"] = "focus_preview",
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    ["t"] = "open_tabnew",
                    ["w"] = "open_with_window_picker",
                    ["C"] = "close_node",
                    ["z"] = "close_all_nodes",
                    ["a"] = {
                        "add",
                        config = {
                            show_path = "none"
                        }
                    },
                    ["A"] = "add_directory",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy",
                    ["m"] = "move",
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                    ["i"] = "show_file_details"
                }
            },
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_hidden = true
                }
            }
        })

        -- Key mapping for toggling focus between neo-tree and the current buffer
        vim.keymap.set("n", "<leader>e", function()
            local view = require("neo-tree.view")
            if view.is_visible() then
                if vim.fn.winnr() == view.get_winnr() then
                    vim.cmd("wincmd p")
                else
                    vim.cmd("Neotree focus")
                end
            else
                vim.cmd("Neotree show")
            end
        end, {
            desc = "Toggle NeoTree"
        })
    end
}}
