"""Replay native banner callbacks with production change/cache decisions.

An optional hooks path lets the same behavioral checks run against the
pre-fix source. Missing hooks deliberately become native passthroughs, so
that control run fails on behavior rather than on a missing text marker.
"""
from pathlib import Path
import re
import sys

root = Path(__file__).resolve().parent.parent
out = Path(sys.argv[1])
hooks = (Path(sys.argv[2]) if len(sys.argv) > 2 else root / "Hooks/SessionGroupHooks.xm").read_text()
adapter = (root / "Controllers/CSGroupListAdapter.m").read_text()


def method(text, marker):
    pattern = re.escape(marker) + ("" if marker.endswith("{") else r"[^;{]*\{")
    match = re.search(pattern, text)
    if not match:
        return None
    start = match.start()
    brace = text.index("{", start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == "{":
            depth += 1
        elif text[end] == "}":
            depth -= 1
            if not depth:
                return text[start:end + 1]
    raise AssertionError(marker)


def required(text, marker):
    body = method(text, marker)
    assert body, marker
    return body


adapter_markers = [
    "- (void)mergePendingChangeOfKind:",
    "- (void)beginNativeChange",
    "- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind {",
    "- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind changedUserNames:",
    "- (void)endNativeChange {",
    "- (void)endNativeChangeCoalesced:",
    "- (void)invalidateNativeSnapshot",
    "- (void)requestRecovery",
    "- (void)requestRefresh",
    "- (NSArray *)nativeSectionsForAccount:",
    "- (void)bindNativeCell:",
]
# The two no-argument wrapper markers include their opening brace to
# disambiguate overloaded methods; the general matcher tolerates it.
out.with_name("GroupBannerAdapterBodies.h").write_text(
    "\n\n".join(required(adapter, marker) for marker in adapter_markers) + "\n"
)
out.with_name("GroupBannerNativeScope.h").write_text(
    "\n\n".join(required(hooks, marker) for marker in [
        "static CSGroupListAdapter *Adapter(",
        "static void Native(",
    ]) + "\n" + (method(hooks, "static void NativeHeaderChange(") or "") + "\n"
)

start = hooks.index("%hook NewMainFrameViewController")
end = hooks.index("%end", start)
owner = hooks[start:end]
replays = []
for name, original in [
    ("insertRow", "originalInsertRow"),
    ("removeRow", "originalRemoveRow"),
    ("reloadAll", "originalReloadAll"),
]:
    marker = "- (void)" + name + (":" if name != "reloadAll" else " ")
    body = method(owner, marker)
    if name == "reloadAll":
        body = body or "- (void)reloadAll { %orig; }"
        call = "[self originalReloadAll]"
    else:
        body = body or f"- (void){name}:(unsigned int)row {{ %orig; }}"
        arg = re.search(r"\)\s*(\w+)\s*\{", body).group(1)
        call = f"[self {original}:{arg}]"
    body = body.replace("%orig;", call + ";")
    # Logos also accepts an explicit original argument list.
    body = re.sub(r"%orig\(([^)]*)\)", lambda match: f"[self {original}:{match.group(1)}]", body)
    assert "%orig" not in body, body
    replays.append(body)
out.write_text("\n\n".join(replays) + "\n")
