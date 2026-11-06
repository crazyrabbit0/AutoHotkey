# AutoHotkey

Personal [AutoHotkey v2](https://www.autohotkey.com/) scripts for Windows: media keys, a custom volume overlay, brightness, text case, idle prevention, game key remaps and a few system helpers.

## Usage

1. Install [AutoHotkey v2](https://www.autohotkey.com/download/) (the scripts use v2 syntax and do not run on v1).
2. Clone or download this repository.
3. Run `Main.ahk`. It includes the modules it needs; the other scripts can also be run on their own.

To start with Windows, put a shortcut to `Main.ahk` in `shell:startup`.

## Scripts

| Script | What it does |
|---|---|
| `Main.ahk` | Entry point: runs as administrator, includes `Multimedia`, `Text Case` and `Prevent Idle`, and adds reload/pause/suspend hotkeys plus a few shortcuts. |
| `Main - Fatsoula.ahk` | A lighter entry point for another PC: `Multimedia` and `Mouse Volume` only. |
| `Multimedia.ahk` | Media keys and `Ctrl+Alt+Shift` arrows control the window under the mouse, with per-app handling for YouTube, Stremio and PotPlayer. |
| `Custom Volume.ahk` | Replaces the Windows volume flyout with a large on-screen percentage. |
| `Mouse Volume.ahk` | Volume with the mouse wheel while holding a button: left button changes the volume, right button mutes or unmutes. |
| `Headphones.ahk` | Starts Audio Repeater when Bluetooth headphones connect and keeps their volume in step with a virtual cable. |
| `Brightness.ahk` | `set_brightness()` helper that sets the display brightness through WMI. |
| `Text Case.ahk` | `Ctrl+Alt+1/2/3` converts the selected text to Title, lower or UPPER case. |
| `Prevent Idle.ahk` | `prevent_idle()` keeps the PC awake during chosen days and hours. |
| `Run as Administrator.ahk` | Include it to relaunch the including script elevated. |
| `Games/Darksiders III.ahk` | Numpad `.` toggles an auto-repeating side mouse button. |
| `Games/Lost In Random.ahk` | Keyboard and mouse remaps for the game. |
| `System/Process List.ahk` | Lists running processes with their command lines. |
| `System/Sound Components.ahk` | Lists every audio device and component with its volume and mute state. |
| `System/ScriptGuard1.ahk` | Third-party helper by TAC109 that hides the source of compiled scripts. |
| `Patches/Patch Packer.ahk`, `Patches/Patch Runner.ahk` | Wrap a patcher executable into a compiled AutoHotkey launcher. They need `Ahk2Exe`, `BinMod` and `ScriptGuard1.ahk` next to them, add a Windows Defender exclusion for `%TEMP%`, and are kept for reference. |

Some scripts expect personal paths such as `%CR%\Programs\Portables\...`; adjust them for your setup.

## Issues

Found a bug or have an idea? [Open an issue](https://github.com/crazyrabbit0/AutoHotkey/issues/new/choose).

## License

[GPL-3.0](LICENSE) © CrazyRabbit
