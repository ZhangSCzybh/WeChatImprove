#!/usr/bin/env python3
"""Run unchanged historical scripts only after explicit safety review; three isolated workers."""
import argparse,concurrent.futures,hashlib,json,os,re,shutil,subprocess,tempfile,time
from pathlib import Path
A=Path(__file__).resolve().parent
AUDIT=A.parent
ROOT=AUDIT.parents[2]
F=AUDIT/'regression/fixture-project'
BASE=AUDIT/'baseline-2.2-16'
LEGACY={'verify-'+n+'.sh' for n in ['message-merge','bubble-style','merge-bubble-integration','message-time','message-gesture','attachment-layout']}
SCRIPTS=sorted(p.name for p in (F/'Tests').glob('verify-*.sh') if not p.name.startswith('verify-close-friend-') and p.name not in LEGACY)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def manifest(root,roots):return {str(p.relative_to(root)):sha(p) for name in roots for p in sorted((root/name).rglob('*')) if p.is_file()}
def run(name,fixture,label):
 d=A/label;d.mkdir(exist_ok=True)
 with tempfile.TemporaryDirectory(prefix='wci-2217-regression-') as temp:
  env=os.environ.copy();env['TMPDIR']=temp+'/'
  for var in ['CS_COMPAT_ENGINE_SOURCE','CS_COMPAT_TEST_SOURCE','CS_RESTORE_IMAGE_SOURCE']:
   env.pop(var,None)
  env['FIRST_FRAME_PROVENANCE_PATH']=str(d/(name+'.first-frame-provenance.json'))
  env['ADMISSION_PROVENANCE_PATH']=str(d/(name+'.admission-provenance.json'))
  for var in ['_THEOS_LOCAL_DATA_DIR','THEOS_BUILD_DIR','THEOS_PACKAGE_DIR']:
   path=Path(temp)/var;path.mkdir();env[var]=str(path)
  command=['bash',str(fixture/'Tests'/name)];start=time.monotonic()
  try:
   p=subprocess.run(command,cwd=fixture,env=env,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=600)
   exit_code=p.returncode;output=p.stdout;timed_out=False
  except subprocess.TimeoutExpired as e:
   exit_code=124;output=(e.stdout or b'').decode(errors='replace') if isinstance(e.stdout,bytes) else (e.stdout or '');timed_out=True
  (d/(name+'.log')).write_text(output)
  r={'script':name,'label':label,'command':command,'cwd':str(fixture),'exit_code':exit_code,'timed_out':timed_out,'elapsed_seconds':round(time.monotonic()-start,3),'script_sha256':sha(fixture/'Tests'/name),'log':str((d/(name+'.log')).relative_to(A)),'temporary_data_root':temp,'temporary_env':{k:env[k] for k in ['TMPDIR','_THEOS_LOCAL_DATA_DIR','THEOS_BUILD_DIR','THEOS_PACKAGE_DIR','FIRST_FRAME_PROVENANCE_PATH','ADMISSION_PROVENANCE_PATH']},'production_manifest':'production-before.json','fixtures_manifest':'fixtures-before.json'}
  (d/(name+'.result.json')).write_text(json.dumps(r,indent=2)+'\n')
  print(label,name,exit_code,round(time.monotonic()-start,2),flush=True)
  return r

def main():
 p=argparse.ArgumentParser();p.add_argument('--only',nargs='+');p.add_argument('--baseline-failures',action='store_true');p.add_argument('--safety-reviewed',action='store_true');args=p.parse_args()
 assert args.safety_reviewed,'Review shell and referenced test fixtures before execution'
 names=args.only or SCRIPTS;assert set(names)<=set(SCRIPTS)
 prod=manifest(ROOT,['Controllers','Hooks','Headers']);tests=manifest(F,['Tests'])
 for name,data in [('production-before.json',prod),('fixtures-before.json',tests)]:
  path=A/name
  if path.exists():assert json.loads(path.read_text())==data,'provenance changed between runs'
  else:path.write_text(json.dumps(data,indent=2)+'\n')
 with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
  current=list(pool.map(lambda n:run(n,F,'current'),names))
 assert manifest(ROOT,['Controllers','Hooks','Headers'])==prod,'production mutated'
 assert manifest(F,['Tests'])==tests,'historical assertions mutated'
 if args.baseline_failures:
  target=A/'baseline-fixture';target.mkdir(exist_ok=True)
  for name in ['Controllers','Hooks','Headers','HeadersFile']:
   link=target/name
   if not link.exists():link.symlink_to(BASE/name,target_is_directory=True)
  if not (target/'Tests').exists():shutil.copytree(F/'Tests',target/'Tests')
  assert manifest(target,['Tests'])==tests
  failures=[r['script'] for r in current if r['exit_code']]
  with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:baseline=list(pool.map(lambda n:run(n,target,'baseline'),failures))
 else:baseline=[]
 result={'current':current,'baseline':baseline,'script_count':len(SCRIPTS),'selected_count':len(names),'passed':sum(r['exit_code']==0 for r in current),'failed':sum(r['exit_code']!=0 for r in current),'production_bytes_unchanged':manifest(ROOT,['Controllers','Hooks','Headers'])==prod,'fixture_bytes_unchanged':manifest(F,['Tests'])==tests,'baseline_production_sha256':manifest(BASE,['Controllers','Hooks','Headers']) if baseline else {}}
 label='results.json' if not args.only else 'partial-'+str(len(names))+'-results.json'
 (A/label).write_text(json.dumps(result,indent=2)+'\n')
 print('SUMMARY',result['passed'],result['failed'],flush=True)
if __name__=='__main__':main()
