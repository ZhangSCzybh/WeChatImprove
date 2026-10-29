#!/usr/bin/env python3
"""Run the unchanged historical geometry probe; write new audit evidence only."""
import datetime
import hashlib
import json
import pathlib
import subprocess
import time

AUDIT=pathlib.Path(__file__).resolve().parent
ROOT=AUDIT.parents[2]
OLD=ROOT/'docs/audits/tabbar-badge-2026-10-28'
AUTH=ROOT/'docs/audits/authorization-cleanup-2026-10-28'
LOGS=AUDIT/'logs'
LOGS.mkdir(exist_ok=True)
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def dump(name,data):(AUDIT/name).write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')
expected=json.loads((AUTH/'source-sha256-after.json').read_text())
source_before={rel:sha(ROOT/rel) for rel in expected}
assert source_before==expected,'current source does not match delivered 2.1-6'
old_before={str(p.relative_to(ROOT)):sha(p) for p in OLD.rglob('*') if p.is_file()}
input_paths=['Controllers/CSTabBarNativeAdapter.m','Controllers/CSTabBarNativeAdapter.h',
    'Controllers/CSTabBarPreferences.m','Controllers/CSTabBarPreferences.h','Controllers/CSPreferenceRefresh.h',
    'Headers/CSTabBarGeometry.h','Tests/TabBarUIKit/TabBarUIKit.m','Tests/TabBarUIKit/UIKit/UIKit.h',
    'docs/audits/tabbar-badge-2026-10-28/probe/run.sh',
    'docs/audits/tabbar-badge-2026-10-28/probe/TabBarBadgeProbe.m']
inputs_before={rel:sha(ROOT/rel) for rel in input_paths}
command=['bash','docs/audits/tabbar-badge-2026-10-28/probe/run.sh','flexible-left-margin']
started=datetime.datetime.now(datetime.timezone.utc).isoformat();begin=time.monotonic()
with (LOGS/'geometry-2.1-6.json').open('wb') as stdout, (LOGS/'geometry-2.1-6.stderr.log').open('wb') as stderr:
    result=subprocess.run(command,cwd=ROOT,stdout=stdout,stderr=stderr,check=False)
elapsed=time.monotonic()-begin
inputs_after={rel:sha(ROOT/rel) for rel in input_paths}
source_after={rel:sha(ROOT/rel) for rel in expected}
old_after={str(p.relative_to(ROOT)):sha(p) for p in OLD.rglob('*') if p.is_file()}
record={'started_at':started,'command':command,'cwd':str(ROOT),'exit_code':result.returncode,
    'elapsed_seconds':round(elapsed,3),'stdout':'logs/geometry-2.1-6.json',
    'stdout_sha256':sha(LOGS/'geometry-2.1-6.json'),'stderr':'logs/geometry-2.1-6.stderr.log',
    'stderr_sha256':sha(LOGS/'geometry-2.1-6.stderr.log'),'stderr_bytes':(LOGS/'geometry-2.1-6.stderr.log').stat().st_size,
    'input_sha256_before':inputs_before,'input_sha256_after':inputs_after,
    'inputs_unchanged':inputs_before==inputs_after,'source_manifest_count':len(expected),
    'all_602_sources_match_2_1_6_before_and_after':source_before==source_after==expected,
    'historical_audit_file_count':len(old_before),'historical_audit_unchanged':old_before==old_after,
    'scope':'isolated host compile/run only; no iOS plugin build/package/device execution',
    'limitations':['geometry model and native badge width inputs are controlled host substitutes, not device readings',
       'the unchanged diagnostic probe exits zero after collecting counters even when geometry failure counters are nonzero',
       'temporary compile/icon outputs and isolated UUID defaults suite are created and cleaned by historical probe']}
if result.returncode==0:
    data=json.loads((LOGS/'geometry-2.1-6.json').read_text())
    fields=['flexibleLeftMarginModeled','combinations','observations','nonzeroFailures','hiddenFailures',
       'emptyIntersectionFailures','hiddenAncestorFailures','identityFailures','repeatedDriftFailures',
       'restoreFailures','maxRepeatedOriginError','maxRestoreOriginError','notFullyContainedObservations',
       'nativeIconCalls','nativeBadgeCalls','nativeReloadCalls']
    record['summary']={key:data[key] for key in fields}
    prior=json.loads((OLD/'probe/flexible-left-margin-results.json').read_text())
    record['matches_historical_summary']={key:data[key]==prior[key] for key in fields}
dump('geometry-run-result.json',record)
assert result.returncode==0,record
assert record['inputs_unchanged'] and record['all_602_sources_match_2_1_6_before_and_after'] and record['historical_audit_unchanged']
print(json.dumps(record['summary'],ensure_ascii=False))
