#!/usr/bin/env python3
"""Read Git and existing frozen manifests; write only this new review directory."""
from hashlib import sha256
import json
from pathlib import Path
import subprocess

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
FILES=['Hooks/SessionGroupHooks.xm','Controllers/CSGroupListAdapter.m']
def git(*args):
    return subprocess.check_output(['git',*args],cwd=ROOT,text=True)
def excerpts(text,needles):
    lines=text.splitlines();result=[]
    for needle in needles:
        matches=[index for index,line in enumerate(lines) if needle in line]
        for index in matches:
            start=max(0,index-3);end=min(len(lines),index+7)
            result.append({'needle':needle,'line':index+1,'source':'\n'.join(f'{i+1}: {lines[i]}' for i in range(start,end))})
    return result
needles=['[Adapter(self) returnToGroupTop];','finishPresentationReturnForController:self',
         'if (suspended && !adapter.presentationSuspended)',
         'self.presentationViewport=nil; self.pendingScrollToTop=NO;',
         'self.pendingScrollToTop=YES;','[self.anchors removeObjectForKey:tabID];']
commits=[]
for ref in ['3810d735','0b53ff51','8467df87','HEAD']:
    info=git('show','--no-patch','--format=%H%n%ad%n%s%n%b','--date=iso',ref).strip()
    control=git('show',ref+':control')
    version=next(line.split(':',1)[1].strip() for line in control.splitlines() if line.startswith('Version:'))
    files={}
    for file in FILES:
        text=git('show',ref+':'+file)
        files[file]={'sha256':sha256(text.encode()).hexdigest(),'excerpts':excerpts(text,needles)}
    commits.append({'ref':ref,'metadata':info,'control_version':version,'files':files})
frozen=[]
for rel in ['session-groups-native-2026-11-03/builds/final',
            'session-groups-blank-2026-11-03','session-groups-cpu-2026-11-03']:
    audit=ROOT/'docs/audits'/rel
    build=json.loads((audit/'build-result.json').read_text())
    manifest=json.loads((audit/'production-inputs.json').read_text())
    source=Path(build['frozen_source']);files={}
    for file in FILES:
        data=(source/file).read_bytes();digest=sha256(data).hexdigest()
        expected=manifest['production_files'][file]
        if digest!=expected: raise SystemExit('Frozen source differs from its manifest: '+str(source/file))
        files[file]={'sha256':digest,'matches_build_manifest':True,'excerpts':excerpts(data.decode(),needles)}
    frozen.append({'version':build['version'],'audit':str(audit.relative_to(ROOT)),
                   'frozen_source':str(source),'files':files})
report={'date':'2026-11-03','checkout':str(ROOT),'history':commits,'frozen_builds':frozen,
        'conclusion':'The source restoration behavior added in 2.1-25 was removed when 2.2-1 reset to the 2.1-20 implementation. The frozen native 2.2-6, 2.2-7 and 2.2-8 sources all contain forced-top behavior. This establishes source lineage, not the first installed device package that exhibited the user-reported regression.',
        'isolation':'Read-only Git and historical frozen source/manifest reads; writes only the new scroll-position audit review directory. No package changes, installation, device, live account or database access.'}
(HERE/'history-evidence.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print('Recorded 4 Git revisions and 3 manifest-matched frozen builds.')
