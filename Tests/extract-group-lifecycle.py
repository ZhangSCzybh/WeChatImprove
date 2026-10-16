"""Replay production lifecycle, queue admission and completion paths on the host.

Only native snapshot/UI publication is replaced with a counted fixture; this is
not an iOS frame-time benchmark. Optional old source/hooks provide a control.
"""
from pathlib import Path
import sys
root = Path(__file__).resolve().parent.parent
source = (Path(sys.argv[2]) if len(sys.argv) > 2 else root/'Controllers/CSGroupListAdapter.m').read_text()
hooks = (Path(sys.argv[3]) if len(sys.argv) > 3 else root/'Hooks/SessionGroupHooks.xm').read_text()
out = Path(sys.argv[1])
def method(text, marker):
    start = text.index(marker)
    brace = text.index('{', start)
    depth = 0
    for end in range(brace, len(text)):
        if text[end] == '{': depth += 1
        elif text[end] == '}':
            depth -= 1
            if not depth: return text[start:end+1]
    raise AssertionError(marker)
methods = []
for marker in ['+ (instancetype)adapterForTable:', '+ (instancetype)adapterForController:',
               '+ (void)attachToController:', '+ (void)layoutForController:', '+ (void)settingsChanged',
               '- (void)requestRefresh', '- (void)beginNativeChange', '- (void)endNativeChange',
               '- (void)performNativeBatch:', '- (void)performInNativePresentation:', '- (void)useNativePresentation {']:
    methods.append(method(source, marker))
for marker, fallback in [('+ (void)setPresentationSuspended:', '+ (void)setPresentationSuspended:(BOOL)value forController:(id)owner { (void)value; (void)owner; }'),
                         ('- (void)finishSuspendedBatches', '- (void)finishSuspendedBatches {}')]:
    methods.append(method(source, marker) if marker in source else fallback)
refresh = method(source, '- (void)refresh {')
prefix = refresh[:refresh.index('    self.publishing=YES; self.dirty=NO;')]
tail = refresh[refresh.index('    } @finally {'):]
methods.append(prefix + '    self.publishing=YES; self.dirty=NO;\n    BOOL finished=NO;\n    @try { [self publishFixture]; finished=YES;\n' + tail)
layout = method(source, '- (void)layout {')
methods.append(layout[:layout.index('    __block UIView *installed')] + '    self.layoutCount++;\n}')
# Actual save/restore/top method entry guards; the expensive UI work is counted.
for name, cut in [('saveAnchor', '    if (self.pendingScrollToTop)'), ('restoreAnchor', '    if (self.pendingScrollToTop)'),
                  ('returnToGroupTop', '    if (!Option'), ('refreshNavigationTitle', '    id titleView=')]:
    body = method(source, '- (void)' + name + ' {')
    methods.append(body[:body.index(cut)] + '    self.anchorOrTitleCount++;\n}')
out.write_text('\n\n'.join(methods)+'\n')
life = []
for name in ['viewWillAppear', 'viewDidAppear', 'viewWillDisappear', 'viewDidDisappear']:
    marker = '- (void)' + name + ':'
    body = method(hooks, marker) if marker in hooks else marker + '(BOOL)animated { %orig; }'
    life.append(body.replace('%orig', '[self nativeAppearance:animated]'))
out.with_name('GroupLifecycleHooks.h').write_text('\n'.join(life)+'\n')
reload = method(hooks, '- (void)reloadData {').replace('%orig', 'self.reloads++')
out.with_name('GroupLifecycleReload.h').write_text(reload+'\n')
