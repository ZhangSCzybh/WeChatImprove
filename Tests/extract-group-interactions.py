"""Replay production editing, title and gesture methods with bounded host doubles."""
from pathlib import Path
import sys
root = Path(__file__).resolve().parent.parent
source = (Path(sys.argv[2]) if len(sys.argv) > 2 else root / 'Controllers/CSGroupListAdapter.m').read_text()
methods = []
for marker in ['- (void)cancelScheduledRefresh {', '- (void)consumeRefreshRequest {', '- (void)requestRecovery {', '- (void)ensureListPanHost {', '- (BOOL)groupPanMoving', '- (NSInteger)listZoneForTouch:', '- (BOOL)nativeMenuGesture:', '- (BOOL)closeMenusForGroupSwitch', '- (BOOL)gestureRecognizerShouldBegin:', '- (void)groupPan:', '- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldBeRequiredToFailByGestureRecognizer:', '- (NSUInteger)nativeMenuState', '- (void)nativeMenuDidChange', '- (void)updateGroupGestureAvailability', '- (void)endSwipeEditing', '- (void)reconcileDeletedSwipeRow',
               '- (BOOL)performNativeEditingContext:', '- (BOOL)forwardSwipeInvocation:',
               '- (void)selectSwipeIndex:(NSInteger)index {',
               '- (BOOL)keepsGroupHeaderDuringSearch', '+ (NSString *)groupTitleForTitleView:', '+ (void)recordNativeTitle:', '- (void)refreshNavigationTitle', '- (BOOL)groupSwipesAvailable',
               '- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:']:
    if marker in ['- (BOOL)groupPanMoving', '- (NSInteger)listZoneForTouch:', '- (BOOL)nativeMenuGesture:', '- (BOOL)closeMenusForGroupSwitch'] and marker not in source:
        if marker == '- (BOOL)nativeMenuGesture:':
            methods.append('- (BOOL)nativeMenuGesture:(UIGestureRecognizer *)gesture inCell:(UIView *)cell shouldReceiveTouch:(UITouch *)touch { (void)gesture; (void)cell; (void)touch; return YES; }')
        continue
    if marker in ['- (NSUInteger)nativeMenuState', '- (void)nativeMenuDidChange'] and marker not in source:
        methods.append('- (NSUInteger)nativeMenuState { return 0; }' if 'nativeMenuState' in marker else '- (void)nativeMenuDidChange {}')
        continue
    if marker == '- (void)updateGroupGestureAvailability' and marker not in source:
        continue  # Optional for the pre-fix comparison.
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
# Exercise the exact refresh admission and scheduling code. Stop before building
# the host's private model; a counter stands in for the admitted reload.
start = source.index('- (void)refresh {')
end = source.index('    self.publishing=YES; self.dirty=NO;', start)
methods.append(source[start:end] + '    (void)sourceViewport; self.refreshCount++; self.dirty=NO;\n}')
start = source.index('- (void)requestRefresh {')
end = source.index('\n- (void)beginNativeChange', start)
methods.append(source[start:end].replace('- (void)requestRefresh {', '- (void)enqueueRefresh {', 1))
Path(sys.argv[1]).write_text('\n'.join(methods)+'\n')
hooks = (Path(sys.argv[3]) if len(sys.argv) > 3 else root / 'Hooks/SessionGroupHooks.xm').read_text()
start = hooks.index('- (void)setEditing:(BOOL)editing {')
end = hooks.index('- (UIView *)tableHeaderView', start)
body = hooks[start:end]
first, second = body.split('- (void)setEditing:(BOOL)editing animated:')
first = first.replace('%orig', '[super setEditing:editing]')
second = second.replace('%orig', '[super setEditing:editing animated:animated]')
Path(sys.argv[1]).with_name('GroupEditingHookBodies.h').write_text(first + '- (void)setEditing:(BOOL)editing animated:' + second)

if 'static CSGroupListAdapter *MenuAdapter(' in hooks:
    start = hooks.index('static CSGroupListAdapter *MenuAdapter(')
    end = hooks.index('%hook MainSessionEditingLogic', start)
    menu = hooks[start:end].replace('%hook MMBaseMultiMenuTableViewCell', '@implementation HookedMenuCell').replace('%end', '@end')
    menu = menu.replace('%orig;', '[super handlePan:gesture];', 1)
    menu = menu.replace('%orig;', '[super setMenuOptionsViewHidden:hidden animated:animated completionHandler:completion];', 1)
    menu = menu.replace('%orig(hidden,animated,observedCompletion);', '[super setMenuOptionsViewHidden:hidden animated:animated completionHandler:observedCompletion];')
else:
    menu = '@implementation HookedMenuCell @end'
Path(sys.argv[1]).with_name('GroupMenuHookBodies.h').write_text(menu)

if 'static BOOL MenuReceiveTouch(' not in menu:
    with Path(sys.argv[1]).with_name('GroupMenuHookBodies.h').open('a') as f:
        f.write('\nstatic BOOL (*OriginalMenuReceiveTouch)(id,SEL,UIGestureRecognizer *,UITouch *);\n')
        f.write('static BOOL MenuReceiveTouch(id cell,SEL selector,UIGestureRecognizer *gesture,UITouch *touch) { return OriginalMenuReceiveTouch ? OriginalMenuReceiveTouch(cell,selector,gesture,touch) : YES; }\n')
        f.write('static void InstallMenuTouchGate(void) { class_addMethod(NSClassFromString(@"MMBaseMultiMenuTableViewCell"),@selector(gestureRecognizer:shouldReceiveTouch:),(IMP)MenuReceiveTouch,"B@:@@"); }\n')
