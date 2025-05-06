-- .config/sketchybar/colors.lua
-- Dracula Colors
return {
    default = 0x80ffffff,
    black = 0xff181819,
    white = 0xfff8f8f2,
    red = 0xffFF9580,
    red_bright = 0xe0f38ba8,
    green = 0xff8AFF80,
    blue = 0xff5199ba,
    blue_bright = 0xe089b4fa,
    yellow = 0xffFFFF80,
    orange = 0xffFFCA80,
    pink = 0xffFF80BF,
    purple = 0xff9580FF,
    other_purple = 0xff302c45,
    cyan = 0xff80FFEA,
    grey = 0xff7f8490,
    dirty_white = 0xc8cad3f5,
    dark_grey = 0xff2b2736,
    transparent = 0x00000000,

    bar = {
        bg = 0xf822212C,
        border = 0xff2c2e34
    },

    popup = {
        bg = 0xd322212c,
        border = 0xd322212c
    },
    spaces = {
        active = 0xffFFFF80,
        inactive = 0xc8cad3f5
    },

    bg1 = 0x331e1d27,
    bg2 = 0xff302c45,

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
