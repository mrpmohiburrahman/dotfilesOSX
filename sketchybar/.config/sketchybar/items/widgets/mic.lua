local colors = require("colors")
local mic = sbar.add("item", "widgets.uname", {
    update_freq = 3,
    position = "right",
    padding_right = -2,
    icon = {
        padding_left = 2
    },
    label = {
        padding_right = 2
    },
    background = {
        color = colors.bg1,
        border_width = 1 -- optional border
    }
})
-- 3) Helper: sanitize UTF-8 via iconv
local function sanitize(name, cb)
    local first = name:match("^(%S+)") or ""
    sbar.exec(("printf %q | iconv -f UTF-8 -t UTF-8//IGNORE"):format(first), function(valid)
        cb(valid)
    end)
end
-- 4) Update function used for both volume_change & click
local function update(env)
    -- Fetch and sanitize mic name
    sbar.exec("SwitchAudioSource -t input -c", function(raw)
        sanitize(raw, function(dev)
            if dev == "" then
                mic:set({
                    icon = {
                        string = "",
                        color = colors.red
                    },
                    label = {
                        string = "",
                        color = colors.red
                    }
                })
                return
            end

            -- Fetch current volume
            sbar.exec("osascript -e 'input volume of (get volume settings)'", function(vol_s)
                local vol = tonumber(vol_s) or 0

                -- Toggle on click
                if env.SENDER == "mouse.clicked" then
                    if vol < 100 then
                        vol = 100
                        sbar.exec("osascript -e 'set volume input volume 100'")
                    else
                        vol = 0
                        sbar.exec("osascript -e 'set volume input volume 0'")
                    end
                end

                -- Choose icon & color
                local icon, clr
                if vol == 0 then
                    icon, clr = "", colors.red
                elseif vol < 100 then
                    icon, clr = "", colors.orange
                else
                    icon, clr = "", colors.white
                end

                -- Apply to SketchyBar
                mic:set({
                    icon = {
                        string = icon,
                        color = clr,
                        padding_left = 8
                    },
                    label = {
                        string = string.format("%s %d", dev, vol),
                        color = clr,
                        padding_right = 8
                    }
                })
            end)
        end)
    end)
end
-- 5) Subscribe to events
mic:subscribe({"volume_change", "mouse.clicked"}, update) -- :contentReference[oaicite:5]{index=5}
