(xbindkey '("XF86Sleep") "(i3lock -c 002a35 -u &) && sudo systemctl suspend")
(xbindkey '("XF86AudioRaiseVolume") "amixer set Master 2dB+ unmute")
(xbindkey '("XF86AudioLowerVolume") "amixer set Master 2dB- unmute")
(xbindkey '("XF86AudioMute") "amixer set Master 0 mute")
(xbindkey '("XF86ScreenSaver") "i3lock -c 002a35 -u")
(xbindkey '("XF86Battery") "urxvt -title powertop -e sudo powertop")

