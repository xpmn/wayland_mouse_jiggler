# Wayland mouse jiggler
Simplest keep-presence alternative for Wayland. Just a tiny bash script

[How it looks - gif screencast](output.gif)

## How to run

```./mouse.sh```

## Running without root

If you get `error: could not open device (Permission denied)`, it's because
`/dev/input/event*` devices are owned by `root:input`. Instead of `sudo`,
install the included udev rule, which grants access to the active logged-in
user only (via `uaccess`):

```
sudo cp 72-mouse-jiggler.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=input
```

Then unplug/replug the mouse (or log out and back in) so the ACL is applied,
and run `./mouse.sh` normally.

## Requirements

You need [evemu](https://www.freedesktop.org/wiki/Evemu/) to run the script. Install it with your package manager: 
`sudo apt install evemu-tools` or `sudo dnf install evemu`
