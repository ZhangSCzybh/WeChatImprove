#!/usr/bin/env python3
"""Validate source hook contracts and export compound-hook presence to host tests."""
from pathlib import Path
import re
import sys

source = Path(sys.argv[1]).read_text()
blocks = re.findall(r"%hook\s+MMTabBarItemView\b(.*?)%end", source, re.S)
if len(blocks) != 1:
    raise SystemExit("Expected exactly one MMTabBarItemView hook block")
methods = dict(re.findall(r"-\s*\(void\)\s*(\w+)\s*\{([^{}]*)\}", blocks[0], re.S))
expected = re.compile(r"\s*CSTabBarBeginItemUpdate\(self\);\s*%orig\s*;\s*CSTabBarEndItemUpdate\(self\);\s*\Z")
for name in ["layoutSubviews", "layoutIcon", "layoutBadgeView", "reloadIconImage"]:
    if not expected.fullmatch(methods.get(name, "")):
        raise SystemExit(f"Host model no longer matches source wrapper: {name}")
has_compound = "relayoutIconAndBadge" in methods
if has_compound and not expected.fullmatch(methods["relayoutIconAndBadge"]):
    raise SystemExit("Host model no longer matches relayoutIconAndBadge wrapper")
Path(sys.argv[2]).write_text(
    "// Generated from Hooks/TabBarStyleHooks.xm; do not hand edit.\n"
    f"#define CS_TEST_SOURCE_RELAYOUT_HOOK {int(has_compound)}\n"
    "#ifndef CS_BADGE_DISABLE_RELAYOUT_HOOK\n#define CS_BADGE_DISABLE_RELAYOUT_HOOK 0\n#endif\n"
)
print(f"tabbar source wrappers verified; relayoutIconAndBadge hook={int(has_compound)}", file=sys.stderr)
