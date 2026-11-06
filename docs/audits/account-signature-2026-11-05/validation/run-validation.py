#!/usr/bin/env python3
"""Compile production metadata extraction and exact controller methods on macOS.

Reuses sibling synthetic CMS fixtures and checks their CMS signatures; never
creates signing material, accesses an installed app, or touches user databases.
"""
from pathlib import Path
import hashlib
import json
import re
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
FIXTURES = HERE.parent / "legacy-reproduction"
CONTROLLER = ROOT / "Controllers/CSAccountDetailViewController.m"
HELPER = ROOT / "Controllers/CSProvisioningProfile.m"


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(command, *, check=True):
    result = subprocess.run(command, text=True, capture_output=True)
    log.append("$ " + " ".join(str(part) for part in command))
    if result.stdout:
        log.append(result.stdout.rstrip())
    if result.stderr:
        log.append(result.stderr.rstrip())
    if check and result.returncode:
        raise RuntimeError(f"command exited {result.returncode}")
    return result


def method(source, signature):
    start = source.index(signature)
    # Production Objective-C methods begin at column zero; method text is kept
    # verbatim, including comments/whitespace, and only the surrounding class is
    # replaced. This avoids matching braces inside strings or comments.
    following = re.search(r"^(?:[-+] \(|@end|#pragma mark)", source[start + len(signature):], re.M)
    if not following:
        raise RuntimeError(f"cannot locate end of {signature}")
    candidate = source[start:start + len(signature) + following.start()].rstrip()
    # Stop after the method's closing brace, omitting the next method's leading
    # explanatory comments. No executable production code is transformed.
    return candidate[:candidate.rfind("}") + 1] + "\n"


log = []
try:
    source = CONTROLLER.read_text()
    constants = source[source.index("#pragma mark - 显示文本常量"):source.index("@interface")]
    signatures = [
        "- (NSString *)determineProfileType:(NSDictionary *)profileDict",
        "- (NSDictionary *)readProvisioningProfile",
        "- (NSString *)getDeviceModelIdentifier",
        "- (void)setupData",
        "- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section",
    ]
    methods = {signature: method(source, signature) for signature in signatures}
    generated = constants + "\n@implementation CSAccountDetailViewController\n\n" + "\n".join(methods.values()) + "\n@end\n"
    extracted = HERE / "ControllerMethods.inc"
    extracted.write_text(generated)
    manifest = {
        "sourceHashes": {str(path.relative_to(ROOT)): sha256(path) for path in [HELPER, HELPER.with_suffix(".h"), CONTROLLER, HERE / "ProfileValidation.m", HERE / "run-validation.py", FIXTURES / "LegacyProfileReproduction.m"]},
        "extractedMethodsSHA256": {signature: hashlib.sha256(body.encode()).hexdigest() for signature, body in methods.items()},
        "extractedFileSHA256": sha256(extracted),
        "fixtureHashes": {name: sha256(FIXTURES / name) for name in [
            "ascii.plist", "ascii.mobileprovision", "utf8.plist", "utf8.mobileprovision",
            "utf8-binary.plist", "utf8-binary.mobileprovision", "all-byte-prefix-with-xml.bin",
            "truncated-before-xml-close.mobileprovision", "truncated-after-xml-close.mobileprovision",
        ]},
        "fixtures": {},
    }
    with tempfile.TemporaryDirectory(prefix="wechat-profile-validation-") as scratch_name:
        scratch = Path(scratch_name)
        for label in ["ascii", "utf8", "utf8-binary"]:
            cms = FIXTURES / f"{label}.mobileprovision"
            payload = FIXTURES / f"{label}.plist"
            recovered = scratch / f"{label}-verified.plist"
            run(["openssl", "cms", "-verify", "-noverify", "-inform", "DER", "-in", str(cms), "-out", str(recovered)])
            if recovered.read_bytes() != payload.read_bytes():
                raise RuntimeError(f"CMS payload differs from XML/binary source: {label}")
            manifest["fixtures"][cms.name] = {"sha256": sha256(cms), "payloadSHA256": sha256(payload), "CMSContentSignatureVerified": True}
        binary = scratch / "profile-validation"
        run(["xcrun", "clang", "-fobjc-arc", "-framework", "Foundation", "-Wno-deprecated-declarations", "-Wno-incompatible-pointer-types", "-I", str(ROOT / "Controllers"), "-I", str(HERE), str(HERE / "ProfileValidation.m"), str(HELPER), "-o", str(binary)])
        result = run([str(binary), str(FIXTURES), str(scratch), str(HERE / "result.json")], check=False)
        manifest["validationExitCode"] = result.returncode
        if result.returncode:
            raise RuntimeError(f"validation checks exited {result.returncode}")
    print("Validation passed; see validation.log, result.json and manifest.json")
finally:
    (HERE / "validation.log").write_text("\n".join(log) + "\n")
    if "manifest" in globals():
        (HERE / "manifest.json").write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n")
