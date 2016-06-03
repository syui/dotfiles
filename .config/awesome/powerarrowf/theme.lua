---------------------------
-- Default awesome theme --
---------------------------

theme = {}


-- Setup Paths 
pathToConfig = os.getenv("HOME") .. "/.config/awesome/"


--if not awful.util.file_readable(pathToConfig .. "/icons/awesome.png") then
--    shared    = "/usr/share/local/awesome"
--end

theme.font          = "sans 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#1E2320"
theme.bg_urgent     = "#3F3F3F"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#AAAAAA"
theme.fg_urgent     = "#3F3F3F"
theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
--theme.taglist_squares_sel   = pathToConfig .. "powerarrowf/icons/square_sel.png"
--theme.taglist_squares_unsel = pathToConfig .. "powerarrowf/icons/square_unsel.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100
-- Origin {{{
theme.fg_normal                     = "#DDDDFF"
theme.fg_focus                      = "#F0DFAF"

theme.fg_urgent                     = "#CC9393"
theme.bg_normal                     = "#1A1A1A"
theme.bg_focus                      = "#8A0808"
theme.bg_urgent                     = "#1A1A1A"
theme.border_width                  = "2"
theme.border_normal                 = "#3F3F3F"
theme.border_focus                  = "#0B3861"
theme.border_marked                 = "#CC9393"
theme.titlebar_bg_focus             = "#FFFFFF"
theme.titlebar_bg_normal            = "#FFFFFF"
theme.tasklist_bg_focus             = "#0B3861"
theme.tasklist_fg_focus             = "#D8D782"

theme.textbox_widget_margin_top     = 1
theme.notify_fg                     = theme.fg_normal
theme.notify_bg                     = theme.bg_normal
theme.notify_border                 = theme.border_focus
theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 2
theme.mouse_finder_color            = "#CC9393"
theme.menu_height                   = "16"
theme.menu_width                    = "140"
-- }}}




-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

theme.wallpaper = pathToConfig .. "powerarrowf/darkwood.png"

-- You can use your own layout icons like this:
theme.layout_floating  = pathToConfig .. "powerarrowf/layouts/awesome.png"
theme.layout_tilebottom = pathToConfig  .. "powerarrowf/layouts/tilebottom.png"
theme.layout_tileleft   = pathToConfig .. "powerarrowf/layouts/tileleft.png"
theme.layout_tile = pathToConfig .. "powerarrowf/layouts/tile.png"
theme.layout_tiletop = pathToConfig .. "powerarrowf/layouts/tiletop.png"

theme.layout_fairh = pathToConfig .. "powerarrowf/layouts/fairvw.png"
theme.layout_fairv = pathToConfig .. "powerarrowf/layouts/awesome.png"
theme.layout_magnifier = pathToConfig .. "powerarrowf/layout/magnifierw.png"
--theme.layout_max = pathToConfig .. "powerarrowf/layout/awesome.png"
theme.layout_fullscreen = pathToConfig .. "powerarrowf/layouts/window.png"
theme.layout_spiral  = pathToConfig .. "powerarrowf/layouts/fullscreenw.png"
theme.layout_dwindle = pathToConfig .. "powerarrowf/layouts/magnifierw.png"
--theme.awesome_icon = pathToConfig .. "powerarrowf/layout/awesome.png"

--{{ For the Dark Theme }} --

theme.arrl = pathToConfig .. "powerarrowf/icons/arrl.png"
theme.arrl_ld = pathToConfig .. "powerarrowf/icons/arrl_ld.png"
theme.arrl_dl = pathToConfig .. "powerarrowf/icons/arrl_dl.png"

--{{ For the time and date clock icon }} --
theme.clock = "/usr/share/icons/Numix/24x24/emblems/emblem-urgent.svg"

--{{ For the wifi icon }} --
theme.netlow = "/usr/share/icons/Numix/24x24/status/gnome-netstatus-50-74.svg"
theme.netmed = "/usr/share/icons/Numix/24x24/status/network-error.svg"
theme.nethigh = "/usr/share/icons/Numix/24x24/status/gnome-netstatus-75-100.svg"

--{{ For the charging (AC adaptor) icon }} --
theme.ac = "/usr/share/icons/Numix/24x24/status/battery-100-charging.svg"

--{{ For the hard drive icon }} --
theme.hdd = "/usr/share/icons/Numix/64x64/devices/drive-harddisk.svg"

--{{ For the volume icons }} --
theme.mute = "/usr/share/icons/Numix/24x24/status/audio-volume-muted-blocking-panel.svg"
theme.music = "/usr/share/icons/Numix/24x24/status/audio-volume-high-panel.svg"

--{{ For the CPU icon }} --
theme.cpu = "/usr/share/icons/Numix/24x24/status/indicator-cpufreq-100.svg"

--{{ For the Memory icon }} --
theme.mem = "/usr/share/icons/Numix/24x24/status/syspeek-50.svg"

--{{ For the mail icons }} --
theme.mail = pathToConfig .. "powerarrowf/icons/mail.png"
theme.mailopen = pathToConfig .. "powerarrowf/icons/mailopen.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = pathToConfig .. "powerarrowf/icons/awesome.png"
theme.awesome_icon = pathToConfig .. "/awesome.png"

return theme
