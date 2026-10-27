"""Build both package schemes without touching workspace .theos or old packages."""
from pathlib import Path
import hashlib
import json
import shutil
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
work = Path(tempfile.mkdtemp(prefix='wechat-folded-summary-2.0-26-'))
commands = {}
for scheme in ['rootless', 'rootful']:
    command = ['make', '-j2', 'package', 'SCHEME=' + scheme,
               '_THEOS_LOCAL_DATA_DIR=' + str(work / scheme),
               'THEOS_BUILD_DIR=' + str(work), 'THEOS_PACKAGE_DIR=' + str(work / 'packages'), 'COLOR=0']
    commands[scheme] = command
    (HERE / 'build-environment.json').write_text(json.dumps({'workspace': str(ROOT), 'buildRoot': str(work), 'commands': commands}, indent=2) + '\n')
    with (HERE / ('build-' + scheme + '.log')).open('w') as log:
        result = subprocess.run(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    print(scheme, 'exit', result.returncode, flush=True)
    if result.returncode:
        raise SystemExit(result.returncode)

symbols = work / 'packages/com.wechat.improve_2.0-26_symbols.zip'
with zipfile.ZipFile(symbols, 'w', compression=zipfile.ZIP_DEFLATED) as archive:
    for scheme in commands:
        for path in sorted((work / scheme).rglob('*')):
            if path.is_file() and '.dSYM/' in str(path):
                relative = path.relative_to(work / scheme)
                # Theos keeps its architecture subdirectory below obj/.
                archive.write(path, str(Path(scheme) / Path(*relative.parts[1:])))

outputs = sorted((work / 'packages').glob('com.wechat.improve_2.0-26*'))
if len(outputs) != 3:
    raise SystemExit('Expected exactly two packages and one symbols archive: ' + repr(outputs))
manifest = []
for source in outputs:
    destination = ROOT / 'packages' / source.name
    if destination.exists():
        raise SystemExit('Refusing to overwrite package: ' + str(destination))
    shutil.copy2(source, destination)
    manifest.append({'path': str(destination.relative_to(ROOT)), 'sha256': hashlib.sha256(destination.read_bytes()).hexdigest(), 'bytes': destination.stat().st_size})
(HERE / 'packages.json').write_text(json.dumps(manifest, indent=2) + '\n')
print(json.dumps(manifest, indent=2), flush=True)
