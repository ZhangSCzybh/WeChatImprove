#!/usr/bin/env python3
"""Fault-inject isolated source copies; never mutate production code."""
import json
import pathlib
import subprocess
import sys

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parents[3]
source = ROOT / 'Controllers/WESessionTabContainerView.m'
text = source.read_text()
mutations = {
    'font-cache-stale': (
        'if (![self.measuredTitle isEqualToString:title] || ![self.measuredTitleFont isEqual:font]) {',
        'if (![self.measuredTitle isEqualToString:title]) {'),
    'badge-layout-stale': (
        'if ([self widthForTabButton:button] != previousWidth) self.tabLayoutValid = NO;',
        '(void)previousWidth; // Negative control: omit badge layout invalidation.'),
    'indicator-cancel-missing': (
        'if (!animated && [layer animationForKey:kIndicatorAnimationKey]) [layer removeAnimationForKey:kIndicatorAnimationKey];',
        '// Negative control: retain the animation when disabled.'),
    'selection-ack-layout': (
        'if (index == _selectedIndex) {',
        'if (index == _selectedIndex) { [self layoutIfNeeded];'),
}
results = []
for label, (before, after) in mutations.items():
    if text.count(before) != 1:
        raise SystemExit(f'{label}: mutation anchor must occur exactly once')
    path = HERE / (label + '.m')
    path.write_text(text.replace(before, after))
    run = subprocess.run([sys.executable, str(HERE / 'run-ui-validation.py'),
        '--source', str(path), '--label', label], capture_output=True, text=True)
    result_path = HERE / (label + '-result.json')
    result = json.loads(result_path.read_text())
    caught = run.returncode == 1 and 'FAIL:' in result['stderr']
    results.append({'fault': label, 'caught': caught, 'exit_code': run.returncode,
        'fixture_output': json.loads(result['output']), 'failed_checks': result['stderr'].splitlines()})

output = {'negative_controls': len(results), 'all_caught': all(r['caught'] for r in results), 'results': results}
(HERE / 'negative-controls-result.json').write_text(json.dumps(output, ensure_ascii=False, indent=2) + '\n')
print(json.dumps(output, ensure_ascii=False, indent=2))
raise SystemExit(0 if output['all_caught'] else 1)
