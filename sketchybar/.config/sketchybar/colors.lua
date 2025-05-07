-- .config/sketchybar/colors.lua
-- Dracula Colors
return {
    default = 0x80ffffff,
    black = 0xff181819,
    white = 0xffe2e2e3,
    red = 0xfffc5d7c,
    green = 0xff9ed072,
    blue = 0xff76cce0,
    yellow = 0xffe7c664,
    orange = 0xfff39660,
    magenta = 0xffb39df3,
    -- white = 0xfff8f8f2,
    -- red = 0xffFF9580,
    -- green = 0xff8AFF80,
    -- blue = 0xff5199ba,
    -- yellow = 0xffFFFF80,
    -- orange = 0xffFFCA80,
    blue_bright = 0xe089b4fa,
    red_bright = 0xe0f38ba8,
    pink = 0xffFF80BF,
    purple = 0xff9580FF,
    other_purple = 0xff302c45,
    cyan = 0xff80FFEA,
    grey = 0xff7f8490,
    dirty_white = 0xc8cad3f5,
    dark_grey = 0xff2b2736,
    transparent = 0x00000000,

    bar = {
        bg = 0xf02c2e34,
        border = 0xff2c2e34
    },

    popup = {
        bg = 0xc02c2e34,
        border = 0xff7f8490
    },
    spaces = {
        active = 0xffFFFF80,
        inactive = 0xc8cad3f5
    },

    bg1 = 0xff363944,
    bg2 = 0xff414550,

    accent = 0xFFb482c2,
    accent_bright = 0x33efc2fc,

    spotify_green = 0xe040a02b,

    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
    end
}
