"""Compile the actual adapter methods with host dependencies substituted.

This exercises appearance and scrolling decisions, not UIKit/WeChat rendering.
An optional source path allows running the regression against the old adapter.
"""
from pathlib import Path
import sys

root = Path(__file__).resolve().parent.parent
source = Path(sys.argv[2]) if len(sys.argv) > 2 else root / "Controllers/CSGroupListAdapter.m"
text = source.read_text()
methods = []
for marker in [
    "+ (instancetype)adapterForTable:", "+ (instancetype)adapterForController:",
    "+ (void)attachToController:", "- (void)requestRefresh",
    "- (BOOL)hasScrollableContent", "- (BOOL)canRestoreAnchor",
    "- (void)saveAnchor", "- (void)restoreAnchor",
]:
    start = text.find(marker)
    if start < 0:
        assert marker in ["- (BOOL)hasScrollableContent", "- (BOOL)canRestoreAnchor"]
        continue
    brace = text.index("{", start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == "{":
            depth += 1
        elif text[end] == "}":
            depth -= 1
            if depth == 0:
                methods.append(text[start:end + 1])
                break
    else:
        raise AssertionError(marker)
Path(sys.argv[1]).write_text("\n\n".join(methods) + "\n")
