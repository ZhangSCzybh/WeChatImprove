"""Extract the production selection and indicator methods for a host replay."""
from pathlib import Path
import re
import sys
source = (Path(__file__).resolve().parent.parent / 'Controllers/WESessionTabContainerView.m').read_text()
def extract(marker, text=None):
    text = source if text is None else text
    start = text.index(marker)
    brace = text.index('{', start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == '{': depth += 1
        if text[end] == '}':
            depth -= 1
            if depth == 0:
                return text[start:end+1]
    raise ValueError(marker)

methods = [extract(marker) for marker in ['- (NSInteger)indexForTabID:', '- (void)setSelectedTabID:',
               '- (void)updateTabs:', '- (CGFloat)widthForTabButton:', '- (void)layoutTabButtons',
               '- (void)scrollViewWillBeginDragging:',
               '- (void)selectTabAtIndex:', '- (void)updateIndicatorPosition {',
               '- (void)updateIndicatorPositionAnimated:', '- (void)moveIndicatorToFrame:',
               '- (void)scrollToSelectedTab', '- (CGRect)indicatorFrameForIndex:', '- (void)updateInteractiveTransitionToIndex:',
               '- (void)cancelInteractiveTransition', '- (void)updateCapsuleSelectionAnimated:',
               '- (CGRect)capsuleFrameForButton:', '- (void)moveCapsuleToFrame:',
               '- (void)tabButtonPressed:', '- (void)tabButtonPressEntered:',
               '- (void)tabButtonPressExited:', '- (void)tabButtonTouchCancelled:',
               '- (void)tabButtonTapped:']]
output = Path(sys.argv[1])
output.write_text('\n'.join(methods)+'\n')
# Select the container implementation, after WETabButton's layoutSubviews.
container_source = source[source.index('@implementation WESessionTabContainerView'):]
output.with_name('GroupContainerLayoutBody.h').write_text(extract('- (void)layoutSubviews',container_source)+'\n')
output.with_name('GroupCapsuleHelpers.h').write_text(source[source.index('static NSTimeInterval const kCapsulePressDuration'):source.index('// Match the native')])
# Replay the real UIControl event bindings, so handler tests also cover wiring.
bindings = re.findall(r'\[button addTarget:self action:@selector\([^)]*\) forControlEvents:[^;]+;', extract('- (void)updateTabs:'))
if len(bindings) != 5:
    raise ValueError('Expected all five tab button touch bindings')
output.with_name('GroupCapsuleTouchBindings.h').write_text('\n'.join(bindings)+'\n')
output.with_name('GroupTabScrollBody.h').write_text(extract('- (BOOL)touchesShouldCancelInContentView:')+'\n')
appearance = extract('- (void)refreshAppearance')
touch_start = appearance.index('CSGroupIndicatorStyle style =')
touch_end = appearance.index('self.scrollView.delaysContentTouches = !capsule;') + len('self.scrollView.delaysContentTouches = !capsule;')
output.with_name('GroupCapsuleTouchAppearance.h').write_text(appearance[touch_start:touch_end]+'\n')
setup = extract('- (void)setupUI')
cancel_policy = re.search(r'_scrollView\.canCancelContentTouches\s*=\s*[^;]+;', setup)
if not cancel_policy:
    raise ValueError('Missing explicit scroll touch cancellation policy')
output.with_name('GroupCapsuleTouchSetup.h').write_text(cancel_policy.group()+'\n')
# Skip the declaration in the private interface.
source = source[source.index('@implementation WETabButton'):]
output.with_name('GroupCapsuleButtonBody.h').write_text('\n'.join(extract(marker) for marker in [
    '- (void)setCapsuleProgress:', '- (void)configureCapsuleEnabled:',
    '- (BOOL)beginTrackingWithTouch:', '- (BOOL)continueTrackingWithTouch:'])+'\n')
