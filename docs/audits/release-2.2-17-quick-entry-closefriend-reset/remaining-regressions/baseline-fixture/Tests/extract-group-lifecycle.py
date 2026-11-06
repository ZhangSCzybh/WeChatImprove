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
header = (root/'Controllers/CSGroupListAdapter.h').read_text()
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
if '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:' in source:
    # Keep the refresh-tail dependency real: host boundaries supply immutable
    # rows/account state, while production decides whether a source is verified.
    interface = header.split('// BEGIN Chat tab badge decision', 1)[1].split('// END Chat tab badge decision', 1)[0]
    implementation_start = source.index('@implementation CSGroupTabBadgeDecision')
    implementation_end = source.index('@end', implementation_start)+len('@end')
    constant = next(line for line in source.splitlines() if line.startswith('NSNotificationName const CSGroupTabBadgeSourceDidRefreshNotification='))
    out.with_name('GroupLifecycleTabBadgeDependencies.h').write_text('NS_ASSUME_NONNULL_BEGIN\n'+interface+'\nNS_ASSUME_NONNULL_END\n#define CS_GROUP_LIFECYCLE_TAB_BADGE 1\n')
    out.with_name('GroupLifecycleTabBadgeImplementation.inc').write_text(source[implementation_start:implementation_end]+'\n'+constant+'\n')
    methods.append(method(source, '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision {'))
    methods.append(method(source, '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:'))
    for marker in ['+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:', '+ (void)requestTabBadgeSourcesRefresh {', '- (void)requestTabBadgeSourceRefresh {', '- (void)requestTabBadgeSourceRefreshCoalesced:(BOOL)coalesced {', '- (void)cancelTabBadgeSourceRefresh {', '- (void)refreshTabBadgeSource {']:
        if marker in source: methods.append(method(source, marker))
else:
    out.with_name('GroupLifecycleTabBadgeDependencies.h').write_text('#define CS_GROUP_LIFECYCLE_TAB_BADGE 0\n')
    out.with_name('GroupLifecycleTabBadgeImplementation.inc').write_text('')
for marker in ['+ (instancetype)adapterForTable:', '+ (instancetype)adapterForController:',
               '+ (void)attachToController:', '+ (void)layoutForController:', '+ (void)settingsChanged',
               '- (void)requestRefresh {', '- (void)requestRecovery {', '- (void)scheduleRefresh {', '- (void)cancelScheduledRefresh {', '+ (void)applicationActivityChanged:', '+ (void)closeFriendPolicyChanged:', '- (void)beginNativeChangeOfKind:', '- (void)requestCoalescedRefresh', '- (void)invalidateNativeSnapshot', '- (NSArray *)nativeSectionsForAccount:', '- (void)beginNativeChange', '- (void)endNativeChange {', '- (void)endNativeChangeCoalesced:',
               '- (void)pruneNativeActions', '- (void)performNativeBatch:', '- (void)performInNativePresentation:', '- (void)useNativePresentation {']:
    methods.append(method(source, marker))
methods.append(method(source,'- (void)selectIndex:'))
if '+ (void)refreshFoldedListsForAccount:' in source:
    methods.append(method(source,'+ (void)refreshFoldedListsForAccount:'))
for marker, fallback in [('+ (void)setPresentationSuspended:', '+ (void)setPresentationSuspended:(BOOL)value forController:(id)owner { (void)value; (void)owner; }'),
                         ('- (void)shieldVisiblePrivateRows', '- (void)shieldVisiblePrivateRows {}'),
                         ('- (void)finishSuspendedBatches', '- (void)finishSuspendedBatches {}')]:
    methods.append(method(source, marker) if marker in source else fallback)
refresh = method(source, '- (void)refresh {')
prefix = refresh[:refresh.index('    self.publishing=YES; self.dirty=NO;')]
tail = refresh[refresh.index('    } @finally {'):]
account_start=refresh.index('        NSString *account=CSGroupCurrentAccountID();')
account_end=refresh.index('        self.searching=CSGroupReadInteger',account_start)
account_reset=refresh[account_start:account_end]
mode_end=refresh.index('        if (!self.preferences || changed)',account_end)
account_reset+=refresh[account_end:mode_end]
publication_start=refresh.index('    self.publishing=YES; self.dirty=NO;')
publication_end=refresh.index('    @try {',publication_start)
publication_state=refresh[publication_start:publication_end]
methods.append(prefix + publication_state + '    @try {\n' + account_reset + ' self.lastPublishedChanges=changes; [self publishFixture]; finished=YES;\n' + tail)
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
folded=[]
for name in ['FoldedAppear','FoldedDisappear']:
    folded.append(method(hooks,'static void '+name+'('))
out.with_name('FoldedLifecycleHooks.h').write_text('\n'.join(folded)+'\n')
reload = method(hooks, '- (void)reloadData {').replace('%orig', 'self.reloads++')
out.with_name('GroupLifecycleReload.h').write_text(reload+'\n')
