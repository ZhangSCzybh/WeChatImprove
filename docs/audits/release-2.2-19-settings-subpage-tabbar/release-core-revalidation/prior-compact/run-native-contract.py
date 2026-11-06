#!/usr/bin/env python3
"""Run the unmodified production gates inside versioned macOS test app bundles."""
import argparse, hashlib, json, os, plistlib, subprocess, tempfile
from pathlib import Path
HERE=Path(__file__).resolve().parent
ROOT=Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
SOURCES=['CSMessageMergePolicy.m','CSMessageMergeAdapter.m','CSRevokeReference.m','CSChatNativeBridge.m',
'CSMessageNavigation.m','CSMessageTimeLayout.m','CSBubbleStylePolicy.m','CSBubbleStyleAdapter.m','CSBubbleTextColors.m']
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    parser=argparse.ArgumentParser();parser.add_argument('--phase',choices=['red','green'],required=True);args=parser.parse_args()
    source_root=HERE.parent/'baseline-2.2-14' if args.phase=='red' else ROOT
    records=[];before={n:digest(source_root/'Controllers'/n) for n in SOURCES}
    versions=['8.0.80','8.0.80.34'] if args.phase=='red' else ['8.0.78','8.0.80','8.0.80.34','8.0.81']
    with tempfile.TemporaryDirectory(prefix='wechat-2215-native-contract-') as directory:
        app=Path(directory)/'Contract.app';binary=app/'Contents/MacOS/contract';binary.parent.mkdir(parents=True)
        command=['xcrun','--sdk','macosx','clang','-DCS_MERGE_BUBBLE_INTEGRATION=1','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-unused-parameter',
        '-framework','Foundation','-framework','CoreGraphics','-framework','CoreFoundation','-I'+str(HERE/'fixtures/MergeBubbleUIKit'),'-I'+str(HERE/'fixtures/MessageUIKit'),'-I'+str(source_root/'Controllers')]
        command += [str(HERE/'fixtures/MessageUIKit/MessageUIKit.m'),str(HERE/'fixtures/MessageUIKit/DisplayLink.m'),str(HERE/'fixtures/BubbleUIKit/BubbleUIKit-production.m')]
        command += [str(source_root/'Controllers'/n) for n in SOURCES]
        command += [str(HERE/'Native8080CompactTests.m'),'-o',str(binary)]
        built=subprocess.run(command,text=True,capture_output=True);(HERE/(args.phase+'-build.log')).write_text(built.stdout+built.stderr)
        if built.returncode: raise RuntimeError(built.stdout+built.stderr)
        for version in versions:
            (app/'Contents/Info.plist').write_bytes(plistlib.dumps({'CFBundleExecutable':'contract','CFBundleIdentifier':'test.wechat2215.compact','CFBundleShortVersionString':version,'CFBundlePackageType':'APPL'}))
            env=os.environ.copy()
            run=subprocess.run([str(binary)],text=True,capture_output=True,env=env);output=run.stdout+run.stderr
            (HERE/(args.phase+'-'+version+'.log')).write_text(output)
            accepted=run.returncode!=0 and 'actual=21.000 target=2.000' in output if args.phase=='red' else run.returncode==0
            records.append({'version':version,'exit_code':run.returncode,'accepted':accepted,'log':args.phase+'-'+version+'.log','summary':next((line for line in output.splitlines() if line.startswith(('PASS:', 'FAIL:'))), output.splitlines()[-1])})
            print(args.phase,version,'accepted='+str(accepted),records[-1]['summary'])
    after={n:digest(source_root/'Controllers'/n) for n in SOURCES}
    report={'phase':args.phase,'production_source_root':str(source_root),'source_sha256':before,'source_unchanged_during_run':before==after,
    'test_sha256':digest(HERE/'Native8080CompactTests.m'),'command':command,'runs':records,
    'scope':'Host macOS Foundation execution; actual production adapters and original version gates, no CS_MERGE_TESTING or CS_BUBBLE_TESTING. UIKit/native classes and 8+38+9 geometry are controlled doubles; no actual phone or IPA process was run.'}
    (HERE/(args.phase+'-result.json')).write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    if before!=after or not all(r['accepted'] for r in records): raise SystemExit(1)
if __name__=='__main__': main()
