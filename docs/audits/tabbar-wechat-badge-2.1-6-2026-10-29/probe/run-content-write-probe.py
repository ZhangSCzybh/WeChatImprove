#!/usr/bin/env python3
"""Freeze historical-matching sources, extract exact bodies, compile host probe."""
import datetime
import hashlib
import json
import pathlib
import subprocess

PROBE=pathlib.Path(__file__).resolve().parent
ROOT=PROBE.parents[3]
AUTH=ROOT/'docs/audits/authorization-cleanup-2026-10-28'
AFTER=json.loads((AUTH/'source-sha256-after.json').read_text())

def sha(data): return hashlib.sha256(data).hexdigest()
def dump(name,data): (PROBE/name).write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')

def balanced(source,opening):
    depth=0;state='code';i=opening
    while i<len(source):
        c=source[i];n=source[i:i+2]
        if state=='line':
            if c=='\n':state='code'
        elif state=='block':
            if n=='*/':state='code';i+=1
        elif state in ('string','char'):
            if c=='\\':i+=1
            elif c==('"' if state=='string' else "'"):state='code'
        elif n=='//':state='line';i+=1
        elif n=='/*':state='block';i+=1
        elif c=='"':state='string'
        elif c=="'":state='char'
        elif c=='{':depth+=1
        elif c=='}':
            depth-=1
            if depth==0:return i+1
        i+=1
    raise AssertionError('unbalanced source')

files=['Controllers/CSGroupListAdapter.m','Hooks/CloseFriendNotificationHooks.xm',
       'Controllers/CSCloseFriendPolicy.h','Controllers/CSCloseFriendPolicy.m',
       'Controllers/CSGroupProjection.h','Controllers/CSGroupProjection.m',
       'Controllers/WESessionTabItem.h','Controllers/WESessionTabItem.m']
source_bytes={rel:(ROOT/rel).read_bytes() for rel in files}
records=[]
for rel,data in source_bytes.items():
    assert sha(data)==AFTER[rel],f'not historical 2.1-6: {rel}'
    dest=PROBE/'sources'/rel;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(data)
    records.append({'path':rel,'sha256':sha(data),'matches_authorization_cleanup_after':True})

extracts=[]
def extract(rel,marker,output,block=False):
    source=source_bytes[rel].decode();start=source.index(marker)
    if block:start=source.index('^',start)
    end=balanced(source,source.index('{',start));text=source[start:end]
    out=PROBE/'extracted'/output;out.parent.mkdir(parents=True,exist_ok=True);out.write_text(text+'\n')
    extracts.append({'source':rel,'marker':marker,'output':str(out.relative_to(PROBE)),
                     'source_start_line':source.count('\n',0,start)+1,'source_end_line':source.count('\n',0,end)+1,
                     'body_sha256':sha(text.encode()),'file_sha256':sha(out.read_bytes()),'source_unchanged':True})
extract(files[0],'+ (NSNumber *)closeFriendAlertBadgeCount','closeFriendAlertBadgeCount.inc')
extract(files[1],'static BOOL ChatTab(','ChatTab.inc')
for var,name in [('tab','numeric'),('tabString','string'),('dot','dot')]:
    extract(files[1],f'__block IMP {var}=NULL;',f'{name}-block.inc',True)

dump('content-source-manifest.json',{'captured_at':datetime.datetime.now(datetime.timezone.utc).isoformat(),
    'authority':str((AUTH/'source-sha256-after.json').relative_to(ROOT)),
    'authority_sha256':sha((AUTH/'source-sha256-after.json').read_bytes()),'sources':records,'extracts':extracts,
    'harness_sha256':sha((PROBE/'content-write-probe.m').read_bytes()),
    'runner_sha256':sha(pathlib.Path(__file__).read_bytes())})

binary=PROBE/'content-write-probe-host'
command=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror',
         '-Wno-unused-parameter','-framework','Foundation','-I'+str(PROBE/'sources/Controllers'),
         '-I'+str(PROBE/'extracted'),str(PROBE/'sources/Controllers/CSCloseFriendPolicy.m'),
         str(PROBE/'sources/Controllers/CSGroupProjection.m'),str(PROBE/'sources/Controllers/WESessionTabItem.m'),
         str(PROBE/'content-write-probe.m'),'-o',str(binary)]
compiled=subprocess.run(command,cwd=ROOT,capture_output=True)
(PROBE/'content-compile.log').write_bytes(compiled.stdout+compiled.stderr)
dump('content-build-result.json',{'command':command,'exit_code':compiled.returncode,
                                'log':'content-compile.log','device_or_package_build':False})
assert compiled.returncode==0,compiled.stderr.decode()
results=[]
quadrant_rows={}
for style in (0,1):
    for phase in ('cold','message'):
        run=subprocess.run([str(binary),str(style),phase],cwd=PROBE,capture_output=True)
        name=f'content-style-{style}-{phase}.jsonl';(PROBE/name).write_bytes(run.stdout)
        (PROBE/f'content-style-{style}-{phase}.stderr.log').write_bytes(run.stderr)
        assert run.returncode==0,(name,run.stderr.decode())
        rows=[json.loads(line) for line in run.stdout.splitlines()]
        quadrant_rows[(style,phase)]=rows
        results.append({'style_label':bool(style),'phase':phase,'exit_code':run.returncode,
                        'log':name,'log_sha256':sha(run.stdout),'summary':rows[-1]})
stable=all((ROOT/rel).read_bytes()==data for rel,data in source_bytes.items())
assert stable,'production inputs changed during probe'
def normalized(rows):
    rows=json.loads(json.dumps(rows))
    for row in rows:
        row.pop('styleLabelOnly',None)
        for field in ('before','after'):
            if field in row:row[field].pop('object',None)
    return rows
style_parity={phase:normalized(quadrant_rows[(0,phase)])==normalized(quadrant_rows[(1,phase)]) for phase in ('cold','message')}
assert all(style_parity.values()),style_parity
dump('content-results.json',{'status':'passed','production_sources_stable':stable,'quadrants':results,
    'style_label_content_parity_ignoring_object_addresses':style_parity,
    'host_executable_sha256':sha(binary.read_bytes()),'production_or_formal_tests_modified':False,
    'device_data_read':False,'package_build_or_install':False,
    'limits':['style on/off is a controlled label; actual style implementation is deliberately not loaded',
              'cold means no notification setter invoked in the controlled host, not an observed cold-start path',
              'message invokes the exact extracted hook blocks with synthetic input; actual device state/order is unknown',
              'badge content/hidden writes and fixed frame in original IMPs are explicit native host fixtures',
              'real policy/projection/tab model sources are compiled; account/cache/controller/thread are controlled boundaries',
              'this probe does not establish device clipping, geometry, visibility or causality of the user incident']})
print(json.dumps({'status':'passed','quadrants':len(results),'checks':sum(r['summary']['checks'] for r in results),
                  'rows':sum(r['summary']['rows'] for r in results)},ensure_ascii=False))
