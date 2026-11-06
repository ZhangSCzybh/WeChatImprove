#!/usr/bin/env python3
"""Run unchanged historical assertions against this checkout; retain their provenance."""
import argparse, concurrent.futures, hashlib, json
from pathlib import Path
import subprocess

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AUDIT=HERE.parent

def run(item):
 name, command, prefix=item
 result=subprocess.run(command,cwd=ROOT,text=True,capture_output=True)
 content=result.stdout+result.stderr
 (HERE/(prefix+name+'.log')).write_text(content)
 return {'name':name,'command':command,'exit_code':result.returncode,'output':content}

def main():
 parser=argparse.ArgumentParser()
 parser.add_argument('--group',choices=['legacy','prior','security','compact'],required=True)
 parser.add_argument('--only',nargs='+',help='Run only these named suites without changing their scripts or assertions.')
 parser.add_argument('--result-label',help='Preserve earlier evidence under a distinct result and log prefix.')
 args=parser.parse_args()
 if args.group=='legacy':
  names=['message-merge','bubble-style','merge-bubble-integration','message-time','message-gesture','attachment-layout']
  items=[(name,['bash',str(HERE/'fixture-project/Tests'/('verify-'+name+'.sh'))]) for name in names]
 elif args.group=='prior':
  items=[(name,['python3',str(AUDIT/('prior-'+name)/script)]) for name,script in [('settings','run-validation.py'),('tabbar','run-validation.py'),('privacy','run_validation.py'),('merge','run-validation.py')]]
 elif args.group=='compact':
  items=[('compact-production',['python3',str(AUDIT/'prior-compact/run-native-contract.py'),'--phase','green'])]
 else:
  names=sorted(p.stem.removeprefix('verify-') for p in (HERE/'fixture-project/Tests').glob('verify-close-friend-*.sh'))
  items=[(name,['bash',str(HERE/'fixture-project/Tests'/('verify-'+name+'.sh'))]) for name in names]
 if args.only:
  assert set(args.only)<=set(name for name,command in items),'Unknown suite name'
  items=[item for item in items if item[0] in args.only]
 label=args.result_label or args.group
 prefix=(label+'-') if args.result_label else ''
 items=[(name,command,prefix) for name,command in items]
 with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
  runs=list(pool.map(run,items))
 provenance=json.loads((HERE/'fixture-provenance.json').read_text())
 preserved=all(hashlib.sha256((HERE/'fixture-project'/p).read_bytes()).hexdigest()==h for p,h in provenance['files'].items())
 report={'group':args.group,'runs':runs,'original_test_bytes_preserved':preserved,'scope':'Host Foundation/native/UIKit doubles and actual iOS SDK compilation; no phone observation.'}
 (HERE/(label+'-result.json')).write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
 for row in runs:print(row['name'],row['exit_code'],row['output'].strip()[-1200:])
 assert preserved
 assert all(row['exit_code']==0 for row in runs)
if __name__=='__main__':main()
