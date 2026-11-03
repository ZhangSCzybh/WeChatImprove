from pathlib import Path
import hashlib
import json
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
    '- (void)refreshNativeSessionModel', '- (void)bindNativeCell:',
    '- (CSGroupProjection *)projectionForSections:',
    '+ (NSNumber *)closeFriendAlertBadgeCount', '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecision {',
    '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForPublication:',
    '+ (CSGroupTabBadgeDecision *)closeFriendTabBadgeDecisionForController:',
    '- (void)consumeRefreshRequest', '- (void)cancelScheduledRefresh', '- (void)requestRecovery',
    '- (void)requestRefresh', '- (void)scheduleRefresh {', '- (void)requestCoalescedRefresh',
    '- (void)beginNativeChange {', '- (void)beginNativeChangeOfKind:', '- (void)endNativeChange {', '- (void)endNativeChangeCoalesced:',
]
implementation=source[source.index('@implementation CSGroupListAdapter\n'):]
(out/'AdapterBodies.h').write_text('\n\n'.join(body(implementation,m) for m in markers))
start=source.index('@interface CSGroupListAdapter ()')
end=source.index('@end',start)
declarations=source[start:end].replace('@interface CSGroupListAdapter () <UIGestureRecognizerDelegate>', '@interface CSGroupListAdapter : NSObject')
declarations+='''
@property(nonatomic) NSUInteger fixtureRefreshes, fixtureRecoveries, fixtureBadgeRequests;
@property(nonatomic) BOOL fixtureScheduleOnly;
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
paths=['Controllers/CSGroupNativeModel.m','Controllers/CSGroupNativeSessionCoordinator.m','Controllers/CSGroupListAdapter.m',
       'Controllers/CSGroupNativeBridge.m','Controllers/CSGroupProjection.m','Hooks/NativeSessionGroupHooks.xm',
       'Controllers/CSGroupNativeModel.h','Controllers/CSGroupNativeSessionCoordinator.h','Controllers/CSGroupListAdapter.h',
       'Controllers/CSGroupNativeBridge.h','Controllers/CSCloseFriendUnreadPanelAdapter.m',
       'Hooks/CloseFriendUnreadPanelHooks.xm','Hooks/SessionGroupHooks.xm']
(out/'production-source-hashes.json').write_text(json.dumps({p:hashlib.sha256((root/p).read_bytes()).hexdigest() for p in paths},indent=2)+'\n')
