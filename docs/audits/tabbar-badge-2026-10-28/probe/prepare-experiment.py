#!/usr/bin/env python3
"""Generate a reviewable temporary adapter variant; never writes the source input."""
import difflib
import hashlib
import json
from pathlib import Path
import sys

source_path, destination_path, evidence_dir = map(Path, sys.argv[1:])
source = source_path.read_text()
variant = source
pairs = [
    (
        "    CSRestoreItem(item);\n    s.bar=bar; s.image=item.imageView.image; s.imageMode=item.imageView.contentMode;",
        "    CSRestoreItem(item);\n"
        "    // ISOLATED EXPERIMENT: resolve the native pair after parent resizing.\n"
        "    s.depth++;\n    [item layoutIcon];\n    [item layoutBadgeView];\n    s.depth--;\n"
        "    s.bar=bar; s.image=item.imageView.image; s.imageMode=item.imageView.contentMode;",
    ),
    (
        "    s.badgeOffset=CGPointMake(badge.origin.x-s.badgeFrame.origin.x,badge.origin.y-s.badgeFrame.origin.y);\n"
        "    CSSetFrame(item.badgeView,badge);",
        "    CSSetFrame(item.badgeView,badge);\n"
        "    // ISOLATED EXPERIMENT: account for native pixel alignment.\n"
        "    CGRect appliedBadge=item.badgeView.frame;\n"
        "    s.badgeOffset=CGPointMake(appliedBadge.origin.x-s.badgeFrame.origin.x,appliedBadge.origin.y-s.badgeFrame.origin.y);",
    ),
    (
        "        CSSetFrame(b.button,b.frame); CSSetFrame(b.item,b.itemFrame);",
        "        CSSetFrame(b.button,b.frame); CSSetFrame(b.item,b.itemFrame);\n"
        "        // ISOLATED EXPERIMENT: native width is now restored.\n"
        "        CSTabBarItemState *itemState=objc_getAssociatedObject(b.item,&CSItemStateKey);\n"
        "        itemState.depth++;\n"
        "        [(MMTabBarItemView *)b.item layoutIcon];\n"
        "        [(MMTabBarItemView *)b.item layoutBadgeView];\n"
        "        itemState.depth--;",
    ),
]
for before, after in pairs:
    if variant.count(before) != 1:
        raise SystemExit(f"Expected exactly one replacement target: {before!r}")
    variant = variant.replace(before, after)
destination_path.write_text(variant)
evidence_dir.joinpath("experimental-adapter.diff").write_text("".join(difflib.unified_diff(
    source.splitlines(keepends=True), variant.splitlines(keepends=True),
    fromfile="Controllers/CSTabBarNativeAdapter.m (2.1-6 source)",
    tofile="Temporary adapter (isolated experiment only)",
)))
manifest = {
    "sourcePath": str(source_path),
    "sourceSHA256": hashlib.sha256(source.encode()).hexdigest(),
    "generatedAdapterSHA256": hashlib.sha256(variant.encode()).hexdigest(),
    "replacements": len(pairs),
    "sourceUnchangedAfterGeneration": source_path.read_text() == source,
    "productionSourceModified": False,
}
evidence_dir.joinpath("experimental-adapter-manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
