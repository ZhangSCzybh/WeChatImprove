#!/usr/bin/env python3
"""Compile production settings layout with iOS SDK and execute controlled host lifecycles."""
from hashlib import sha256
import json
from pathlib import Path
import re
import subprocess
import tempfile

HERE=Path(__file__).resolve().parent
ROOT=Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')


def run(command,name):
    result=subprocess.run(command,text=True,capture_output=True)
    output=result.stdout+result.stderr
    (HERE/(name+'.log')).write_text(output)
    return {'command':command,'exit_code':result.returncode,'output':output}


def coverage():
    classes={};sources={};headers=[]
    for path in (ROOT/'Controllers').glob('*.[hm]'):
        text=path.read_text()
        for name,parent in re.findall(r'@interface\s+(\w+)\s*:\s*(\w+)',text):
            classes[name]=parent;sources[name]=str(path.relative_to(ROOT))
        if path.suffix=='.h' and re.search(r'@interface\s+\w+\s*:\s*CSSettingsTableViewController',text):
            headers.append(path.name)
    def inherits(name,parent):
        seen=set()
        while name not in seen:
            if name==parent:return True
            seen.add(name);name=classes.get(name)
            if not name:return False
        return False
    descendants=sorted(name for name in classes if name!='CSSettingsTableViewController' and inherits(name,'CSSettingsTableViewController'))
    remaining=sorted(name for name,parent in classes.items() if name!='CSSettingsTableViewController' and parent=='UITableViewController')
    custom=(ROOT/'Controllers/CSCustomViewController.m').read_text()
    targets=sorted(set(re.findall(r'\[\[(CS\w+)\s+alloc\]',custom)))
    report={'migrated_direct_count':sum(parent=='CSSettingsTableViewController' for parent in classes.values()),
            'settings_table_descendants':[{'class':name,'parent':classes[name],'source':sources[name]} for name in descendants],
            'remaining_direct_UITableViewController':remaining,
            'custom_entry_allocated_targets':[{'class':name,'inherits_settings_base':inherits(name,'CSSettingsTableViewController')} for name in targets],
            'indirect_entry':'CSCustomViewController dispatches the close-friend row to CSCloseFriendManager.presentSettingsFrom:. CSCloseFriendSettingsViewController inherits CSSettingsTableViewController.',
            'scope':'All Objective-C class declarations in Controllers/*.[hm], plus concrete CS class allocations in CSCustomViewController.m. Non-table editors already constrain controls to safeAreaLayoutGuide; WEContact selector is intentionally outside this migration.'}
    assert remaining==['WEContactSelectViewController'],remaining
    assert all(inherits(name,'CSSettingsTableViewController') for name in targets),targets
    (HERE/'route-coverage.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    (HERE/'MigratedHeaders.m').write_text('\n'.join('#import "'+name+'"' for name in sorted(headers))+'\n')
    return report


def main():
    paths=['Controllers/CSSettingsTableViewController.h','Controllers/CSSettingsTableViewController.m']
    hashes={name:sha256((ROOT/name).read_bytes()).hexdigest() for name in paths}
    route=coverage();records=[]
    sdk=subprocess.check_output(['xcrun','--sdk','iphoneos','--show-sdk-path'],text=True).strip()
    with tempfile.TemporaryDirectory(prefix='wechat80-settings-') as directory:
        temporary=Path(directory)
        # These compile against Apple's actual UIKit; the SDK is not a host double.
        for arch in ['arm64','arm64e']:
            command=['xcrun','--sdk','iphoneos','clang','-target',arch+'-apple-ios15.0','-isysroot',sdk,
                     '-fobjc-arc','-Wall','-Wextra','-Werror','-Wno-deprecated-declarations',
                     '-I'+str(ROOT/'Controllers'),'-I'+str(ROOT/'Headers'),
                     '-c',str(ROOT/'Controllers/CSSettingsTableViewController.m'),'-o',str(temporary/(arch+'.o'))]
            result=run(command,'ios-'+arch)
            records.append({'name':'ios-'+arch,'accepted':result['exit_code']==0,**result})
        command=['xcrun','--sdk','iphoneos','clang','-target','arm64-apple-ios15.0','-isysroot',sdk,
                 '-fobjc-arc','-fsyntax-only','-Wall','-Wextra','-Werror','-Wno-deprecated-declarations',
                 '-I'+str(ROOT/'Controllers'),'-I'+str(ROOT/'Headers'),str(HERE/'MigratedHeaders.m')]
        result=run(command,'ios-migrated-headers')
        records.append({'name':'ios-migrated-headers','accepted':result['exit_code']==0,**result})
        source=(ROOT/'Controllers/CSSettingsTableViewController.m').read_text()
        variants=[('baseline',(HERE/'baseline-CSSettingsTableViewController.m').read_text(),'provisional.tableView.contentOffset.y==0'),
                  ('current',source,None),
                  ('negative-navigation',source.replace('self.edgesForExtendedLayout = UIRectEdgeNone;',
                                                         'self.edgesForExtendedLayout = UIRectEdgeAll;'),'edgesForExtendedLayout==UIRectEdgeNone'),
                  ('negative-bottom-addition',source.replace('content.bottom = MAX(0, content.bottom + delta);',
                                                             'content.bottom = bottom;'),'table.contentInset.bottom,12+safeBottom'),
                  ('negative-return-scroll',source.replace('[super viewDidLayoutSubviews];',
                                                           '[super viewDidLayoutSubviews];\n    self.tableView.contentOffset = CGPointMake(0,0);'),'table.contentOffset.y,retainedOffset.y')]
        for name,text,expected in variants:
            input_file=ROOT/'Controllers/CSSettingsTableViewController.m' if name=='current' else temporary/(name+'.m')
            if name!='current':input_file.write_text(text)
            executable=temporary/name
            command=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror',
                     '-framework','Foundation','-framework','CoreGraphics','-I'+str(HERE),'-I'+str(ROOT/'Controllers'),
                     str(HERE/'UIKitDouble.m'),str(input_file),str(HERE/'SettingsLifecycleTests.m'),'-o',str(executable)]
            built=run(command,name+'-build')
            if built['exit_code']:raise RuntimeError(built['output'])
            result=run([str(executable)],name)
            accepted=result['exit_code']==0 if expected is None else result['exit_code']!=0 and expected in result['output']
            records.append({'name':name,'expected_failure':expected,'accepted':accepted,**result})
            print(name,'accepted='+str(accepted),result['output'].strip())
    after={name:sha256((ROOT/name).read_bytes()).hexdigest() for name in paths}
    report={'source_sha256':hashes,'source_unchanged_during_tests':hashes==after,'sdk':sdk,'runs':records,
            'coverage':{'direct_settings_classes':route['migrated_direct_count'],'all_settings_table_descendants':len(route['settings_table_descendants']),
                        'custom_concrete_allocation_routes':len(route['custom_entry_allocated_targets'])},
            'limits':'iOS SDK object compilation validates actual Apple API types and arm64/arm64e code generation. Lifecycle execution uses actual production base-class code against a host UIKit double; it does not observe UIKit navigation animation or the user phone. No app installation, real account, database or preferences accessed.'}
    (HERE/'result.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    if hashes!=after or not all(row['accepted'] for row in records):raise SystemExit(1)
    print('PASS: iOS SDK compilation, route inheritance coverage and host lifecycle regression.')


if __name__=='__main__':main()
