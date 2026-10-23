# Changelog

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
