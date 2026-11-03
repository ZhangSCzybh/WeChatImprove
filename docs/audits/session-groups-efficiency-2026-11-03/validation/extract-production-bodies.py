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
(out/'CompatibilityAPIs.h').write_text('#define CS_COMPAT_NAMES '+str(int(compat_names))+'\n#define CS_COMPAT_SOURCE_HINTS '+str(int(compat_source_hints))+'\n#define CS_STRICT_STRUCTURE_HINTS '+str(int('BOOL strictStructure=' in (root/'Controllers/CSGroupNativeBridge.m').read_text()))+'\n')
actual_bodies=[body(implementation,m) for m in markers]
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
@property(nonatomic) BOOL fixtureScheduleOnly;
@property(nonatomic) BOOL fixtureRealRecovery,fixtureRealNotifications,fixtureRealCompatibilityRefresh,fixtureRealCompatSource;
@property(nonatomic,readonly,getter=isActive) BOOL active;
@property(nonatomic,copy) NSArray *fixtureCompatSections;
@property(nonatomic,copy) void (^fixtureOnCompatSource)(void);
- (void)productionCompatibilityRefresh;
- (void)reconcileDeletedSwipeRow;
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
(out/'NativeChangedNamesBody.h').write_text('\n\n'.join(change_bodies)+'\n')
paths=['Controllers/CSGroupNativeModel.m','Controllers/CSGroupNativeSessionCoordinator.m','Controllers/CSGroupListAdapter.m',
       'Controllers/CSGroupNativeBridge.m','Controllers/CSGroupProjection.m','Hooks/NativeSessionGroupHooks.xm',
       'Controllers/CSGroupNativeModel.h','Controllers/CSGroupNativeSessionCoordinator.h','Controllers/CSGroupListAdapter.h',
       'Controllers/CSGroupNativeBridge.h','Controllers/CSCloseFriendUnreadPanelAdapter.m',
       'Hooks/CloseFriendUnreadPanelHooks.xm','Hooks/SessionGroupHooks.xm']
(out/'production-source-hashes.json').write_text(json.dumps({p:hashlib.sha256((root/p).read_bytes()).hexdigest() for p in paths},indent=2)+'\n')
