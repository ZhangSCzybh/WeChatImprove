#!/usr/bin/env python3
"""Freeze historical-matching inputs and run an isolated selection/content matrix."""
import datetime
import hashlib
import json
from pathlib import Path
import subprocess

PROBE = Path(__file__).resolve().parent
ROOT = PROBE.parents[4]
AUTH = ROOT / 'docs/audits/authorization-cleanup-2026-10-28/source-sha256-after.json'
AFTER = json.loads(AUTH.read_text())
FILES = ['Controllers/CSGroupListAdapter.m', 'Hooks/CloseFriendNotificationHooks.xm',
         'Controllers/CSCloseFriendPolicy.h', 'Controllers/CSCloseFriendPolicy.m',
         'Controllers/CSGroupProjection.h', 'Controllers/CSGroupProjection.m',
         'Controllers/WESessionTabItem.h', 'Controllers/WESessionTabItem.m']

def sha(data):
    return hashlib.sha256(data).hexdigest()

def dump(name, value):
    (PROBE / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')

def balanced(source, opening):
    depth = 0
    state = 'code'
    index = opening
    while index < len(source):
        char, pair = source[index], source[index:index + 2]
        if state == 'line':
            if char == '\n':
                state = 'code'
        elif state == 'block':
            if pair == '*/':
                state = 'code'
                index += 1
        elif state in ('string', 'char'):
            if char == '\\':
                index += 1
            elif char == ('"' if state == 'string' else "'"):
                state = 'code'
        elif pair == '//':
            state = 'line'
            index += 1
        elif pair == '/*':
            state = 'block'
            index += 1
        elif char == '"':
            state = 'string'
        elif char == "'":
            state = 'char'
        elif char == '{':
            depth += 1
        elif char == '}':
            depth -= 1
            if depth == 0:
                return index + 1
        index += 1
    raise AssertionError('Unbalanced source')

source_bytes = {name: (ROOT / name).read_bytes() for name in FILES}
sources = []
for name, data in source_bytes.items():
    assert sha(data) == AFTER[name], f'Input differs from 2.1-6 delivery: {name}'
    target = PROBE / 'sources' / name
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)
    sources.append({'path': name, 'sha256': sha(data), 'matches_2_1_6_after': True})

extracts = []
def extract(name, marker, output, block=False):
    source = source_bytes[name].decode()
    start = source.index(marker)
    if block:
        start = source.index('^', start)
    end = balanced(source, source.index('{', start))
    body = source[start:end]
    target = PROBE / 'extracted' / output
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(body + '\n')
    extracts.append({'source': name, 'marker': marker, 'output': str(target.relative_to(PROBE)),
                     'source_start_line': source.count('\n', 0, start) + 1,
                     'source_end_line': source.count('\n', 0, end) + 1,
                     'body_sha256': sha(body.encode()), 'output_sha256': sha(target.read_bytes())})

extract(FILES[0], '+ (NSNumber *)closeFriendAlertBadgeCount', 'closeFriendAlertBadgeCount.inc')
extract(FILES[1], 'static BOOL ChatTab(', 'ChatTab.inc')
for variable, name in [('tab', 'numeric'), ('tabString', 'string'), ('dot', 'dot')]:
    extract(FILES[1], f'__block IMP {variable}=NULL;', f'{name}-block.inc', True)

manifest = {'captured_at': datetime.datetime.now(datetime.timezone.utc).isoformat(),
            'authority': str(AUTH.relative_to(ROOT)), 'authority_sha256': sha(AUTH.read_bytes()),
            'sources': sources, 'extracts': extracts,
            'harness_sha256': sha((PROBE / 'selection-content-probe.m').read_bytes()),
            'runner_sha256': sha(Path(__file__).read_bytes())}
dump('source-manifest.json', manifest)
binary = PROBE / 'selection-content-probe-host'
command = ['xcrun', '--sdk', 'macosx', 'clang', '-fobjc-arc', '-fblocks',
           '-Wall', '-Wextra', '-Werror', '-framework', 'Foundation',
           '-I' + str(PROBE / 'sources/Controllers'), '-I' + str(PROBE / 'extracted'),
           *[str(PROBE / 'sources' / name) for name in
             ['Controllers/CSCloseFriendPolicy.m', 'Controllers/CSGroupProjection.m', 'Controllers/WESessionTabItem.m']],
           str(PROBE / 'selection-content-probe.m'), '-o', str(binary)]
compiled = subprocess.run(command, cwd=ROOT, capture_output=True)
(PROBE / 'compile.log').write_bytes(compiled.stdout + compiled.stderr)
dump('build-result.json', {'command': command, 'exit_code': compiled.returncode,
                          'log': 'compile.log', 'ios_build': False, 'package_or_install': False})
assert compiled.returncode == 0, compiled.stderr.decode()
run = subprocess.run([str(binary)], cwd=PROBE, capture_output=True)
(PROBE / 'events.jsonl').write_bytes(run.stdout)
(PROBE / 'stderr.log').write_bytes(run.stderr)
assert run.returncode == 0, run.stderr.decode()
rows = [json.loads(line) for line in run.stdout.splitlines()]
assert rows[-1]['kind'] == 'summary'
assert rows[-1]['matrixCases'] == 60 and rows[-1]['lifecycleCases'] == 12
assert rows[-1]['constructionCases'] == 4
assert len(rows) - 1 == rows[-1]['eventRows'] == 268
stable = all((ROOT / name).read_bytes() == data for name, data in source_bytes.items())
assert stable, 'Production inputs changed during probe'
events = rows[:-1]
matrix = [row for row in events if row['kind'] == 'matrix']
lifecycles = [row for row in events if row['kind'] == 'controlled-lifecycle']
construction = [row for row in events if row['kind'] == 'controlled-construction']
required = []
for selection in ['friend', 'group']:
    for candidate in [0, 5]:
        for state in ['valid-cache', 'no-cache', 'dirty', 'change-depth', 'revision-mismatch']:
            matches = [row for row in matrix if row['selection'] == selection and row['candidateUnread'] == candidate
                       and row['ordinaryNumericUnread'] == 7 and row['snapshotState'] == state
                       and row['event'] == 'isolated-number']
            assert len(matches) == 1
            row = matches[0]
            expected = 7 if state == 'valid-cache' else 0
            assert row['getterDecision'] == row['originalNumberArgument'] == expected
            required.append({'selection': selection, 'candidateUnread': candidate, 'ordinaryNumericUnread': 7,
                             'snapshotState': state, 'nativeTotalInput': row['nativeTotalInput'],
                             'getterDecision': row['getterDecision'], 'originalNumberArgument': row['originalNumberArgument'],
                             'hidden': row['after']['hidden']})
dump('required-cases.json', required)
dump('results.json', {'status': 'passed', 'exit_code': run.returncode, 'summary': rows[-1],
                     'matrix_event_rows': len(matrix), 'lifecycle_event_rows': len(lifecycles),
                     'construction_event_rows': len(construction),
                     'production_sources_stable': stable, 'inputs_match_2_1_6_after': True,
                     'events_sha256': sha(run.stdout), 'binary_sha256': sha(binary.read_bytes()),
                     'production_or_formal_tests_modified': False, 'device_data_read': False,
                     'ios_build_or_package_or_install': False,
                     'limitations': ['Account, input rows, adapter state and native setter effects are synthetic host boundaries.',
                                     'Real policy/projection sources and exact extracted getter/Hook bodies are compiled.',
                                     'The lifecycle is manual state assignment, not real GroupListAdapter begin/end/refresh execution or device timing.',
                                     'Empty selection leaves the candidate row unprotected; candidateUnread is still included in the supplied native total.',
                                     'Numeric total equals the two controlled numeric-row inputs; this does not reproduce all WeChat aggregate/readiness semantics.',
                                     'No style, UIKit, native message delivery, notification installer, device clipping or geometry is loaded.']})
print(json.dumps({'status': 'passed', **rows[-1]}, ensure_ascii=False))
