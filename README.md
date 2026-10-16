# Auto Sort Inventory (Baldur's Gate 3)

Keeps character inventories and containers sorted automatically. Whenever items are added or removed, the game's own Sort runs with the option you picked from that window's **Sort** button (Type, Value, Weight, …).

- Keyboard & mouse UI only (no controller / Steam Deck layout yet)
- UI-only and save-safe: no scripts, items or data added to your save
- No Script Extender needed

## Install

Download the zip from [Releases](../../releases) and drag it into [BG3 Mod Manager](https://github.com/LaughingLeader/BG3ModManager/releases), or extract `AutoSortInventory.pak` into `%LOCALAPPDATA%\Larian Studios\Baldur's Gate 3\Mods`. Activate it and save the load order.

## How it works

The mod overrides three of the game's keyboard UI XAML files under `mod/AutoSortInventory/Mods/AutoSortInventory/GUI/`:

- `Pages/Container.xaml` – container window with auto-sort
- `Library/Lib_Keyboard.xaml` – character inventory template with auto-sort
- `StateMachines/Keyboard.xaml` – overrides the `ContainerInventory` state so it loads this mod's `Container.xaml`

## Building

Requires [LSLib](https://github.com/Norbyte/lslib/releases) (ExportTool). Extract it so that `tools/lslib/Packed/Tools/Divine.exe` exists, then:

```powershell
.\build.ps1            # dist/AutoSortInventory.pak
.\build.ps1 -Install   # also copy into the game's Mods folder
.\build.ps1 -Release   # also build dist/AutoSortInventory-<version>.zip for BG3 Mod Manager
```

Bump `Version64` in `meta.lsx` before a release (`major<<55 | minor<<47 | revision<<31 | build`).

## Known limitations

- Newly picked-up items briefly appear in the last slot before being sorted.
- The chosen sort option isn't saved across loads; it goes back to the default after loading a save.
- The party inventory screen's Sort button doesn't change the auto-sort option.
- You can't keep a manual arrangement while the mod is active.
- Multiplayer is untested.

## License

MIT for this mod's own changes and tooling; see [LICENSE](LICENSE). The overridden XAML files are based on Larian Studios' Baldur's Gate 3 UI, which remains theirs.
