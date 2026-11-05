from pathlib import Path
import hashlib
import json
import os
import re
import sys

root, out = map(Path, sys.argv[1:])
source = (root / 'Controllers/CSGroupListAdapter.m').read_text()

def body(text, marker):
    start = text.index(marker)
    opening = text.index('{', start)
    depth = 0
    # Production method markers are unique and these bodies have balanced
    # literal/comment braces; do not replace any implementation expressions.
    for end in range(opening, len(text)):
        if text[end] == '{': depth += 1
        elif text[end] == '}':
            depth -= 1
            if depth == 0: return text[start:end+1]
    raise AssertionError(marker)

markers = [
    '+ (instancetype)adapterForTable:', '+ (instancetype)adapterForController:', '+ (void)attachToController:',
    '- (id)nativeSource', '- (void)installProxies', '- (id)proxyForTarget:',
    '- (BOOL)adoptCompatibilityModelIfNeeded', '- (void)shieldVisiblePrivateRows', '- (void)refreshNativeSessionModel', '- (void)bindNativeCell:',
    '- (CSGroupProjection *)projectionForSections:',
    '+ (NSNumber *)closeFriendAlertBadgeCount', '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision {',
    '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:',
    '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:',
    '- (void)consumeRefreshRequest', '- (void)cancelScheduledRefresh', '- (void)requestRecovery',
    '- (void)requestRefresh', '- (void)scheduleRefresh {', '- (void)requestCoalescedRefresh',
    '- (void)nativeMenuDidChange', '- (void)endSwipeEditing',
    '- (void)beginNativeChange {', '- (void)beginNativeChangeOfKind:', '- (void)endNativeChange {', '- (void)endNativeChangeCoalesced:',
]
implementation=source[source.index('@implementation CSGroupListAdapter\n'):]
for optional in ['- (BOOL)refreshInteractionIsBlocking', '- (BOOL)ordinaryRefreshBlockedByInteraction', '- (BOOL)shouldDeferOrdinaryRefresh', '- (void)mergePendingChangeOfKind:', '- (void)publishNativeProjection:', '- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind changedUserNames:']:
    if optional in implementation: markers.append(optional)
actual_recovery=body(implementation,'- (void)scheduleNativeRecoveryForKey:').replace(
    '- (void)scheduleNativeRecoveryForKey:', '- (void)productionScheduleNativeRecoveryForKey:',1)
actual_notifications=body(implementation,'- (void)nativeSessionModelChanged:').replace(
    '- (void)nativeSessionModelChanged:', '- (void)productionNativeSessionModelChanged:',1)
if os.environ.get('WECHAT_VALIDATION_RESTORE_OLD_RECOVERY_RESET')=='1':
    # Explicit negative control: restore the removed candidate behavior only in
    # this temporary extracted fixture. Production files are never rewritten.
    actual_notifications=actual_notifications.replace('[self shieldVisiblePrivateRows];',
        '[self shieldVisiblePrivateRows];\n    if (!self.publishing) { self.nativeRecoveryAttempts=0;self.nativeRecoveryGeneration++; }',1)
compatibility_publisher=body(implementation,'- (void)publishProjection:')
compat_names='changedUserNames:' in compatibility_publisher[:compatibility_publisher.index('{')]
compatibility_source=body(implementation,'- (NSArray *)nativeSectionsForAccount:')
compat_source_hints='changes:' in compatibility_source[:compatibility_source.index('{')]
(out/'CompatibilityAPIs.h').write_text('#define CS_COMPAT_NAMES '+str(int(compat_names))+'\n#define CS_COMPAT_SOURCE_HINTS '+str(int(compat_source_hints))+'\n#define CS_LEGACY_TOP_APIS '+str(int('- (void)returnToGroupTop' in implementation))+'\n#define CS_STRICT_STRUCTURE_HINTS '+str(int('BOOL strictStructure=' in (root/'Controllers/CSGroupNativeBridge.m').read_text()))+'\n')
actual_bodies=[body(implementation,m) for m in markers]
# Execute full production scroll state, geometry, selection and lifecycle bodies.
# Existing CPU fixtures retain their no-op geometry boundary via explicit wrappers;
# the position suite enables the renamed real implementations.
scroll_markers=['+ (void)setPresentationSuspended:', '+ (void)layoutForController:',
    '+ (void)refreshFoldedListsForAccount:', '- (BOOL)hasScrollableContent',
    '- (BOOL)canRestoreAnchor', '- (void)selectIndex:',
    '- (void)publishHeader:', '- (BOOL)keepsGroupHeaderDuringSearch', '- (void)prepareForNativeSearch',
    '- (void)performInNativePresentation:', '- (void)useNativePresentation',
    '- (void)forwardInvocation:']
for method_name in ['finishPresentationReturnForController:', 'captureViewportForTabID:', 'validViewport:',
                    'restoreScrollHeight:', 'restorePendingViewport', 'restoreViewportFromSource:',
                    'clearPendingViewport', 'beginUserScrolling', 'beginUserDragging', 'tablePan:', 'groupSwipesAvailable']:
    match=re.search(r'^[+-] \([^)]*\)'+re.escape(method_name)+r'(?=[\s{(])',implementation,re.M)
    if match: scroll_markers.append(match.group(0))
if '- (void)returnToGroupTop' in implementation: scroll_markers.append('- (void)returnToGroupTop')
scroll_bodies=[body(implementation,m) for m in scroll_markers]
for marker,replacement in [('- (void)saveAnchor','- (void)productionSaveAnchor'),
                           ('- (void)restoreAnchor','- (void)productionRestoreAnchor'),
                           ('- (void)applyPendingScrollToTop','- (void)productionApplyPendingScrollToTop'),
                           ('- (void)layout {','- (void)productionLayout {')]:
    if marker in implementation: scroll_bodies.append(body(implementation,marker).replace(marker,replacement,1))
# Explicit negative controls alter only the temporary extracted compilation.
for index,method in enumerate(scroll_bodies):
    if os.environ.get('WECHAT_SCROLL_LOSE_RETARGET_IDENTITY')=='1' and method.startswith('- (void)restorePendingViewport'):
        needle='self.switchViewport=request; viewport=self.switchViewport;'
        assert method.count(needle)==1
        scroll_bodies[index]=method.replace(needle,'self.switchViewport=request; viewport=request;')
    if os.environ.get('WECHAT_SCROLL_IGNORE_FAILED_RESTORE')=='1' and method.startswith('- (void)restorePendingViewport'):
        needle='if (![self restoreScrollHeight:[viewport[@"height"] doubleValue]]) return;'
        assert method.count(needle)==1
        scroll_bodies[index]=method.replace(needle,'[self restoreScrollHeight:[viewport[@"height"] doubleValue]];')
    if os.environ.get('WECHAT_SCROLL_IGNORE_SETTER_READBACK')=='1' and method.startswith('- (void)selectIndex:'):
        needle='if (![self.preferences.selectedTabID isEqual:tabID])'
        assert method.count(needle)==1
        scroll_bodies[index]=method.replace(needle,'if (NO && ![self.preferences.selectedTabID isEqual:tabID])')
actual_bodies+=scroll_bodies
actual_bodies.append(compatibility_publisher)
compatibility_refresh=body(implementation,'- (void)refresh {').replace('- (void)refresh {','- (void)productionCompatibilityRefresh {',1)
actual_bodies.append(compatibility_refresh)
actual_bodies.append(compatibility_source.replace('- (NSArray *)nativeSectionsForAccount:', '- (NSArray *)productionNativeSectionsForAccount:',1))
if os.environ.get('WECHAT_VALIDATION_COMPAT_FULL_UI')=='1':
    for index,method in enumerate(actual_bodies):
        if method.startswith('- (void)publishProjection:'):
            actual_bodies[index]=method[:method.index('{')]+'''{ (void)projection;(void)previous;(void)changes;(void)previouslyProjecting;
''' + ('(void)changedUserNames;' if compat_names else '') + '''
CSGroupWithDisplayIndices(self.table, ^{[self.table reloadData];[self.table layoutIfNeeded];});
}'''
if os.environ.get('WECHAT_VALIDATION_COMPAT_ALWAYS_LAYOUT')=='1':
    for index,method in enumerate(actual_bodies):
        if method.startswith('- (void)publishProjection:'):
            needle='if (reloaded || self.sessionLayoutHeld) [self.table layoutIfNeeded];'
            assert method.count(needle)==1
            actual_bodies[index]=method.replace(needle,'if (reloaded || self.sessionLayoutHeld || YES) [self.table layoutIfNeeded];')
if os.environ.get('WECHAT_VALIDATION_COMPAT_IGNORE_METADATA')=='1':
    for index,method in enumerate(actual_bodies):
        if method.startswith('- (void)publishProjection:'):
            needle='BOOL changed=row!=old && ('
            assert method.count(needle)==1
            actual_bodies[index]=method.replace(needle,'BOOL changed=row!=old && [changedUserNames containsObject:row.userName] && (')

if os.environ.get('WECHAT_VALIDATION_COMPAT_DROP_NAMES')=='1':
    for index,method in enumerate(actual_bodies):
        if method.startswith('- (void)productionCompatibilityRefresh {'):
            needle='changedUserNames=self.pendingChangeNamesUnknown ? nil : [self.pendingChangedUserNames copy];'
            assert method.count(needle)==1
            actual_bodies[index]=method.replace(needle,needle+'changedUserNames=nil;')
if os.environ.get('WECHAT_VALIDATION_COMPAT_IGNORE_REENTRANCY')=='1':
    for index,method in enumerate(actual_bodies):
        if method.startswith('- (void)productionCompatibilityRefresh {'):
            needle='BOOL sourceUnchanged=self.modelRevision==requestedRevision;'
            assert method.count(needle)==1
            actual_bodies[index]=method.replace(needle,'BOOL sourceUnchanged=YES;')
if os.environ.get('WECHAT_VALIDATION_RESTORE_INTERACTION_MISMATCH')=='1':
    # Negative control restores the precise 2.2-8 scheduler mismatch only in
    # temporary extracted code; the real native refresh gate remains unchanged.
    for index,method in enumerate(actual_bodies):
        if method.startswith('- (void)scheduleRefresh {'):
            old='[self refreshInteractionIsBlocking]'
            assert method.count(old)==1
            actual_bodies[index]=method.replace(old,'(self.table.tracking || [self groupPanMoving] || ([self nativeMenuState]&2))')

if os.environ.get('WECHAT_VALIDATION_FORCE_FULL_UI')=='1':
    # Negative control restores the old whole-table publication work only in
    # extracted temporary code. This never mutates production source.
    for index,method in enumerate(actual_bodies):
        if method.startswith('- (void)publishNativeProjection:'):
            actual_bodies[index]=method[:method.index('{')]+'''{
    (void)projection;(void)previous;(void)changes;(void)changedUserNames;(void)previouslyProjecting;
    [self.table reloadData];[self.table layoutIfNeeded];
}'''
(out/'AdapterBodies.h').write_text('\n\n'.join(actual_bodies)+
    '\n\n'+actual_recovery+'\n\n'+actual_notifications)
start=source.index('@interface CSGroupListAdapter ()')
end=source.index('@end',start)
declarations=source[start:end].replace('@interface CSGroupListAdapter () <UIGestureRecognizerDelegate>', '@interface CSGroupListAdapter : NSObject')
declarations+='''
@property(nonatomic) NSUInteger fixtureRefreshes, fixtureRecoveries, fixtureBadgeRequests;
@property(nonatomic) BOOL fixtureScheduleOnly,fixtureRealScroll;
@property(nonatomic) BOOL fixtureRealRecovery,fixtureRealNotifications,fixtureRealCompatibilityRefresh,fixtureRealCompatSource;
@property(nonatomic,readonly,getter=isActive) BOOL active;
@property(nonatomic,copy) NSArray *fixtureCompatSections;
@property(nonatomic,copy) void (^fixtureOnCompatSource)(void);
- (void)productionCompatibilityRefresh;
- (void)reconcileDeletedSwipeRow;
- (BOOL)forwardSwipeInvocation:(NSInvocation *)inv target:(id)target;
- (NSIndexPath *)displayPath:(NSIndexPath *)path;
#if CS_COMPAT_SOURCE_HINTS
- (NSArray *)productionNativeSectionsForAccount:(NSString *)account changes:(CSGroupChangeKind)changes changedUserNames:(NSSet *)names;
#else
- (NSArray *)nativeSectionsForAccount:(NSString *)account;
- (NSArray *)productionNativeSectionsForAccount:(NSString *)account;
#endif
@property(nonatomic) NSUInteger fixtureLegacyRefreshes;
@property(nonatomic,copy) void (^fixtureOnRefresh)(void);
+ (instancetype)adapterForTable:(id)table;
+ (instancetype)adapterForController:(id)controller;
+ (void)attachToController:(id)controller;
+ (NSNumber *)closeFriendAlertBadgeCount;
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision;
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:(BOOL)includeNative;
+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:(id)controller includeNative:(BOOL)includeNative;
- (void)refresh;
- (void)refreshNativeSessionModel;
- (void)bindNativeCell:(UITableViewCell *)cell atPath:(NSIndexPath *)path;
- (void)detach;
- (void)nativeSessionModelChanged:(NSNotification *)note;
- (void)nativeMenuDidChange;
- (void)endSwipeEditing;
- (void)updateGroupGestureAvailability;
- (void)pruneNativeActions;
- (void)finishSuspendedBatches;
- (BOOL)groupPanMoving;
- (NSUInteger)nativeMenuState;
- (void)saveAnchor;
- (void)restoreAnchor;
- (void)ensureChrome;
- (void)layout;
- (void)refreshNavigationTitle;
- (void)applyPendingScrollToTop;
- (void)scheduleNativeRecoveryForKey:(NSArray *)key;
- (void)productionScheduleNativeRecoveryForKey:(NSArray *)key;
- (void)productionNativeSessionModelChanged:(NSNotification *)note;
- (NSIndexPath *)currentPathForRow:(CSGroupRow *)row;
- (void)invalidateNativeSnapshot;
- (id)nativeSource;
- (void)installProxies;
- (id)proxyForTarget:(id)target role:(NSUInteger)role;
- (CSGroupProjection *)projectionForSections:(NSArray *)sections tabs:(NSArray *)tabs selectedTabID:(NSString *)selected accountID:(NSString *)account;
- (void)requestCoalescedRefresh;
- (void)beginNativeChange;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind;
- (void)endNativeChange;
- (void)endNativeChangeCoalesced:(BOOL)coalesced;
- (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind changedUserNames:(NSSet *)names;
@end
'''
declarations=declarations.replace('@end\n',''.join(m[:m.index('{')].strip()+';\n' for m in scroll_bodies)+'@end\n')
(out/'AdapterDeclarations.h').write_text(declarations)
header=(root/'Controllers/CSGroupListAdapter.h').read_text()
start=header.index('@interface CSGroupTabBadgeDecision');end=header.index('@end',start)+4
(out/'BadgeDecisionDeclaration.h').write_text('NS_ASSUME_NONNULL_BEGIN\n'+header[start:end]+'\nNS_ASSUME_NONNULL_END\n')
start=source.index('@implementation CSGroupTabBadgeDecision');end=source.index('@end',start)+4
(out/'BadgeDecisionImplementation.h').write_text(source[start:end])
hooks=(root/'Hooks/NativeSessionGroupHooks.xm').read_text()
copy=body(hooks,'static NSArray *CSNativeGroupCopyEnumerator(')
start=hooks.index('IMP replacement=imp_implementationWithBlock(^id(id manager)')
replacement=body(hooks[start:],'IMP replacement=')
# Invoke the exact production block using the real native method as its IMP.
expression=replacement.split('imp_implementationWithBlock(',1)[1]
(out/'NativeEnumeratorBody.h').write_text(copy+'\nstatic id FixtureForwardEnumerator(id manager) {\n'
    'CSGroupNativeSessionCoordinator *coordinator=Coordinator;\n'
    'SEL selector=@selector(fixtureForwardableSessionEnumerator);\n'
    'IMP original=[MainSessionMgr instanceMethodForSelector:selector];\n'
    'id (^replacement)(id)='+expression+';\nreturn replacement(manager);\n}\n')
change_bodies=[]
for marker in ['static NSSet *CSNativeGroupChangedNames(', 'static void CSNativeGroupUnknownMutation(']:
    if marker in hooks: change_bodies.append(body(hooks,marker))
ui_hooks=(root/'Hooks/SessionGroupHooks.xm').read_text()
if 'static NSSet *ChangedSessionNames(' in ui_hooks: change_bodies.append(body(ui_hooks,'static NSSet *ChangedSessionNames('))
# Preserve the actual native-mode scroll/edit hook wakeup logic. The original
# UIKit callback is the only substituted unavailable-host boundary.
callback_bodies=[]
for marker,name in [('- (void)scrollViewDidEndDragging:', 'FixtureDidEndDragging'),
                    ('- (void)scrollViewDidEndDecelerating:', 'FixtureDidEndDecelerating'),
                    ('- (void)tableView:(id)table didEndEditingRowAtIndexPath:', 'FixtureDidEndEditing')]:
    method=body(ui_hooks,marker)
    contents=method[method.index('{'):].replace('%orig;', 'FixtureNativeEndCallbacks++;')
    signature={'FixtureDidEndDragging':'static void FixtureDidEndDragging(id scrollView,BOOL decelerate)',
               'FixtureDidEndDecelerating':'static void FixtureDidEndDecelerating(id scrollView)',
               'FixtureDidEndEditing':'static void FixtureDidEndEditing(id table,id path)'}[name]
    if name=='FixtureDidEndEditing': contents=contents.replace('{','{ (void)path;',1)
    callback_bodies.append(signature+contents)
(out/'NativeInteractionCallbacks.h').write_text('\n\n'.join(callback_bodies)+'\n')
lifecycle=[body(ui_hooks,'static CSGroupListAdapter *Adapter('),body(ui_hooks,'static void Native(')]
for name in ['viewWillAppear','viewDidAppear','viewWillDisappear','viewDidDisappear']:
    method=body(ui_hooks,'- (void)'+name+':')
    contents=method[method.index('{'):]
    contents=contents.replace('self','owner').replace('%orig','FixtureLifecycleOriginal(owner,@"'+name+'")')
    contents=contents.replace('animated','YES')
    lifecycle.append('static void Fixture_'+name+'(id owner) '+contents)
begin_marker='- (void)scrollViewWillBeginDragging:'
if begin_marker in ui_hooks:
    begin=body(ui_hooks,begin_marker)
    begin='static void FixtureDidBeginDragging(id scrollView) '+begin[begin.index('{'):].replace('%orig;','FixtureNativeEndCallbacks++;')
else: begin=''
if 'static BOOL MainScrollToTop(' in ui_hooks:
    begin+='\nstatic BOOL (*MainScrollToTopOriginal)(id,SEL,id);\n'+body(ui_hooks,'static BOOL MainScrollToTop(')
    did=body(ui_hooks,'- (void)scrollViewDidScrollToTop:')
    begin+='\nstatic void FixtureDidScrollToTop(id scrollView) '+did[did.index('{'):].replace('%orig;','FixtureNativeEndCallbacks++;')
(out/'ScrollInteractionBegin.h').write_text(begin+'\n')
(out/'ScrollAPIs.h').write_text('#define CS_SCROLL_APIS '+str(int('captureViewportForTabID:' in implementation))+'\n'+
    '#define CS_TABLE_PAN_APIS '+str(int('- (void)tablePan:' in implementation))+'\n'+
    '#define CS_VIEWPORT_GENERATION_APIS '+str(int('viewportGeneration' in implementation))+'\n')
if os.environ.get('WECHAT_SCROLL_SKIP_FINAL_RETURN')=='1':
    needle='[CSGroupListAdapter finishPresentationReturnForController:owner];'
    assert sum(method.count(needle) for method in lifecycle)==1
    lifecycle=[method.replace(needle,'((void)owner);') for method in lifecycle]
(out/'LifecycleCallbacks.h').write_text('\n\n'.join(lifecycle)+'\n')
(out/'NativeChangedNamesBody.h').write_text('\n\n'.join(change_bodies)+'\n')
paths=['Controllers/CSGroupNativeModel.m','Controllers/CSGroupNativeSessionCoordinator.m','Controllers/CSGroupListAdapter.m',
       'Controllers/CSGroupNativeBridge.m','Controllers/CSGroupProjection.m','Hooks/NativeSessionGroupHooks.xm',
       'Controllers/CSGroupNativeModel.h','Controllers/CSGroupNativeSessionCoordinator.h','Controllers/CSGroupListAdapter.h',
       'Controllers/CSGroupNativeBridge.h','Controllers/CSCloseFriendUnreadPanelAdapter.m',
       'Hooks/CloseFriendUnreadPanelHooks.xm','Hooks/SessionGroupHooks.xm']
(out/'production-source-hashes.json').write_text(json.dumps({p:hashlib.sha256((root/p).read_bytes()).hexdigest() for p in paths},indent=2)+'\n')
