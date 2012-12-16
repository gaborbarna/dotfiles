-- default rc.lua for shifty
--
-- Standard awesome library
require("awful")
require("awful.autofocus")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- shifty - dynamic tagging library
require("shifty")

vicious = require("vicious")

-- useful for debugging, marks the beginning of rc.lua exec
print("Entered rc.lua: " .. os.time())

-- Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
theme_path = "/home/lesbroot/.config/awesome/themes/solarized/theme.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
browser = "firefox"
terminal = "urxvt"
mail = terminal .. " -e mutt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
rtorrent = terminal .. " -e rtorrent"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key, I suggest you to remap
-- Mod4 to another key using xmodmap or other tools.  However, you can use
-- another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false

-- Shifty configured tags.
shifty.config.tags = {
    ["1"] = {
        layout    = awful.layout.suit.tile,
        mwfact    = 0.60,
        exclusive = false,
        position  = 1,
        init      = true,
        --screen    = 1,
    },
    ["2:www"] = {
        layout      = awful.layout.suit.max,
        mwfact      = 0.65,
        exclusive   = true,
        max_clients = 1,
        position    = 2,
        init        = true,
    },
    ["3"] = {
        position  = 3,
        init      = true,
    },
    ["4:media"] = {
        layout    = awful.layout.suit.tile,
        mwfact    = 0.50,
        exclusive = false,
        position  = 4,
        init      = true,
    },
    ["5"] = {
        position  = 5,
        init      = true,
    },
    ["6"] = {
        position  = 6,
        init      = true,
    },
    ["7"] = {
        position  = 7,
        init      = true,
    },
    ["8"] = {
        position  = 8,
        init      = true,
    },
    ["9"] = {
        position  = 9,
        init      = true,
    },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
    {
        match = {
            "Navigator",
            "Vimperator",
            "Pentadactyl",
            "Gran Paradiso",
        },
        tag = "2:www",
    },
    {
        match = {
            "Mplayer.*",
        },
        tag = "4:media",
        nopopup = true,
    },
    {
        match = {
            "MPlayer",
        },
        float = true,
    },
    {
        match = {
            terminal,
        },
        honorsizehints = false,
        slave = true,
    },
    {
        match = {""},
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c) client.focus = c; c:raise() end),
            awful.button({modkey}, 1, function(c)
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
                end),
            awful.button({modkey}, 3, awful.mouse.client.resize)
            )
    },
}

-- SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : should shifty try and guess tag names when creating
--                 new (unconfigured) tags?
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
    layout = awful.layout.suit.tile,
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    exclusive = false,
    guess_name = true,
    guess_position = true,
}

-- {{{ Reusable separator
separator = widget({ type = "imagebox" })
separator.image = image(beautiful.widget_sep)

spacer = widget({ type = "textbox" })
spacer.width = 3
-- }}}

---- ALSA volume widget
alsa_channel = "Master"
alsa_step = "5%"
alsa_color_unmute = "#657b83"
alsa_color_mute = "#657b83"
alsa_mixer = terminal .. " -e alsamixer" -- or whatever your preferred sound mixer is
-- create widget
alsawidget = awful.widget.progressbar()
alsawidget:set_width(8)
alsawidget:set_vertical(true)
alsawidget:set_background_color("#002A35")
alsawidget:set_color("#657b83")

-- create tooltip
alsawidget_tip = awful.tooltip({ objects = { alsawidget.widget }})
vicious.register(alsawidget, vicious.widgets.volume, function (widget, args)
    widget:set_gradient_colors({ alsa_color_unmute, alsa_color_unmute, alsa_color_unmute })
    alsawidget_tip:set_text(" " .. alsa_channel .. ": " .. args[1] .. "% ")
    return args[1]
end, 1, alsa_channel) -- relatively high update time, use of keys/mouse will force update


--- {{{ Memory usage
memtext_format = "$2MiB/$3MiB " -- %1 percentage, %2 used %3 total %4 free
-- icon
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)

-- mem text output
memtext = widget({ type = "textbox" })
vicious.register(memtext, vicious.widgets.mem, memtext_format, 13)
-- }}}


-- {{{ CPU usage
-- Initialize widget
cpuwidget = awful.widget.graph()
-- Graph properties
cpuwidget:set_width(50)
cpuwidget:set_background_color("#002A35")
cpuwidget:set_color("#FF5656")
cpuwidget:set_gradient_colors({ "#657b83", "#657b83" })
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")
--- }}}

--  Wibox
-- Create a textbox widget
mytextclock = awful.widget.textclock({align = "right"})

-- Create a laucher widget and a main menu
myawesomemenu = {
    {"manual", terminal .. " -e man awesome"},
    {"edit config",
     editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"},
    {"restart", awesome.restart},
    {"quit", awesome.quit}
}

mymainmenu = awful.menu(
    {
        items = {
            {"awesome", myawesomemenu, beautiful.awesome_icon},
              {"open terminal", terminal}}
          })

mylauncher = awful.widget.launcher({image = image(beautiful.awesome_icon),
                                     menu = mymainmenu})

-- Create a systray
mysystray = widget({type = "systray", align = "right"})

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({}, 1, awful.tag.viewonly),
    awful.button({modkey}, 1, awful.client.movetotag),
    awful.button({}, 3, function(tag) tag.selected = not tag.selected end),
    awful.button({modkey}, 3, awful.client.toggletag),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
    )

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({}, 1, function(c)
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        client.focus = c
        c:raise()
        end),
    awful.button({}, 3, function()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({width=250})
        end
        end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
        end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
        end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] =
        awful.widget.prompt({layout = awful.widget.layout.leftright})
    -- Create an imagebox widget which will contains an icon indicating which
    -- layout we're using.  We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
            awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
            awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s,
                                            awful.widget.taglist.label.all,
                                            mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                        return awful.widget.tasklist.label.currenttags(c, s)
                    end,
                                              mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({position = "top", screen = s})
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        spacer,
        memtext,
        spacer,
        spacer,
        cpuwidget.widget,
        spacer,
        alsawidget.widget,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
        }

    mywibox[s].screen = s
end

-- SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()

-- Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({}, 3, function() mymainmenu:show({keygrabber=true}) end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))

-- This function is for awesome versions prior to 3.4

dropdown = {}

function dropdown_toggle(prog, height, s)
   if s == nil then s = mouse.screen end
   if height == nil then height = 0.2 end
   
   if not dropdown[prog] then
      -- Create table
      dropdown[prog] = {}
      
      -- Add unmanage hook for dropdown programs
      awful.hooks.unmanage.register(function (c)
                                       for scr, cl in pairs(dropdown[prog]) do
                                          if cl == c then
                                             dropdown[prog][scr] = nil
                                          end
                                       end
                                    end)
   end
   
   if not dropdown[prog][s] then
      spawnw = function (c)
                  -- Store client
                  dropdown[prog][s] = c
                  
                  -- Float client
                  awful.client.floating.set(c, true)
                  
                  -- Get screen geometry
                  screengeom = screen[s].workarea
                  
                  -- Calculate height
                  if height < 1 then
                     height = screengeom.height*height
                  end

                  -- I like a different border with for the popup window
                  -- So I don't confuse it with terminals in the layout
                  bw = 2

                  -- Resize client
                  c:geometry({
                                x = screengeom.x,
                                y = screengeom.y - 1000,
                                width = screengeom.width - bw, 
                                height = height - bw
                             })

                  -- Mark terminal as ontop
                  --            c.ontop = true
                  --            c.above = true
                  c.border_width = bw

                  -- Focus and raise client
                  c:raise()
                  client.focus = c

                  -- Remove hook
                  awful.hooks.manage.unregister(spawnw)
               end

      -- Add hook
      awful.hooks.manage.register(spawnw)

      -- Spawn program
      awful.util.spawn(prog)

      dropdown.currtag = awful.tag.selected(s)
   else
      -- Get client
      c = dropdown[prog][s]
      
      -- Switch the client to the current workspace

      -- Focus and raise if not hidden
      if c.hidden then
         awful.client.movetotag(awful.tag.selected(s), c)
         c.hidden = false
         c:raise()
         client.focus = c
      else
         if awful.tag.selected(s) == dropdown.currtag then
            c.hidden = true
            local ctags = c:tags()
            for i, t in pairs(ctags) do
               ctags[i] = nil
            end
            c:tags(ctags)
         else
            awful.client.movetotag(awful.tag.selected(s), c)
            c:raise()
            client.focus = c
         end
      end
      dropdown.currtag = awful.tag.selected(s)
   end
end


dropdown_toggled = false
-- Key bindings
globalkeys = awful.util.table.join(
    awful.key({modkey,}, "`",
    function()
        if dropdown_toggled == false then
           dropdown_toggled = true
           dropdown_toggle("urxvt", 0.2, 1)
        else
           dropdown_toggled = false
           dropdown_toggle("urxvt", 0.0, 1)
        end
    end),
    awful.key({modkey, "Shift"}, "s",
    function()
        dropdown_toggle("urxvt", 0.0, 1)
    end),
    
    awful.key({modkey,}, "Left", awful.tag.viewprev),
    awful.key({modkey,}, "Right", awful.tag.viewnext),
    awful.key({modkey,}, "Escape", awful.tag.history.restore),

    -- Shifty: keybindings specific to shifty
    awful.key({modkey}, "d", shifty.del), -- delete a tag
    awful.key({modkey, "Shift"}, "n", shifty.send_prev), -- client to prev tag
    awful.key({modkey}, "n", shifty.send_next), -- client to next tag
    awful.key({modkey, "Control"},
              "n",
              function()
                  local t = awful.tag.selected()
                  local s = awful.util.cycle(screen.count(), t.screen + 1)
                  awful.tag.history.restore()
                  t = shifty.tagtoscr(s, t)
                  awful.tag.viewonly(t)
              end),
    awful.key({modkey}, "a", shifty.add), -- creat a new tag
    awful.key({modkey,}, "F1", shifty.rename), -- rename a tag
    awful.key({modkey, "Shift"}, "a", -- nopopup new tag
    function()
        shifty.add({nopopup = true})
    end),

    awful.key({modkey,}, "j",
    function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "k",
    function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "w", function() mymainmenu:show(true) end),

    -- Layout manipulation
    awful.key({modkey, "Shift"}, "j",
        function() awful.client.swap.byidx(1) end),
    awful.key({modkey, "Shift"}, "k",
        function() awful.client.swap.byidx(-1) end),
    awful.key({modkey, "Control"}, "j", function() awful.screen.focus(1) end),
    awful.key({modkey, "Control"}, "k", function() awful.screen.focus(-1) end),
    awful.key({modkey,}, "u", awful.client.urgent.jumpto),
    awful.key({modkey,}, "Tab",
    function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end),

    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),

    -- Standard program
    awful.key({modkey,}, "Return", function() awful.util.spawn(terminal) end),
    awful.key({modkey, "Control"}, "r", awesome.restart),
    awful.key({modkey, "Shift"}, "q", awesome.quit),

    awful.key({modkey,}, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({modkey,}, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1) end),
    awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1) end),
    awful.key({modkey, "Control"}, "h", function() awful.tag.incncol(1) end),
    awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1) end),
    awful.key({modkey,}, "space", function() awful.layout.inc(layouts, 1) end),
    awful.key({modkey, "Shift"}, "space",
        function() awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({modkey}, "r", function()
        awful.prompt.run({prompt = "Run: "},
        mypromptbox[mouse.screen].widget,
        awful.util.spawn, awful.completion.shell,
        awful.util.getdir("cache") .. "/history")
        end),

    awful.key({modkey}, "F4", function()
        awful.prompt.run({prompt = "Run Lua code: "},
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
        end)
    )

-- Client awful tagging: this is useful to tag some clients and then do stuff
-- like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({modkey,}, "f", function(c) c.fullscreen = not c.fullscreen  end),
    awful.key({modkey, "Shift"}, "c", function(c) c:kill() end),
    awful.key({modkey, "Control"}, "space", awful.client.floating.toggle),
    awful.key({modkey, "Control"}, "Return",
        function(c) c:swap(awful.client.getmaster()) end),
    awful.key({modkey,}, "o", awful.client.movetoscreen),
    awful.key({modkey, "Shift"}, "r", function(c) c:redraw() end),
    awful.key({modkey}, "t", awful.client.togglemarked),
    awful.key({modkey,}, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({modkey}, i, function()
            local t =  awful.tag.viewonly(shifty.getpos(i))
            end),
        awful.key({modkey, "Control"}, i, function()
            local t = shifty.getpos(i)
            t.selected = not t.selected
            end),
        awful.key({modkey, "Control", "Shift"}, i, function()
            if client.focus then
                awful.client.toggletag(shifty.getpos(i))
            end
            end),
        -- move clients to other tags
        awful.key({modkey, "Shift"}, i, function()
            if client.focus then
                t = shifty.getpos(i)
                awful.client.movetotag(t)
                awful.tag.viewonly(t)
            end
        end))
    end

-- Set keys
root.keys(globalkeys)

-- Hook function to execute when focusing a client.
client.add_signal("focus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)
