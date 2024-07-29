---@type ChadrcConfig
local M = {}
M.ui = {
  transparency = true,
  theme = "catppuccin",
  statusline = {
    theme = "vscode_colored",
    order = {
      "mode",
      "tint",
      "separator",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "separator",
      "cwd",
    },
    modules = {
      caps_status = function()
        if vim.g.CAPSON == "True" then
          return "%#StText# Caps: ON  "
        else
          return "%#StText# Caps: OFF  "
        end
      end,
      separator = " ",
      hack = "%#@comment#%",
      tint = "%#StText#", -- Force grey on modules that absorb neighbour colour
      fill = "%#TbFill#%=",
      modified = function()
        return vim.bo.modified and " " or ""
      end,
      bufnr = function()
        local bufnr = vim.api.nvim_get_current_buf()
        return "%#StText#" .. tostring(bufnr)
      end,
      harpoon = function()
        -- https://github.com/letieu/harpoon-lualine
        local inactive = "%#St_HarpoonInactive#"
        local active = "%#St_HarpoonActive#"

        local options = {
          icon = active .. " ⇁ ",
          separator = "",
          indicators = {
            inactive .. "q",
            inactive .. "w",
            inactive .. "e",
            inactive .. "r",
            inactive .. "t",
            inactive .. "y",
          },
          active_indicators = {
            active .. "1",
            active .. "2",
            active .. "3",
            active .. "4",
            active .. "5",
            active .. "6",
          },
        }

        local list = require("harpoon"):list()
        local root_dir = list.config:get_root_dir()
        local current_file_path = vim.api.nvim_buf_get_name(0)
        local length = math.min(list:length(), #options.indicators)
        local status = { options.icon }

        local get_full_path = function(root, value)
          if vim.loop.os_uname().sysname == "Windows_NT" then
            return root .. "\\" .. value
          end

          return root .. "/" .. value
        end

        for i = 1, length do
          local value = list:get(i).value
          local full_path = get_full_path(root_dir, value)

          if full_path == current_file_path then
            table.insert(status, options.active_indicators[i])
          else
            table.insert(status, options.indicators[i])
          end
        end

        if length > 0 then
          table.insert(status, " ")
          return table.concat(status, options.separator)
        else
          return ""
        end
      end,
    },
  },
  theme_toggle = { "catppuccin", "decay" },
  telescope = { style = "bordered" },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true, fg = "#7F838B" },
    CursorLine = { bg = "#2C313C", fg = "#7F838B" }, -- Highlight the line where the cursor is
    CursorLineNr = { bg = "#2C313C" },
    LspInlayHint = { fg = "#4e5665", bg = "NONE" },
    FloatBorder = { link = "TelescopeBorder" },
    NvimTreeRootFolder = { link = "TelescopeBorder" },
    NvimTreeGitDirty = { link = "NvimTreeNormal" },
    Visual = { bg = "#3E4451" },     -- Custom background color for visual mode
    VisualLine = { bg = "#3E4451" }, -- Custom background color for visual line mode
  },
  hl_add = {
    YankVisual = { link = "CursorColumn" },
    LspInfoBorder = { fg = "#444c5b" },
    WinBar = { bg = "NONE" },
    WinBarNC = { bg = "NONE" },
    DropBarMenuCurrentContext = { link = "Visual" },
    St_HarpoonInactive = { link = "StText" },
    St_HarpoonActive = { link = "St_LspHints" },
    NvimTreeGitStagedIcon = { fg = "#a6e3a1" },
  },
  tabufline = {
    order = { "buffers", "tabs", "btns" },
  },
}

M.lsp = {
  signature = true,
  semantic_tokens = true,
}
M.term = {
  float = {
    border = "rounded",
  },
}

M.base46 = {
  integrations = {
    "cmp",
    "dap",
    "hop",
    "lsp",
    "todo",
    "mason",
    "neogit",
    "notify",
    "nvimtree",
    "whichkey",
    "devicons",
    "blankline",
    "rainbowdelimiters",
    "semantic_tokens",
    "codeactionmenu",
  },
}
return M
