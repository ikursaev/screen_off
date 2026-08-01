# screen_off

A tiny [AutoHotkey v2](https://www.autohotkey.com/) script that turns the monitor off on demand — useful when you want the screen dark but the machine still running.

## Usage

1. Install AutoHotkey v2.0 or later.
2. Run `screen_off.ahk`.

Then turn the screen off either way:

- Press **Win+Shift+M**
- Single left-click the tray icon (or pick **Screen off** from its menu)

Move the mouse or press a key to wake the display again. **Exit** in the tray menu quits the script.

## How it works

It broadcasts a `WM_SYSCOMMAND` / `SC_MONITORPOWER` message with the "off" parameter to all top-level windows. Before sending, it waits for `Win` and `Shift` to be released, so the key-up event doesn't immediately wake the display back up.

## Autostart

To run it at login, put a shortcut to `screen_off.ahk` in your Startup folder:

```
Win+R → shell:startup
```
