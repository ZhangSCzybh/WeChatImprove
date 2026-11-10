#!/usr/bin/env python3
"""Compile only temporary candidates; do not replace current or archived production."""
from pathlib import Path
import hashlib
import json
import platform
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[4]
OUTPUT = Path(__file__).resolve().parent
SNAPSHOT = Path(json.loads((ROOT / "docs/audits/clown-local-display-2026-11-09/build-result.json").read_text())["snapshot"])
SDK = subprocess.check_output(["xcrun", "--sdk", "macosx", "--show-sdk-path"], text=True).strip()
UNITS = ["CSClownPreferences.m", "CSClownSession.m", "CSClownLayout.m", "CSMessageActionContext.m", "CSChatNativeBridge.m", "CSMessageNativeActionAdapter.m", "CSClownMenuAdapter.m"]
PRODUCTION = [SNAPSHOT / "Controllers" / unit for unit in UNITS + ["CSClownPresentation.m"]]
PRODUCTION += [ROOT / "Controllers" / unit for unit in UNITS + ["CSClownPresentation.m"]]
def digests():
    return {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in PRODUCTION}

before = digests()
source = (ROOT / "Tests/ClownPresentationTests.m").read_text().replace(
    '#import "../Controllers/CSClownPresentation.m"',
    f'#import "{SNAPSHOT}/Controllers/CSClownPresentation.m"\n'
    'void CSClownTimeDisplayModeDidChange(id controller) { (void)controller; }')
results = []
with tempfile.TemporaryDirectory(prefix="wechat-clown-red-") as temporary:
    temporary = Path(temporary)
    for case, first in [("amount-menu", "TestNativeTransferAmountsAndMenus();"), ("native-time", "TestNativeTimeTapAndDisplayModes();")]:
        candidate = temporary / (case + ".m")
        candidate.write_text(source.replace("        TestUIKitLayerOpacityHitTesting();", "        " + first + " TestUIKitLayerOpacityHitTesting();"))
        binary = temporary / case
        command = ["xcrun", "--sdk", "macosx", "clang", "-target", platform.machine() + "-apple-ios15.0-macabi", "-fobjc-arc", "-fblocks", "-Wall", "-Wextra", "-Werror", "-Wno-deprecated-declarations", "-Wno-unused-parameter", "-isysroot", SDK,
                   "-iframework", SDK + "/System/iOSSupport/System/Library/Frameworks", "-F", SDK + "/System/iOSSupport/System/Library/Frameworks", "-framework", "Foundation", "-framework", "UIKit", "-framework", "QuartzCore", "-framework", "PhotosUI", "-framework", "CoreGraphics", "-I" + str(SNAPSHOT / "Controllers"), "-I" + str(ROOT / "Tests")]
        command += [str(SNAPSHOT / "Controllers" / unit) for unit in UNITS]
        command += [str(ROOT / "Tests/ClownPresentationNativeDouble.m"), str(candidate), "-o", str(binary)]
        compilation = subprocess.run(command, capture_output=True, text=True)
        result = {"case": case, "compile_command": command, "compile_exit": compilation.returncode}
        output = f"Snapshot: {SNAPSHOT}\nCompile exit: {compilation.returncode}\n" + compilation.stdout + compilation.stderr
        if compilation.returncode == 0:
            execution = subprocess.run([str(binary)], capture_output=True, text=True)
            result.update(run_exit=execution.returncode, stdout=execution.stdout, stderr=execution.stderr)
            output += f"Run exit: {execution.returncode}\n" + execution.stdout + execution.stderr
        (OUTPUT / (case + "-old-snapshot-red.log")).write_text(output)
        print(output, end="")
        results.append(result)
        assert compilation.returncode == 0, "Old snapshot must compile before its regression result is valid"
        assert result.get("run_exit") == 1 and "FAIL line" in result.get("stderr", ""), "Expected regression assertion was not reproduced"
assert digests() == before, "Current and archived production must remain byte-identical"
(OUTPUT / "old-snapshot-red-builds.json").write_text(json.dumps({"snapshot": str(SNAPSHOT), "helper_stub": "CSClownTimeDisplayModeDidChange: no-op only to link a symbol absent in 2.3-5", "production_unchanged": True, "production_sha256": before, "results": results}, ensure_ascii=False, indent=2) + "\n")
