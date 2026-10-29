#!/usr/bin/env python3
"""Run new expected behavior against byte-exact legacy 2.1-6 code; expect red."""
import hashlib,json,subprocess
from pathlib import Path
P=Path(__file__).resolve().parent
R=P.parents[3]
sha=lambda data:hashlib.sha256(data).hexdigest()
authority=json.loads((R/'docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json').read_text())
files=['Controllers/CSGroupListAdapter.m','Hooks/CloseFriendNotificationHooks.xm','Controllers/CSCloseFriendPolicy.h','Controllers/CSCloseFriendPolicy.m','Controllers/CSGroupProjection.h','Controllers/CSGroupProjection.m','Controllers/WESessionTabItem.h','Controllers/WESessionTabItem.m']
original={name:(R/name).read_bytes() for name in files}
for name,data in original.items():
    assert sha(data)==authority[name],name
    dest=P/'sources'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(data)
def extract(path,marker,dest,block=False):
    source=original[path].decode();start=source.index(marker)
    if block:start=source.index('^',start)
    opening=source.index('{',start);depth=0
    for end in range(opening,len(source)):
        if source[end]=='{':depth+=1
        elif source[end]=='}':
            depth-=1
            if depth==0:break
    body=source[start:end+1];(P/dest).write_text(body+'\n')
    return {'source':path,'sourceLine':source.count('\n',0,start)+1,'bodySha256':sha(body.encode()),'output':dest}
extracts=[extract(files[0],'+ (NSNumber *)closeFriendAlertBadgeCount','legacy-getter.inc'),extract(files[1],'static BOOL ChatTab(','legacy-ChatTab.inc'),extract(files[1],'__block IMP tab=NULL;','legacy-numeric.inc',True)]
command=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-framework','Foundation','-I'+str(P/'sources/Controllers'),'-I'+str(P),*[str(P/'sources'/name) for name in ['Controllers/CSCloseFriendPolicy.m','Controllers/CSGroupProjection.m','Controllers/WESessionTabItem.m']],str(P/'legacy-tab-red.m'),'-o',str(P/'legacy-tab-red-host')]
compiled=subprocess.run(command,capture_output=True);(P/'compile.log').write_bytes(compiled.stdout+compiled.stderr)
assert compiled.returncode==0,compiled.stderr.decode()
run=subprocess.run([str(P/'legacy-tab-red-host')],capture_output=True);(P/'events.jsonl').write_bytes(run.stdout);(P/'stderr.log').write_bytes(run.stderr)
events=[json.loads(x) for x in run.stdout.splitlines()]
assert run.returncode==1 and len(events)==2 and all(not x['passed'] for x in events)
assert events[0]['legacyGetter']==7 and events[0]['originalNumericArgument']==7
assert events[1]['legacyGetter']==0 and events[1]['originalNumericArgument']==0
assert all((R/name).read_bytes()==data for name,data in original.items())
report={'status':'expected-red','compileExitCode':compiled.returncode,'runExitCode':run.returncode,'behaviorFailures':2,'compileCommand':command,'sourcesMatchHistorical2_1_6':True,'productionUnchangedDuringRun':True,'sources':{name:sha(data) for name,data in original.items()},'extracts':extracts,'eventsSha256':sha(run.stdout),'expectedFailures':['revealed native10 is replaced with7','dirty same-boundary update writes numeric0 instead of holding'],'deviceDataRead':False,'iosBuild':False}
(P/'results.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'status':report['status'],'compileExitCode':0,'runExitCode':1,'behaviorFailures':2},ensure_ascii=False))
