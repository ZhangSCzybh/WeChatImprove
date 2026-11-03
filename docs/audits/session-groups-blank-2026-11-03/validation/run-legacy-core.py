#!/usr/bin/env python3
"""Run selected existing regression suites without restoring deleted Tests."""
from concurrent.futures import ThreadPoolExecutor
import argparse
import json
from pathlib import Path
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
FIXTURE_REF = '863bfdb350fddf678c349574d99badb241d98958'
SUITES = ('verify-group-preferences.sh', 'verify-group-incremental.sh',
          'verify-group-badges.sh', 'verify-group-appearance.sh', 'verify-group-header.sh')


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--output-dir',default='final')
    output=HERE/parser.parse_args().output_dir
    output.mkdir(parents=True,exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='wechat-native-legacy-core-') as temporary:
        sandbox = Path(temporary)
        archive = subprocess.Popen(['git', 'archive', FIXTURE_REF, 'Tests'], cwd=ROOT, stdout=subprocess.PIPE)
        unpacked = subprocess.run(['tar', '-xf', '-', '-C', str(sandbox)], stdin=archive.stdout)
        archive.stdout.close()
        assert archive.wait() == 0 and unpacked.returncode == 0
        for name in ('Controllers', 'Hooks', 'Headers', 'HeadersFile'):
            (sandbox / name).symlink_to(ROOT / name, target_is_directory=True)

        def run(suite):
            command = ['bash', str(sandbox / 'Tests' / suite)]
            result = subprocess.run(command, cwd=sandbox, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            row = {'suite': suite, 'fixture_origin': 'git ' + FIXTURE_REF + ':Tests (temporary export)',
                   'production_origin': str(ROOT), 'exit_code': result.returncode, 'output': result.stdout.strip()}
            (output / (suite + '.log')).write_text(result.stdout)
            return row

        with ThreadPoolExecutor(max_workers=4) as pool:
            results = list(pool.map(run, SUITES))
        (output / 'legacy-core-result.json').write_text(json.dumps(results, ensure_ascii=False, indent=2) + '\n')
        for row in results:
            print(row['suite'] + ': exit ' + str(row['exit_code']))
            print(row['output'][-1800:])
        if any(row['exit_code'] for row in results):
            raise SystemExit(1)


if __name__ == '__main__':
    main()
