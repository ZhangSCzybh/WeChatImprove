#!/usr/bin/env python3
"""Capture bounded source evidence without changing production or Tests."""
import datetime
import hashlib
import json
import pathlib
import subprocess

OUT=pathlib.Path(__file__).resolve().parent
ROOT=OUT.parents[3]
AUTH=ROOT/'docs/audits/authorization-cleanup-2026-10-28'
expected=json.loads((AUTH/'source-sha256-after.json').read_text())
sha=lambda data:hashlib.sha256(data).hexdigest()
before={p:sha((ROOT/p).read_bytes()) for p in expected}
assert before==expected
ranges={
 'Controllers/CSNativeContactPicker.m':[(35,94,'selection validates and commits only after Done/dismiss completion')],
 'Controllers/CSCloseFriendSettingsViewController.m':[(185,219,'selection result replaces friends/groups and saves profile')],
 'Controllers/CSCloseFriendBridge.m':[(7,26,'snapshot bridge and ABI-checked object read'),(44,66,'epoch-guarded profile mutation and hook installation')],
 'Controllers/CSCloseFriendManager.m':[(70,115,'runtime didChange schedules main policy publication'),(162,176,'start refreshes account synchronously'),(232,249,'account synchronization')],
 'Controllers/CSCloseFriendRuntime.m':[(28,42,'initial blocked state and changed invalidation'),(51,90,'account load and fail-closed snapshot'),(203,222,'save readback then changed; authorization gate')],
 'Controllers/CSCloseFriendStore.m':[(99,134,'validated encrypted staged save and atomic rename')],
 'Controllers/CSCloseFriendPolicy.m':[(7,9,'default options include silenceMessages YES'),(48,64,'protected union and conceal semantics')],
 'Controllers/CSGroupListAdapter.m':[(13,23,'privacy predicate excludes silence-only filtering'),(130,169,'attachment regardless group option and suspension clears cache'),(183,228,'badge getter and grouping policy observer'),(263,275,'native table proxies'),(345,394,'header and table layout boundary'),(465,476,'snapshot revision and cache rebuild'),(486,545,'refresh guards; dirty cleared before native work; no-privacy branch'),(547,638,'cache/projection publication and native table callbacks'),(695,777,'refresh scheduling and native mutation depth'),(789,819,'pending native navigation actions'),(972,982,'native cell callback'),(1002,1052,'native callback forwarding'),(1173,1190,'native title callback')],
 'Controllers/CSGroupIndexScope.m':[(1,17,'index domain is a scope, not a native-call suppression barrier')],
 'Controllers/CSGroupNativeBridge.m':[(204,218,'current-account service reads')],
 'Hooks/SessionGroupHooks.xm':[(33,56,'native notification mutation transaction and publishing predicate'),(59,101,'main-list appear/disappear and message callbacks'),(196,204,'unread-count and session notifications'),(312,338,'table reload falls through original while publishing'),(499,510,'group observer registered behind readiness gate')],
 'Hooks/CloseFriendNotificationHooks.xm':[(27,35,'ChatTab predicate and deferred constructor'),(101,129,'content hooks and policy observer force-write path')],
 'Hooks/CloseFriendLifecycleHooks.xm':[(1,9,'home appear first calls original then starts manager'),(25,35,'deferred lifecycle install then start')],
 'Hooks/TabBarStyleHooks.xm':[(1,111,'complete restored 2.1-6 style hook surface')],
 'Controllers/CSTabBarNativeAdapter.m':[(74,93,'owner and item reads'),(169,215,'item style applies original badge object geometry'),(235,257,'navigation only read for inset choice')],
 'Controllers/CSBackupBootstrap.m':[(51,61,'ready callback may run immediately'),(137,163,'atomic account epoch and suspension boundary')],
}
entries=[];markdown=['# Selection follow-up: frozen source references','',
 'Every complete source snapshot below matches the historical 2.1-6 authorization-cleanup after SHA. Lines are one-based and excerpts preserve source text.','']
for rel,segments in ranges.items():
 data=(ROOT/rel).read_bytes();assert sha(data)==expected[rel]
 dest=OUT/'sources'/rel;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(data)
 lines=data.decode().splitlines();parts=[]
 markdown.extend([f'## {rel}', '',f'SHA-256: `{sha(data)}`',''])
 for start,end,label in segments:
  end=min(end,len(lines));excerpt='\n'.join(lines[start-1:end])+'\n'
  parts.append({'start_line':start,'end_line':end,'purpose':label,'excerpt_sha256':sha(excerpt.encode())})
  markdown.extend([f'{start}–{end}: {label}','', '```objc',
                   '\n'.join(f'{n}: {lines[n-1]}' for n in range(start,end+1)), '```',''])
 entries.append({'path':rel,'sha256':sha(data),'matches_2_1_6_after':True,
                 'snapshot':str(dest.relative_to(OUT)),'references':parts})
searches=[
 ['rg','-n','setTabBarBadgeValue:forIndex:|setTabBarBadgeString:forIndex:|showRedDotOnTabBarItemAtIndex:|closeFriendAlertBadgeCount','Controllers','Hooks','Headers'],
 ['rg','-n','setViewControllers:|viewControllers\\s*=|setRootViewController:|rootViewController\\s*=','Controllers/CSTabBarNativeAdapter.m','Hooks/TabBarStyleHooks.xm'],
 ['rg','-n','viewControllers|selectedViewController|topViewController|rootViewController','Controllers/CSTabBarNativeAdapter.m','Hooks/TabBarStyleHooks.xm'],
]
search_results=[]
for command in searches:
 result=subprocess.run(command,cwd=ROOT,capture_output=True)
 search_results.append({'command':command,'exit_code':result.returncode,'stdout':result.stdout.decode(),'stderr':result.stderr.decode()})
after={p:sha((ROOT/p).read_bytes()) for p in expected}
record={'captured_at':datetime.datetime.now(datetime.timezone.utc).isoformat(),
    'authority':'docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json',
    'authority_sha256':sha((AUTH/'source-sha256-after.json').read_bytes()),'sources':entries,'searches':search_results,
    'all_602_inputs_match_before_and_after':before==after==expected,'production_or_formal_tests_modified':False,
    'build_test_or_package_run':False,'device_or_user_data_read':False,
    'limits':['source evidence proves local control flow and explicit calls, not complete native UIKit/WeChat callback effects',
              'observer ordering and actual view lifecycle timing require runtime observation',
              'native initialization evidence is captured separately by the main task']}
(OUT/'source-reference.json').write_text(json.dumps(record,ensure_ascii=False,indent=2)+'\n')
(OUT/'source-references.md').write_text('\n'.join(markdown))
assert record['all_602_inputs_match_before_and_after']
print(json.dumps({'snapshots':len(entries),'all602Stable':True,'style_container_writes_search_exit':search_results[1]['exit_code']}))
