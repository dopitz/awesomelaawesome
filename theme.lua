--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local os, math, string = os, math, string

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/awesomelaawesome"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "xos4 Terminus 9"
theme.fg_normal                                 = "#FEFEFE"
theme.fg_focus                                  = "#32D6FF"
theme.fg_urgent                                 = "#C83F11"
theme.bg_normal                                 = "#222222"
theme.bg_focus                                  = "#1E2320"
theme.bg_urgent                                 = "#3F3F3F"
theme.taglist_fg_focus                          = "#00CCFF"
theme.tasklist_bg_focus                         = "#222222"
theme.tasklist_fg_focus                         = "#00CCFF"
theme.border_width                              = 1
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#6F6F6F"
theme.border_marked                             = "#CC9393"
theme.prompt_bg                                 = "#A43464"
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = 16
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_weather                            = theme.dir .. "/icons/temp.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_task                               = theme.dir .. "/icons/task.png"
theme.widget_scissors                           = theme.dir .. "/icons/scissors.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 0
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

-- Clock
local clock = awful.widget.watch(                                                  
    "date +'%a %d %b %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.calendar({
    --cal = "cal --color=always",
    attach_to = { clock },
    notification_preset = {
        font = "xos4 Terminus 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
local mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_text(" " .. mailcount .. " ")
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- volume
local volicon = wibox.widget.imagebox(theme.widget_music)
theme.volume = lain.widget.pulse ({
    settings = function()
        header = " Vol "                                                                                                
        vlevel = volume_now.left .. "%"
        if volume_now.muted == "yes" then
            vlevel = vlevel .. " M"
        end
        widget:set_markup(markup.font(theme.font, markup(theme.fg_normal, header) .. markup(theme.fg_normal, vlevel)))
    end
})

--theme.volume = lain.widget.alsa({
--     --togglechannel = "IEC958,3",
--     settings = function()
--         header = " Vol "                                                                                                
--         vlevel  = volume_now.level
-- 
--         if volume_now.status == "off" or volume_now.level == 0 then
--             vlevel = vlevel .. "M "
--         else
--             vlevel = vlevel .. " "
--         end
-- 
--        widget:set_markup(markup.font(theme.font, markup(theme.fg_normal, header) .. markup(theme.fg_normal, vlevel)))
--     end
--})


-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)  
theme.weather = lain.widget.weather({
    city_id = 2892794, -- karlsruhe
    --city_id = 2882439, -- künzelnau
    notification_preset = { font = theme.font, fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, theme.fg_normal, "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, descr .. " @ " .. units .. "°C "))
    end
})


-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

--[[ Coretemp (lm_sensors, per core)
local tempwidget = awful.widget.watch({awful.util.shell, '-c', 'sensors | grep Core'}, 30,
function(widget, stdout)
    local temps = ""
    for line in stdout:gmatch("[^\r\n]+") do
        temps = temps .. line:match("+(%d+).*°C")  .. "° " -- in Celsius
    end
    widget:set_markup(markup.font(theme.font, " " .. temps))
end)
--]]

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, " AC "))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup()
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#FEFEFE", " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})

-- xkbmap
kbdlayout = lain.widget.contrib.kbdlayout({
    layouts = { { layout = "dvorak", variant = "-option caps:swapescape -option compose:ralt" },
	            { layout = "gb", variant = "-option caps:swapescape -option compose:ralt"  } },
    settings = function()
        widget:set_text(kbdlayout_now.layout)
    end
})

-- Separators
local arrow = separators.arrow_left
local arrowr = separators.arrow_right

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth         , 0        )
    cr:line_to(offset + width               , 0        )
    cr:line_to(offset + width - arrow_depth , height/2 )
    cr:line_to(offset + width               , height   )
    cr:line_to(offset + arrow_depth         , height   )
    cr:line_to(offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, 16, 16), bgcolor, theme.powerline_rl)
end

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist0 = awful.widget.taglist(s, function(t) return  math.floor((t.index - 1) / 4) == 0  end, awful.util.taglist_buttons)
    s.mytaglistg = awful.widget.taglist(s, function(t) return  math.floor((t.index - 1) / 4) == 1  end, awful.util.taglist_buttons)
    s.mytaglisth = awful.widget.taglist(s, function(t) return  math.floor((t.index - 1) / 4) == 2  end, awful.util.taglist_buttons)
    s.mytaglistt = awful.widget.taglist(s, function(t) return  math.floor((t.index - 1) / 4) == 3  end, awful.util.taglist_buttons)
    s.mytaglistn = awful.widget.taglist(s, function(t) return  math.floor((t.index - 1) / 4) == 4  end, awful.util.taglist_buttons)
    s.mytaglists = awful.widget.taglist(s, function(t) return  math.floor((t.index - 1) / 4) == 5  end, awful.util.taglist_buttons)
    s.mytaglistx = awful.widget.taglist(s, function(t) return  math.floor((t.index - 1) / 4) == 6  end, awful.util.taglist_buttons)


    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    s.mystatusbar = wibox.widget {
      layout = wibox.layout.fixed.horizontal,
      arrow(theme.bg_normal, "#343434"),
      wibox.container.background(wibox.container.margin(wibox.widget { 
        mailicon, 
        mail and mail.widget, 
        layout = wibox.layout.align.horizontal 
      }, 4, 8), "#343434"),
      arrow("#343434", "#8F654B"),
      wibox.container.background(wibox.container.margin(wibox.widget { 
        volicon, 
        theme.volume.widget, 
        layout = wibox.layout.align.horizontal 
      }, 4, 8), "#8F654B"),
      arrow("#8F654B", "#7B99BD"),
      wibox.container.background(wibox.container.margin(wibox.widget { 
        weathericon, 
        theme.weather.widget, 
        layout = wibox.layout.align.horizontal 
      }, 4, 8), "#7B99BD"),
      arrow("#7B99BD", "#777E76"),
      wibox.container.background(wibox.container.margin(wibox.widget { 
        memicon, 
        mem.widget, 
        layout = wibox.layout.align.horizontal 
      }, 4, 8), "#777E76"),
      arrow("#777E76", "#4B696D"),
      wibox.container.background(wibox.container.margin(wibox.widget { 
        cpuicon, 
        cpu.widget, 
        layout = wibox.layout.align.horizontal 
      }, 4, 8), "#4B696D"),
      arrow("#4B696D", "#8DAA9A"),
      wibox.container.background(wibox.container.margin(wibox.widget { 
        baticon, 
        bat.widget, 
        layout = wibox.layout.align.horizontal 
      }, 4, 8), "#8DAA9A"),
      arrow("#8DAA9A", "#C0C0A2"),
      wibox.container.background(wibox.container.margin(wibox.widget { 
        neticon, 
        net.widget, 
        layout = wibox.layout.align.horizontal 
      }, 4, 8), "#C0C0A2"),
      arrow("#C0C0A2", "#777E76"),
      wibox.container.background(wibox.container.margin(kbdlayout.widget, 4, 8), "#777E76"),
      wibox.container.background(wibox.container.margin(wibox.widget { 
        clock, 
        layout = wibox.layout.fixed.horizontal
      }, 4, 8), "#777E76"),
      arrow("#777E76", "alpha"),
      wibox.container.margin(s.mylayoutbox, 4, 8),
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 36, bg = theme.bg_normal, fg = theme.fg_normal })
    
    -- Add widgets to the wibox
    s.mywibox:setup {
      layout = wibox.layout.fixed.vertical,
      {
        forced_height = 18,
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          --spr,
          wibox.container.background(wibox.container.margin(s.mytaglist0, 4, 7),"#5B799D"),
          arrowr("#5B799D","#3B597D"),
          wibox.container.background(wibox.container.margin(s.mytaglistg, 4, 7),"#3B597D"),
          arrowr("#3B597D","#1B395D"),
          wibox.container.background(wibox.container.margin(s.mytaglisth, 4, 7),"#1B395D"),
          arrowr("#1B395D","#0B193D"),
          wibox.container.background(wibox.container.margin(s.mytaglistx, 4, 7),"#0B193D"),
          arrowr("#0B193D", "#A43464"),
          wibox.container.background(wibox.container.margin(s.mypromptbox, 4, 17), "#A43464"),
          arrowr("#A43464", theme.bg_normal),
        },
        nil,
        s.mystatusbar
      },
      nil,
      {
        forced_height = 18,
        layout = wibox.layout.fixed.horizontal,
        { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          wibox.container.background(wibox.container.margin(s.mytaglistt, 4, 7),"#567197"),
          arrowr("#567197","#365177"),
          wibox.container.background(wibox.container.margin(s.mytaglistn, 4, 7),"#365177"),
          arrowr("#365177","#163157"),
          wibox.container.background(wibox.container.margin(s.mytaglists, 4, 7),"#163157"),
          arrowr("#163157", theme.bg_normal),
        },
        s.mytasklist
      }
    }
end

return theme
