#!/usr/bin/env python3
"""Build the approved 2.4-2 voice-progress release from an isolated source snapshot.

Capture only .theos and existing packages in the initial protected baseline.
The authorized control/header/release-note edits are captured with all production
inputs at --build time, after the parent task confirms its production freeze.
No clean/install operation or production .theos mutation occurs.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import time
import zipfile

AUDIT = Path(__file__).resolve().parent
ROOT = AUDIT.parents[2]
VERSION = "2.4-2"
DELIVERY = ROOT / "packages/2.4-2-voice-progress"
BASELINE = AUDIT / "protected-before.json"
PRODUCTION_FOLDERS = ("Controllers", "Hooks", "Headers")
PRODUCTION_FILES = ("Makefile", "control", "WeChatImprove.plist")
EXPORTED_MARKERS = (
    "_OBJC_CLASS_$_CSFavoriteVoiceContext", "_OBJC_CLASS_$_CSFavoriteVoiceMediaProvider",
    "_OBJC_CLASS_$_CSFavoriteVoiceForwardAdapter", "_CSFavoriteHasPendingVoiceDownloads",
    "_CSMessageValidateVoiceData", "_CSMessageHasPendingVoiceDownloads",
    "_OBJC_CLASS_$_CSMessageActionCoordinator", "_OBJC_CLASS_$_CSVoiceForwardAdapter",
    "_CSCFCurrentForwardRecipients",
    "_OBJC_CLASS_$_CSVoicePlaybackController", "_OBJC_CLASS_$_CSVoicePlaybackPreferences",
    "_CSVoicePlaybackRefreshCell", "_CSVoicePlaybackDetachCell", "_CSVoicePlaybackOwnsTouch",
)
RELEASE_SELECTOR_MARKERS = (
    "calcVoiceTimeWithData:VoiceFormat:", "onMultiDone", "onMultiDoneInPageSheetMode",
    "m_dicMultiSelect", "allValuesInOrder", "m_selectView", "FavDataItemWrap",
    "currentPlayingMsg", "currentPlayTime", "seekToTime:", "isMsgPlaying:",
    "com.wechat.enhance.voice_playback.progress_enabled",
)
DEBUG_MARKERS = ("+[CSFavoriteVoiceContext standaloneItemForListObject:]",
    "-[CSVoicePlaybackController seekToTime:message:generation:]")
HOOK_MARKERS = (
    "_logos_method$_ungrouped$MsgPlayingFacade$OnBeginPlaying$success$",
    "_logos_method$_ungrouped$MsgPlayingFacade$OnEndPlaying$isForceStop$",
    "_logos_method$_ungrouped$VoiceMessageCellView$onBeginPlayingMsg$autoPlayEnabled$",
    "_logos_method$_ungrouped$FavVoiceDetaiViewController$onAction$",
    "_logos_method$_ungrouped$FavVoiceDetaiViewController$onFavActionSheetSelectedForwardToUser$",
    "_logos_method$_ungrouped$FavActionSheet$initWithFavDelegate$enableType$",
    "_logos_method$_ungrouped$MyFavoritesViewController$forwardData$",
    "_logos_method$_ungrouped$FavoritesMgr$onDownloadFavoritesItemFinished$ErrCode$",
    "_logos_method$_ungrouped$ForwardMessageLogicController$ForwardMsg$ToContact$",
    "_logos_method$_ungrouped$VoiceMsgDownloader$OnRecvData$",
)


def sha(path):
    with path.open("rb") as handle:
        return hashlib.file_digest(handle, "sha256").hexdigest()


def write_json(path, data):
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def file_record(path):
    if path.is_symlink():
        return {"kind": "symlink", "target": os.readlink(path)}
    return {"kind": "file", "bytes": path.stat().st_size, "sha256": sha(path)}


def tree_manifest(folder, exclude_delivery=False):
    records = {}
    if not folder.exists():
        return {"exists": False, "files": records}
    for path in sorted(folder.rglob("*")):
        if exclude_delivery and (path == DELIVERY or DELIVERY in path.parents):
            continue
        if path.is_symlink() or path.is_file():
            records[str(path.relative_to(ROOT))] = file_record(path)
    return {"exists": True, "files": records}


def protected_manifest():
    # Version metadata and release notes are intentionally absent here: the parent
    # updates them before freeze. production_manifest covers them during the build.
    return {
        "main_theos": tree_manifest(ROOT / ".theos"),
        "previous_packages": tree_manifest(ROOT / "packages", exclude_delivery=True),
    }


def production_manifest(folder):
    files = [folder / name for name in PRODUCTION_FILES]
    files += [path for name in PRODUCTION_FOLDERS for path in (folder / name).rglob("*")
              if path.is_file() and path.name != ".DS_Store"]
    return {str(path.relative_to(folder)): sha(path) for path in sorted(files)}


def output(*command):
    return subprocess.check_output(command, text=True, stderr=subprocess.STDOUT).strip()


def capture_baseline():
    assert not DELIVERY.exists(), "Release directory already exists; never overwrite it."
    assert not BASELINE.exists(), "Protected baseline already exists; never replace it."
    state = protected_manifest()
    write_json(BASELINE, state)
    print(json.dumps({"captured": str(BASELINE),
                      "main_theos_files": len(state["main_theos"]["files"]),
                      "previous_package_files": len(state["previous_packages"]["files"])}))


def preservation_result(baseline, attempt):
    after = protected_manifest()
    write_json(attempt / "protected-after.json", after)
    checks = {name: after[name] == baseline[name] for name in baseline}
    write_json(attempt / "preservation-result.json", checks)
    return checks


def build(verify_existing=False):
    assert BASELINE.is_file(), "Run --capture-baseline before building."
    assert not DELIVERY.exists(), "Release directory already exists; never overwrite it."
    baseline = json.loads(BASELINE.read_text())
    assert protected_manifest() == baseline, "Protected environment changed since baseline."
    assert f"Version: {VERSION}\n" in (ROOT / "control").read_text()
    assert f'kPluginVersionString @"{VERSION}"' in (ROOT / "Headers/CSUserInfoHelper.h").read_text()
    assert VERSION in (ROOT / "Controllers/CSReleaseNotesViewController.m").read_text(), "Release notes do not include the formal version."
    if verify_existing:
        report = json.loads((AUDIT / "build-result.json").read_text())
        assert report["version"] == VERSION and report["release"] and report["status"] == "failed"
        work = Path(report["work_directory"])
        source = Path(report["snapshot"])
        attempt = Path(report["audit_directory"])
        before = json.loads((attempt / "production-inputs.json").read_text())
        assert source == work / "source" and attempt.parent == AUDIT
        assert all(result["exit_code"] == 0 for result in report["builds"]), "Cannot verify a failed compilation."
        write_json(attempt / "failed-verification-before-resume.json", report)
        report["verification_resumed_without_rebuild"] = True
        report["verified"] = []
        report.pop("failure", None)
    else:
        stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S.%fZ")
        attempt = AUDIT / ("build-attempt-" + stamp)
        attempt.mkdir()
        work = Path(tempfile.mkdtemp(prefix="wechat-release-2.4-2-voice-progress-build-"))
        source = work / "source"
        source.mkdir()
        before = production_manifest(ROOT)
        for folder in PRODUCTION_FOLDERS:
            shutil.copytree(ROOT / folder, source / folder)
        for name in PRODUCTION_FILES:
            shutil.copy2(ROOT / name, source / name)
        write_json(attempt / "production-inputs.json", before)
        report = {"release": True, "version": VERSION, "checkout": str(ROOT),
                  "snapshot": str(source), "work_directory": str(work), "audit_directory": str(attempt),
                  "delivery_directory": str(DELIVERY), "device_installed": False, "builds": [], "verified": []}
    assert production_manifest(source) == before, "Snapshot does not match frozen production inputs."
    assert production_manifest(ROOT) == before, "Frozen production inputs changed."

    def build_scheme(scheme):
        target = work / scheme
        target.mkdir()
        command = ["make", "package", "-j4", "SCHEME=" + scheme, "PACKAGE_VERSION=" + VERSION,
                   "_THEOS_LOCAL_DATA_DIR=" + str(target / ".theos"), "THEOS_OBJ_DIR_NAME=obj",
                   "THEOS_STAGING_DIR=" + str(target / "staging"), "THEOS_BUILD_DIR=" + str(target),
                   "THEOS_PACKAGE_DIR=" + str(target / "packages")]
        start = time.monotonic()
        log_path = attempt / (scheme + "-build.log")
        with log_path.open("w") as log:
            result = subprocess.run(command, cwd=source, stdout=log, stderr=subprocess.STDOUT)
        warnings = [line for line in log_path.read_text(errors="replace").splitlines() if "warning:" in line]
        write_json(attempt / (scheme + "-warnings.json"), warnings)
        return {"scheme": scheme, "command": command, "exit_code": result.returncode,
                "seconds": round(time.monotonic() - start, 2), "log": str(log_path),
                "warning_count": len(warnings), "object_root": str(target / ".theos/obj"),
                "staging_dir": str(target / "staging"), "package_dir": str(target / "packages")}

    try:
        if not verify_existing:
            with ThreadPoolExecutor(max_workers=2) as pool:
                report["builds"] = list(pool.map(build_scheme, ("rootless", "rootful")))
            write_json(attempt / "build-commands.json", report["builds"])
        assert all(result["exit_code"] == 0 for result in report["builds"]), "Inspect isolated build logs."
        assert production_manifest(ROOT) == before, "Source changed during the frozen build."
        packages, symbols, rootful_dylib = [], [], None
        for scheme, architecture in (("rootless", "iphoneos-arm64"), ("rootful", "iphoneos-arm")):
            target = work / scheme
            deb = target / "packages" / f"com.wechat.improve_{VERSION}_{architecture}.deb"
            info = {field: output("dpkg-deb", "-f", str(deb), field)
                    for field in ("Package", "Version", "Architecture")}
            assert info == {"Package": "com.wechat.improve", "Version": VERSION, "Architecture": architecture}, info
            extracted = target / "verified"
            subprocess.run(["dpkg-deb", "-x", str(deb), str(extracted)], check=True)
            prefix = "var/jb/" if scheme == "rootless" else ""
            relative = prefix + "Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib"
            dylib = extracted / relative
            plist = dylib.with_suffix(".plist")
            assert dylib.is_file() and plist.is_file(), "Package payload path mismatch."
            dylibs = [str(path.relative_to(extracted)) for path in extracted.rglob("WeChatImprove.dylib")]
            assert dylibs == [relative], dylibs
            # Theos serializes the source OpenStep plist as a binary plist. Compare
            # decoded filter values; original source bytes remain in the manifest.
            packaged_filter = json.loads(output("plutil", "-convert", "json", "-o", "-", str(plist)))
            source_filter = json.loads(output("plutil", "-convert", "json", "-o", "-", str(source / "WeChatImprove.plist")))
            assert packaged_filter == source_filter, "Package injection filter changed."
            assert set(output("xcrun", "lipo", "-archs", str(dylib)).split()) == {"arm64", "arm64e"}
            uuids, architecture_evidence = {}, {}
            for cpu in ("arm64", "arm64e"):
                thin = target / (cpu + ".dylib")
                subprocess.run(["xcrun", "lipo", str(dylib), "-thin", cpu, "-output", str(thin)], check=True)
                exported = output("xcrun", "nm", "-g", str(thin))
                assert all(marker in exported for marker in EXPORTED_MARKERS), (scheme, cpu, "missing exported marker")
                binary_bytes = thin.read_bytes()
                assert all(marker.encode() + b"\0" in binary_bytes for marker in RELEASE_SELECTOR_MARKERS), (scheme, cpu, "missing release selector marker")
                assert VERSION.encode() + b"\0" in binary_bytes, (scheme, cpu, "missing embedded release version")
                dsym = target / ".theos/obj" / cpu / "WeChatImprove.dylib.dSYM"
                dwarf = dsym / "Contents/Resources/DWARF/WeChatImprove.dylib"
                debug_symbols = output("xcrun", "nm", str(dwarf))
                assert all(marker in debug_symbols for marker in HOOK_MARKERS + DEBUG_MARKERS), (scheme, cpu, "missing native hook or release marker")
                (attempt / (scheme + "-" + cpu + "-favorite-symbols.txt")).write_text("\n".join(
                    line for line in (exported + "\n" + debug_symbols).splitlines()
                    if "CSFavorite" in line or any(marker in line for marker in HOOK_MARKERS)) + "\n")
                uuid = re.search(r"UUID: ([A-Fa-f0-9-]+)", output("xcrun", "dwarfdump", "--uuid", str(thin))).group(1)
                dsym_uuid = output("xcrun", "dwarfdump", "--uuid", str(dsym))
                assert uuid in dsym_uuid, (scheme, cpu, "dSYM UUID mismatch")
                uuids[cpu] = uuid
                architecture_evidence[cpu] = {"thin_sha256": sha(thin), "dwarf_sha256": sha(dwarf),
                                             "exported_markers": list(EXPORTED_MARKERS), "hook_markers": list(HOOK_MARKERS),
                                             "selector_markers": list(RELEASE_SELECTOR_MARKERS), "debug_markers": list(DEBUG_MARKERS)}
                symbols.append((scheme, cpu, dsym))
            packages.append(deb)
            report["verified"].append({**info, "scheme": scheme, "payload_path": relative,
                                       "architectures": ["arm64", "arm64e"], "dylib_sha256": sha(dylib), "injection_filter": packaged_filter,
                                       "dsym_uuids": uuids, "symbol_evidence": architecture_evidence})
            if scheme == "rootful":
                rootful_dylib = dylib
        assert production_manifest(ROOT) == before
        report["preservation"] = preservation_result(baseline, attempt)
        assert all(report["preservation"].values()), "A protected original changed during build."
        # Finish every check before publishing. A verification failure keeps the
        # owned work outputs reusable by --verify-existing and leaves DELIVERY absent.
        staged_delivery = work / "release-output"
        assert work.stat().st_dev == DELIVERY.parent.stat().st_dev, "Atomic delivery requires one filesystem."
        if staged_delivery.exists():
            assert verify_existing and staged_delivery.is_dir(), "Unexpected staged release directory."
        else:
            staged_delivery.mkdir()
        for package in packages:
            shutil.copy2(package, staged_delivery / package.name)
        shutil.copy2(rootful_dylib, staged_delivery / "WeChatImprove.dylib")
        archive_name = f"com.wechat.improve_{VERSION}_symbols.zip"
        with zipfile.ZipFile(staged_delivery / archive_name, "w", zipfile.ZIP_DEFLATED) as archive:
            for scheme, cpu, dsym in symbols:
                for path in sorted(dsym.rglob("*")):
                    if path.is_file():
                        archive.write(path, str(Path(scheme) / cpu / dsym.name / path.relative_to(dsym)))
        with zipfile.ZipFile(staged_delivery / archive_name) as archive:
            assert archive.testzip() is None, "Symbols archive CRC verification failed."
            for verified in report["verified"]:
                for cpu in ("arm64", "arm64e"):
                    entry = f'{verified["scheme"]}/{cpu}/WeChatImprove.dylib.dSYM/Contents/Resources/DWARF/WeChatImprove.dylib'
                    assert hashlib.sha256(archive.read(entry)).hexdigest() == verified["symbol_evidence"][cpu]["dwarf_sha256"], (entry, "archived dSYM differs")
        report["symbols_archive_verified"] = True
        artifact_names = sorted([package.name for package in packages] + ["WeChatImprove.dylib", archive_name])
        assert {path.name for path in staged_delivery.iterdir()} <= set(artifact_names + ["SHA256SUMS"])
        report["artifacts"] = {name: sha(staged_delivery / name) for name in artifact_names}
        (staged_delivery / "SHA256SUMS").write_text("".join(f"{digest}  {name}\n" for name, digest in report["artifacts"].items()))
        report["frozen_manifest_sha256"] = sha(attempt / "production-inputs.json")
        report["sources_unchanged_during_build"] = production_manifest(ROOT) == before
        report["preservation"] = preservation_result(baseline, attempt)
        assert report["sources_unchanged_during_build"] and all(report["preservation"].values())
        report["build_environment"] = {"theos": "/Users/zhangshichao/theos", "clang": output("xcrun", "--find", "clang"),
                                       "sdk": output("xcrun", "--show-sdk-path", "--sdk", "iphoneos")}
        assert not DELIVERY.exists(), "Release destination appeared during the build."
        os.rename(staged_delivery, DELIVERY)
        report["delivery_published_after_verification"] = True
        report["status"] = "passed"
    except BaseException as error:
        report["status"] = "failed"
        report["failure"] = repr(error)
        report["preservation"] = preservation_result(baseline, attempt)
        write_json(attempt / "build-result.json", report)
        write_json(AUDIT / "build-result.json", report)
        raise
    write_json(attempt / "build-result.json", report)
    write_json(AUDIT / "build-result.json", report)
    print(json.dumps({"status": report["status"], "result": str(AUDIT / "build-result.json"),
                      "release_directory": str(DELIVERY), "artifacts": report["artifacts"],
                      "preservation": report["preservation"]}, indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--capture-baseline", action="store_true")
    mode.add_argument("--build", action="store_true")
    mode.add_argument("--verify-existing", action="store_true")
    arguments = parser.parse_args()
    capture_baseline() if arguments.capture_baseline else build(arguments.verify_existing)
