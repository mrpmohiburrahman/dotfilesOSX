-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

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
      -- "git",
      "%=",
      "lsp_msg",
      "%=",
      -- "diagnostics",
      -- "lsp",
      -- "cursor",
      -- "caps_status",
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

  ---@diagnostic disable-next-line
  theme_toggle = { "catppuccin", "decay" },
  telescope = { style = "bordered" },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true, fg = "#7F838B" },
  },

  -- hl_add = {}
  -- nvdash = {}
}

M.term = {
  float = {
    border = "rounded",
  },
}
return M
