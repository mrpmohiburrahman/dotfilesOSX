-- .config/sketchybar/settings.lua
return {
    paddings = 3,
    group_paddings = 5,

    -- paddings = 8,
    -- group_paddings = 5,
    icons = "sf-symbols", -- alternatively available: NerdFont

    -- This is a font configuration for SF Pro and SF Mono (installed manually)
    font = require("helpers.default_font"),

    -- Alternatively, this is a font config for JetBrainsMono Nerd Font
    -- font = {
    --   text = "JetBrainsMono Nerd Font", -- Used for text
    --   numbers = "JetBrainsMono Nerd Font", -- Used for numbers
    --   style_map = {
    --     ["Regular"] = "Regular",
    --     ["Semibold"] = "Medium",
    --     ["Bold"] = "SemiBold",
    --     ["Heavy"] = "Bold",
    --     ["Black"] = "ExtraBold",
    --   },
    -- },
    font_icon = {
        text = "Hack Nerd Font",
        numbers = "Hack Nerd Font",
        size = 13.0,
        style_map = {
            ["Regular"] = "Regular",
            ["Semibold"] = "Semibold",
            ["Bold"] = "Bold",
            ["Heavy"] = "Heavy",
            ["Black"] = "Black"
        }
    },
    height = 24,
    padding = {
        icon_item = {
            icon = {
                padding_left = 12,
                padding_right = 12
            }
        },
        icon_label_item = {
            icon = {
                padding_left = 8,
                padding_right = 0
            },
            label = {
                padding_left = 6,
                padding_right = 8
            }
        }
    }
}
