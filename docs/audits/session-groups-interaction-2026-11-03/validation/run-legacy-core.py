#!/usr/bin/env python3
"""Run selected existing regression suites without restoring deleted Tests."""
from concurrent.futures import ThreadPoolExecutor
import argparse
import json
import os
from pathlib import Path
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = Path(os.environ.get("WECHAT_VALIDATION_SOURCE_ROOT", HERE.parents[3])).resolve()
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
        archive = subprocess.Popen(['git', 'archive', FIXTURE_REF, 'Tests'], cwd=HERE.parents[3], stdout=subprocess.PIPE)
        unpacked = subprocess.run(['tar', '-xf', '-', '-C', str(sandbox)], stdin=archive.stdout)
        archive.stdout.close()
        assert archive.wait() == 0 and unpacked.returncode == 0
        for name in ('Controllers', 'Hooks', 'Headers', 'HeadersFile'):
            (sandbox / name).symlink_to(ROOT / name, target_is_directory=True)

        fixture_adaptations=[]
        if 'CSGroupBuildNativeSections(' not in (ROOT/'Controllers/CSGroupNativeBridge.h').read_text():
            # The production-only thin wrapper had no caller and was removed.
            # Adapt its two historical fixture calls to the exact same existing
            # four-argument implementation, preserving every assertion.
            fixture=sandbox/'Tests/GroupBadgeTests.m'
            text=fixture.read_text();old='CSGroupBuildNativeSections(p.controller,p,p.controller)'
            assert text.count(old)==2
            fixture.write_text(text.replace(old,'CSGroupBuildNativeSectionsReusing(p.controller,p,p.controller,nil)'))
            fixture_adaptations.append('Two GroupBadgeTests thin-wrapper calls use CSGroupBuildNativeSectionsReusing(...,nil); no assertions changed.')

        def run(suite):
            command = ['bash', str(sandbox / 'Tests' / suite)]
            result = subprocess.run(command, cwd=sandbox, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            row = {'suite': suite, 'fixture_origin': 'git ' + FIXTURE_REF + ':Tests (temporary export)',
                   'production_origin': str(ROOT), 'temporary_fixture_adaptations':fixture_adaptations, 'exit_code': result.returncode, 'output': result.stdout.strip()}
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
