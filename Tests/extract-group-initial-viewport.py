"""Replay production startup/return viewport decisions with isolated host doubles.

The optional adapter path supports running the same regressions against a
different revision. No WeChat defaults, account store, or UIKit service is used.
"""
from pathlib import Path
import re
import sys

root = Path(__file__).resolve().parent.parent
source = (Path(sys.argv[2]) if len(sys.argv) > 2 else root / "Controllers/CSGroupListAdapter.m").read_text()


def method(marker, text=source):
    match = re.search(re.escape(marker) + r"[^;{]*\{", text)
    if not match:
        raise AssertionError(f"Production method not found: {marker}")
    start = match.start()
    brace = text.index("{", start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == "{":
            depth += 1
        elif text[end] == "}":
            depth -= 1
            if depth == 0:
                return text[start:end + 1]
    raise AssertionError(marker)


markers = [
    "+ (instancetype)adapterForController:",
    "+ (void)setPresentationSuspended:",
    "+ (void)finishPresentationReturnForController:",
    "- (void)prepareForNativeSearch",
    "- (BOOL)hasScrollableContent",
    "- (BOOL)canRestoreAnchor",
    "- (NSDictionary *)captureViewportForTabID:",
    "- (BOOL)validViewport:",
    "- (void)clearPendingViewport",
    "- (void)prepareInitialViewport",
    "- (void)cancelInitialViewport",
    "- (void)restoreInitialViewport",
    "- (void)beginUserScrolling",
    "- (BOOL)restoreScrollHeight:",
    "- (void)restorePendingViewport",
    "- (void)saveAnchor",
    "- (void)restoreAnchor",
    "- (void)selectIndex:",
]
Path(sys.argv[1]).write_text("\n\n".join(method(marker) for marker in markers) + "\n")
hooks = (Path(sys.argv[3]) if len(sys.argv) > 3 else root / "Hooks/SessionGroupHooks.xm").read_text()
hook_declarations = [
    "static void (*MainTabDoubleClickedOriginal)(id,SEL,id);",
    "static void (*NewMainTabDoubleClickedOriginal)(id,SEL,id);",
]
for declaration in hook_declarations:
    assert declaration in hooks, declaration
hook_markers = [
    "static void BeginMainTabPositioning(",
    "static void MainTabDoubleClicked(",
    "static void NewMainTabDoubleClicked(",
    "static void InstallMainTabPositioningHooks(",
]
Path(sys.argv[1]).with_name("GroupInitialViewportHooks.h").write_text(
    "\n".join(hook_declarations) + "\n\n" + "\n\n".join(method(marker, hooks) for marker in hook_markers) + "\n"
)
