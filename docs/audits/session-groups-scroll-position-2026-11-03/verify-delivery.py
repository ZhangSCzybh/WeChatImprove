#!/usr/bin/env python3
"""Verify the cleaned release, exact source inputs and preserved historical evidence."""
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile

AUDIT=Path(__file__).resolve().parent
ROOT=AUDIT.parents[2]
REMOVED=('Controllers/CSGroupPerformanceObservation.h','Controllers/CSGroupPerformanceObservation.m',
         'Hooks/SessionGroupPerformanceObservation.xm')
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(p.read_text())
def command(args):return subprocess.check_output(args,text=True,stderr=subprocess.STDOUT)
def main():
    initial_status=(AUDIT/'initial-git-status.z').read_bytes()
    current_status=subprocess.check_output(['git','status','--porcelain=v1','-z','--untracked-files=no'],cwd=ROOT)
    deleted=lambda data:{row[3:] for row in data.split(b'\0') if b'D' in row[:2]}
    previous,current=deleted(initial_status),deleted(current_status)
    assert previous==current
    assert not (ROOT/'Tests').exists()
    initial=read(AUDIT/'initial-source-hashes.json')
    baseline={n:d for n,d in initial.items() if not n.startswith('HeadersFile/')}
    assert all(sha(AUDIT/'baseline-2.2-10'/n)==d for n,d in baseline.items())
    removed=sorted(n for n in initial if not (ROOT/n).exists())
    assert removed==sorted(REMOVED)
    changed=sorted(n for n,d in initial.items() if (ROOT/n).exists() and sha(ROOT/n)!=d)
    assert changed==sorted(['Controllers/CSGroupListAdapter.h','Controllers/CSGroupListAdapter.m',
        'Hooks/SessionGroupHooks.xm','Headers/CSUserInfoHelper.h','Controllers/CSReleaseNotesViewController.m','control','Makefile']),changed
    core=[p for folder in ('Controllers','Hooks','Headers') for p in (ROOT/folder).rglob('*')
          if p.is_file() and p.suffix in {'.h','.m','.xm'}]
    forbidden=('CSGroupPerformance','CS_GROUP_PERFORMANCE_OBSERVATION','returnToGroupTop','pendingScrollToTop','applyPendingScrollToTop')
    for p in core+[ROOT/'Makefile']:
        text=p.read_text()
        assert not any(marker in text for marker in forbidden),str(p)
    preserved={}
    for name in ('session-groups-instruments-2026-11-03','session-groups-instruments-2.2-9-2026-11-03','session-groups-efficiency-2026-11-03'):
        folder=ROOT/'docs/audits'/name
        manifest=read(folder/'evidence-manifest.json')
        assert all(sha(folder/r['path'])==r['sha256'] for r in manifest['files'])
        preserved[name]=len(manifest['files'])
    folder=AUDIT/'builds/final/normal'
    build=read(folder/'build-result.json')
    assert build['version']=='2.2-11' and build['observation_removed'] and not build['device_installed']
    assert all(r['exit_code']==0 for r in build['builds'])
    assert build['inputs_unchanged'] and build['historical_packages_preserved']
    before=read(folder/'production-inputs.json')['production_files']
    assert all(sha(ROOT/n)==d for n,d in before.items())
    assert read(folder/'effective-inputs.json')==read(folder/'production-inputs.json')
    history=read(folder/'historical-packages-before.json')
    assert all(sha(ROOT/n)==d for n,d in history.items())
    packages=[]
    with tempfile.TemporaryDirectory(prefix='wechat-clean-release-check-') as temp:
        for artifact in build['artifacts']:
            assert sha(ROOT/artifact['path'])==artifact['sha256']
            if not artifact['path'].endswith('.deb'):continue
            target=Path(temp)/Path(artifact['path']).name;target.mkdir()
            subprocess.run(['dpkg-deb','-x',str(ROOT/artifact['path']),str(target)],check=True)
            dylibs=list(target.rglob('WeChatImprove.dylib'));assert len(dylibs)==1
            slices={}
            for arch in ('arm64','arm64e'):
                thin=target/(arch+'.dylib')
                subprocess.run(['xcrun','lipo',str(dylibs[0]),'-thin',arch,'-output',str(thin)],check=True)
                strings=command(['strings',str(thin)])
                symbols=command(['xcrun','nm',str(thin)])
                for marker in ('com.wechatimprove.performance','ModelFull','ModelDelta','ModelSelection',
                               'AdapterPublication','ReloadDispatchUnverified','AdapterProjectionBuild',
                               'CompatibilityPublication','AdapterLayoutAttempt',*forbidden):
                    assert marker not in strings,(arch,marker)
                assert '_CSGroupPerformanceBegin' not in symbols and '_os_signpost_emit_with_name_impl' not in symbols
                for method in ('modelBySelectingTabID:fromResult:foldedRows:','refreshInteractionIsBlocking',
                               'nativeSectionsForAccount:changes:changedUserNames:',
                               'publishProjection:previous:changes:changedUserNames:previouslyProjecting:',
                               'finishPresentationReturnForController:','beginUserScrolling','restorePendingViewport'):
                    assert method in strings,(arch,method)
                slices[arch]={'removed_code_absent':True,'core_optimization_and_scroll_methods_present':True}
            packages.append({'path':artifact['path'],'sha256':artifact['sha256'],'slices':slices})
    assert len(packages)==2
    result={'checkout':str(ROOT),'device_installed':False,
            'previous_tracked_deletions_preserved':len(previous),'root_tests_remain_deleted':True,
            'frozen_baseline_files_verified':len(baseline),'prior_audits_preserved':preserved,
            'production_changes_from_initial_snapshot':changed,'removed_observation_files':removed,
            'obsolete_scroll_to_top_state_absent':True,'observation_source_and_binary_absent':True,
            'historical_packages_preserved':True,'historical_package_artifacts_checked':len(history),
            'build_source_matches_current_production':True,'frozen_source_transformed':False,
            'verified_packages':packages}
    (AUDIT/'delivery-integrity.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps(result,ensure_ascii=False,indent=2))
if __name__=='__main__':main()
