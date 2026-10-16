#import "CSMessageNavigation.h"
#import "CSMessageMergeAdapter.h"
#import "CSChatNativeBridge.h"
#import "CSRevokeReference.h"
#import "CSChatDiagnostics.h"
#import "CSMessageMergePolicy.h"
#import <objc/runtime.h>
#import <objc/message.h>
#include <math.h>
#import <QuartzCore/CADisplayLink.h>

@interface CSMessageNavigationRequest : NSObject
@property(nonatomic, copy) NSString *account;
@property(nonatomic, copy) NSString *session;
@property(nonatomic, strong) id message;
@property(nonatomic) long long serverID;
@property(nonatomic) BOOL correcting;
@property(nonatomic) BOOL positioned;
@property(nonatomic) BOOL checkQueued;
@property(nonatomic) NSTimeInterval created;
@property(nonatomic, strong) NSTimer *deadline;
@property(nonatomic, weak) id owner;
@property(nonatomic, strong) CADisplayLink *presentationLink;
@property(nonatomic) NSUInteger presentationFrames;
@property(nonatomic) NSUInteger presentationAttempts;
@property(nonatomic) BOOL presentationReady;
@property(nonatomic, weak) id presentationCell;
@property(nonatomic, weak) id presentationModel;
@property(nonatomic) CGPoint presentationOffset;
@property(nonatomic) CGRect presentationRect;
- (void)presentationTick;
- (void)cancelPresentation;

@end
static char CSNavigationKey;
@interface CSNavigationDisplayTarget : NSObject
@property(nonatomic, weak) CSMessageNavigationRequest *request;
- (void)tick:(CADisplayLink *)link;
@end
@implementation CSNavigationDisplayTarget
- (void)tick:(CADisplayLink *)link { [self.request presentationTick]; }
@end
@implementation CSMessageNavigationRequest
- (void)cancelPresentation {
    [self.presentationLink invalidate];self.presentationLink=nil;self.presentationReady=NO;
}
- (void)presentationTick {
    id owner=self.owner;
    if (!owner || objc_getAssociatedObject(owner,&CSNavigationKey)!=self) { [self cancelPresentation];return; }
    // First callback precedes that frame's commit; the next boundary lets it be presented.
    // This link exists only for this tap, for two callbacks, never while the chat is idle.
    if (++self.presentationFrames<2) return;
    [self.presentationLink invalidate];self.presentationLink=nil;self.presentationReady=YES;
    CSMessageNavigationCheck(owner);
}
- (void)dealloc { [_presentationLink invalidate];[_deadline invalidate]; }
@end
static BOOL CSNavigationReloading(UITableView *table) {
    SEL selector=NSSelectorFromString(@"isReloadingData");
    NSMethodSignature *signature=[table methodSignatureForSelector:selector];
    return signature.numberOfArguments==2 && (signature.methodReturnType[0]=='B' || signature.methodReturnType[0]=='c') &&
        ((BOOL (*)(id,SEL))objc_msgSend)(table,selector);
}


static BOOL CSNavigationMatches(id controller, CSMessageNavigationRequest *request) {
    return request && [request.account isEqual:CSMessageCurrentAccount()] &&
        [request.session isEqual:CSMessageNativeObject(controller,@"getCurrentChatName")];
}
static void CSNavigationFailure(id controller, NSString *message) {
    if (![controller isKindOfClass:UIViewController.class] || ![controller viewIfLoaded].window || [controller presentedViewController]) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法定位原消息" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
    [controller presentViewController:alert animated:YES completion:nil];
}
static long long CSNavigationServerID(id wrap) {
    SEL sel = NSSelectorFromString(@"m_n64MesSvrID");
    NSMethodSignature *sig = [wrap methodSignatureForSelector:sel];
    return sig.numberOfArguments == 2 && strcmp(sig.methodReturnType,@encode(long long)) == 0 ?
        ((long long (*)(id,SEL))objc_msgSend)(wrap,sel) : 0;
}
static NSIndexPath *CSNavigationPath(id controller, long long serverID) {
    NSArray *nodes = CSMessageNativeObject(controller,@"GetMessageNodeDataArray");
    if (![nodes isKindOfClass:NSArray.class]) return nil;
    NSIndexPath *found = nil;
    // Event-only O(n) lookup. Never run in a scrolling callback without a pending navigation.
    for (NSUInteger i=0;i<nodes.count;i++) {
        id wrap = CSMessageNativeObject(nodes[i],@"messageWrap");
        if (CSNavigationServerID(wrap) == serverID) {
            if (found) return nil; // Ambiguous identity must not select an arbitrary message.
            found = [NSIndexPath indexPathForRow:0 inSection:i];
        }
    }
    return found;
}
static UIEdgeInsets CSNavigationInsets(id controller, UITableView *table) {
    UIEdgeInsets insets = table.adjustedContentInset;
    UIView *tool = CSMessageNativeObject(controller,@"getInputToolView");
    if ([tool isKindOfClass:UIView.class] && tool.window == table.window && !tool.hidden) {
        CGRect obstruction = [table convertRect:tool.bounds fromView:tool];
        CGRect intersection = CGRectIntersection(table.bounds,obstruction);
        if (!CGRectIsNull(intersection) && CGRectGetMaxY(intersection) >= CGRectGetMaxY(table.bounds)-1)
            insets.bottom = MAX(insets.bottom,CGRectGetMaxY(table.bounds)-CGRectGetMinY(intersection));
    }
    return insets;
}
static BOOL CSNavigationScroll(id controller,id message,CGFloat margin,BOOL highlightTarget) {
    SEL sel = NSSelectorFromString(@"scrollToMessage:highlight:marginTop:animated:");
    NSMethodSignature *sig = [controller methodSignatureForSelector:sel];
    if (sig.numberOfArguments != 6 || sig.methodReturnType[0] != 'v' ||
        [sig getArgumentTypeAtIndex:2][0] != '@' || strcmp([sig getArgumentTypeAtIndex:4],@encode(double)) != 0) return NO;
    const char *highlight = [sig getArgumentTypeAtIndex:3], *animated = [sig getArgumentTypeAtIndex:5];
    if ((*highlight != 'B' && *highlight != 'c') || (*animated != 'B' && *animated != 'c')) return NO;
    // Native history loading stays intact; highlighting is deferred until layout settles.
    ((void (*)(id,SEL,id,BOOL,double,BOOL))objc_msgSend)(controller,sel,message,highlightTarget,margin,NO);
    return YES;
}
static BOOL CSNavigationHighlight(id controller,id message,CGFloat margin) {
    // BaseMsgContentViewController owns the native locate animation and its cleanup.
    // Pass the visible message wrap, already verified against the pending request.
    SEL selector=NSSelectorFromString(@"highlightMsg:");
    NSMethodSignature *signature=[controller methodSignatureForSelector:selector];
    if (signature.numberOfArguments==3 && signature.methodReturnType[0]=='v' &&
        [signature getArgumentTypeAtIndex:2][0]=='@') {
        ((void (*)(id,SEL,id))objc_msgSend)(controller,selector,message);
        return YES;
    }
    // Older variants can expose only the existing native scroll/highlight entry point.
    return CSNavigationScroll(controller,message,margin,YES);
}
static BOOL CSNavigateToRevoke(id controller,id manager,NSString *session,long long serverID,unsigned int expectedLocalID) {
    if (!NSThread.isMainThread || serverID <= 0 || !session.length) return NO;
    NSString *account = CSMessageCurrentAccount();
    if (!account.length || ![session isEqual:CSMessageNativeObject(controller,@"getCurrentChatName")]) return NO;
    CSMessageNavigationRequest *existing = objc_getAssociatedObject(controller,&CSNavigationKey);
    if (CSNavigationMatches(controller,existing) && existing.serverID==serverID &&
        NSDate.timeIntervalSinceReferenceDate-existing.created<.1) return YES;
    if (existing) CSMessageNavigationCancel(controller);
    CSChatRecordEvent(@"revoke",@"query-start");
    SEL get = NSSelectorFromString(@"GetMsg:n64SvrID:");
    NSMethodSignature *sig = [manager methodSignatureForSelector:get];
    id message = nil;
    if (sig.numberOfArguments == 4 && sig.methodReturnType[0] == '@' && [sig getArgumentTypeAtIndex:2][0] == '@' &&
        strcmp([sig getArgumentTypeAtIndex:3],@encode(long long)) == 0)
        message = ((id (*)(id,SEL,id,long long))objc_msgSend)(manager,get,session,serverID);
    NSString *from = CSMessageNativeObject(message,@"m_nsFromUsr"), *to = CSMessageNativeObject(message,@"m_nsToUsr");
    unsigned int actualLocalID=0;
    SEL localSelector=NSSelectorFromString(@"m_uiMesLocalID");
    Method localMethod=class_getInstanceMethod(object_getClass(message),localSelector);
    if (localMethod && method_getNumberOfArguments(localMethod)==2 && method_getTypeEncoding(localMethod)[0]=='I')
        actualLocalID=((unsigned int (*)(id,SEL))objc_msgSend)(message,localSelector);
    if (!message || (expectedLocalID && actualLocalID!=expectedLocalID) || CSNavigationServerID(message) != serverID || (![from isEqual:session] && ![to isEqual:session])) {
        CSChatRecordEvent(@"revoke",@"query-identity-rejected");
        CSNavigationFailure(controller,@"原消息可能已删除，或尚未保存在当前账号中。"); return YES;
    }
    UITableView *table = CSMessageNativeTable(controller);
    if (!table) { CSNavigationFailure(controller,@"当前微信页面不支持原文定位。"); return YES; }
    CSMessageNavigationRequest *request = [CSMessageNavigationRequest new];
    request.owner=controller;
    request.created=NSDate.timeIntervalSinceReferenceDate;
    request.account = account; request.session = session; request.serverID = serverID; request.message = message;
    objc_setAssociatedObject(controller,&CSNavigationKey,request,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    __weak id timeoutOwner=controller;
    __weak CSMessageNavigationRequest *timeoutRequest=request;
    request.deadline=[NSTimer timerWithTimeInterval:8 repeats:NO block:^(NSTimer *timer) {
        id owner=timeoutOwner;
        CSMessageNavigationRequest *pending=timeoutRequest;
        if (owner && pending && objc_getAssociatedObject(owner,&CSNavigationKey)==pending) {
            CSChatRecordEvent(@"revoke",@"timeout");CSMessageNavigationFailed(owner);
        }
    }];
    [NSRunLoop.mainRunLoop addTimer:request.deadline forMode:NSRunLoopCommonModes];
    NSIndexPath *path = CSNavigationPath(controller,serverID);
    CGFloat height = 0;
    if (path && path.section < [table numberOfSections] && [table numberOfRowsInSection:path.section] > 0)
        height = [table rectForSection:path.section].size.height;
    UIEdgeInsets insets = CSNavigationInsets(controller,table);
    CGFloat margin = CSMessageNavigationMargin(table.bounds.size.height-insets.top-insets.bottom,height);
    if (!CSNavigationScroll(controller,message,margin,NO)) {
        CSMessageNavigationCancel(controller); CSNavigationFailure(controller,@"当前微信版本缺少兼容的原文定位接口。"); return YES;
    }
    __weak id weakController = controller;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (objc_getAssociatedObject(weakController,&CSNavigationKey) == request) CSMessageNavigationCheck(weakController);
    });
    return YES;
}
BOOL CSMessageNavigateToRevoke(id controller,id manager,NSString *session,long long serverID) {
    return CSNavigateToRevoke(controller,manager,session,serverID,0);
}
void CSMessageNavigationCheck(id controller) {
    if (!NSThread.isMainThread) return;
    CSMessageNavigationRequest *request = objc_getAssociatedObject(controller,&CSNavigationKey);
    if (!request || request.correcting || request.presentationLink) return;
    UITableView *table = CSMessageNativeTable(controller);
    if (!CSNavigationMatches(controller,request) || !table.window || table.dragging) { CSMessageNavigationCancel(controller); return; }
    if (table.hasUncommittedUpdates || table.decelerating || CSNavigationReloading(table)) return;
    NSIndexPath *path = CSNavigationPath(controller,request.serverID);
    if (!path || path.section >= [table numberOfSections] || [table numberOfRowsInSection:path.section] == 0) return;
    request.correcting = YES;
    // Settle queued merge measurements while navigation still owns the scroll position.
    CSMessageMergeFlush(controller);
    if (!CSMessageMergeLayoutSettled(controller)) { request.correcting=NO;return; }
    [table layoutIfNeeded];
    if (objc_getAssociatedObject(controller,&CSNavigationKey) != request) return;
    if (!CSNavigationMatches(controller,request)) { CSMessageNavigationCancel(controller); return; }
    path = CSNavigationPath(controller,request.serverID);
    if (!path || path.section >= [table numberOfSections] || [table numberOfRowsInSection:path.section] == 0) {
        CSMessageNavigationFailed(controller); return;
    }
    CGRect rect = [table rectForSection:path.section];
    UIEdgeInsets insets = CSNavigationInsets(controller,table);
    CGFloat y = CSMessageNavigationOffset(rect.origin.y,rect.size.height,table.bounds.size.height,
        table.contentSize.height,insets.top,insets.bottom);
    if (!request.positioned && isfinite(y) && fabs(y-table.contentOffset.y) > 1)
        [table setContentOffset:CGPointMake(table.contentOffset.x,y) animated:NO];
    request.positioned=YES;
    [table layoutIfNeeded];
    if (objc_getAssociatedObject(controller,&CSNavigationKey)!=request) return;
    if (table.hasUncommittedUpdates || CSNavigationReloading(table) || !CSMessageMergeLayoutSettled(controller)) { request.correcting=NO;return; }
    if (!CSNavigationMatches(controller,request) || table.dragging) { CSMessageNavigationCancel(controller);return; }
    NSIndexPath *settledPath=CSNavigationPath(controller,request.serverID);
    if (!settledPath || ![settledPath isEqual:path]) { CSMessageNavigationFailed(controller);return; }
    // Select an actual visible row belonging to this logical message, including split text.
    NSIndexPath *visible=nil;
    for (NSIndexPath *candidate in table.indexPathsForVisibleRows)
        if (candidate.section==path.section && (!visible || candidate.row<visible.row)) visible=candidate;
    if (!visible) { request.correcting=NO;return; }
    id visibleCell=CSMessageNativeObject([table cellForRowAtIndexPath:visible],@"cellView");
    id visibleModel=CSMessageNativeObject(visibleCell,@"viewModel");
    id visibleWrap=CSMessageNativeObject(visibleModel,@"messageWrap") ?:
        CSMessageNativeObject(CSMessageNativeObject(visibleModel,@"parentModel"),@"messageWrap");
    if (CSNavigationServerID(visibleWrap)!=request.serverID) { request.correcting=NO;return; }
    CGRect visibleRect=[table rectForRowAtIndexPath:visible];
    if (!request.presentationReady || request.presentationCell!=visibleCell || request.presentationModel!=visibleModel ||
        !CGPointEqualToPoint(request.presentationOffset,table.contentOffset) || !CGRectEqualToRect(request.presentationRect,visibleRect)) {
        request.correcting=NO;request.presentationReady=NO;
        if (++request.presentationAttempts>4) { CSMessageNavigationFailed(controller);return; }
        request.presentationCell=visibleCell;request.presentationModel=visibleModel;
        request.presentationOffset=table.contentOffset;request.presentationRect=visibleRect;
        request.presentationFrames=0;
        CSNavigationDisplayTarget *target=[CSNavigationDisplayTarget new];target.request=request;
        request.presentationLink=[CADisplayLink displayLinkWithTarget:target selector:@selector(tick:)];
        [request.presentationLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
        CSChatRecordEvent(@"revoke",@"waiting-native-presentation");
        return;
    }
    CGFloat margin=CSMessageNavigationMargin(table.bounds.size.height-insets.top-insets.bottom,rect.size.height);
    if (!CSNavigationHighlight(controller,visibleWrap,margin)) {
        CSMessageNavigationFailed(controller);return;
    }
    // Native highlighting may synchronously call back into this page. Do not clear a new request.
    if (objc_getAssociatedObject(controller,&CSNavigationKey)!=request) return;
    CSChatRecordEvent(@"revoke",@"native-highlight-requested");
    [request.deadline invalidate];
    objc_setAssociatedObject(controller,&CSNavigationKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
void CSMessageNavigationFinishedLoading(id controller) {
    CSMessageNavigationRequest *request = objc_getAssociatedObject(controller,&CSNavigationKey);
    if (request.correcting) return;
    CSMessageNavigationCheck(controller);
    // A generic loading callback is not proof that this target has finished loading.
    CSMessageNavigationLayoutReady(controller);
}
void CSMessageNavigationFailed(id controller) {
    if (!CSMessageNavigationIsActive(controller)) return;
    CSMessageNavigationCancel(controller);
    CSNavigationFailure(controller,@"未能在当前聊天记录中加载原消息，请稍后重试。");
}
void CSMessageNavigationCancel(id controller) {
    if (!controller) return;
    CSMessageNavigationRequest *request=objc_getAssociatedObject(controller,&CSNavigationKey);
    [request.deadline invalidate];[request cancelPresentation];
    objc_setAssociatedObject(controller,&CSNavigationKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
void CSMessageNavigationContentChanged(id controller) {
    CSMessageNavigationRequest *request=objc_getAssociatedObject(controller,&CSNavigationKey);
    [request cancelPresentation];
}
void CSMessageNavigationLayoutReady(id controller) {
    CSMessageNavigationRequest *request=objc_getAssociatedObject(controller,&CSNavigationKey);
    if (!request || request.correcting || request.checkQueued || request.presentationLink) return;
    request.checkQueued=YES;
    __weak id weakOwner=controller;
    dispatch_async(dispatch_get_main_queue(),^{
        request.checkQueued=NO;
        if (objc_getAssociatedObject(weakOwner,&CSNavigationKey)==request) CSMessageNavigationCheck(weakOwner);
    });
}
BOOL CSMessageNavigationIsActive(id controller) { return objc_getAssociatedObject(controller,&CSNavigationKey) != nil; }

@interface CSRevokePageBinding : NSObject
@property(nonatomic,weak) id owner;
@property(nonatomic,weak) id model;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *session;
@end
@implementation CSRevokePageBinding @end
static char CSRevokePageKey;
void CSMessageNavigationBind(id controller, UITableView *table, NSIndexPath *path, id cell) {
    if (!NSThread.isMainThread || table!=CSMessageNativeTable(controller)) return;
    id view=CSMessageNativeObject(cell,@"cellView"),model=CSMessageNativeObject(view,@"viewModel");
    if (!view||!model) return;
    CSRevokePageBinding *binding=[CSRevokePageBinding new];binding.owner=controller;binding.model=model;
    binding.account=CSMessageCurrentAccount();binding.session=CSMessageNativeObject(controller,@"getCurrentChatName");
    objc_setAssociatedObject(view,&CSRevokePageKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
BOOL CSMessageHandleRevokeLink(id source,id manager,id clickedLink,id explicitWrap) {
    if (!NSThread.isMainThread) return NO;
    id model=CSMessageNativeObject(source,@"viewModel");
    id wrap=explicitWrap ?: CSMessageNativeObject(model,@"messageWrap");
    NSString *content=CSMessageNativeObject(wrap,@"m_nsContent"),*pattern=CSMessageNativeObject(wrap,@"m_nsPattern");
    CSChatRecordEvent(@"revoke",@"link-entry");
    CSRevokeReference *reference=CSRevokeResolveReference(clickedLink,content,pattern);
    if (!reference && !CSRevokeOwnsLink(clickedLink) &&
        (clickedLink || !CSRevokeHasOwnedReference(content,pattern))) return NO;
    CSChatRecordEvent(@"revoke",@"link-received");
    CSRevokePageBinding *binding=objc_getAssociatedObject(source,&CSRevokePageKey);
    id owner=nil;
    if (binding.model==model && [binding.account isEqual:CSMessageCurrentAccount()]) owner=binding.owner;
    if (!owner) owner=CSMessageNativeObject(source,@"getMsgContentViewController") ?: CSMessageNativeObject(source,@"getCurrViewController");
    if (!owner) owner=CSMessageNativeObject(CSMessageNativeObject(model,@"delegate"),@"getViewController");
    if (!owner) owner=CSMessageNativeObject(source,@"getViewController");
    if (!CSMessageNativeTable(owner)) {
        id responder=source;
        for (NSUInteger i=0;responder && i<32;i++) {
            if (CSMessageNativeTable(responder)) { owner=responder;break; }
            if (!owner && [responder isKindOfClass:UIViewController.class]) owner=responder;
            responder=CSMessageNativeObject(responder,@"nextResponder");
        }
    }
    NSString *session=CSMessageNativeObject(owner,@"getCurrentChatName");
    // The logic controller callback may have only a reconstructed wrap. Resolve it within
    // this page's actual nodes rather than demanding the original Cell association.
    if (!model && explicitWrap) {
        NSArray *nodes=CSMessageNativeObject(owner,@"GetMessageNodeDataArray");
        NSString *identity=CSMessageNativeIdentity(explicitWrap);
        if ([nodes isKindOfClass:NSArray.class]) for (id node in nodes) {
            id candidate=CSMessageNativeObject(node,@"messageWrap");
            if (candidate==explicitWrap || (identity.length && [identity isEqual:CSMessageNativeIdentity(candidate)])) { model=node;break; }
        }
    }
    NSString *modelChat=CSMessageModelChatName(model);
    if (!modelChat.length && model && explicitWrap && CSMessageNativeObject(model,@"messageWrap")==explicitWrap) modelChat=session;
    if (!modelChat.length && binding.owner==owner && binding.model==model) modelChat=binding.session;
    BOOL matches=CSRevokeSessionMatches(CSMessageCurrentAccount(),session,modelChat,
        CSMessageNativeObject(wrap,@"m_nsFromUsr"),CSMessageNativeObject(wrap,@"m_nsToUsr"));
    if (!reference || !matches) {
        CSChatRecordEvent(@"revoke",reference ? @"session-rejected" : @"invalid-reference");
        CSNavigationFailure(owner,@"无法确认这条提示所属的原消息，请重新打开聊天后重试。");return YES;
    }
    // Every click resolves a fresh target through the current account's manager.
    if (!CSNavigateToRevoke(owner,manager,session,reference.serverID,reference.localID)) {
        CSChatRecordEvent(@"revoke",@"page-unavailable");
        CSNavigationFailure(owner,@"当前页面暂时无法定位原消息，请稍后重试。");
    }
    return YES;
}
