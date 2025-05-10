-- .config/sketchybar/items/widgets/wifi.lua
local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "network_update"
-- for the network interface "en0", which is fired every 1.5 seconds.
sbar.exec(
    "killall network_load >/dev/null; $CONFIG_DIR/helpers/event_providers/network_load/bin/network_load en0 network_update 1.5")

local popup_width = 250

local wifi_up = sbar.add("item", "widgets.wifi1", {
    position = "right",
    padding_left = -5,
    width = 0,
    icon = {
        padding_right = 0,
        font = {
            style = settings.font.style_map["Bold"],
            size = 9.0
        },
        string = icons.wifi.upload
    },
    label = {
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Bold"],
            size = 9.0
        },
        color = colors.red,
        string = "??? Bps"
    },
    y_offset = 4
})

local wifi_down = sbar.add("item", "widgets.wifi2", {
    position = "right",
    padding_left = -5,
    icon = {
        padding_right = 0,
        font = {
            style = settings.font.style_map["Bold"],
            size = 9.0
        },
        string = icons.wifi.download
    },
    label = {
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Bold"],
            size = 9.0
        },
        color = colors.blue,
        string = "??? Bps"
    },
    y_offset = -4
})

local wifi = sbar.add("item", "widgets.wifi.padding", {
    position = "right",
    label = {
        drawing = false
    }
    -- padding_left = 3
})

-- Background around the item
local wifi_bracket = sbar.add("bracket", "widgets.wifi.bracket", {wifi.name, wifi_up.name, wifi_down.name}, {
    background = {
        color = colors.bg1
        -- border_color = colors.bg1,
        -- border_width = 2
    },
    popup = {
        align = "center",
        height = 30
    }
})

local ssid = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        font = {
            style = settings.font.style_map["Bold"]
        },
        string = icons.wifi.router
    },
    width = popup_width,
    align = "center",
    label = {
        font = {
            size = 15,
            style = settings.font.style_map["Bold"]
        },
        max_chars = 18,
        string = "????????????"
    },
    background = {
        height = 2,
        color = colors.grey,
        y_offset = -15
    }
})

local hostname = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        align = "left",
        string = "Hostname:",
        width = popup_width / 2
    },
    label = {
        max_chars = 20,
        string = "????????????",
        width = popup_width / 2,
        align = "right"
    }
})

local ip = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        align = "left",
        string = "IP:",
        width = popup_width / 2
    },
    label = {
        string = "???.???.???.???",
        width = popup_width / 2,
        align = "right"
    }
})

local mask = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        align = "left",
        string = "Subnet mask:",
        width = popup_width / 2
    },
    label = {
        string = "???.???.???.???",
        width = popup_width / 2,
        align = "right"
    }
})

local router = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        align = "left",
        string = "Router:",
        width = popup_width / 2
    },
    label = {
        string = "???.???.???.???",
        width = popup_width / 2,
        align = "right"
    }
})

sbar.add("item", {
    position = "right",
    width = settings.group_paddings
})
--- Parse a speed string like "1.23 MBps" or "512 KBps"
-- @param s  string  e.g. "1.23 MBps"
-- @return num  number  the numeric part
-- @return unit string  the unit part, e.g. "MBps"
local function parse_speed(s)
    -- Trim whitespace
    local str = s:match("^%s*(.-)%s*$") or ""
    -- Capture number and unit
    local num, unit = str:match("([%d%.]+)%s*(%a+)")
    if num then
        return tonumber(num), unit
    end
    return nil, nil
end

wifi_up:subscribe("network_update", function(env)
    local up_str = env.upload
    local up_val, up_unit = parse_speed(up_str)

    -- Determine upload colour
    local up_color
    if up_str == "000 Bps" then
        up_color = colors.grey
    elseif up_unit == "MBps" and up_val >= 1 then
        up_color = colors.green -- ≥1 MBps → green
    else
        up_color = colors.red -- <1 MBps → red
    end

    wifi_up:set({
        icon = {
            color = up_color
        },
        label = {
            string = up_str,
            color = up_color
        }
    })

    -- Now update download similarly
    local down_str = env.download
    local down_val, down_unit = parse_speed(down_str)

    local down_color
    if down_str == "000 Bps" then
        down_color = 0xFF4C566A
    elseif down_unit == "MBps" and down_val >= 1 then
        down_color = colors.green
    else
        down_color = 0xFFEBCB8B -- your original “active but <1 MBps” colour
    end

    wifi_down:set({
        icon = {
            color = down_color
        },
        label = {
            string = down_str,
            color = down_color
        }
    })
end)

wifi:subscribe({"wifi_change", "system_woke", "forced"}, function(env)
    wifi:set({
        icon = {
            string = icons.wifi.disconnected,
            color = colors.pink
        }
    })
    sbar.exec([[ipconfig getifaddr en0]], function(result_ip)
        local ipconnected = not (result_ip == "")

        if ipconnected then
            Wifi_icon = icons.wifi.connected
            Wifi_color = colors.dirty_white
        end

        wifi:set({
            icon = {
                string = Wifi_icon,
                color = Wifi_color
            }
        })

        -- VPN icon
        sbar.exec([[sleep 2; scutil --nwi | grep -m1 'utun' | awk '{ print $1 }']], function(vpn)
            local vpnconnected = not (vpn == "")

            if vpnconnected then
                Wifi_icon = icons.wifi.vpn
                Wifi_color = colors.green
            end

            wifi:set({
                icon = {
                    string = Wifi_icon,
                    color = Wifi_color
                }
            })
        end)
    end)
end)

local function hide_details()
    wifi_bracket:set({
        popup = {
            drawing = false
        }
    })
end

local function toggle_details()
    local should_draw = wifi_bracket:query().popup.drawing == "off"
    if should_draw then
        wifi_bracket:set({
            popup = {
                drawing = true
            }
        })
        sbar.exec("networksetup -getcomputername", function(result)
            hostname:set({
                label = result
            })
        end)
        sbar.exec("ipconfig getifaddr en0", function(result)
            ip:set({
                label = result
            })
        end)
        sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
            ssid:set({
                label = result
            })
        end)
        sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'", function(result)
            mask:set({
                label = result
            })
        end)
        sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
            router:set({
                label = result
            })
        end)
    else
        hide_details()
    end
end

wifi_up:subscribe("mouse.clicked", toggle_details)
wifi_down:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
    local label = sbar.query(env.NAME).label.value
    sbar.exec("echo \"" .. label .. "\" | pbcopy")
    sbar.set(env.NAME, {
        label = {
            string = icons.clipboard,
            align = "center"
        }
    })
    sbar.delay(1, function()
        sbar.set(env.NAME, {
            label = {
                string = label,
                align = "right"
            }
        })
    end)
end

ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)
