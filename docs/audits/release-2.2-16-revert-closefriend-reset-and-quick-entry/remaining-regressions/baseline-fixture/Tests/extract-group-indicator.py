"""Extract the production selection and indicator methods for a host replay."""
from pathlib import Path
import sys
source = (Path(__file__).resolve().parent.parent / 'Controllers/WESessionTabContainerView.m').read_text()
def extract(marker):
    start = source.index(marker)
    brace = source.index('{', start)
    depth = 0
    for end in range(brace, len(source)):
        if source[end] == '{': depth += 1
        if source[end] == '}':
            depth -= 1
            if depth == 0:
                return source[start:end+1]
    raise ValueError(marker)

methods = [extract(marker) for marker in ['- (NSInteger)indexForTabID:', '- (void)setSelectedTabID:',
               '- (void)selectTabAtIndex:', '- (void)updateIndicatorPosition {',
               '- (void)updateIndicatorPositionAnimated:', '- (void)moveIndicatorToFrame:',
               '- (void)scrollToSelectedTab', '- (CGRect)indicatorFrameForIndex:', '- (void)updateInteractiveTransitionToIndex:',
               '- (void)cancelInteractiveTransition', '- (void)updateCapsuleSelectionAnimated:']]
output = Path(sys.argv[1])
output.write_text('\n'.join(methods)+'\n')
output.with_name('GroupCapsuleHelpers.h').write_text(source[source.index('static NSTimeInterval const kCapsuleDuration'):source.index('// Match the native')])
# Skip the declaration in the private interface.
source = source[source.index('@implementation WETabButton'):]
output.with_name('GroupCapsuleButtonBody.h').write_text(extract('- (void)setCapsuleProgress:')+'\n'+extract('- (void)configureCapsuleEnabled:')+'\n')
