# Contributing

This is a community fork of the Anycubic Vyper CE firmware. Bug reports and
test results are more useful than large refactors, but pull requests are
welcome.

## Before opening an issue

1. Read [docs/TESTING.md](docs/TESTING.md) and the troubleshooting section of
   the [README](README.md#troubleshooting).
2. Reproduce the problem on the latest `main`.
3. Collect: firmware version (`M115`), build variant, LCD firmware version,
   machine modifications, and the steps to reproduce.

## Pull requests

* Keep changes focused; one logical change per PR.
* Match the style of the surrounding Marlin code.
* Build the affected variant(s) locally or let CI do it:

  ```bash
  scripts/build_all.sh LA_JD_IS
  ```

* If the change affects the display protocol, state which LCD firmware version
  you tested with. The LCD firmware is intentionally kept at CE 6.2.2 and
  `EXPECTED_UI_VERSION_MAJOR` must stay `622`.
* Do not commit build output (`.pio/`, `dist/`) or binaries.

## License

By contributing you agree that your changes are released under the same
GPLv3 license as Marlin and the rest of this repository.
