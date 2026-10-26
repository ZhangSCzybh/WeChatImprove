#!/usr/bin/env python3
"""Verify development artifacts before copying them into this branch's packages/."""
import hashlib
import json
from pathlib import Path
import plistlib
import re
import shutil
import subprocess
import tempfile
import zipfile

audit = Path(__file__).resolve().parent
repo = audit.parents[2]
environment = json.loads((audit / "build-environment.json").read_text())
build = Path(environment["buildRoot"])
version = "2.0-13+entry2"


def run(*args):
    return subprocess.check_output([str(arg) for arg in args], text=True)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def publish(path):
    target = repo / "packages" / path.name
    if target.exists():
        assert sha(target) == sha(path), f"Refuse to replace an existing artifact: {target}"
    else:
        shutil.copy2(path, target)
    return {"path": str(target.relative_to(repo)), "sha256": sha(target), "bytes": target.stat().st_size}


assert re.search(r"^Version: (.+)$", (repo / "control").read_text(), re.M)[1] == version
assert f'kPluginVersionString @"{version}"' in (repo / "Headers/CSUserInfoHelper.h").read_text()
assert f'@"{version}": @[' in (repo / "Controllers/CSReleaseNotesViewController.m").read_text()
results = []
symbol_files = []
for scheme, package_arch, prefix in [("rootless", "iphoneos-arm64", "var/jb/"), ("rootful", "iphoneos-arm", "")]:
    package = build / "packages" / f"com.wechat.improve_{version}_{package_arch}.deb"
    assert run("dpkg-deb", "-f", package, "Version").strip() == version
    assert run("dpkg-deb", "-f", package, "Architecture").strip() == package_arch
    with tempfile.TemporaryDirectory(prefix="wechat-entry-package-check-") as directory:
        extracted = Path(directory)
        subprocess.run(["dpkg-deb", "-x", str(package), directory], check=True)
        dylib = extracted / (prefix + "Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib")
        assert len(list(extracted.rglob("WeChatImprove.dylib"))) == 1 and dylib.is_file()
        assert set(run("xcrun", "lipo", "-archs", dylib).split()) == {"arm64", "arm64e"}
        payload = dylib.read_bytes()
        for symbol in [b"CSCloseFriendReset", b"prepareResetWithPassword:token:error:", b"resetFrom:completion:", b"removeDiscoveryForAccountID:error:", b"CSCloseFriendEntryState", b"discoverCloseFriendEntry:", b"settingsEntryDiscoveryToken", b"discoverSettingsEntryWithToken:", b"com.wechatimprove.closefriends.entry-discovery", b"CSScheduledTaskManager", b"CSMessageImageStickerAdapter", version.encode()]:
            assert symbol in payload, symbol
        for symbol in [b"ResetFixture", b"ResetStore", b"com.wechatimprove.tests.reset.", b"EntryController", b"EntryManager", b"com.wechatimprove.tests.entry.", b"CSFakeLAContext"]:
            assert symbol not in payload, symbol
        injection = plistlib.loads((dylib.parent / "WeChatImprove.plist").read_bytes())
        assert "com.tencent.xin" in injection["Filter"]["Bundles"]
        load_commands = run("xcrun", "otool", "-arch", "all", "-l", dylib)
        assert len(re.findall(r"\bminos 15\.0\b", load_commands)) == 2
        uuids = run("xcrun", "dwarfdump", "--uuid", dylib)
        slices = []
        for arch in ["arm64", "arm64e"]:
            dsym = build / scheme / ".theos/obj" / arch / "WeChatImprove.dylib.dSYM"
            uuid = re.search(r"UUID: ([A-F0-9-]+) \(" + arch + r"\)", uuids)[1]
            assert uuid in run("xcrun", "dwarfdump", "--uuid", dsym)
            slices.append({"arch": arch, "uuid": uuid})
            symbol_files.extend((file, f"{scheme}/{arch}/{file.relative_to(dsym.parent)}") for file in sorted(dsym.rglob("*")) if file.is_file())
        entry = publish(package)
        entry.update(scheme=scheme, version=version, architecture=package_arch, dylibSHA256=sha(dylib), slices=slices)
        results.append(entry)
archive = build / "packages" / f"com.wechat.improve_{version}_symbols.zip"
if not archive.exists():
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as zipped:
        for path, name in symbol_files:
            zipped.write(path, name)
results.append(publish(archive))
(audit / "packages.json").write_text(json.dumps(results, indent=2) + "\n")
print("Rootless and rootful packages verified: version, prefixes, arm64/arm64e, iOS 15, feature symbols, injection filter and matching dSYM UUIDs")
