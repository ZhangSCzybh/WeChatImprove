from pathlib import Path
import hashlib,json,shutil,subprocess,tempfile,sys
assert len(sys.argv)==3, 'usage: build_online.py PATCHED_SOURCE NEW_AUDIT_OUTPUT'
ROOT=Path(sys.argv[1]).resolve()
AUDIT=Path(sys.argv[2]).resolve()
AUDIT.mkdir(parents=True,exist_ok=False)
SCRATCH=Path(tempfile.mkdtemp(prefix='wechatimprove-2513-online2-',dir='/private/tmp'))
SOURCE=SCRATCH/'source'
SOURCE.mkdir()
paths=sorted([p.relative_to(ROOT) for folder in ['Controllers','Headers','Hooks'] for p in (ROOT/folder).rglob('*') if p.is_file() and p.suffix in ['.m','.h','.xm']]+[Path('Makefile'),Path('control'),Path('WeChatImprove.plist')])
inputs={}
for relative in paths:
    target=SOURCE/relative
    target.parent.mkdir(parents=True,exist_ok=True)
    shutil.copy2(ROOT/relative,target)
    inputs[str(relative)]=hashlib.sha256(target.read_bytes()).hexdigest()
assert len(inputs)==453
assert 'Version: 2.5-13+online.2' in (SOURCE/'control').read_text()
assert '#define kPluginVersionString @"2.5-13+online.2"' in (SOURCE/'Headers/CSUserInfoHelper.h').read_text()
manifest=''.join(f'{value}  {key}\n' for key,value in inputs.items())
(AUDIT/'package-build-inputs.sha256').write_text(manifest)
state={'checkout':str(ROOT),'version':'2.5-13+online.2','scratch':str(SCRATCH),'source':str(SOURCE),'input_count':len(inputs),'manifest_sha256':hashlib.sha256(manifest.encode()).hexdigest(),'commands':{}}
for scheme in ['rootless']:
    state['commands'][scheme]=['/usr/bin/make','package','-j4',f'SCHEME={scheme}','PACKAGE_VERSION=2.5-13+online.2',f'_THEOS_LOCAL_DATA_DIR={SCRATCH}/{scheme}/theos',f'THEOS_BUILD_DIR={SCRATCH}/{scheme}',f'THEOS_PACKAGE_DIR={SCRATCH}/{scheme}/deb']
(AUDIT/'build-state.json').write_text(json.dumps(state,indent=2)+'\n')
print(f'Frozen {len(inputs)} production inputs at {SOURCE}',flush=True)
results={}
for scheme,command in state['commands'].items():
    with (AUDIT/f'build-{scheme}.log').open('w') as output:
        result=subprocess.run(command,cwd=SOURCE,stdout=output,stderr=subprocess.STDOUT)
    results[scheme]=result.returncode
    (AUDIT/'build-results.json').write_text(json.dumps(results,indent=2)+'\n')
    print(f'{scheme}: exit {result.returncode}',flush=True)
    if result.returncode:
        print((AUDIT/f'build-{scheme}.log').read_text()[-10000:],flush=True)
        raise SystemExit(result.returncode)
for relative,digest in inputs.items():
    assert hashlib.sha256((ROOT/relative).read_bytes()).hexdigest()==digest,relative
    assert hashlib.sha256((SOURCE/relative).read_bytes()).hexdigest()==digest,relative
print('Rootless diagnostic package built; checkout and frozen input hashes match',flush=True)
