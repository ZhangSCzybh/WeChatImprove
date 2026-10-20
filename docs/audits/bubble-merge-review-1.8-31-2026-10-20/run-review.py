from pathlib import Path
import subprocess,json,concurrent.futures,sys
out=Path(__file__).resolve().parent;root=out.parents[2];work=Path((out/'work-path.txt').read_text().strip())
base=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-unused-parameter','-framework','Foundation','-framework','CoreGraphics','-framework','CoreFoundation','-I'+str(root/'Controllers')]
bubble=['-DCS_BUBBLE_TESTING=1','-I'+str(root/'Tests/BubbleUIKit'),'Tests/BubbleUIKit/BubbleUIKit.m','Controllers/CSBubbleStylePolicy.m','Controllers/CSBubbleStyleAdapter.m','Controllers/CSBubbleTextColors.m',str(out/'bubble-probes.m')]
merge=['-DCS_MERGE_TESTING=1','-I'+str(root/'Tests/MessageUIKit'),'Tests/MessageUIKit/MessageUIKit.m','Tests/MessageUIKit/DisplayLink.m','Controllers/CSMessageMergePolicy.m','Controllers/CSMessageMergeAdapter.m','Controllers/CSRevokeReference.m','Controllers/CSChatNativeBridge.m','Controllers/CSMessageNavigation.m','Controllers/CSMessageTimeLayout.m',str(out/'merge-probes.m')]
def run(name,args):
 with (out/(name+'.log')).open('w') as log:
  result=subprocess.run(args,cwd=root,stdout=log,stderr=subprocess.STDOUT)
 return {'name':name,'exit_code':result.returncode}
selected=set(sys.argv[1:]);results=[]
if selected and (out/'results.json').exists(): results=json.loads((out/'results.json').read_text())
with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
 baseline=list(pool.map(lambda x:run(*x),[x for x in [
  ('baseline-bubble',['bash','Tests/verify-bubble-style.sh']),
  ('baseline-merge',['bash','Tests/verify-message-merge.sh'])] if not selected or x[0] in selected]))
 results=[r for r in results if r['name'] not in {b['name'] for b in baseline}]+baseline
for name,inputs in [('bubble-probes',bubble),('merge-probes',merge)]:
 if selected and name not in selected: continue
 results=[r for r in results if r['name'] not in (name,name+'-build')]
 compiled=run(name+'-build',base+inputs+['-o',str(work/name)]);results.append(compiled)
 if compiled['exit_code']==0:results.append(run(name,[str(work/name)]))
(out/'results.json').write_text(json.dumps(results,indent=2)+'\n')
print(json.dumps(results,indent=2));raise SystemExit(any(r['exit_code'] for r in results))
