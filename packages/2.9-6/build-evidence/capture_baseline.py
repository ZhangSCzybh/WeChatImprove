#!/usr/bin/env python3
"""Capture a new explicitly named preserved-environment baseline; never replaces old evidence."""
from pathlib import Path
import argparse,datetime,hashlib,json
ROOT=Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
OUT=ROOT/'packages/2.9-6'
WORK=Path('/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-2.9-6-final-krbcf3bu')
p=argparse.ArgumentParser(description=__doc__);p.add_argument('name',help='New baseline filename, e.g. preserved-environment-build-final.json');a=p.parse_args()
assert Path(a.name).name==a.name and a.name.endswith('.json'),'Use a JSON filename in this build root'
target=WORK/a.name
assert not target.exists(),'Refusing to replace an earlier baseline'
def sha(path):
 h=hashlib.sha256()
 with path.open('rb') as stream:
  for block in iter(lambda:stream.read(1024*1024),b''):h.update(block)
 return h.hexdigest()
files=[f for d in (ROOT/'.theos',ROOT/'packages') for f in d.rglob('*') if f.is_file() and not f.is_relative_to(OUT)]
files.append(ROOT/'Controllers/WESessionTabContainerView.m')
data={str(f.relative_to(ROOT)):sha(f) for f in sorted(set(files))};target.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')
meta={'captured_at':datetime.datetime.now(datetime.timezone(datetime.timedelta(hours=8))).isoformat(),'baseline':str(target),'file_count':len(data),'source_checkout':str(ROOT),'excluded_build_output':str(OUT)}
(target.with_name(target.stem+'-context.json')).write_text(json.dumps(meta,ensure_ascii=False,indent=2)+'\n');print(json.dumps(meta,ensure_ascii=False,indent=2))
