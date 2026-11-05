#!/usr/bin/env python3
"""Read-only host-shape probes against current production Objective-C code.

These probes identify reproduction conditions. They do not prove which private
host shape exists on the user's device and never read real preferences.
"""
from pathlib import Path
import hashlib
import json
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PREVIOUS = ROOT / "docs/audits/session-groups-native-2026-11-03/validation"
PRODUCTION = [
    "CSGroupNativeModel.m", "CSGroupNativeSessionCoordinator.m", "CSGroupNativeBridge.m",
    "CSGroupProjection.m", "CSGroupPreferences.m", "WESessionTabItem.m",
    "CSCloseFriendPolicy.m", "CSCloseFriendSignatures.m",
]

source = (PREVIOUS / "NativeGroupBehaviorTests.m").read_text()
# Match the checked-in class dump: raw source is only an ivar, and wrapper unread
# has unsigned-int ABI. Existing production bridge must support both differences.
source = source.replace("@property(nonatomic) long long mainUnReadCount;",
                        "@property(nonatomic) unsigned int mainUnReadCount;")
source = source.replace("@interface MMNewSessionMgr:NSObject\n@property(nonatomic,copy) NSArray *m_arrSession;\n@end",
                        "@interface MMNewSessionMgr:NSObject { @public NSArray *m_arrSession; }\n@end")
source = source.replace("Full.m_arrSession", "Full->m_arrSession")
probe = r'''
static void HostShapeProbes(void) {
    MMSessionInfo *a=Session(@"host-a",7);
    MainSessionInfoItem *wrapper=Wrap(a,11);
    Main.hostTop=@[];Main.hostNormal=@[wrapper];Main.hostAllTop=@[];
    Main.hostTotal=0;Full->m_arrSession=@[a];
    [Main rebuildMainSessions];
    CHECK(!Coordinator.boundary && Main.normalSessions.count==1);
    CHECK([Coordinator.model rowForSession:wrapper].unreadCount==7);
    printf("ABI-accurate ivar-only raw source and unsigned wrapper: accepted\n");

    Main.hostTop=nil;
    [Main rebuildMainSessions];
    printf("nil empty top partition: boundary=%d published_normal_count=%lu native_normal_count=%lu\n",
        Coordinator.boundary,(unsigned long)Main.normalSessions.count,(unsigned long)Main.hostNormal.count);

    Main.hostTop=@[wrapper];Main.hostAllTop=@[wrapper];Main.hostNormal=nil;Main.hostTotal=1;
    [Main rebuildMainSessions];
    printf("nil empty normal partition: boundary=%d published_top_count=%lu native_top_count=%lu\n",
        Coordinator.boundary,(unsigned long)Main.topSessions.count,(unsigned long)Main.hostTop.count);

    Main.hostTop=@[];Main.hostAllTop=@[];Main.hostNormal=@[wrapper];Main.hostTotal=0;
    Full->m_arrSession=nil;
    [Main rebuildMainSessions];
    printf("unavailable raw source with ready main arrays: boundary=%d published_normal_count=%lu native_normal_count=%lu\n",
        Coordinator.boundary,(unsigned long)Main.normalSessions.count,(unsigned long)Main.hostNormal.count);
}
'''
source = source.replace("int main(void)", probe + "\nint main(void)")
source = source.replace("ModelTests();CoordinatorTests();CompleteSourceTests();StatisticsEligibilityTests();AdapterTests(owner);SchedulingTests();ReentrantPublicationTests();",
                        "HostShapeProbes();")
source = source.replace("Native model/coordinator/adapter/scheduling: %lu behavior checks passed",
                        "Host-shape probe: %lu assertions passed; remaining lines are observations")

with tempfile.TemporaryDirectory(prefix="wechat-blank-host-shapes-") as scratch:
    work = Path(scratch)
    subprocess.run(["python3", str(PREVIOUS / "extract-production-bodies.py"), str(ROOT), str(work)], check=True)
    fixture = work / "HostShapeProbes.m"
    fixture.write_text(source)
    binary = work / "host-shapes"
    command = ["xcrun", "--sdk", "macosx", "clang", "-fobjc-arc", "-fblocks", "-Wall", "-Wextra", "-Werror",
               "-Wno-undeclared-selector", "-Wno-incomplete-implementation", "-Wno-unused-function",
               "-framework", "Foundation", "-I" + str(work), "-I" + str(PREVIOUS), "-I" + str(ROOT / "Controllers")]
    command += [str(ROOT / "Controllers" / file) for file in PRODUCTION]
    command += [str(fixture), "-o", str(binary)]
    subprocess.run(command, check=True)
    result = subprocess.run([str(binary)], check=True, capture_output=True, text=True)
    print(result.stdout, end="")
    # Preserve the original failing-source evidence on later fixed-source runs.
    output_prefix = "host-shapes-current" if (HERE / "host-shapes-output.txt").exists() else "host-shapes"
    (HERE / (output_prefix + "-output.txt")).write_text(result.stdout)
    (HERE / (output_prefix + "-source-hashes.json")).write_text(json.dumps({
        "Controllers/" + file: hashlib.sha256((ROOT / "Controllers" / file).read_bytes()).hexdigest()
        for file in PRODUCTION
    }, indent=2) + "\n")
