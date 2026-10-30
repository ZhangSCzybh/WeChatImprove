#!/usr/bin/env python3
"""Record final source/build-input differences and rehash historical artifacts."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT=Path(__file__).resolve().parents[3]
AUDIT=Path(__file__).resolve().parent


def sha(path):
    with path.open('rb') as source:
        return hashlib.file_digest(source,'sha256').hexdigest()


def save(name,value):
    (AUDIT/name).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')


def main():
    baseline=json.loads((AUDIT/'baseline.json').read_text())
    before=json.loads((AUDIT/'baseline-production-input-sha256.json').read_text())
    paths=[p for folder in ('Controllers','Hooks','Headers','HeadersFile','layout')
           for p in (ROOT/folder).rglob('*') if p.is_file() and p.name!='.DS_Store']
    paths += [ROOT/name for name in ('Makefile','control','WeChatImprove.plist')]
    current={str(p.relative_to(ROOT)):sha(p) for p in sorted(paths) if p.is_file()}
    all_names=sorted(set(before)|set(current))
    differences=[{'file':name,'baseline_sha256':before.get(name),'current_sha256':current.get(name),
                  'change':('added' if name not in before else 'removed' if name not in current else 'changed')}
                 for name in all_names if before.get(name)!=current.get(name)]
    save('input-differences.json',{'baseline_commit':baseline['baseline_commit'],
         'baseline_production_input_count':len(before),'current_production_input_count':len(current),
         'changed_count':len(differences),'differences':differences})
    scopes=['Controllers','Hooks','Headers','HeadersFile','layout','Makefile','control','WeChatImprove.plist','README.md']
    patch=subprocess.check_output(['git','diff',baseline['baseline_commit'],'--',*scopes],cwd=ROOT)
    (AUDIT/'production.patch').write_bytes(patch)
    preservation={}
    for key,name in [('task_start_artifacts','task-start-artifacts-sha256.json'),
                     ('historical_packages','historical-packages-before.json')]:
        manifest=json.loads((AUDIT/name).read_text())
        missing=[p for p in manifest if not (ROOT/p).is_file()]
        changed=[p for p,digest in manifest.items() if (ROOT/p).is_file() and sha(ROOT/p)!=digest]
        preservation[key]={'count':len(manifest),'missing':missing,'changed':changed,
                           'all_original_bytes_preserved':not(missing or changed)}
    guard=json.loads(subprocess.check_output(['python3','-B',str(AUDIT/'verify-source-guards.py')],text=True))
    save('source-guard-final-check.json',guard)
    result={'baseline_commit':baseline['baseline_commit'],'preservation':preservation,
            'protected_definitions':guard['protected_count'],
            'all_protected_definitions_byte_identical':guard['all_protected_methods_byte_identical'],
            'production_patch_sha256':sha(AUDIT/'production.patch')}
    save('final-input-preservation.json',result)
    print(json.dumps(result,ensure_ascii=False,indent=2))
    if not result['all_protected_definitions_byte_identical'] or not all(x['all_original_bytes_preserved'] for x in preservation.values()):
        raise SystemExit(1)


if __name__=='__main__':
    main()
