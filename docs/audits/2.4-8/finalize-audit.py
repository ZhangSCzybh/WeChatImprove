#!/usr/bin/env python3
"""Check release scope against the captured local baseline, without Git."""
import hashlib
import json
from pathlib import Path

AUDIT=Path(__file__).resolve().parent
ROOT=AUDIT.parents[2]
def sha(p):
    with p.open('rb') as f:
        return hashlib.file_digest(f,'sha256').hexdigest()
def read_manifest(name):
    return {line.split('  ',1)[1]:line.split('  ',1)[0] for line in (AUDIT/name).read_text().splitlines()}
def write_manifest(name, entries):
    (AUDIT/name).write_text(''.join(f'{digest}  {path}\n' for path,digest in sorted(entries.items())))

top=sorted(p.name for p in (ROOT/'Tests').iterdir() if not p.name.startswith('.'))
(AUDIT/'tests-top-level-final.txt').write_text('\n'.join(top)+'\n')
assert len(top)==307
assert (AUDIT/'tests-top-level-final.txt').read_bytes()==(AUDIT/'tests-top-level-baseline.txt').read_bytes()
tests={str(p.relative_to(ROOT)):sha(p) for p in (ROOT/'Tests').rglob('*') if p.is_file()}
write_manifest('tests-final.sha256',tests)
assert tests==read_manifest('tests-baseline.sha256'), 'Tests changed'
historical=read_manifest('historical-packages-before.sha256')
after={name:sha(ROOT/name) for name in historical}
write_manifest('historical-packages-after.sha256',after)
assert historical==after, 'Historical package changed'
old_release_dirs={Path(name).parts[1] for name in historical if len(Path(name).parts)>2}
actual_old={str(p.relative_to(ROOT)) for name in old_release_dirs for p in (ROOT/'packages'/name).rglob('*') if p.is_file()}
assert actual_old=={name for name in historical if len(Path(name).parts)>2}, 'Historical package file list changed'
baseline=read_manifest('production-baseline.sha256')
production={name:sha(ROOT/name) for name in baseline}
write_manifest('production-final.sha256',production)
changed={name:{'before':digest,'after':production[name]} for name,digest in baseline.items() if production[name]!=digest}
expected={'Controllers/CSGroupChatSettingsViewController.m','Controllers/CSReleaseNotesViewController.m','Headers/CSUserInfoHelper.h','control'}
assert set(changed)==expected, changed
(AUDIT/'changed-files.json').write_text(json.dumps(changed,ensure_ascii=False,indent=2)+'\n')
if (AUDIT/'package-build-inputs.sha256').exists():
    assert production==read_manifest('package-build-inputs.sha256'), 'Delivered source differs from frozen build'
summary={'tests_visible_top_level':len(top),'tests_recursive_files':len(tests),'tests_unchanged':True,'historical_package_files':len(historical),'historical_packages_unchanged':True,'production_inputs':len(production),'changed_production_files':sorted(changed),'frozen_build_inputs_match':(AUDIT/'package-build-inputs.sha256').exists()}
(AUDIT/'final-protection-checks.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(summary,ensure_ascii=False,indent=2))
