#!/usr/bin/env python3
"""Activate exactly one VYPER_BUILD_* variant in Marlin/Configuration.h."""

import re
import sys
from pathlib import Path

VARIANTS = [
    "CJ",
    "CJ_IS",
    "LA_JD",
    "LA_CJ",
    "LA_JD_IS",
    "LA_CJ_IS",
    "LA_JD_T",
    "LA_CJ_T",
    "LA_JD_IS_T",
    "LA_CJ_IS_T",
    "LA_JD_TE",
    "LA_CJ_TE",
    "LA_JD_IS_TE",
    "LA_CJ_IS_TE",
]

CONFIG = Path(__file__).resolve().parent.parent / "Marlin" / "Configuration.h"


def usage() -> int:
    print(f"usage: {Path(sys.argv[0]).name} <{'|'.join(VARIANTS)}>", file=sys.stderr)
    return 2


def main() -> int:
    if len(sys.argv) != 2 or sys.argv[1] not in VARIANTS:
        return usage()

    chosen = sys.argv[1]
    text = CONFIG.read_text(encoding="utf-8")

    def repl(match: re.Match) -> str:
        token = match.group(1)
        marker = "#define " if token == "VYPER_BUILD_" + chosen else "//#define "
        return marker + token

    text, count = re.subn(
        r"^[ \t]*(?://)?#define[ \t]+(VYPER_BUILD_\w+)",
        repl,
        text,
        flags=re.MULTILINE,
    )
    if count != len(VARIANTS):
        print(
            f"error: found {count} VYPER_BUILD_* lines in {CONFIG}, "
            f"expected {len(VARIANTS)}",
            file=sys.stderr,
        )
        return 1

    CONFIG.write_text(text, encoding="utf-8")
    print(f"Active variant: {chosen}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
