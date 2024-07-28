---@type ChadrcConfig
local M = {}

M.ui = {
  transparency = true,
  theme = "catppuccin",
  statusline = {
    theme = "vscode_colored",
    order = {
      "mode",
      "file",
      "%=",
      "lsp_msg",
      "%=",
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
    },
  },
  theme_toggle = { "catppuccin", "decay" },
  telescope = { style = "bordered" },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true, fg = "#7F838B" },
    CursorLine = { bg = "#7F838B", fg = "#7F838B" }, -- Highlight the line where the cursor is
    CursorLineNr = { bg = "#2C313C" },
    LspInlayHint = { fg = "#4e5665", bg = "NONE" },
    FloatBorder = { link = "TelescopeBorder" },
    NvimTreeRootFolder = { link = "TelescopeBorder" },
    NvimTreeGitDirty = { link = "NvimTreeNormal" },
    Visual = { bg = "#3E4451" }, -- Custom background color for visual mode
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
}

M.term = {
  float = {
    border = "rounded",
  },
}

return M
