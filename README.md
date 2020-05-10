# urxvt-fork-cwd
Hook to open new terminal instances to the same dir as a focused bash term

## Prerequisites
The script as-is is tailored towards urxvt bash users. You're free to tailor the script to suit your needs.

### Dependencies
```
urxvt
bash
pstree
pgrep
grep
tail
readlink
xdpyinfo
xprop
```

## Install
Add the script as a keybinding to your WM or the like. In my case for i3, I have:

```
bindsym $mod+Return exec --no-startup-id ~/.config/i3/urxvt-fork-cwd.sh
```
