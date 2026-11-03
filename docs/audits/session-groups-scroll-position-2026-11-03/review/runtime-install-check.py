#!/usr/bin/env python3
"""Independent macOS ObjC runtime check; writes only this new review directory.

Production function bodies are copied verbatim. UIKit/WeChat and Substrate are
unavailable on this host, so adapter delivery and MSHookMessageEx are controlled
substitutes. This checks optional-selector installation and preserved returns,
not a claim of iPhone runtime or Instruments verification.
"""
from pathlib import Path
import datetime
import hashlib
import json
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def function(text, prefix):
    start = text.index(prefix)
    brace = text.index("{", start)
    depth = 1
    at = brace + 1
    while depth:
        depth += (text[at] == "{") - (text[at] == "}")
        at += 1
    return text[start:at]


hook = ROOT / "Hooks/SessionGroupHooks.xm"
bridge = ROOT / "Controllers/CSCloseFriendBridge.m"
signatures = ROOT / "Controllers/CSCloseFriendSignatures.m"
hook_text = hook.read_text()
bridge_text = bridge.read_text()
signature_text = signatures.read_text().split("\n", 1)[1]
bodies = [
    function(hook_text, "static BOOL MainScrollToTop("),
    function(hook_text, "static void InstallMainScrollToTopHook("),
    function(bridge_text, "BOOL CSCloseFriendInstallHook("),
]
prelude = r'''
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#include <string.h>
#include <stdio.h>
static NSUInteger Assertions, HookCalls, OriginalCalls, ClearCalls, CapabilityCalls;
static BOOL LastCapability;
static void Check(BOOL condition, const char *text) {
    Assertions++;
    if (!condition) { fprintf(stderr,"Assertion failed: %s\n",text); exit(2); }
}
#define CHECK(x) Check((x),#x)
@interface CSGroupListAdapter : NSObject
+ (instancetype)adapterForTable:(id)table;
- (void)beginUserScrolling;
@end
@implementation CSGroupListAdapter
+ (instancetype)adapterForTable:(id)table {
    static CSGroupListAdapter *adapter;
    if (!adapter) adapter=[CSGroupListAdapter new];
    return table ? adapter : nil;
}
- (void)beginUserScrolling { ClearCalls++; }
@end
static void CSCloseFriendRecordCapability(NSString *name, BOOL value) {
    CHECK([name isEqual:@"NewMainFrameViewController.scrollViewShouldScrollToTop:"]);
    CapabilityCalls++; LastCapability=value;
}
static void MSHookMessageEx(Class cls, SEL sel, IMP replacement, IMP *original) {
    HookCalls++;
    Method method=class_getInstanceMethod(cls,sel);
    CHECK(method!=NULL);
    *original=method_getImplementation(method);
    class_replaceMethod(cls,sel,replacement,method_getTypeEncoding(method));
}
static BOOL (*MainScrollToTopOriginal)(id,SEL,id);
BOOL CSCloseFriendInstallHook(NSString *,NSString *,IMP,IMP *,const char *);
static BOOL OriginalYes(id owner,SEL sel,id table) {(void)owner;(void)sel;(void)table;OriginalCalls++;return YES;}
static BOOL OriginalNo(id owner,SEL sel,id table) {(void)owner;(void)sel;(void)table;OriginalCalls++;return NO;}
static NSInteger WrongABI(id owner,SEL sel,id table) {(void)owner;(void)sel;(void)table;OriginalCalls++;return 73;}
'''
main = r'''
int main(int argc,const char **argv) {
    @autoreleasepool {
        CHECK(argc==2); NSString *mode=[NSString stringWithUTF8String:argv[1]];
        BOOL missingClass=[mode isEqual:@"missing-class"];
        BOOL missingMethod=[mode isEqual:@"missing-method"];
        BOOL wrong=[mode isEqual:@"wrong-abi"];
        BOOL inherited=[mode hasPrefix:@"inherited-"];
        BOOL rejected=[mode hasSuffix:@"no"];
        SEL selector=@selector(scrollViewShouldScrollToTop:);
        Class parent=NSObject.class, cls=Nil;
        if (inherited) {
            parent=objc_allocateClassPair(NSObject.class,"RuntimeParent",0);
            CHECK(class_addMethod(parent,selector,(IMP)(rejected ? OriginalNo : OriginalYes),"B@:@"));
            objc_registerClassPair(parent);
        }
        if (!missingClass) {
            cls=objc_allocateClassPair(parent,"NewMainFrameViewController",0);
            CHECK(cls!=Nil);
            if (!missingMethod && !inherited)
                CHECK(class_addMethod(cls,selector,wrong ? (IMP)WrongABI : (IMP)(rejected ? OriginalNo : OriginalYes),wrong ? "q@:@" : "B@:@"));
            objc_registerClassPair(cls);
        }
        IMP parentBefore=inherited ? method_getImplementation(class_getInstanceMethod(parent,selector)) : NULL;
        InstallMainScrollToTopHook();
        if (missingClass) {
            CHECK(HookCalls==0 && MainScrollToTopOriginal==NULL && ClearCalls==0);
        } else {
            id owner=[[cls alloc] init], table=[NSObject new];
            CHECK(class_getInstanceMethod(cls,selector)!=NULL);
            if (wrong) {
                NSInteger result=((NSInteger(*)(id,SEL,id))objc_msgSend)(owner,selector,table);
                CHECK(result==73 && HookCalls==0 && OriginalCalls==1 && ClearCalls==0);
                CHECK(CapabilityCalls==1 && !LastCapability);
            } else {
                BOOL result=((BOOL(*)(id,SEL,id))objc_msgSend)(owner,selector,table);
                CHECK(result==!rejected);
                CHECK(ClearCalls==(rejected ? 0U : 1U));
                CHECK(OriginalCalls==(missingMethod ? 0U : 1U));
                CHECK(HookCalls==(missingMethod ? 0U : 1U));
                CHECK((MainScrollToTopOriginal==NULL)==missingMethod);
                if (!missingMethod) CHECK(CapabilityCalls==1 && LastCapability);
            }
            if (inherited) {
                CHECK(method_getImplementation(class_getInstanceMethod(parent,selector))==parentBefore);
                BOOL parentResult=((BOOL(*)(id,SEL,id))objc_msgSend)([[parent alloc] init],selector,table);
                CHECK(parentResult==!rejected && ClearCalls==(rejected ? 0U : 1U));
            }
        }
        printf("{\"case\":\"%s\",\"assertions\":%lu,\"hook_calls\":%lu,\"original_calls\":%lu,\"pending_clears\":%lu}\n",
            mode.UTF8String,(unsigned long)Assertions,(unsigned long)HookCalls,(unsigned long)OriginalCalls,(unsigned long)ClearCalls);
    }
}
'''
combined = prelude + signature_text + "\n" + "\n".join(bodies) + main
cases = ["missing-method", "direct-yes", "direct-no", "inherited-yes", "inherited-no", "wrong-abi", "missing-class"]
with tempfile.TemporaryDirectory(prefix="objc-runtime-", dir=HERE) as temporary:
    temporary = Path(temporary)
    source, binary = temporary / "runtime.m", temporary / "runtime"
    source.write_text(combined)
    compile_result = subprocess.run(
        ["xcrun", "clang", "-fobjc-arc", "-fblocks", "-Wall", "-Wextra", "-Werror", "-framework", "Foundation", str(source), "-o", str(binary)],
        text=True, capture_output=True,
    )
    if compile_result.returncode:
        raise SystemExit(compile_result.stderr)
    case_results = []
    for case in cases:
        result = subprocess.run([str(binary), case], check=True, text=True, capture_output=True)
        case_results.append(json.loads(result.stdout))
record = {
    "scope": "Independent macOS Objective-C runtime review of exact production optional-scroll-to-top installation functions",
    "generated_at": datetime.datetime.now(datetime.timezone.utc).isoformat(),
    "production_inputs": {str(path.relative_to(ROOT)): sha(path) for path in [hook, bridge, signatures]},
    "source_body_sha256": hashlib.sha256("\n".join(bodies).encode()).hexdigest(),
    "harness_sha256": hashlib.sha256(combined.encode()).hexdigest(),
    "cases": case_results,
    "total_assertions": sum(case["assertions"] for case in case_results),
    "passed": True,
    "limitations": ["macOS Foundation runtime, not the iPhone UIKit lifecycle", "MSHookMessageEx replaced with class_replaceMethod retaining the original IMP", "adapter notification receiver controlled and counted; no device or real account touched"],
}
(HERE / "runtime-install-result.json").write_text(json.dumps(record, indent=2, ensure_ascii=False) + "\n")
print(json.dumps({"passed": record["passed"], "cases": len(cases), "assertions": record["total_assertions"]}))
