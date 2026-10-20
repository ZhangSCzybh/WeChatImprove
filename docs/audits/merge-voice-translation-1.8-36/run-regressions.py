import concurrent.futures, hashlib, json, subprocess, time
from pathlib import Path

root=Path(__file__).resolve().parents[3]
out=Path(__file__).resolve().parent
logs=out/'regression';logs.mkdir(exist_ok=True)
focused=json.loads((out/'focused-results.json').read_text())
for row in focused:
    assert row['exit_code']==0
    for name,digest in row['input_sha256'].items():
        assert hashlib.sha256((root/name).read_bytes()).hexdigest()==digest, name

def run(script):
    start=time.monotonic();log=logs/(script.stem+'.log')
    with log.open('w') as stream:
        result=subprocess.run(['bash',str(script)],cwd=root,stdout=stream,stderr=subprocess.STDOUT)
    row={'script':str(script.relative_to(root)),'exit_code':result.returncode,'seconds':round(time.monotonic()-start,2),'log':str(log.relative_to(root))}
    print(json.dumps(row),flush=True);return row

already={r['script'] for r in focused}
scripts=[p for p in sorted((root/'Tests').glob('verify-*.sh')) if str(p.relative_to(root)) not in already]
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
    results=focused+list(pool.map(run,scripts))
results.sort(key=lambda row:row['script'])
(out/'regression-results.json').write_text(json.dumps(results,indent=2)+'\n')
print('Passed',sum(r['exit_code']==0 for r in results),'of',len(results),flush=True)
raise SystemExit(any(r['exit_code']!=0 for r in results))
