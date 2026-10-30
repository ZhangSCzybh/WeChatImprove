"""Replay complete production launch publication and header/cell delivery methods.

The host fixture supplies UIKit and account/model boundaries. No source rewrite is
performed: publication order, header mounting, and native cell delivery stay real.
An optional source argument supports a red control against the previous release.
"""
from pathlib import Path
import sys

root = Path(__file__).resolve().parent.parent
source = (Path(sys.argv[2]) if len(sys.argv) > 2 else root / 'Controllers/CSGroupListAdapter.m').read_text()

def method(marker):
    start = source.index(marker)
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{':
            depth += 1
        elif source[end] == '}':
            depth -= 1
            if depth == 0:
                return source[start:end + 1]
    raise AssertionError(marker)

markers = ['- (void)refresh {', '- (void)publishProjection:', '- (void)layout {',
           '- (void)publishHeader:', '- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target {',
           '- (BOOL)isActive {']
Path(sys.argv[1]).write_text('\n\n'.join(method(marker) for marker in markers) + '\n')
