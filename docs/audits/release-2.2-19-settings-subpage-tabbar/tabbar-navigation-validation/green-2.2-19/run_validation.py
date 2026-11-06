#!/usr/bin/env python3
"""Run source-bound navigation-policy host tests. No device or simulator execution."""
import argparse,hashlib,json,pathlib,re,shutil,subprocess,sys
HERE=pathlib.Path(__file__).resolve().parent
DEFAULT_ROOT=HERE.parents[3]
PLAIN={'CSAIConnectionEditor':'Controllers/CSAIReplySettingsViewController.m','CSAIPresetEditor':'Controllers/CSAIReplySettingsViewController.m','CSScheduledTaskTextEditor':'Controllers/CSScheduledTaskSettingsViewController.m','CSScheduledTaskTimeEditor':'Controllers/CSScheduledTaskSettingsViewController.m'}
def digest(path):return hashlib.sha256(pathlib.Path(path).read_bytes()).hexdigest()
def production_hashes(root):return {str(p.relative_to(root)):digest(p) for directory in ['Controllers','Hooks','Headers'] for p in sorted((root/directory).rglob('*')) if p.is_file()}
def extract_getter(text,cls):
 start=text.index('@implementation '+cls);end=text.index('@end',start);body=text[start:end]
 match=re.search(r'-\s*\(BOOL\)\s*hidesBottomBarWhenPushed\s*\{',body)
 if not match:return ''
 opening=match.end()-1;level=0
 for n in range(opening,len(body)):
  if body[n]=='{':level+=1
  if body[n]=='}':
   level-=1
   if not level:return body[match.start():n+1]
 raise ValueError('unclosed getter')
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--source-root',type=pathlib.Path,default=DEFAULT_ROOT);ap.add_argument('--output',type=pathlib.Path,required=True);args=ap.parse_args()
 root=args.source_root.resolve();out=args.output.resolve();out.mkdir(parents=True,exist_ok=False)
 before=production_hashes(root)
 classes={};sources={};declarations=[];pushes=[]
 for p in sorted((root/'Controllers').glob('*.[hm]')):
  text=p.read_text()
  for match in re.finditer(r'@interface\s+(\w+)\s*:\s*(\w+)',text):
   name,parent=match.groups();classes[name]=parent;sources[name]=str(p.relative_to(root));declarations.append({'class':name,'parent':parent,'file':str(p.relative_to(root)),'line':text.count('\n',0,match.start())+1})
  for number,line in enumerate(text.splitlines(),1):
   if 'pushViewController:' in line:pushes.append({'file':str(p.relative_to(root)),'line':number,'text':line.strip()})
 def inherits(cls,parent):
  seen=set()
  while cls not in seen:
   if cls==parent:return True
   seen.add(cls);cls=classes.get(cls)
   if not cls:return False
  return False
 selected=set(n for n in classes if n!='CSSettingsTableViewController' and inherits(n,'CSSettingsTableViewController'))|set(PLAIN)
 ordered=[];remaining=set(selected)
 while remaining:
  ready=sorted(n for n in remaining if classes[n]=='CSSettingsTableViewController' or classes[n] not in selected or classes[n] in ordered)
  if not ready:raise ValueError('cycle')
  ordered.extend(ready);remaining-=set(ready)
 getter_files={};rows=[];generated=['// Source-derived declarations only. These page implementations are NOT executed.']
 for n in ordered:
  getter=extract_getter((root/PLAIN[n]).read_text(),n) if n in PLAIN else ''
  if n in PLAIN:
   (out/(n+'-getter.m')).write_text(getter+'\n');getter_files[n]={'source':PLAIN[n],'method':getter or None,'baseline_fallback':'UIKit default NO' if not getter else None}
  generated.extend(['@interface '+n+' : '+classes[n]+' @end','@implementation '+n,getter,'@end'])
  rows.append({'label':n,'class':n,'parent':classes[n],'source':sources[n],'implementation_executed':'extracted getter only' if n in PLAIN else 'source-derived declaration plus full production shared base'})
 # Both close-friend routes target the same concrete page; retain separate model samples.
 rows.extend([{'label':'密友-普通入口','class':'CSCloseFriendSettingsViewController','source':'Controllers/CSCloseFriendManager.m:395–402'},{'label':'密友-头像五击快捷入口','class':'CSCloseFriendSettingsViewController','source':'Controllers/CSCustomViewController.m:646–661'}])
 generated+=['static NSArray<NSDictionary *> *ProductionRoutes(void) { return @[']
 generated += ['@'+json.dumps({'label':r['label'],'class':r['class']},ensure_ascii=False).replace('"label":','@"label":').replace('"class":','@"class":').replace(': "',': @"')+',' for r in rows]
 # JSON dictionary literals need Objective-C separators.
 generated=[line.replace('{@','{@') for line in generated]
 generated+= [']; }']
 (out/'ProductionRoutes.h').write_text('\n'.join(generated)+'\n')
 (out/'route-coverage.json').write_text(json.dumps({'classes':rows,'declarations':declarations,'push_calls':pushes,'remaining_direct_table_page':'WEContactSelectViewController; compiled by source glob but no call sites found in Controllers/Hooks','limits':'Declarations reflect source hierarchy, not execution of page bodies or native navigation. Only full CSSettingsTableViewController production unit and four extracted getters execute.'},ensure_ascii=False,indent=2)+'\n')
 (out/'getter-extraction.json').write_text(json.dumps(getter_files,ensure_ascii=False,indent=2)+'\n')
 snapshots=['Controllers/CSSettingsTableViewController.h','Controllers/CSSettingsTableViewController.m','Controllers/CSAIReplySettingsViewController.m','Controllers/CSScheduledTaskSettingsViewController.m','Controllers/CSCustomViewController.m','Controllers/CSNativeSettingsHost.m','Controllers/CSCloseFriendManager.m','Hooks/CustomEntryHooks.xm','Hooks/TabBarStyleHooks.xm','Controllers/CSTabBarNativeAdapter.m','Makefile']
 for rel in snapshots:
  dest=out/'production'/rel;dest.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(root/rel,dest)
 for filename in ['NavigationTests.m','UIKitDouble.m','run_validation.py']:
  shutil.copyfile(HERE/filename,out/filename)
 shutil.copytree(HERE/'UIKit',out/'UIKit')
 command=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-framework','Foundation','-framework','CoreGraphics','-I'+str(out),'-I'+str(out/'production/Controllers'),str(out/'UIKitDouble.m'),str(out/'production/Controllers/CSSettingsTableViewController.m'),str(out/'NavigationTests.m'),'-o',str(out/'navigation-tests')]
 build=subprocess.run(command,capture_output=True,text=True);(out/'compile.log').write_text(build.stdout+build.stderr)
 run_command=[str(out/'navigation-tests'),str(out/'samples.json')]
 result=subprocess.run(run_command,capture_output=True,text=True) if build.returncode==0 else None
 (out/'run.log').write_text(result.stdout+result.stderr if result else 'NOT RUN: compilation failed\n')
 after=production_hashes(root)
 fixture_names=['NavigationTests.m','UIKitDouble.m','UIKit/UIKit.h','run_validation.py']
 provenance={'source_root':str(root),'source_sha256_before':before,'source_sha256_after':after,'source_unchanged':before==after,'fixture_sha256':{p:digest(HERE/p) for p in fixture_names},'snapshot_sha256':{p:digest(out/'production'/p) for p in snapshots},'compile_command':command,'compile_exit_code':build.returncode,'run_command':run_command,'run_exit_code':result.returncode if result else None,'all_samples':'samples.json','route_count':len(rows),'limits':'Host policy model, not UIKit runtime. MMTabBar hidden/alpha/frame/window observations on device are UNAVAILABLE. The native destination/top policy was established with separately retained offline disassembly.'}
 (out/'provenance.json').write_text(json.dumps(provenance,ensure_ascii=False,indent=2)+'\n')
 if build.returncode:print(build.stdout+build.stderr);return build.returncode
 print(result.stdout+result.stderr);return result.returncode if before==after else 99
if __name__=='__main__':sys.exit(main())
