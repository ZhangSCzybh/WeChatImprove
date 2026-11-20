from pathlib import Path
from datetime import datetime
from zoneinfo import ZoneInfo
import concurrent.futures, hashlib, json, re, subprocess

root=Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
out=Path('/tmp/wechat-2.7-5-regression-7i7ea4as')
out.mkdir(parents=True,exist_ok=True)
names=['settings-home','settings-tab-bar','settings-home-animation','settings-home-theme',
       'plugin-header-entry','plugin-header-avatar','plugin-header-layout',
       'authorization-prompt','close-friend-entry','backup-registry']
jobs=[(name,['bash',f'Tests/verify-{name}.sh']) for name in names]

sources=['Controllers/'+x+'.m' for x in ['CSCustomViewController','CSSettingsHomeAnimator',
         'CSSettingsHomeTheme','CSSettingsHomePaletteCell','CSSettingsHomeCell','CSSettingsTabBar']]
for arch in ['arm64','arm64e']:
    jobs.append(('ios15-syntax-'+arch,['xcrun','--sdk','iphoneos','clang','-target',arch+'-apple-ios15.0',
        '-fobjc-arc','-fblocks','-fsyntax-only','-Wall','-Wextra','-Werror','-Wno-unused-parameter',
        '-Wno-nullability-completeness','-IHeaders','-IControllers','-IHooks']+sources))

def run(job):
    name,command=job
    result=subprocess.run(command,cwd=root,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
    log=out/(name+'.log');log.write_text(result.stdout)
    entry={'name':name,'command':command,'exit_code':result.returncode,
           'result':'passed' if result.returncode==0 else 'failed',
           'log':log.name,'log_sha256':hashlib.sha256(log.read_bytes()).hexdigest()}
    counts=re.findall(r'(\d+) (?:checks(?:, 0 failures| passed)?|assertions)',result.stdout)
    if name=='version-release':
        match=re.search(r'^RESULT_JSON (.+)$',result.stdout,re.M)
        if match: entry['release_checks']=json.loads(match.group(1))
    elif counts: entry['checks']=sum(map(int,counts))
    print(json.dumps(entry,ensure_ascii=False),flush=True)
    return entry
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
    results=list(executor.map(run,jobs))
summary={'version':'2.7-5','verified_at':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),
         'source_checkout':str(root),'all_passed':all(x['exit_code']==0 for x in results),
         'total_checks':sum(x.get('checks',0) for x in results),
         'version_release_check_owner':'root agent',
         'verification_boundary':'Host-side production-method fixtures and iOS15 SDK syntax checks; no physical device install or rendering verification.',
         'tests':results}
(out/'summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
assert summary['all_passed'],'Inspect regression logs'
