"""Compile the actual adapter methods with host dependencies substituted.

This exercises appearance and scrolling decisions, not UIKit/WeChat rendering.
Optional adapter and Hook paths allow running the regression against old code.
"""
from pathlib import Path
import sys

root = Path(__file__).resolve().parent.parent
source = Path(sys.argv[2]) if len(sys.argv) > 2 else root / "Controllers/CSGroupListAdapter.m"
text = source.read_text()
hooks = (Path(sys.argv[3]) if len(sys.argv) > 3 else root / "Hooks/SessionGroupHooks.xm").read_text()
out = Path(sys.argv[1])


def method(text, marker):
    start = text.find(marker)
    if start < 0:
        assert marker in ["- (BOOL)hasScrollableContent", "- (BOOL)canRestoreAnchor"]
        return ""
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


methods = [method(text, marker) for marker in [
    "+ (instancetype)adapterForTable:", "+ (instancetype)adapterForController:",
    "+ (void)attachToController:", "+ (void)setPresentationSuspended:", "+ (void)finishPresentationReturnForController:",
    "- (void)cancelScheduledRefresh {", "- (void)requestRefresh {", "- (void)scheduleRefresh {", "- (void)requestRecovery {",
    "- (BOOL)hasScrollableContent", "- (BOOL)canRestoreAnchor",
    "- (void)saveAnchor", "- (void)restoreAnchor {", "- (NSNumber *)presentationScrollHeight",
    "- (void)restoreViewportFromTab:", "- (void)restoreScrollHeight:",
    "- (void)returnToGroupTop", "- (void)applyPendingScrollToTop", "- (void)selectIndex:",
]]
out.write_text("\n\n".join(methods) + "\n")
refresh = method(text, "- (void)refresh {")
capture = refresh.split("@try {", 1)[1].split("[self saveAnchor];", 1)[0]
assert "NSString *viewportTab=" in capture and "CGFloat viewportHeight=" in capture
out.with_name("GroupViewportCapture.h").write_text(capture + "\n")
restore_start = refresh.index("[self restoreViewportFromTab:")
restore_end = refresh.index(";", restore_start) + 1
out.with_name("GroupViewportRestore.h").write_text(refresh[restore_start:restore_end] + "\n")
main_hooks = hooks.split("%hook NewMainFrameViewController", 1)[1].split("%end", 1)[0]
appearance = [method(main_hooks, "- (void)" + name + ":").replace("%orig", "[self nativeAppearance:animated]")
              for name in ["viewWillAppear", "viewDidAppear", "viewWillDisappear", "viewDidDisappear"]]
out.with_name("GroupViewportHooks.h").write_text("\n\n".join(appearance) + "\n")
