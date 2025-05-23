-- .config/sketchybar/items/calendar.lua
local settings = require("settings")
local colors = require("colors")
-- Padding item required because of bracket
sbar.add("item", {
    position = "right",
    width = settings.group_paddings
})

local cal = sbar.add("item", {
    icon = {
        color = colors.white,
        -- color = colors.dirty_white,
        padding_left = 8,
        padding_right = 28, -- add a bit of space after the icon
        font = {
            style = settings.font.style_map["Black"],
            size = 12.0
        }
        -- y_offset = -1,
        -- padding_right = -2
    },
    label = {
        color = colors.white,
        -- color = colors.dirty_white,
        padding_right = 8,
        width = 49,
        align = "right",
        font = {
            family = settings.font.numbers
        }
    },
    position = "right",
    update_freq = 30,
    padding_left = 1,
    padding_right = 1,
    background = {
        color = colors.bg2,
        border_color = colors.black,
        border_width = 1
    },
    click_script = "open -a 'Calendar'"
})

-- Double border for calendar using a single item bracket
sbar.add("bracket", {cal.name}, {
    background = {
        color = colors.transparent,
        height = 30,
        border_color = colors.grey
    }
})

-- Padding item required because of bracket
sbar.add("item", {
    position = "right",
    width = settings.group_paddings
})

cal:subscribe({"forced", "routine", "system_woke"}, function(env)
    cal:set({
        icon = os.date("%a. %d %b."),
        label = os.date("%I:%M %p")
    })
end)

-- -- german Date
-- cal:subscribe({"forced", "routine", "system_woke"}, function(env)
--     local weekdayNames = {"Sun.", "Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat."}
--     local monthNames = {"Jan.", "Feb.", "Mar", "Apr.", "May", "Jun", "July", "Aug.", "Sep.", "Oct.", "Nov.", "Dec."}

--     cal:set({
--         icon = weekdayNames[tonumber(os.date("%w")) + 1] .. os.date("%d") .. " " ..
--             monthNames[tonumber(os.date("%m"))],
--         label = "｜" .. os.date("%I:%M:%S %p")
--     })
-- end)

-- cal:subscribe("mouse.clicked", function(env)
--     sbar.exec("open -a 'Dato'")
-- end)

-- -- english date
-- -- cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
-- --   cal:set({ icon = os.date("%a. %d %b."), label = os.date("%H:%M") })
-- -- end)
