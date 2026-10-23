# Testing checklist

Use this list when testing a new build. You do not need to do everything on
every run, but please report which items you covered.

## Before flashing

- [ ] Built from the commit you intend to test (`git log -1`)
- [ ] Build variant matches the machine (for a stock Vyper: `LA_JD_IS` or `CJ_IS`)
- [ ] LCD firmware is CE 6.2.2 (expected UI version `622`)
- [ ] Only one `main_board_*.bin` is present in the SD card root
- [ ] EEPROM backup: note the current `M503` output

## Boot and UI

- [ ] Boot screen shows the expected version string
- [ ] Main screen: temperatures, coordinates, status line
- [ ] All touch screens open and the back button works
- [ ] No "UI version mismatch" warning
- [ ] Language, beep and standby settings survive a reboot

## SD card and files

- [ ] Card mounts at boot and the file list opens
- [ ] Long filenames and directories are displayed correctly
- [ ] Removing the card while idle does not leave an error popup
- [ ] Reinserting the card clears any error and reopens the file list
- [ ] Removing the card during a print triggers the expected abort/error
- [ ] Starting, pausing, resuming and aborting a print from SD

## Motion and probing

- [ ] Home X/Y/Z (both Z homing modes, if the firmware offers them)
- [ ] Z offset can be adjusted and is saved (`M500`)
- [ ] Bed mesh runs to completion; record the range
- [ ] First layer over the whole bed
- [ ] Input shaping / linear advance behave as configured (`M593`, `M900`)

## Thermal

- [ ] Hotend and bed heat to target and hold
- [ ] PID autotune (`M303 E0 S240` and `M303 E-1 S75`) finishes and saves
- [ ] Part cooling fan and hotend fan switch correctly
- [ ] Thermal runaway protection stays armed (do not bypass it)

## Filament

- [ ] Load and unload filament from the UI
- [ ] Extruder direction and steps are correct
- [ ] Filament runout behaves as configured (disabled by default on this fork)

## Reporting

Include the firmware version, variant, LCD version, machine modifications,
steps to reproduce, and photos or serial logs. A short video of display bugs
helps a lot.
