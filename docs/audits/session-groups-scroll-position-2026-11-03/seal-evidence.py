#!/usr/bin/env python3
"""Seal this new audit only; never rewrite historical audits or package artifacts."""
from pathlib import Path
from hashlib import sha256
from datetime import datetime
from zoneinfo import ZoneInfo
import json
AUDIT=Path(__file__).resolve().parent
items=[]
for p in sorted(AUDIT.rglob('*')):
    if not p.is_file() or '__pycache__' in p.parts or p.suffix=='.pyc' or p.name in {'.DS_Store','evidence-manifest.json','evidence-manifest.sha256'}:continue
    digest=sha256()
    with p.open('rb') as f:
        for chunk in iter(lambda:f.read(1024*1024),b''):digest.update(chunk)
    items.append({'path':str(p.relative_to(AUDIT)),'sha256':digest.hexdigest(),'bytes':p.stat().st_size})
manifest={'created_at':datetime.now(ZoneInfo('Asia/Shanghai')).isoformat(),'scope':'2.2-11 scroll-position repair, authorized production cleanup, isolated validation, final frozen release builds, and delivery integrity; no device capture',
          'files':items,'file_count':len(items),'total_bytes':sum(row['bytes'] for row in items)}
target=AUDIT/'evidence-manifest.json'
target.write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
digest=sha256(target.read_bytes()).hexdigest()
(AUDIT/'evidence-manifest.sha256').write_text(digest+'  evidence-manifest.json\n')
assert all(sha256((AUDIT/item['path']).read_bytes()).hexdigest()==item['sha256'] for item in items)
print(json.dumps({'files':len(items),'bytes':manifest['total_bytes'],'manifest_sha256':digest,'verified':True},indent=2))
