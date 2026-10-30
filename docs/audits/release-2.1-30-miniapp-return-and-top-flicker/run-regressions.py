#!/usr/bin/env python3
"""Focused host regressions. Every required suite runs once; no device claims."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import hashlib,json,re,subprocess,time
AUDIT=Path(__file__).resolve().parent
ROOT=AUDIT.parents[2]
SUITES=['group-lifecycle','group-launch-banner','group-viewport','group-search',
        'close-friend-session','group-return-privacy','group-return-layout',
        'group-return-banner','list-corners']
def run(suite):
    script=ROOT/'Tests'/('verify-'+suite+'.sh')
    start=time.monotonic()
    result=subprocess.run(['bash',str(script)],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
    output=result.stdout
    (AUDIT/('regression-'+suite+'.log')).write_text(output)
    summaries=[{'checks':int(a),'failures':int(b)} for a,b in re.findall(r'(\d+) checks, (\d+) failures',output)]
    return {'suite':suite,'command':['bash',str(script.relative_to(ROOT))],
            'exit_code':result.returncode,'duration_seconds':round(time.monotonic()-start,3),
            'checks':sum(x['checks'] for x in summaries),'failures':sum(x['failures'] for x in summaries),
            'log_sha256':hashlib.sha256(output.encode()).hexdigest(),'summaries':summaries}
def main():
    with ThreadPoolExecutor(max_workers=3) as pool: rows=list(pool.map(run,SUITES))
    data={'scope':'host-only; no screen/compositor/natural device callback observations',
          'suites':rows,'green_checks':sum(x['checks'] for x in rows),
          'all_passed':all(x['exit_code']==0 and x['failures']==0 and x['checks']>0 for x in rows)}
    (AUDIT/'regression-result.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps(data,ensure_ascii=False,indent=2))
    if not data['all_passed']:raise SystemExit(1)
if __name__=='__main__':main()
