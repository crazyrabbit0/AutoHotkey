# AGENTS.md

Personal AutoHotkey **v2** scripts for Windows, public on GitHub (`crazyrabbit0/AutoHotkey`, branch `main`). No build, no tests; `README.md` lists every script.

## Layout

- Root: `Main.ahk` (daily entry point) and reusable modules it `#Include`s (`Multimedia`, `Text Case`, `Prevent Idle`, `Run as Administrator`, `Custom Volume`, ...). `Main - Fatsoula.ahk` is a second entry point for another PC.
- `Games/`: per-game remaps scoped with `#HotIf WinActive("ahk_exe ...")`.
- `System/`: standalone diagnostics, plus third-party `ScriptGuard1.ahk` (TAC109; leave it unmodified).
- `Patches/`: Ahk2Exe packer/runner kept for reference; their `#Include` paths assume a different layout, so `/Validate` fails on them by design.

## Conventions

- AutoHotkey v2 syntax only (`Send "..."`, `Hotkey(...)`, `Gui(...)`); no `#Requires` lines today.
- Sections are banner comments: `;###...### Run|Includes|Variables|Hotkeys|Functions ###`, sub-sections `;~~~ Name ~~~`.
- `snake_case` functions and variables; hotkeys wrapped in `#HotIf` blocks ending with a bare `#HotIf`.
- Indentation is tabs in older files and spaces in newer ones; keep each file's own.
- Personal paths come from the `%CR%` environment variable (`EnvGet("cr")`).

## Checking a change

- Syntax-check with the installed interpreter (2.0.31 at `C:\CR\Programs\Portables\AutoHotkey\AutoHotkey64.exe`): `AutoHotkey64.exe /ErrorStdOut /Validate "<script>"` exits 0 when it loads. Run it on every changed file and on `Main.ahk`, since modules are included there.
- Behaviour needs a manual run on Windows; nothing here is testable headless.

## Commits

Conventional Commits with a module scope, e.g. `feat(mouse): ...`, `fix(multimedia): ...`, `docs: ...`. Update the README table when a script is added, removed or changes purpose. Files are LF (`.gitattributes`).

Contributor-facing rules live in `CONTRIBUTING.md` and `.github/pull_request_template.md`; keep them in step with this file.
