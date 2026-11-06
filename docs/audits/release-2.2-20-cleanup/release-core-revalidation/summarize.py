#!/usr/bin/env python3
"""Summarize unchanged fixture results; preserve inherited raw gate statistics."""
from pathlib import Path
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent


def read(name):
    return (HERE / 'runs' / (name + '.log')).read_text()


def count(name, pattern):
    match = re.search(pattern, read(name))
    assert match, (name, pattern)
    return int(match.group(1))


def main():
    result = json.loads((HERE / 'result.json').read_text())
    execution = json.loads((HERE / 'execution.json').read_text())
    assert result['all_selected_passed'] and result['completed_tasks'] == 92
    assert result['raw_passed'] == 82 and result['raw_failed'] == 0
    assert result['production_unchanged_during_revalidation'] and result['fixture_bytes_preserved']
    assert execution['core_exit_code'] == 0 and execution['navigation_exit_code'] == 0
    counts = {
        'quick_reset': count('quick-reset259', r'Quick reset: (\d+) checks, 0 failures'),
        'new_password': count('new-password105', r'new-password production path: (\d+) checks, 0 failures'),
        'quick_entry': count('quick90', r'Quick entry: (\d+) checks, 0 failures'),
        'rollback': count('rollback232', r'Rollback/migration: (\d+) checks, 0 failures'),
        'compact': sum(map(int, re.findall(r'PASS: (\d+) checks, 0 failures', read('compact1436')))),
        'settings': count('prior-settings', r'current accepted=True PASS: (\d+) settings lifecycle checks'),
        'merge_policy': count('prior-merge', r'PASS: (\d+) message merge/navigation checks'),
        'header': count('header37152', r'Header gap lifecycle: (\d+) checks, 0 failures'),
        'layout_preferences': count('verify-layout-preferences.sh', r'PASS: (\d+) layout preference snapshot checks'),
        'list_corners': count('verify-list-corners.sh', r'List corners: (\d+) checks, 0 failures'),
        'group_header': count('verify-group-header.sh', r'Group header semantics: (\d+) checks, 0 failures'),
        'group_indicator': count('verify-group-indicator.sh', r'(\d+) checks'),
        'privacy': count('verify-close-friend-privacy.sh', r'CloseFriendPrivacyTests: (\d+) checks passed'),
    }
    privacy = json.loads((HERE / 'prior-privacy/results.json').read_text())['results']
    current_privacy = [row for row in privacy if row['source'] == 'current']
    assert all(row['exit_code'] == 0 for row in current_privacy)
    counts['search_title'] = sum(sum(map(int, re.findall(
        r'(?:CloseFriendContactTests|CloseFriendRecoveryTests): (\d+) checks passed', row['output'])))
        for row in current_privacy)
    merge_counts = list(map(int, re.findall(
        r'current [^ ]+ accepted=True PASS: (\d+) native adapter', read('prior-merge'))))
    assert len(merge_counts) == 3 and len(set(merge_counts)) == 1
    counts['merge_adapter_per_supported_version'] = merge_counts[0]
    tabbar = json.loads((HERE / 'prior-tabbar/validation-result.json').read_text())
    assert all(row['exit_code'] == 0 for row in tabbar)
    counts['tabbar_validation_steps'] = len(tabbar)
    names = ['verify-message-merge.sh', 'verify-bubble-style.sh', 'verify-merge-bubble-integration.sh',
             'verify-message-time.sh', 'verify-message-gesture.sh', 'verify-attachment-layout.sh']
    patterns = [r'PASS: (\d+) [^\n]*checks', r': (\d+) checks passed', r'; (\d+) checks;',
                r'PASS: (\d+) message-time', r'PASS: (\d+) production gesture',
                r'Attachment layout: (\d+) checks passed']
    message_layout = {name: sum(map(int, re.findall(pattern, read(name))))
                      for name, pattern in zip(names, patterns)}
    counts['message_layout_six_script_checks'] = sum(message_layout.values())
    navigation = (HERE / 'navigation.log').read_text()
    values = re.search(r'RESULT assertions=(\d+) passed=(\d+) failed=(\d+) routes=(\d+) samples=(\d+)', navigation)
    assert values, navigation
    navigation_counts = dict(zip(['assertions', 'passed', 'failed', 'routes', 'samples'], map(int, values.groups())))
    assert navigation_counts['failed'] == 0 and navigation_counts['assertions'] == 101400
    assert [counts[key] for key in ['quick_reset', 'new_password', 'quick_entry', 'rollback', 'compact',
                                   'settings', 'search_title', 'header']] == [259, 105, 90, 232, 1436, 5114, 357, 37152]
    summary = {
        'fresh_revalidation': {'completed_tasks': 92, 'passed_tasks': 92, 'failed_tasks': 0,
                               'original_unwaived_scripts': 82, 'modern_suites_including_header': 10},
        'navigation_suite_additional_to_92': navigation_counts,
        'core_counts': counts, 'message_layout_six_details': message_layout,
        'compact_gap_pt': 2, 'normal_gap_pt': [21, 24],
        'header_geometry': {'checks': 37152, 'failed': 0, 'scenarios': 432,
                            'stages_per_scenario': 14, 'geometry_samples': 6048},
        'inherited_original_gate_statistics': {'script_count': 100, 'passed': 82, 'failed': 18},
        'waived_script_names': result['waived_raw_scripts'], 'known_waived_scripts_rerun_this_round': False,
        'new_failures_outside_waiver': 0, 'fixtures_and_assertions_changed': False,
        'fixture_and_runner_files_protected': 325,
        'production_unchanged_during_revalidation': result['production_unchanged_during_revalidation'],
        'raw_tests_preserved_after': execution['raw_test_hashes_preserved_after'],
        'evidence_result_sha256': hashlib.sha256((HERE / 'result.json').read_bytes()).hexdigest(),
        'counts_overlap_do_not_sum': True, 'device_validated': False,
        'host_boundary_tests_are_not_UIKit_device_runtime': True,
        'notice': '100 个原始脚本中 18 个仍未通过，本轮继续按用户限定授权豁免；本轮重跑其余82脚本和现代核心套件，未新增豁免。',
    }
    (HERE.parent / 'CORE-REGRESSIONS.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(summary, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
