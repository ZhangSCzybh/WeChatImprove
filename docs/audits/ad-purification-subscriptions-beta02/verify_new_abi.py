#!/usr/bin/env python3
"""Read-only ABI check of beta02's new subscription additions against IPA metadata.
This does not prove ad-removal efficacy or safe caller semantics.
"""
import csv,hashlib,json,re
from pathlib import Path
A=Path(__file__).resolve().parent
ROOT=A.parents[2]
cs=json.loads((A/'objc-metadata.json').read_text())['classes']
rows=[
 dict(cls='FlutterBrandTLApiImplementation',kind='-',selector='getMassSendDataLastOrderId:initData:resetData:completion:',expected='v@:qBB@?'),
 dict(cls='FlutterFinderBoxApiImplementation',kind='-',selector='getMassSendDataLastOrderId:initData:resetData:completion:',expected='v@:qBB@?'),
 dict(cls='BrandTimelineMsgMgr',kind='+',selector='canTimlineMsgDiscard:',expected='B@:@'),
 dict(cls='AffBizCppToNativeManagerImpl',kind='-',selector='doDataMigrate',expected='@@:'),
 dict(cls='BoxAffBizCppToNativeManagerImpl',kind='-',selector='doDataMigrate',expected='@@:')]
for r in rows:
 m=[m for m in cs[r['cls']]['methods'] if m['kind']==r['kind'] and m['selector']==r['selector']]
 assert len(m)==1,(r,m)
 m=m[0];r.update(actual=m['encoding'],compact_actual=re.sub(r'\d+','',m['encoding']),implementation=m['implementation'],superclass=cs[r['cls']]['superclass'],origin=m['origin'])
 r['matches']=r['expected']==r['compact_actual']
 assert r['matches'],r
source=ROOT/'Controllers'/'CSAdPurificationSubscriptionHooks.m'
report=dict(scope='beta02 new subscription hooks only; beta01 audit remains unchanged',count=len(rows),matching=sum(r['matches'] for r in rows),source_file=str(source),source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),hooks=rows)
(A/'new-hook-abi.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
with (A/'new-hook-abi.csv').open('w') as f:
 w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
print(json.dumps({k:v for k,v in report.items() if k!='hooks'},indent=2))
