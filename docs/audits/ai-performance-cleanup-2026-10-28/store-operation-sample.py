#!/usr/bin/env python3
"""Count production store work using synthetic data and genuine temporary fsync writes."""
import argparse
import datetime
import hashlib
import json
import platform
import plistlib
import statistics
import subprocess
import tempfile
from pathlib import Path


AUDIT = Path(__file__).resolve().parent
REPO = AUDIT.parents[2]
BASELINE = 'a445c24adee5653ce64f20fdbec3052b894a2067'


def run(args, **kwargs):
    return subprocess.check_output(args, cwd=REPO, **kwargs)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def fixture(large, timestamp):
    conversation_count, preset_count, handled_count, history_count = (1000, 50, 4000, 200) if large else (3, 1, 10, 5)
    presets = [{'id': 'default' if index == 0 else f'preset-{index}', 'name': f'Audit preset {index}',
                'prompt': ('Synthetic prompt. ' * (70 if large else 3)).strip()} for index in range(preset_count)]
    configuration = {'enabled': True, 'endpoint': 'https://example.invalid/v1/chat/completions', 'model': 'audit-model',
                     'credentialRevision': 'synthetic-revision', 'verifiedConnection': '', 'defaultPreset': 'default',
                     'presets': presets, 'conversations': {f'room-{index}@chatroom': {'enabled': True, 'presetID': ''}
                                                       for index in range(conversation_count)}}
    state = {'schema': 1, 'account': 'audit-synthetic-account', 'configuration': configuration,
             'handled': {f'existing-message-{index}': timestamp - datetime.timedelta(seconds=index % 60)
                         for index in range(handled_count)},
             'history': [{'date': timestamp, 'conversation': f'room-{index}@chatroom', 'preset': 'default',
                          'result': 'submitted', 'detail': 'Synthetic audit history'} for index in range(history_count)]}
    data = plistlib.dumps(state, fmt=plistlib.FMT_BINARY, sort_keys=True)
    metadata = {'sha256': digest(data), 'bytes': len(data), 'conversations': conversation_count, 'presets': preset_count,
                'handled_before_claim': handled_count, 'history_before_append': history_count,
                'omits_allowUnmentioned': True, 'timestamp_utc': timestamp.isoformat() + 'Z'}
    return data, metadata


def validate(result, optimized):
    for name in ('claim', 'append_history'):
        sample = result[name]
        assert sample['plist_encodes'] == (1 if optimized else 2), sample
        assert sample['plist_decodes'] == (0 if optimized else 1), sample
        assert sample['configuration_pointer_stable'] is optimized, sample
        assert sample['cf_deep_copies'] == (1 if optimized and name == 'append_history' else 0), sample
        assert sample['file_fsync_calls'] == 1 and sample['directory_fsync_calls'] == 1, sample
        assert sample['fsync_failures'] == 0 and sample['disk_readback_verified'], sample
    for sample in result.get('batch_trials', []):
        count = sample['durable_operations']
        assert sample['plist_encodes'] == count * (1 if optimized else 2), sample
        assert sample['plist_decodes'] == count * (0 if optimized else 1), sample
        assert sample['file_fsync_calls'] == count and sample['directory_fsync_calls'] == count, sample
        assert sample['fsync_failures'] == 0, sample
        assert sample['configuration_pointer_stable_operations'] == (count if optimized else 0), sample


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pairs', type=int, default=20, help='Claim/history pairs per large-fixture timing trial; 0 disables timings.')
    args = parser.parse_args()
    assert 0 <= args.pairs <= 100, 'Keep the measured ledger below the 5000-entry eviction threshold.'
    snapshots = AUDIT / 'source-snapshots'
    snapshots.mkdir(exist_ok=True)
    baseline_store = run(['git', 'show', f'{BASELINE}:Controllers/CSAIReplyStore.m'])
    optimized_store = (REPO / 'Controllers/CSAIReplyStore.m').read_bytes()
    baseline_auth = run(['git', 'show', f'{BASELINE}:Controllers/CSAuthorizationManager.m'])
    optimized_auth = (REPO / 'Controllers/CSAuthorizationManager.m').read_bytes()
    sources = {'baseline-CSAIReplyStore.m': baseline_store, 'optimized-CSAIReplyStore.m': optimized_store,
               'baseline-CSAuthorizationManager.m': baseline_auth, 'optimized-CSAuthorizationManager.m': optimized_auth,
               'CSAIReplyStore.h': (REPO / 'Controllers/CSAIReplyStore.h').read_bytes(),
               'CSAIClient.h': (REPO / 'Controllers/CSAIClient.h').read_bytes()}
    for name, data in sources.items():
        (snapshots / name).write_bytes(data)
    compile_flags = ['-O2', '-fobjc-arc', '-fblocks', '-Wall', '-Wextra', '-Werror', '-Wno-deprecated-declarations',
                     '-Wno-unused-function', '-framework', 'Foundation']
    timestamp = datetime.datetime.now(datetime.timezone.utc).replace(tzinfo=None, microsecond=0) - datetime.timedelta(hours=1)
    results, fixtures = {}, {}
    with tempfile.TemporaryDirectory(prefix='wechat-ai-store-audit-') as temporary:
        temporary = Path(temporary)
        fixture_paths = {}
        for size, large in [('small', False), ('large', True)]:
            data, metadata = fixture(large, timestamp)
            fixture_paths[size] = temporary / f'{size}-fixture.plist'
            fixture_paths[size].write_bytes(data)
            fixtures[size] = metadata
        for version, source in [('baseline', baseline_store), ('optimized', optimized_store)]:
            work = temporary / version
            work.mkdir()
            (work / 'StoreUnderTest.m').write_bytes(source)
            executable = work / 'store-operation-sample'
            run(['xcrun', '--sdk', 'macosx', 'clang', *compile_flags, '-I' + str(work), '-I' + str(snapshots),
                 str(AUDIT / 'StoreOperationSample.m'), '-o', str(executable)], stderr=subprocess.STDOUT)
            results[version] = {}
            for size, fixture_path in fixture_paths.items():
                output = run([str(executable), str(work / size), str(fixture_path), str(args.pairs if size == 'large' else 0)])
                result = json.loads(output)
                validate(result, version == 'optimized')
                results[version][size] = result
    assert optimized_store == (REPO / 'Controllers/CSAIReplyStore.m').read_bytes(), 'Store changed during sampling; rerun.'
    assert optimized_auth == (REPO / 'Controllers/CSAuthorizationManager.m').read_bytes(), 'Authorization changed during sampling; rerun.'
    timing_summary = {}
    if args.pairs:
        for version in results:
            trials = results[version]['large']['batch_trials']
            timing_summary[version] = {name: statistics.median(trial[name] / trial['durable_operations'] for trial in trials)
                                       for name in ['user_cpu_seconds', 'system_cpu_seconds', 'wall_seconds']}
    report = {'schema': 1, 'captured_at_utc': datetime.datetime.now(datetime.timezone.utc).isoformat(),
              'baseline_git_commit': BASELINE, 'baseline_store_git_blob': run(['git', 'rev-parse', f'{BASELINE}:Controllers/CSAIReplyStore.m']).decode().strip(),
              'source_sha256': {name: digest(data) for name, data in sources.items()},
              'audit_code_sha256': {path.name: digest(path.read_bytes()) for path in [Path(__file__), AUDIT / 'StoreOperationSample.m']},
              'environment': {'platform': platform.platform(), 'machine': platform.machine(),
                              'macos': run(['sw_vers']).decode().strip(), 'clang': run(['xcrun', '--sdk', 'macosx', 'clang', '--version']).decode().strip(),
                              'sdk_version': run(['xcrun', '--sdk', 'macosx', '--show-sdk-version']).decode().strip(), 'compile_flags': compile_flags},
              'method': {'data_source': 'synthetic shared schema-1 fixtures; no allowUnmentioned field; no credentials or user data',
                         'isolation': 'separate baseline/optimized processes; one store on one thread; all state files in auto-removed temporary directory',
                         'counted_region': 'successful claimMessageIDs or appendHistory only; excludes fixture seed/load/readback/cleanup',
                         'instrumentation': 'production source included unchanged; plist class macro selects forwarding counting subclass; CF deep copy and fsync wrappers forward to actual system calls',
                         'durability': 'real writes, atomic rename, file fsync and directory fsync preserved; persisted values/mode0600/readback checked',
                         'configuration_pointer': 'strongly retained nonempty before object compared using == across each mutation, plus value equality',
                         'timings': 'local macOS getrusage user/system CPU and monotonic wall time, warmup excluded; not iPhone energy/temperature evidence',
                         'batch_scope': 'large fixture starts with4000 handled IDs; stays below5000, so common non-eviction path; each trial reseeded; order baseline then optimized'},
              'fixtures': fixtures, 'results': results, 'median_seconds_per_durable_operation': timing_summary,
              'authorization_static_comparison': {
                  'scope': 'one successful native live-follow check; excludes singleton init and explicit authorization UI',
                  'baseline': {'native_follow_queries': 1, 'defaults_synchronize_calls': 2, 'defaults_remove_calls': 2,
                               'defaults_set_calls': 2, 'unconditional_clear_logs': 1},
                  'optimized': {'native_follow_queries': 1, 'defaults_synchronize_calls': 0, 'defaults_remove_calls': 0,
                                'defaults_set_calls': 0, 'unconditional_clear_logs': 0},
                  'evidence': 'baseline checkAuthorization calls clearAuthorizationCache then saveCache; current check returns live native result directly; independent AuthorizationReadTests passed67 checks with defaults/log macro counters0'},
              'limitations': ['Counts show call volume, not a measured iPhone heat or energy reduction.',
                              'New appendHistory still makes a record-level CF immutable deep copy; 0 plist decodes does not mean zero copying.',
                              'Both versions retain whole-state validation, encoding, atomic write and2 fsync calls per durable operation.',
                              'Timing includes retained IO and validation; host load, cache warmth and fixed execution order can affect it.',
                              'Fixture omits the new allowUnmentioned field deliberately so the baseline accepts identical business-format data.']}
    output_path = AUDIT / 'store-operation-counts.json'
    output_path.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    print(output_path)
    print(json.dumps({'operation_counts_verified': True, 'median_seconds_per_durable_operation': timing_summary}, indent=2))


if __name__ == '__main__':
    main()
