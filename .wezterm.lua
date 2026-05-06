local wezterm = require 'wezterm'

local config = {}

local wallpaper_dir = 'C:/Users/Mik/Pictures/Wallpaper/Monhun/'
local function Wallpaper(name, h_align)
    return {
        name = name,
        h_align = h_align or 'Center'
    }
end
-- adjust the wallpaper alignment to the focal point of the image
local wallpapers = {
    Wallpaper('abysal.png'),
    Wallpaper('dalamadur.png', 'Left'),
    Wallpaper('desert.png'),
    Wallpaper('doshaguma.png', 'Right'),
    Wallpaper('fatalis.png'),
    Wallpaper('gore.png', 'Right'),
    Wallpaper('jin.png', 'Right'),
    Wallpaper('lagiacrus.png'),
    Wallpaper('nargacuga.png', 'Left'),
    Wallpaper('tetsucabra.png', 'Left'),
    Wallpaper('tobi.png'),
    Wallpaper('ukanlos.png', 'Left'),
    Wallpaper('velkhana.png', 'Right')
}

math.randomseed(os.time())
local chosen_wallpaper = wallpapers[math.random(#wallpapers)]

--consolas for main font, fallback jetbrains is just there for the icons
config.font = wezterm.font_with_fallback {
    { family = 'Consolas' , weight = 'Bold' },
    { family = 'JetBrains Mono Nerd Font' }
}
config.color_scheme = 'Monokai Pro (Gogh)'
config.window_close_confirmation = 'NeverPrompt'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.background = {
    {
        source = { File = wallpaper_dir..chosen_wallpaper.name },
        hsb = {
        brightness = 0.15,
        },

        width = 'Cover',
        height = 'Cover',
        vertical_align = 'Middle',
        horizontal_align = chosen_wallpaper.h_align
    },
}

return config