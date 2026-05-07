local wezterm = require 'wezterm'
local config = {}

-- Wallpaper shenanigans
local wallpaper_dir = 'C:/Users/Mik/Pictures/Wallpaper/Monhun/'
local function Wallpaper(name, options)
    options = options or {}
    return {
        name = name,
        h_align = options.h_align or 'Center',
        v_align = options.v_align or 'Middle',
        brightness = options.brightness or 0.15
    }
end
local wallpapers = {
    Wallpaper('abysal.png',{brightness = 0.5}),
    Wallpaper('dalamadur.png', {h_align = 'Left'}),
    Wallpaper('desert.png'),
    Wallpaper('doshaguma.png', {h_align = 'Right'}),
    Wallpaper('fatalis.png', {brightness = 0.5}),
    Wallpaper('gore.png', {h_align = 'Right'}),
    Wallpaper('jin.png', {h_align = 'Right'}),
    Wallpaper('lagiacrus.png'),
    Wallpaper('nargacuga.png', {h_align = 'Left'}),
    Wallpaper('tetsucabra.png', {h_align = 'Left'}),
    Wallpaper('tobi.png'),
    Wallpaper('ukanlos.png', {h_align = 'Left'}),
    Wallpaper('velkhana.png', {h_align = 'Right'})
}
math.randomseed(os.time())
local chosen_wallpaper = wallpapers[math.random(#wallpapers)]
local wallpaper_brigthness = chosen_wallpaper.brightness
local function buildWallpaper()
    return {
        {
            source = { File = wallpaper_dir..chosen_wallpaper.name },
            hsb = {brightness = wallpaper_brigthness},
            width = 'Cover',
            height = 'Cover',
            vertical_align = chosen_wallpaper.v_align,
            horizontal_align = chosen_wallpaper.h_align
        }
    }
end

-- Initial wallpaper roll
config.background = buildWallpaper()
-- Rerolling will use this
local function randomizeWallpaper()
    math.randomseed(os.time())
    chosen_wallpaper = wallpapers[math.random(#wallpapers)]

end
local function fadeSwap(window)
    -- Starts to look choppy at around 300 ms, anything below straight up doesnt work
    local total_fade_speed_ms = 500
    local steps = 20
    local fade_speed = total_fade_speed_ms/steps;
    local brightness_step = chosen_wallpaper.brightness/steps
    for i = chosen_wallpaper.brightness, 0.00, -brightness_step do
        wallpaper_brigthness = i
        wezterm.sleep_ms(fade_speed)
        window:set_config_overrides({background = buildWallpaper()})
    end
    randomizeWallpaper()
    for i = 0.00, chosen_wallpaper.brightness, brightness_step do
        wallpaper_brigthness = i
        wezterm.sleep_ms(fade_speed)
        window:set_config_overrides({background = buildWallpaper()})
    end
end

config.keys = {
    {
        key = "r",
        mods = "CTRL",
        action = wezterm.action_callback(function(window, pane)
        fadeSwap(window)
        end),
    },
}
-- End of wallpaper shenanigans
config.initial_cols = 120
config.initial_rows = 35
-- Consolas for main font, fallback jetbrains is just there for the icons
config.font = wezterm.font_with_fallback {
    { family = 'Consolas' , weight = 'Bold' },
    { family = 'JetBrains Mono Nerd Font' }
}
config.color_scheme = 'Monokai Pro (Gogh)'
config.window_close_confirmation = 'NeverPrompt'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

return config