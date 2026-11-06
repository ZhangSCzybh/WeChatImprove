#!/usr/bin/env python3
"""Run byte-preserved 2.2-19 fixtures on current production, outside the checkout."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
INPUTS = HERE / 'inputs'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=HERE,
                        help='Use a fresh evidence directory for subsequent replays.')
    args = parser.parse_args()
    output = args.output.resolve()
    if (output / 'result.json').exists() or (output / 'execution.json').exists():
        raise SystemExit('Preserve previous results; select a new --output directory.')
    output.mkdir(parents=True, exist_ok=True)
    provenance = json.loads((HERE / 'input-provenance.json').read_text())
    current_head = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    subprocess.run(['git', 'cat-file', '-e', provenance['origin_commit'] + '^{commit}'],
                   cwd=ROOT, check=True)
    for row in provenance['retained_inputs']:
        assert sha(HERE / row['retained']) == row['sha256'], row
    for row in provenance['raw_277_restored_head_files']:
        assert sha(ROOT / row['path']) == row['sha256'], row

    temporary = Path(tempfile.mkdtemp(prefix='wechat-2220-core-'))
    audit = temporary / 'audit'
    shutil.copytree(INPUTS, audit)
    core = audit / 'release-core-revalidation'
    fixture_project = core / 'fixture-project'
    fixture_project.mkdir()
    shutil.copytree(ROOT / 'Tests', fixture_project / 'Tests')
    for name in ('Controllers', 'Hooks', 'Headers', 'HeadersFile'):
        (fixture_project / name).symlink_to(ROOT / name, target_is_directory=True)
    source = (core / 'run-core.py').read_text()
    source = source.replace('ROOT = AUDIT.parents[2]', 'ROOT = Path(' + repr(str(ROOT)) + ')')
    source = source.replace("'green-2.2-19'", "'green-2.2-20'")
    source = source.replace('wci-2219-core-', 'wci-2220-core-')
    (core / 'run-core.py').write_text(source)
    environment = os.environ.copy()
    environment['PYTHONDONTWRITEBYTECODE'] = '1'
    baseline_git = None
    if current_head != provenance['origin_commit']:
        # The unchanged privacy runner reads `git show HEAD` as its historical
        # negative control. Give child processes a private metadata view only;
        # never change the checkout's HEAD, index, refs, sources or user config.
        baseline_git = temporary / 'baseline.git'
        subprocess.run(['git', 'init', '--bare', '--quiet', str(baseline_git)], check=True)
        common = Path(subprocess.check_output(
            ['git', 'rev-parse', '--git-common-dir'], cwd=ROOT, text=True).strip())
        if not common.is_absolute():
            common = ROOT / common
        (baseline_git / 'objects/info/alternates').write_text(str((common / 'objects').resolve()) + '\n')
        (baseline_git / 'HEAD').write_text(provenance['origin_commit'] + '\n')
        environment['GIT_DIR'] = str(baseline_git)
        environment['GIT_WORK_TREE'] = str(ROOT)
    state = {'temporary_root': str(temporary), 'production_root': str(ROOT),
             'original_fixture_and_runner_count': provenance['fixture_and_runner_count_protected'],
             'retained_inputs_byte_preserved': True,
             'orchestrator_only_changes': ['Bind production root explicitly', 'Use 2.2-20 output label', 'Use distinct temporary prefix'],
             'fixture_or_assertion_changes': False, 'device_validated': False,
             'checkout_head': current_head, 'negative_control_head': provenance['origin_commit'],
             'private_git_metadata_for_postcommit_replay': str(baseline_git) if baseline_git else None}
    save(output / 'execution.json', state)
    command = [sys.executable, str(core / 'run-core.py')]
    with (output / 'run-core.log').open('w') as log:
        completed = subprocess.run(command, cwd=ROOT, env=environment,
                                   stdout=log, stderr=subprocess.STDOUT)
    state['core_command'] = command
    state['core_exit_code'] = completed.returncode
    navigation = audit / 'tabbar-navigation-validation'
    navigation_output = navigation / 'green-2.2-20'
    if completed.returncode == 0:
        command = [sys.executable, str(navigation / 'run_validation.py'),
                   '--source-root', str(ROOT), '--output', str(navigation_output)]
        with (output / 'navigation.log').open('w') as log:
            navigated = subprocess.run(command, cwd=ROOT, env=environment,
                                       stdout=log, stderr=subprocess.STDOUT)
        state['navigation_command'] = command
        state['navigation_exit_code'] = navigated.returncode
    else:
        state['navigation_not_started'] = 'Core failure; stop without additional waiver.'

    # Executables, duplicate raw fixtures and full geometry sample files stay in
    # the retained temporary tree. Keep the logs, hashes and source evidence here.
    allowed = {'.json', '.log', '.h', '.m', '.py', '.sh', '.c', '.txt', '.md'}
    excluded_components = {'fixture-project', 'inputs', '__pycache__'}
    exported = []
    for path in sorted(audit.rglob('*')):
        if not path.is_file() or path.is_symlink():
            continue
        rel = path.relative_to(audit)
        if any(part in excluded_components for part in rel.parts):
            continue
        if path.name in {'samples.json', 'geometry-trace.json'} or path.suffix not in allowed:
            continue
        retained = INPUTS / rel
        if retained.is_file() and sha(retained) == sha(path):
            continue
        if rel.parts[0] == 'release-core-revalidation':
            dest = output / Path(*rel.parts[1:])
        else:
            dest = output.parent / rel
        # Inputs have their own immutable namespace. Only execution artifacts
        # from the temporary tree are exported into the new audit output.
        if dest.exists():
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(path, dest)
        exported.append({'path': str(dest.relative_to(output.parent)), 'sha256': sha(dest)})
    state['exported_evidence'] = exported
    state['all_original_input_hashes_preserved_after'] = all(
        sha(HERE / row['retained']) == row['sha256'] for row in provenance['retained_inputs'])
    state['raw_test_hashes_preserved_after'] = all(
        sha(ROOT / row['path']) == row['sha256'] for row in provenance['raw_277_restored_head_files'])
    save(output / 'execution.json', state)
    print(json.dumps({k: v for k, v in state.items() if k != 'exported_evidence'},
                     ensure_ascii=False, indent=2))
    accepted = completed.returncode == 0 and state.get('navigation_exit_code') == 0
    accepted = accepted and state['all_original_input_hashes_preserved_after'] and state['raw_test_hashes_preserved_after']
    return 0 if accepted else 1


if __name__ == '__main__':
    sys.exit(main())
