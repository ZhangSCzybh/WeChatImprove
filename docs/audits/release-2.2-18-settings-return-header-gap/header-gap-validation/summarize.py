#!/usr/bin/env python3
"""Check frozen red/green provenance and produce stage-specific audit counts."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def stages(label):
    rows = json.loads((HERE / label / 'geometry-trace.json').read_text())
    failures, totals = Counter(), Counter()
    assert len(rows) % 14 == 0
    changed_wxid = changed_header = changed_scroll = 0
    for index in range(0, len(rows), 14):
        scenario = rows[index:index + 14]
        baseline = scenario[0]
        for row in scenario:
            totals[row['phase']] += 1
            failures[row['phase']] += row['section_title_height'] != baseline['section_title_height']
            changed_wxid += row['wxid_y'] != baseline['wxid_y']
            changed_header += row['header_height'] != baseline['header_height']
            changed_scroll += row['content_offset_y'] != baseline['content_offset_y']
    return {'sample_count': len(rows), 'scenario_count': len(rows) // 14,
            'stages': [{'phase': name, 'samples': total, 'gap_failures': failures[name]} for name, total in totals.items()],
            'changed_wxid_samples': changed_wxid, 'changed_header_samples': changed_header,
            'changed_scroll_samples': changed_scroll,
            'terminal_only_would_pass': failures['post-transition-final'] == failures['pop-after-cancel-final'] == 0}


red = json.loads((HERE / 'red-final-2.2-17/provenance.json').read_text())
green = json.loads((HERE / 'green-2.2-18/provenance.json').read_text())
assert red['test_sha256'] == green['test_sha256']
assert red['runner_sha256'] == green['runner_sha256']
assert red['source_unchanged_during_test'] and green['source_unchanged_during_test']
sdk = Path(subprocess.check_output(['xcrun', '--sdk', 'iphoneos', '--show-sdk-path'], text=True).strip())
header = sdk / 'System/Library/Frameworks/UIKit.framework/Headers/UITableView.h'
lines = header.read_text().splitlines()
selected = [{'line': i + 1, 'text': line} for i, line in enumerate(lines)
            if '@property' in line and any(name in line for name in ['sectionHeaderHeight;', 'estimatedSectionHeaderHeight '])]
assert any('set to 0 to disable' in row['text'] for row in selected)
summary = {'red': stages('red-final-2.2-17'), 'green': stages('green-2.2-18'),
           'fixture_sha256_equal': red['test_sha256'] == green['test_sha256'],
           'runner_sha256_equal': red['runner_sha256'] == green['runner_sha256'],
           'fixture_sha256': red['test_sha256'], 'runner_sha256': red['runner_sha256'],
           'red_source_sha256': red['source_sha256'], 'green_source_sha256': green['source_sha256'],
           'sdk_contract': {'path': str(header), 'sha256': digest(header), 'lines': selected},
           'limits': red['limits']}
(HERE / 'RESULT.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2) + '\n')
print(json.dumps(summary, ensure_ascii=False, indent=2))
