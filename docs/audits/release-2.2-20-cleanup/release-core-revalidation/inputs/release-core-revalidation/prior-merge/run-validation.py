#!/usr/bin/env python3
"""Compile the actual merge adapter against a controlled native/UIKit boundary."""
from hashlib import sha256
import json
import os
from pathlib import Path
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
FIXTURES = HERE / "fixtures"


def run(command, log_name, environment=None):
    result = subprocess.run(command, text=True, capture_output=True, env=environment)
    output = result.stdout + result.stderr
    (HERE / log_name).write_text(output)
    return {"exit_code": result.returncode, "output": output}


def main():
    sources = ["CSMessageMergePolicy.m", "CSMessageMergeAdapter.m", "CSRevokeReference.m",
               "CSChatNativeBridge.m", "CSMessageNavigation.m", "CSMessageTimeLayout.m"]
    hashes = {name: sha256((ROOT / "Controllers" / name).read_bytes()).hexdigest() for name in sources}
    records = []
    with tempfile.TemporaryDirectory(prefix="wechat80-merge-") as directory:
        temporary = Path(directory)
        common = ["xcrun", "--sdk", "macosx", "clang", "-DCS_MERGE_TESTING=1", "-fobjc-arc", "-fblocks",
                  "-Wall", "-Wextra", "-Werror", "-Wno-unused-parameter", "-framework", "Foundation",
                  "-framework", "CoreGraphics", "-framework", "CoreFoundation",
                  "-I" + str(FIXTURES / "MessageUIKit"), "-I" + str(ROOT / "Controllers")]
        for kind in ["baseline", "current"]:
            adapter = HERE / "baseline-CSMessageMergeAdapter.m" if kind == "baseline" else ROOT / "Controllers/CSMessageMergeAdapter.m"
            executable = temporary / kind
            command = common + [str(FIXTURES / "MessageUIKit/MessageUIKit.m"),
                                str(FIXTURES / "MessageUIKit/DisplayLink.m")]
            command += [str(adapter if name == "CSMessageMergeAdapter.m" else ROOT / "Controllers" / name) for name in sources]
            command += [str(FIXTURES / "MessageMergeAdapterTests.m"), "-o", str(executable)]
            built = run(command, kind + "-build.log")
            if built["exit_code"]:
                raise RuntimeError(built["output"])
            for version in ["8.0.78", "8.0.80", "8.0.80.34"]:
                environment = os.environ.copy()
                environment["WECHAT_PROFILE"] = version
                result = run([str(executable)], kind + "-" + version + ".log", environment)
                expected_pass = kind == "current" or version == "8.0.78"
                accepted = result["exit_code"] == 0 if expected_pass else result["exit_code"] != 0 and "FAIL line" in result["output"]
                records.append({"source": kind, "profile": version, "expected_pass": expected_pass,
                                "accepted": accepted, **result})
                print(kind, version, "accepted=" + str(accepted), result["output"].strip())
        policy = temporary / "policy"
        command = ["xcrun", "--sdk", "macosx", "clang", "-fobjc-arc", "-Wall", "-Wextra", "-Werror",
                   "-framework", "Foundation", "-I" + str(ROOT / "Controllers"),
                   str(ROOT / "Controllers/CSMessageMergePolicy.m"), str(FIXTURES / "MessageMergePolicyTests.m"),
                   "-o", str(policy)]
        built = run(command, "policy-build.log")
        if built["exit_code"]:
            raise RuntimeError(built["output"])
        result = run([str(policy)], "policy.log")
        records.append({"source": "current-policy", "accepted": result["exit_code"] == 0, **result})
        print(result["output"].strip())
    after = {name: sha256((ROOT / "Controllers" / name).read_bytes()).hexdigest() for name in sources}
    report = {"source_sha256": hashes, "source_unchanged_during_tests": hashes == after, "runs": records,
              "scope": "Host Foundation execution of actual production merge adapter/policy and navigation/time dependencies. UIKit and native WeChat message objects are fixtures. No phone/app installation, real database, account or settings accessed.",
              "coverage": "First/middle/last compact seams, native sizes and hit regions, voice/transcript internal layout, unsupported auxiliary content, quoted replies, fractional geometry, unknown versions, cell reuse, settings disable/restore, native cache invalidation, mutation, background/scene/menu suspension."}
    (HERE / "result.json").write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
    if hashes != after or not all(record["accepted"] for record in records):
        raise SystemExit(1)


if __name__ == "__main__":
    main()
