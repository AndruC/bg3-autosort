# Nexus upload checklist: Auto Sort Inventory 1.0.0

## Files
- Main file: `dist/AutoSortInventory-1.0.0.0.zip` (contains `AutoSortInventory.pak` + `info.json`)
- Rebuild with `.\build.ps1 -Release` after any change; bump `Version64` in `meta.lsx` first
  (1.0.1 = 36028797018963968 + 2147483648 = 36028799166447616; formula: major<<55 | minor<<47 | revision<<31 | build)

## Mod page fields
- **Name:** Auto Sort Inventory
- **Category:** User Interface
- **Version:** 1.0.0
- **Brief overview (≤350 chars):**
  Keeps character inventories and containers sorted automatically. Whenever items are added or removed, the game's own Sort runs with the option you picked (Type, Value, Weight…). Keyboard & mouse UI, save-safe, no Script Extender needed.
- **Description:** paste `nexus/description.bbcode`
- **Requirements:** none (mention BG3 Mod Manager as recommended tool)
- **Tags:** User Interface, Inventory, Quality of Life

## Images
- Header: `nexus/art/header.png` (1300×372, Nexus's required size; rendered at 2x scale and downscaled so emoji keep the 3D style)
- Primary image: `nexus/art/primary.png` (1920×1080)
- Source: `nexus/art/art.html` (re-render with headless Edge, `?mode=header` / `?mode=primary`)

## Before uploading
- [ ] Screenshots: inventory sorted by Type, then by Weight or Value; a container sorted with empty slots at the end
- [ ] Decide permissions (Nexus permissions tab)
- [x] Author name: AndruC (in `meta.lsx` and `info.json`)
- [ ] Optional: test multiplayer and update the Known limitations section
