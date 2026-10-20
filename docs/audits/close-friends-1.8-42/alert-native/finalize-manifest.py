"""Record produced evidence and bounded disassembly coverage without executing target."""
import bisect
import hashlib
import json
from pathlib import Path
import re

out = Path(__file__).resolve().parent
scope = {'__file__': str(out / 'analyze.py')}
exec((out / 'analyze.py').read_text().split("\nif sys.argv[1]")[0], scope)
manifest_file = out / 'manifest.json'
manifest = json.loads(manifest_file.read_text())
files, coverage = [], []
for file in sorted(out.iterdir()):
    if not file.is_file() or file == manifest_file:
        continue
    files.append({'file': file.name, 'bytes': file.stat().st_size,
                  'sha256': hashlib.sha256(file.read_bytes()).hexdigest()})
    if file.suffix != '.asm':
        continue
    addresses = [int(m.group(1), 16) for m in re.finditer(
        r'^([0-9a-f]+):', file.read_text(), re.M)]
    if not addresses:
        raise RuntimeError('No disassembled instructions in ' + file.name)
    start, stop = addresses[0], addresses[-1] + 4
    expected_end = scope['starts'][bisect.bisect_right(scope['starts'], start)]
    coverage.append({'file': file.name, 'start': hex(start),
                     'stop': hex(stop), 'function_end': hex(expected_end),
                     'truncated': stop < expected_end})
root = scope['ROOT']
inputs = [root / 'docs/evidence/close-friends-native-2026-10-20/extract.py',
          root / 'docs/evidence/message-actions-native-2026-10-17/classes.json',
          root / 'docs/evidence/close-friends-native-2026-10-20/VoIPInvitationService--rejectInvitationWithInfo_.asm']
manifest['parser_inputs'] = [
    {'file': str(file.relative_to(root)),
     'sha256': hashlib.sha256(file.read_bytes()).hexdigest()} for file in inputs]
manifest['evidence_files'] = files
manifest['disassembly'] = coverage
manifest['disassembly_count'] = len(coverage)
manifest['truncated_disassembly_count'] = sum(row['truncated'] for row in coverage)
manifest['coverage_limits'] = [
    'Objective-C class and metaclass base method tables; no complete category inventory.',
    'Property metadata for selected identities; dynamic accessors were not run.',
    'Reference annotations are hints, not complete register data-flow analysis.',
    'No target execution, device access, account access, service requests, or runtime success validation.'
]
report = out.parent / 'alert-native-report.md'
manifest['report'] = {'file': '../' + report.name,
                      'sha256': hashlib.sha256(report.read_bytes()).hexdigest()}
manifest_file.write_text(json.dumps(manifest, indent=2) + '\n')
print(json.dumps({'evidence_file_count': len(files), 'disassembly_count': len(coverage),
                  'truncated': [row for row in coverage if row['truncated']]}, indent=2))
