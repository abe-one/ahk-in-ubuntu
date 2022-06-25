#!/bin/bash

# Clearing the default mods and keeping Super and Hyper separate
# because mod3 (4?) interacts unexpectedly with firefox because (?) of the distro it's based on.
xmodmap -e "clear mod4"
xmodmap -e "clear mod3"
xmodmap -e "add mod4 = Super_L"
xmodmap -e "add mod3 = Hyper_L"

# Setting CapLock key as Mode_switch (previously disabled through mint/ubuntu keyboard settings)
xmodmap -e "keycode 66 = Mode_switch"

# Setting the Mode_switch outputs for Dvorak comfy navigation
xmodmap -e "keycode 46 = n N Right Right"
xmodmap -e "keycode 44 = h H Left Left"
xmodmap -e "keycode 45 = t T Up Up"
xmodmap -e "keycode 59 = w W Down Down"
xmodmap -e "keycode 33 = l L End End"
xmodmap -e "keycode 30 = g G Home Home"
xmodmap -e "keycode 43 = d D Delete Delete"


# Setting s as comfy Shift (Lock)
xmodmap -e "clear shift"
xmodmap -e "keycode 47 = s S Shift_Lock Shift_Lock"
# Setting right shift as Shift Lock in case 's' based Shift Lock fails
xmodmap -e "keycode 62 = Shift_Lock Shift_Lock Shift_Lock Shift_Lock"
# Binding shift modifier to relevant keys
xmodmap -e "add shift = Shift_L"
xmodmap -e "add shift = Shift_R"
xmodmap -e "add shift =  Shift_Lock"

# Swapping Left Control and Left Alt
xmodmap -e "clear control"
xmodmap -e "clear mod1"
xmodmap -e "keycode 64 = Control_L Control_L Control_L Control_L"
xmodmap -e "keycode 37 = Alt_L Alt_L Alt_L Alt_L"
xmodmap -e "add control = Control_R"
xmodmap -e "add control = Control_L"
xmodmap -e "add mod1 = Alt_R"
xmodmap -e "add mod1 = Alt_L"


# Grepping the first actual keyboard id, not hardcoded for personal reason
kBoardId=$(xinput list | grep -m 1 -P '^((?![Xx][Tt][Ee][Ss][Tt]).)*\s*[kK]eyboard\s*id=[0-9]*\s*\[slave\s*keyboard' | grep -oP '(?<=id=)[0-9]*')

# Final command reading keyboard inputs and
# If CapsLock key is released while Shift Lock is enabled
# Then disable Shift Lock
xinput test $kBoardId | while read in ; do [[ $in = "key release 66" ]] && if [[ $(xset -q ) =~ "Shift Lock:  on" ]]; then xdotool key Shift_Lock; fi; done
