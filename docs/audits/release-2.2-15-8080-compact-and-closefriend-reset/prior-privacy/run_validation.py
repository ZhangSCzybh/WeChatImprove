#!/usr/bin/env python3
"""Compile production privacy adapters with native-boundary doubles, without IPA execution."""
from pathlib import Path
import subprocess,sys,os,json,hashlib
ROOT=Path(__file__).resolve().parents[4]
AUDIT=Path(__file__).resolve().parent
os.chdir(ROOT)
OWNED=['Controllers/CSCloseFriendSearchAdapter.h','Controllers/CSCloseFriendSearchAdapter.m','Hooks/CloseFriendSearchHooks.xm','Controllers/CSCloseFriendManager.m','Hooks/CloseFriendLifecycleHooks.xm']
def read(path,baseline=False):
 return subprocess.check_output(['git','show','HEAD:'+path],text=True) if baseline and path in OWNED else Path(path).read_text()
extract=(AUDIT/'extract-contact-bodies.sh').read_text().split("<<'PY'\n",1)[1].rsplit('\nPY',1)[0]
extract=extract.replace("Path('","read('").replace("').read_text()","')")
# The extractor's Path(sys.argv[1]) is unaffected; all source reads now select explicit baseline/current.
results=[]
for baseline in [False,True]:
 label='baseline' if baseline else 'current'
 work=AUDIT/'build'/label;work.mkdir(parents=True,exist_ok=True)
 ns={'read':lambda p:read(p,baseline),'sys':sys};oldargv=sys.argv;sys.argv=[str(__file__),str(work)]
 try:exec(compile(extract,'production-extractor','exec'),ns)
 finally:sys.argv=oldargv
 source=read('Controllers/CSCloseFriendManager.m',baseline);start=source.index('- (void)recovery:')
 (work/'ManagerRecoveryUnderTest.h').write_text(source[start:source.index('\n@end',start)])
 for flavor in ['search-legacy','search-8.0.80','search-8.0.80-voice','recovery']:
  out=work/flavor
  cmd=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-incomplete-implementation','-framework','Foundation','-IControllers','-I'+str(work),'-I'+str(AUDIT)]
  if flavor.startswith('search'):
   if flavor.startswith('search-8.0.80'):cmd+=['-DSEARCH_VOICE_SOURCE=unsigned int','-DTEST_UNSIGNED_VOICE=1']
   if flavor=='search-8.0.80-voice':cmd+=['-DTEST_ONLY_VOICE_ABI=1']
   cmd+=['Controllers/CSCloseFriendPolicy.m','Controllers/CSCloseFriendSignatures.m','Controllers/CSCloseFriendContactProjection.m',str(AUDIT/'CloseFriendContactTests.m')]
  else:cmd+=['Controllers/CSCloseFriendPolicy.m',str(AUDIT/'CloseFriendRecoveryTests.m')]
  cmd+=['-o',str(out)]
  comp=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
  (work/(flavor+'-compile.log')).write_text(comp.stdout)
  if comp.returncode:
   print(label,flavor,'COMPILE FAILED');print(comp.stdout);raise SystemExit(1)
  run=subprocess.run([str(out)],text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
  (work/(flavor+'.log')).write_text(run.stdout)
  results.append({'source':label,'flavor':flavor,'exit_code':run.returncode,'output':run.stdout})
  print(label,flavor,run.returncode,run.stdout.strip())
  if not baseline and run.returncode:raise SystemExit(1)
  if baseline and not run.returncode:raise SystemExit('negative control unexpectedly passed')
(AUDIT/'results.json').write_text(json.dumps({'results':results,'source_hashes':{p:hashlib.sha256(Path(p).read_bytes()).hexdigest() for p in OWNED}},ensure_ascii=False,indent=2)+'\n')
