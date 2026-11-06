# Contributing

Thanks for helping out. Bug reports and ideas go in [issues](https://github.com/crazyrabbit0/AutoHotkey/issues/new/choose); fixes and new scripts go in pull requests.

## Pull requests

1. Keep each pull request to one script or one change.
2. Use AutoHotkey v2 syntax, keep the `;### Section ###` banners and `snake_case` names, and keep each file's existing indentation.
3. Run `AutoHotkey64.exe /ErrorStdOut /Validate "<script>.ahk"` on every changed script (and on `Main.ahk` if you changed a module it includes); it must exit with code 0.
4. Update the table in the [README](README.md) when you add or remove a script or change what one does.
5. Describe how you tested it, including your Windows version.

These are personal AutoHotkey v2 scripts that change real systems, so explain anything that edits the registry, services, files or permissions.

## License

By contributing you agree that your changes are licensed under [GPL-3.0](LICENSE).
