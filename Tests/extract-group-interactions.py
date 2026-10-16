"""Replay production editing, title and gesture methods with bounded host doubles."""
from pathlib import Path
import sys
source = (Path(__file__).resolve().parent.parent / 'Controllers/CSGroupListAdapter.m').read_text()
methods = []
for marker in ['- (void)endSwipeEditing', '- (void)reconcileDeletedSwipeRow',
               '- (BOOL)performNativeEditingContext:', '- (BOOL)forwardSwipeInvocation:',
               '+ (NSString *)groupTitleForTitleView:', '+ (void)recordNativeTitle:', '- (void)refreshNavigationTitle', '- (BOOL)groupSwipesAvailable',
               '- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:']:
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
