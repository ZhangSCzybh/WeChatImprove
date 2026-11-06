"""Extract production Logos getters; substitute only %orig for host doubles."""
from pathlib import Path
import sys
root = Path(__file__).resolve().parent.parent
source = Path(sys.argv[2]) if len(sys.argv) > 2 else root / 'Hooks/SessionGroupHooks.xm'
text = source.read_text()
methods = []
for marker, original in [('- (UIView *)tableHeaderView', '[self originalTableHeaderView]'),
                         ('- (BOOL)hasSearchBarHeader', '[self originalHasSearchBarHeader]')]:
    start = text.find(marker)
    if start < 0:
        assert 'hasSearchBarHeader' in marker
        methods.append(marker + ' { return ' + original + '; }')
        continue
    brace = text.index('{', start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == '{': depth += 1
        if text[end] == '}':
            depth -= 1
            if not depth:
                methods.append(text[start:end+1].replace('%orig', original))
                break
Path(sys.argv[1]).write_text('\n'.join(methods) + '\n')
