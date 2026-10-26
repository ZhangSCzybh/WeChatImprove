"""Bounded read-only disassembly for selected close-friend integration decisions."""
import json,subprocess,re,runpy,hashlib
from pathlib import Path
out=Path(__file__).parent
# Reuse only the parser prefix without running the inventory writer.
ctx={};exec((out/'extract.py').read_text().split('\nimport re,subprocess,hashlib,bisect')[0],ctx)
selected={
'MMDiskUsageUtil':['DeleteBizUnknowFile:','DeleteBizUnknowDir:','moveFileToTmpTrash:description:','moveFolderToTmpTrash:description:','pathOfTrashFile','pathOfTrashFolder','pathOfTrash','RemoveUnneedDiskScanTrash','movePath:to:','removePath:'],
'MMDiskUsageScaner':['deleteFile:matchInfo:inFolder:withScanConfig:fileSize:logicFileSize:latestTimeInterval:','handleDeleteFolder:withFolderPath:withScanStat:','scanBeginWithRootFolderWithScanConfig:withScanData:','scanFileInFolder:withFolderPath:withScanConfig:'],
'MMDiskUsageConfigHandler':['loadConfigFromX','init'],
'MMDiskUsageMgr':['wholeWechatScan:','startWholeScan:quickScan:completion:','onServiceEnterForeground','startFinishScanDiskWithUrgentLevel:','finishScanPhase','p_shouldFinishScanWithUrgentLevel:'],
'MMDiskUsageScanData':['scanRootDir'],
'MMDiskBizUsageHandler':['fileMatchedBizType:inFolder:','matchBizWithChildFolder:parentFolder:','loadPathMatchRulesWithOtherUser:'],
'CBaseFile':['RemoveFile:','ClearPath:','SyncClearPath:']}

rows=json.loads((out/'methods.json').read_text());reports=[]
for row in rows:
 if row['selector'] not in selected.get(row['cls'],[]):continue
 start=int(row['address'],16);stop=min(int(row['end'],16),start+16000)
 name=row['cls']+'--'+row['selector'].replace(':','_')+'.asm'
 if (out/name).exists():
  reports.append(dict(file=name,start=hex(start),stop=hex(stop),truncated=stop<int(row['end'],16)))
  continue
 raw=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(stop),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
 regs={};lines=[]
 for line in raw.splitlines():
  m=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
  if m:regs[m[1]]=int(m[2],16)
  m=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
  if m and m[1] in regs:
   try:
    value=ctx['string'](ctx['ptr'](ctx['pos'](regs[m[1]]+int(m[2],16))))
    if value and len(value)<180 and all(c.isprintable() and c!='�' for c in value):line+=' ; '+value
   except Exception:pass
  lines.append(line.rstrip())
 name=row['cls']+'--'+row['selector'].replace(':','_')+'.asm'
 (out/name).write_text('\n'.join(lines)+'\n');reports.append(dict(file=name,start=hex(start),stop=hex(stop),truncated=stop<int(row['end'],16)))
manifest={'target':'/tmp/wechat-8.0.78-inset-analysis/WeChat','sha256':'0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e','static_only':True,'disassembly':reports}
manifest['files']={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in out.iterdir() if p.suffix in ['.py','.asm','.json'] and p.name!='manifest.json'}
(out/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
print(json.dumps(reports,indent=2))
