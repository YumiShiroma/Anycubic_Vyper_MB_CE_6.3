# Changelog

## Unreleased

* Restored stock Vyper CE settings (CE 6.2 behavior) for a stock machine.

* Revert the machine-specific CE 6.3.0 customizations of the repo author's
printer and restore the stock Anycubic Vyper CE defaults as shipped in
CE 6.2.2, for a stock Vyper.

| Setting | CE 6.3 parent `3638f86` | Stock CE 6.2 |
| --- | --- | --- |
| Motion variant | `LA_JD_IS` | `LA_JD_IS` |
| X direction inversion | `true` | `false` |
| X/Y/Z/E steps/mm | `100/100/400/689` | `80/100/400/420` |
| Print / travel acceleration (mm/s²) | `2500/2500` | `3000/5000` |
| Bilinear mesh | 4×4 | 7×7 |
| Probe margin | Base 35 mm with left/right 35/35 and front/back 50/51 mm | 10 mm on each side |
| Z slow speed (mm/min) | `30` | `Z_PROBE_FEEDRATE_FAST / 2` (which is `30`) - put back Marlin def instead of the hardcoded value |
| Probe tare delay (ms) | `500` | `200` |
| Probe deploy / between points / between samples (mm) | `10/5/5` | `5/2/2` |
| Runout sensor | Disabled | Enabled, `PA5` |
| Adaptive part cooling fan slowdown | Disabled | Enabled, equivalent to the CE 6.2 FSD build |
| G26 hotend / bed defaults (°C) | `230/75` | `210/60` |
| PETG preheat hotend / bed (°C) | `215/75` | `240/85` |
| LCD status timeout (ms) | `60000` | `15000` |
| DGUS boot timeout (ms) | `3000` | `4000` |
| All-metal hotend option | Enabled | Enabled |


## 6.3.1 — 2026-10-23

Maintenance release. The EEPROM layout is unchanged from 6.3.0, so settings made
with 6.3.0 are kept.

### Fixed

* The "SD card error" popup stayed on screen after the card was reinserted.
  A successful mount now dismisses it and opens the file list.
* The "Media Init Fail" status message was not cleared after a successful
  mount.
* A media error reported after the card was already removed (detect-pin bounce)
  no longer opens a pointless popup.
* `setstatusmessagePGM(nullptr)` in the host-confirmation cancel path called
  `strlen(NULL)` and could hard-fault the board.

### Changed

* One automatic remount retry after a failed SD initialization, for slow or
  marginal cards.

### Build and documentation

* `scripts/build_all.sh` builds one or all 14 variants, checks the flash budget
  and copies the images to `dist/`.
* GitHub Actions builds every variant on push and pull request.
* `Dockerfile` and an updated devcontainer for a reproducible toolchain.
* `docs/TESTING.md` checklist, bug report form and PR template.
* README: troubleshooting, build instructions and licensing notes.

## 6.3.0 — 2026-10-12

* Ported the Vyper CE 6.2.2 customizations to Marlin 2.1.2.9.
* Kept the complete CE 6.2.2 feature set and the DGUS protocol
  (`EXPECTED_UI_VERSION_MAJOR = 622`).
* `EEPROM_VERSION` is `V89`: the first boot after flashing resets the EEPROM.
* Added machine-specific defaults for the author's printer (probing margins,
  disabled runout sensor, direct-drive steps, silicone bed mounts).
