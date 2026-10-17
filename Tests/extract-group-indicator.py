"""Extract the production selection and indicator methods for a host replay."""
from pathlib import Path
import sys
source = (Path(__file__).resolve().parent.parent / 'Controllers/WESessionTabContainerView.m').read_text()
methods = []
for marker in ['- (NSInteger)indexForTabID:', '- (void)setSelectedTabID:',
               '- (void)selectTabAtIndex:', '- (void)updateIndicatorPosition {',
               '- (void)updateIndicatorPositionAnimated:', '- (void)moveIndicatorToFrame:',
               '- (void)scrollToSelectedTab', '- (CGRect)indicatorFrameForIndex:', '- (void)updateInteractiveTransitionToIndex:', '- (void)cancelInteractiveTransition']:
    start = source.index(marker)
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{': depth += 1
        if source[end] == '}':
            depth -= 1
            if depth == 0:
                methods.append(source[start:end+1])
                break
Path(sys.argv[1]).write_text('\n'.join(methods)+'\n')
