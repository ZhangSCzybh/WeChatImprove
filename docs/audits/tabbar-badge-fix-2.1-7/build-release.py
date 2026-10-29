#!/usr/bin/env python3
"""Build one release scheme in its own Theos directories without cleaning history."""
from pathlib import Path
import json
import re
import subprocess
import sys
import time

audit = Path(__file__).resolve().parent
state = json.loads((audit / 'build-state.json').read_text())
scheme = sys.argv[1]
assert scheme in ('rootful', 'rootless')
root = Path(state['root'])
build = Path(state['build']) / scheme
output = Path(state['output'])
output.mkdir(parents=True, exist_ok=True)
command = [
    'make', 'package', '-j4', f'SCHEME={scheme}',
    f'PACKAGE_VERSION={state["version"]}',
    f'_THEOS_LOCAL_DATA_DIR={build / ".theos"}',
    f'THEOS_BUILD_DIR={build}', f'THEOS_PACKAGE_DIR={output}',
]
started = time.monotonic()
with (audit / 'logs' / f'build-{scheme}.log').open('w') as log:
    result = subprocess.run(command, cwd=root, stdout=log, stderr=subprocess.STDOUT)
text = (audit / 'logs' / f'build-{scheme}.log').read_text()
plain = re.sub(r'\x1b\[[0-9;]*m', '', text)
warnings = [line for line in plain.splitlines() if 'warning:' in line]
record = {
    'scheme': scheme, 'command': command, 'exit_code': result.returncode,
    'duration_seconds': round(time.monotonic() - started, 3),
    'warning_count': len(warnings), 'warnings': warnings,
}
(audit / f'build-{scheme}-result.json').write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps(record, indent=2))
if result.returncode:
    raise SystemExit(result.returncode)
if len(warnings) > 6:
    raise SystemExit(f'{scheme}: warning count increased beyond the baseline of six')
