#!/usr/bin/env python3
"""Read-only ABI metadata and targeted disassembly for the supplied 8.0.80 image.

This writes only files beside this script. It never loads/executes the image.
The metadata readers are preserved, unmodified 2.2-14 audit tools.
"""
import argparse
import collections
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
OLD = ROOT / "docs/audits/wechat-8.0.80-2026-11-05"
DEFAULT_BINARY = "/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat"
EXPECTED_SHA256 = "571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9"
CLASSES = ["BaseMsgContentViewController", "BaseMessageViewModel", "CommonMessageViewModel",
           "TextMessageViewModel", "TextMessageSubViewModel", "BaseMessageCellView",
           "CommonMessageCellView", "TextMessageCellView", "VoiceMessageViewModel",
           "VoiceMessageCellView", "VoIPBubbleMessageCellView", "VoIPSignalMessageCellView",
           "RichTextView", "YYAsyncImageView", "YYImage"]
TARGETS = {
    "BaseMsgContentViewController": ["initTableView", "tableView:heightForRowAtIndexPath:",
        "tableView:cellForRowAtIndexPath:", "tableView:willDisplayCell:forRowAtIndexPath:", "makeCell:indexPath:"],
    "BaseChatViewModel": ["rowHeight", "shouldLayoutIfNeeded", "updateLayoutsWithoutReload"],
    "BaseChatCellView": ["layoutSubviews", "layoutInternal"],
    "ChatTableViewCell": ["setViewModel:", "layoutSubviews"],
    "BaseMessageViewModel": ["measure:"],
    "CommonMessageViewModel": ["measure:", "bgBubbleInfo"],
    "TextMessageViewModel": ["cellViewClassName", "numberOfRowsInSection", "cellDataForRow:", "measureContentViewSize:"],
    "CommonMessageCellView": ["updateBgImageView:", "layoutSubviews", "layoutInternal", "layoutContentView",
        "initWithViewModel:", "setViewModel:", "onAppear", "updateStatus", "updateNodeStatus", "initBgImageView"],
    "TextMessageCellView": ["layoutContentView"],
    "BaseMessageCellView": ["getContentView", "layoutInternal"],
    "BubbleInfo": ["getBubbleImage:isDarkMode:useCache:", "getBubbleImage:isDarkMode:", "getBubbleImage:"],
}
# External UIKit inheritance is kept separate from native-image metadata.
UIKIT = {"viewDidLoad": "v@:", "viewWillAppear:": "v@:B", "viewDidAppear:": "v@:B",
         "viewDidDisappear:": "v@:B", "viewDidLayoutSubviews": "v@:", "layoutSubviews": "v@:",
         "prepareForReuse": "v@:", "traitCollectionDidChange:": "v@:@", "didMoveToWindow": "v@:",
         "setImage:": "v@:@", "setHighlightedImage:": "v@:@"}
SOURCES = ["Hooks/MessageMergeHooks.xm", "Hooks/BubbleStyleHooks.xm", "Hooks/MessageGestureHooks.xm"]


def digest(path):
    return hashlib.file_digest(Path(path).open("rb"), "sha256").hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--binary", default=DEFAULT_BINARY)
    parser.add_argument("--skip-disassembly", action="store_true")
    args = parser.parse_args()
    assert digest(args.binary) == EXPECTED_SHA256, "different WeChat native image"
    spec = importlib.util.spec_from_file_location("metadata", OLD / "privacy-validation/objc_metadata.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    image = module.MachO(args.binary)
    class_cache = {name: image.readclass(name) for name in image.classmap}

    def export(name, classes):
        (HERE / name).write_text(json.dumps({"binary": args.binary, "sha256": EXPECTED_SHA256,
            "classes": [class_cache[c] for c in classes]}, ensure_ascii=False, indent=2) + "\n")

    export("native-message-metadata.json", CLASSES)
    export("native-bubble-metadata.json", ["BubbleInfo", "BubbleManager"])
    export("native-ancestors-metadata.json", ["BaseChatViewModel", "BaseChatCellView", "ChatTableViewCell",
                                            "BaseMessageCellView", "CommonMessageCellView", "TextMessageCellView",
                                            "BaseMsgContentViewController"])
    records = []
    for source in SOURCES:
        cls = None
        for number, line in enumerate((ROOT / source).read_text().splitlines(), 1):
            if line.startswith("%hook "):
                cls = line.split()[1]
            if line.startswith("%end"):
                cls = None
            if not cls or not line.startswith("- "):
                continue
            signature = line.split("{")[0]
            result = re.search(r"-\s*\(([^)]+)\)", signature)[1]
            arguments = re.findall(r"(\w+):\s*\(([^)]+)\)", signature)
            selector = "".join(p[0] + ":" for p in arguments) if arguments else re.search(r"\)\s*(\w+)", signature)[1]
            def typ(value):
                return {"void": "v", "id": "@", "BOOL": "B", "double": "d", "CGFloat": "d"}.get(value, "@" if "*" in value else "?")
            expected = typ(result) + "@:" + "".join(typ(t) for _, t in arguments)
            owner, native, visited = cls, None, set()
            while owner in class_cache and owner not in visited:
                visited.add(owner)
                native = next((v for v in class_cache[owner]["methods"] if v["selector"] == selector), None)
                if native:
                    break
                owner = class_cache[owner]["superclass"]
            encoding = native["encoding"] if native else UIKIT.get(selector)
            status = "MATCH" if encoding and re.sub(r"[0-9]", "", encoding) == expected else ("ABSENT_IN_IMAGE" if not encoding else "MISMATCH")
            records.append({"file": source, "line": number, "class": cls, "selector": selector,
                "hook_abi": expected, "native_owner": owner if native else ("UIKit declaration " + owner if encoding else None),
                "native_encoding": encoding, "imp": native["imp"] if native else None, "status": status,
                "evidence": "native-method-list" if native else ("external-SDK" if encoding else "no-native-method-in-ancestry")})
    absent = {r["selector"] for r in records if r["status"] == "ABSENT_IN_IMAGE"}
    assert absent == {"addMessageNode:layout:addMoreMsg:", "addMessageNode:addMoreMsg:"}
    assert not any(r["status"] == "MISMATCH" for r in records)
    (HERE / "hook-abi-audit.json").write_text(json.dumps(records, ensure_ascii=False, indent=2) + "\n")
    lines = ["# 8.0.80 message hook ABI audit", "",
        "Encodings include implicit self/_cmd. Explicit argument counts are shown separately. UIKit superclass declarations are marked separately. These results establish static ABI eligibility, not a hook installation inside the user's process.", "",
        "| Source | Hook class | Selector | Return / explicit argc | Hook ABI | Native owner / encoding | IMP | Result |",
        "| --- | --- | --- | --- | --- | --- | --- | --- |"]
    for r in records:
        lines.append(f"| `{r['file']}:{r['line']}` | {r['class']} | `{r['selector']}` | `{r['hook_abi'][0]}` / {r['selector'].count(':')} | `{r['hook_abi']}` | {r['native_owner']} / `{r['native_encoding']}` | `{r['imp']}` | {r['status']} |")
    (HERE / "hook-abi-audit.md").write_text("\n".join(lines) + "\n")
    commands = []
    if not args.skip_disassembly:
        starts = sorted({int(v["imp"], 16) for c in class_cache.values() for v in c["methods"]})
        for cls, selectors in TARGETS.items():
            for selector in selectors:
                method = next(v for v in class_cache[cls]["methods"] if v["selector"] == selector)
                start = int(method["imp"], 16)
                end = next(v for v in starts if v > start)
                command = ["xcrun", "llvm-objdump", "--disassemble", "--start-address=" + hex(start),
                           "--stop-address=" + hex(end), args.binary]
                output = HERE / (cls + "-" + selector.replace(":", "_") + ".asm")
                output.write_text(subprocess.check_output(command, text=True))
                commands.append({"command": command, "output": output.name, "start": hex(start), "stop": hex(end)})
        annotate = ["python3", str(OLD / "merge-validation/inspect_objc.py"), args.binary,
                    *dict.fromkeys([*CLASSES, *TARGETS, "BubbleInfo"]), "--annotate-directory", str(HERE)]
        (HERE / "annotator-metadata.json").write_text(subprocess.check_output(annotate, text=True))
        commands.append({"command": annotate, "output": "annotator-metadata.json"})
        (HERE / "disassembly-commands.json").write_text(json.dumps(commands, ensure_ascii=False, indent=2) + "\n")
    provenance = {"binary": args.binary, "binary_sha256": EXPECTED_SHA256,
        "metadata_reader": str(OLD / "privacy-validation/objc_metadata.py"),
        "metadata_reader_sha256": digest(OLD / "privacy-validation/objc_metadata.py"),
        "annotator_sha256": digest(OLD / "merge-validation/inspect_objc.py"),
        "source_sha256": {s: digest(ROOT / s) for s in SOURCES},
        "scope": "Offline metadata and targeted disassembly only; no image execution, phone install, runtime hook instrumentation, or device frame collection."}
    (HERE / "native-provenance.json").write_text(json.dumps(provenance, ensure_ascii=False, indent=2) + "\n")
    print("64 hook declarations examined: " + str(dict(collections.Counter(r["status"] for r in records))))
    print("PASS: no ABI mismatches; the two legacy mutation absences are explicit and are not counted as installed hooks.")


if __name__ == "__main__":
    main()
