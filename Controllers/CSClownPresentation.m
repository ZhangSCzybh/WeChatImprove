#import "CSClownPresentation.h"
#import "CSClownPreferences.h"
#import "CSClownSession.h"
#import "CSClownLayout.h"
#import "CSClownTextRules.h"
#import "CSChatNativeBridge.h"
#import "CSMessageActionContext.h"
#import "CSMessageNativeActionAdapter.h"
#import <PhotosUI/PhotosUI.h>
#import <objc/runtime.h>
#import <math.h>
#include <string.h>
#include <stdatomic.h>

// Native wrappers, models, rich-text content and image caches remain untouched.
// Only view geometry and an independent, noninteractive overlay are projected.
static char CSClownPageKey, CSClownModelKey, CSClownCellKey, CSClownTimeKey, CSClownAmountKey;
static char CSClownSubmissionKey, CSClownSentWrapKey;
static NSString *const CSClownSendScope = @"CSClownInputSendScope";
static _Atomic(NSUInteger) CSClownAccountEpoch = 1;
static NSHashTable *CSClownPages;
static NSRange CSClownAmountRange(NSString *text);
static UILabel *CSClownAmountLabel(id cell);

@interface CSClownPage : NSObject
@property(nonatomic, weak) UIViewController *owner;
@property(nonatomic, strong) CSClownSession *session;
@property(nonatomic, strong) NSHashTable *cells;
@property(nonatomic, strong) UIViewController *editor;
@property(nonatomic, strong) id editorDelegate;
@property(nonatomic) NSUInteger editSerial;
@property(nonatomic) BOOL needsNativeReload;
@property(nonatomic, strong) NSMutableArray *pendingPhotos;
@property(nonatomic) NSUInteger accountEpoch;
@end
@implementation CSClownPage @end

@interface CSClownModelBinding : NSObject
@property(nonatomic, weak) CSClownPage *page;
@property(nonatomic, weak) id root;
@property(nonatomic) NSUInteger row;
@end
@implementation CSClownModelBinding @end

// This read-only source is used only to capture an offscreen model's identity.
// It is never installed in a native cell, data source or message manager.
@interface CSClownModelSource : NSObject
@property(nonatomic, strong) id viewModel;
- (id)getCurrentMessageWrap;
@end
@implementation CSClownModelSource
- (id)getCurrentMessageWrap { return CSMessageActionObjectGetter(self.viewModel, NSSelectorFromString(@"messageWrap")); }
@end

@interface CSClownQuoteSubmission : NSObject
@property(nonatomic, weak) CSClownPage *page;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic, copy) NSString *body;
@property(nonatomic, copy) NSString *quote;
@property(nonatomic, weak) id formedWrap;
@property(nonatomic) BOOL claimed;
@end
@implementation CSClownQuoteSubmission @end

@interface CSClownSentSource : NSObject
@property(nonatomic, strong) id wrap;
- (id)getCurrentMessageWrap;
@end
@implementation CSClownSentSource
- (id)getCurrentMessageWrap { return self.wrap; }
@end

@interface CSClownEditRequest : NSObject
@property(nonatomic, weak) CSClownPage *page;
@property(nonatomic, weak) id cell;
@property(nonatomic, strong) CSMessageActionContext *context;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) BOOL image;
@property(nonatomic) BOOL amount;
@property(nonatomic) NSUInteger editSerial;
@end
@implementation CSClownEditRequest @end

@interface CSClownFrame : NSObject
@property(nonatomic, weak) UIView *view;
@property(nonatomic) CGRect nativeFrame;
@property(nonatomic) CGRect projectedFrame;
@end
@implementation CSClownFrame @end

@interface CSClownCellState : NSObject
@property(nonatomic, strong) UIView *overlay;
@property(nonatomic, strong) UILabel *quoteView;
@property(nonatomic, weak) UIView *source;
@property(nonatomic, strong) CALayer *nativeMask;
@property(nonatomic, strong) CALayer *concealMask;
@property(nonatomic) BOOL accessibilityHidden;
@property(nonatomic, strong) NSMutableArray<CSClownFrame *> *frames;
@property(nonatomic) BOOL active;
@end
@implementation CSClownCellState @end

@interface CSClownObservation : NSObject
@property(nonatomic, strong) id token;
@end
@implementation CSClownObservation
- (void)dealloc { if (_token) [NSNotificationCenter.defaultCenter removeObserver:_token]; }
@end

static id CSClownObject(id object, NSString *name) { return CSMessageActionObjectGetter(object, NSSelectorFromString(name)); }
static NSString *CSClownString(id value) { return [value isKindOfClass:NSString.class] ? value : @""; }
static UIView *CSClownView(id value) { return [value isKindOfClass:UIView.class] ? value : nil; }
static id CSClownIvar(id object, const char *name) {
    Ivar ivar = object ? class_getInstanceVariable(object_getClass(object), name) : NULL;
    if (!ivar || ivar_getTypeEncoding(ivar)[0] != '@') return nil;
    return object_getIvar(object, ivar);
}
static CGSize CSClownSize(id object, NSString *name) {
    SEL selector = NSSelectorFromString(name);
    Method method = object ? class_getInstanceMethod(object_getClass(object), selector) : NULL;
    char type[128] = {0}; if (method) method_getReturnType(method, type, sizeof(type));
    if (!method || method_getNumberOfArguments(method) != 2 || strcmp(type, @encode(CGSize))) return CGSizeZero;
    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = object; invocation.selector = selector;
    @try { [invocation invoke]; CGSize size; [invocation getReturnValue:&size]; return size; }
    @catch (__unused NSException *exception) { return CGSizeZero; }
}
static double CSClownTimestamp(id model) {
    SEL selector = NSSelectorFromString(@"showingTime");
    Method method = model ? class_getInstanceMethod(object_getClass(model), selector) : NULL;
    char type[16] = {0}; if (method) method_getReturnType(method, type, sizeof(type));
    if (!method || method_getNumberOfArguments(method) != 2 || strcmp(type, @encode(double))) return NAN;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)]];
    invocation.target = model; invocation.selector = selector;
    @try { [invocation invoke]; double time; [invocation getReturnValue:&time]; return time; }
    @catch (__unused NSException *exception) { return NAN; }
}
static NSString *CSClownChat(id controller) {
    return CSClownString(CSClownObject(controller, @"getCurrentChatName") ?: CSClownObject(CSClownObject(controller, @"GetContact"), @"m_nsUsrName"));
}
static BOOL CSClownPageIsCurrent(CSClownPage *page) {
    return NSThread.isMainThread && page.owner && page.session.active &&
        page.accountEpoch == CSClownAccountEpoch &&
        [page.session.accountID isEqual:CSMessageCurrentAccount()] &&
        [page.session.conversationID isEqual:CSClownChat(page.owner)];
}
static NSArray *CSClownNodes(id controller) {
    id nodes = CSClownObject(controller, @"GetMessageNodeDataArray");
    return [nodes isKindOfClass:NSArray.class] ? nodes : @[];
}
static id CSClownRoot(id model) {
    NSMutableSet *seen = [NSMutableSet set];
    for (NSUInteger depth = 0; model && depth < 16; depth++) {
        NSValue *identity = [NSValue valueWithNonretainedObject:model];
        if ([seen containsObject:identity]) return nil;
        [seen addObject:identity];
        id parent = CSClownObject(model, @"parentModel");
        if (!parent) return model;
        model = parent;
    }
    return nil;
}
static CSMessageActionContext *CSClownContext(CSClownPage *page, id model) {
    if (!CSClownPageIsCurrent(page)) return nil;
    CSClownModelSource *source = [CSClownModelSource new]; source.viewModel = CSClownRoot(model);
    return [CSMessageActionContext contextWithCell:source controller:page.owner
        accountID:page.session.accountID accountEpoch:CSClownAccountEpoch
        conversationID:page.session.conversationID bindingGeneration:page.session.epoch];
}
static id CSClownRowModel(id root, NSUInteger row) {
    for (NSString *type in @[@"Q", @"q"]) {
        if (CSMessageNativeSupports(root, @"cellDataForRow:", @"@", @[type])) {
            @try { return CSMessageNativeInvoke(root, @"cellDataForRow:", @[@(row)]) ?: (row ? nil : root); }
            @catch (__unused NSException *exception) { return nil; }
        }
    }
    id children = CSClownObject(root, @"subViewModels");
    if ([children isKindOfClass:NSArray.class] && row < [children count]) return children[row];
    return row ? nil : root;
}
static BOOL CSClownIsLastRow(id model, NSUInteger row) {
    id root = CSClownRoot(model);
    for (NSString *type in @[@"q", @"Q", @"i", @"I"]) {
        if (CSMessageNativeSupports(root, @"numberOfRowsInSection", type, @[])) {
            NSUInteger count = [CSMessageNativeInvoke(root, @"numberOfRowsInSection", @[]) unsignedIntegerValue];
            return count > 0 && row == count-1;
        }
    }
    id children = CSClownObject(root, @"subViewModels");
    return [children isKindOfClass:NSArray.class] && [children count] ? row == [children count]-1 : row == 0;
}
static void CSClownAssociateModel(CSClownPage *page, id root, id model, NSUInteger row) {
    if (!model) return;
    CSClownModelBinding *binding = [CSClownModelBinding new]; binding.page = page; binding.root = root; binding.row = row;
    objc_setAssociatedObject(model, &CSClownModelKey, binding, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

void CSClownRestoreCell(id cell) {
    if (!NSThread.isMainThread) return;
    CSClownCellState *state = objc_getAssociatedObject(cell, &CSClownCellKey);
    if (!state.active) return;
    state.overlay.hidden = YES;
    state.quoteView.hidden = YES;
    [CATransaction begin]; [CATransaction setDisableActions:YES];
    if (state.source.layer.mask == state.concealMask) state.source.layer.mask = state.nativeMask;
    [CATransaction commit];
    state.source.accessibilityElementsHidden = state.accessibilityHidden;
    for (CSClownFrame *frame in state.frames.reverseObjectEnumerator) {
        if (CGRectEqualToRect(frame.view.frame, frame.projectedFrame)) frame.view.frame = frame.nativeFrame;
    }
    [state.frames removeAllObjects]; state.source = nil; state.nativeMask = nil; state.concealMask = nil; state.active = NO;
}
void CSClownReuseCell(id cell) {
    CSClownRestoreCell(cell);
    CSClownCellState *state = objc_getAssociatedObject(cell, &CSClownCellKey);
    [state.overlay removeFromSuperview];
    [state.quoteView removeFromSuperview];
    objc_setAssociatedObject(cell, &CSClownCellKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void CSClownRefresh(CSClownPage *page) {
    for (UIView *cell in page.cells) CSClownRestoreCell(cell);
    UITableView *table = CSMessageNativeTable(page.owner);
    if (!table) return;
    CGPoint offset = table.contentOffset;
    [UIView performWithoutAnimation:^{
        [table reloadData]; [table layoutIfNeeded];
        CGFloat minimum = -table.adjustedContentInset.top;
        CGFloat maximum = MAX(minimum, table.contentSize.height - table.bounds.size.height + table.adjustedContentInset.bottom);
        CGPoint restored = offset; restored.y = MIN(maximum, MAX(minimum, restored.y)); [table setContentOffset:restored animated:NO];
    }];
}
static void CSClownCloseEditor(CSClownPage *page) {
    UIViewController *editor = page.editor;
    id delegate = page.editorDelegate;
    page.editSerial++;
    // Keep a picker delegate alive through dismissal even after its session expires.
    if (editor && page.owner.presentedViewController == editor) {
        [editor dismissViewControllerAnimated:NO completion:^{ (void)delegate; }];
    }
    page.editorDelegate = nil; page.editor = nil;
}
static void CSClownInvalidate(CSClownPage *page) {
    if (!page.session.active) return;
    [page.session invalidate];
    page.needsNativeReload = YES;
    [page.pendingPhotos removeAllObjects];
    for (UIView *cell in page.cells) { CSClownReuseCell(cell); CSClownBindTimeCell(cell); [cell setNeedsLayout]; }
    CSClownCloseEditor(page);
}
static void CSClownInitialize(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSClownPages = [NSHashTable weakObjectsHashTable];
        [NSNotificationCenter.defaultCenter addObserverForName:CSClownSettingsDidChangeNotification
            object:CSClownPreferences.sharedPreferences queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) {
                CSClownSettings *settings = CSClownPreferences.sharedPreferences.snapshot;
                for (CSClownPage *page in CSClownPages) {
                    if (!page.session.active) continue;
                    if (!settings.enabled) { CSClownInvalidate(page); CSClownRefresh(page); continue; }
                    if (!settings.textEnabled) [page.session clearText];
                    if (!settings.imageEnabled) [page.session clearImages];
                    if (!settings.timeEnabled) [page.session clearTimes];
                    if (!settings.amountEnabled) [page.session clearAmounts];
                    if (![settings warmsConversation:page.session.conversationID account:page.session.accountID]) [page.session clearWarmTexts];
                    if (!settings.fakeQuoteEnabled) [page.session clearFakeQuotes];
                    CSClownCloseEditor(page);
                    CSClownRefresh(page);
                }
            }];
    });
}
static CSClownPage *CSClownPageForController(id controller, BOOL create) {
    if (!NSThread.isMainThread || ![controller isKindOfClass:UIViewController.class]) return nil;
    CSClownInitialize();
    CSClownPage *page = objc_getAssociatedObject(controller, &CSClownPageKey);
    BOOL needsReload = page.needsNativeReload;
    if (page && !CSClownPageIsCurrent(page)) {
        CSClownInvalidate(page); needsReload = needsReload || page.needsNativeReload; page = nil;
    }
    if (!page && create && CSClownPreferences.sharedPreferences.snapshot.enabled) {
        CSClownSession *session = [[CSClownSession alloc] initWithAccountID:CSMessageCurrentAccount() conversationID:CSClownChat(controller)];
        if (!session) return nil;
        page = [CSClownPage new]; page.owner = controller; page.session = session; page.cells = [NSHashTable weakObjectsHashTable];
        page.needsNativeReload = needsReload;
        page.pendingPhotos = [NSMutableArray array];
        page.accountEpoch = CSClownAccountEpoch;
        objc_setAssociatedObject(controller, &CSClownPageKey, page, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [CSClownPages addObject:page];
    }
    return page;
}
static CSClownPage *CSClownPageForCell(id cell, BOOL create) {
    id owner = [[CSMessageNativeEnvironment new] controllerForCell:cell];
    return CSClownPageForController(owner, create);
}
static void CSClownInputAlert(id controller, NSString *text) {
    if (![controller isKindOfClass:UIViewController.class] || [controller presentedViewController]) return;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"假的引用好玩吗" message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
    [controller presentViewController:alert animated:YES completion:nil];
}
void CSClownSubmitInput(id controller, id text, void (^native)(id)) {
    if (!NSThread.isMainThread || !CSClownPreferences.sharedPreferences.snapshot.fakeQuoteEnabled ||
        ![text isKindOfClass:NSString.class] || ![text hasPrefix:@"#假引用"]) { native(text); return; }
    NSString *error = nil; CSClownFakeQuoteInput *input = [CSClownFakeQuoteInput parse:text error:&error];
    if (!input) { CSClownInputAlert(controller, error); return; }
    id presenter = CSClownObject(controller, @"inputPresenter");
    if (CSClownObject(controller, @"getReplyingMessage") || CSClownObject(presenter, @"replyingMessage") ||
        CSClownObject(presenter, @"replyingReferPartialInfo")) {
        CSClownInputAlert(controller, @"请先取消输入框中的真实引用，再发送假引用。草稿已保留。"); return;
    }
    // WeChat's mention tokens end with a four-per-em space. Preserve the draft
    // rather than stripping a native member selection while parsing the command.
    if ([text rangeOfString:@"\u2005"].location != NSNotFound) {
        CSClownInputAlert(controller, @"请先移除输入框中的 @ 成员，再发送假引用。草稿已保留。"); return;
    }
    if (!CSMessageNativeSupports(controller, @"AsyncSendMessage:replyingMsg:referPartialInfo:isPasted:", @"v", @[@"@",@"@",@"@",@"B"])) {
        CSClownInputAlert(controller, @"当前微信发送接口不兼容，草稿已保留。"); return;
    }
    CSClownPage *page = CSClownPageForController(controller, YES);
    if (!CSClownPageIsCurrent(page)) { CSClownInputAlert(controller, @"当前会话已变化，草稿已保留。"); return; }
    CSClownQuoteSubmission *submission = [CSClownQuoteSubmission new]; submission.page = page; submission.epoch = page.session.epoch;
    submission.body = input.body;
    CSMessageNativeEnvironment *environment = [CSMessageNativeEnvironment new];
    id manager = [environment serviceNamed:@"CContactMgr"]; id contact = CSClownObject(manager, @"getSelfContact");
    NSString *name = CSClownString(CSClownObject(contact, @"m_nsNickName"));
    if ([page.session.conversationID hasSuffix:@"@chatroom"] &&
        CSMessageNativeSupports(contact, @"getChatRoomDisplayName:", @"@", @[@"@"])) {
        id roomName = CSMessageNativeInvoke(contact, @"getChatRoomDisplayName:", @[page.session.conversationID]);
        if ([roomName isKindOfClass:NSString.class] && [roomName length]) name = roomName;
    }
    submission.quote = [NSString stringWithFormat:@"%@：%@", name.length ? name : @"我", input.quote];
    // A unique mutable carrier prevents NSString interning from sharing tokens.
    // Native 8.0.80 retains this exact object in its main-queue submission block.
    NSMutableString *carrier = [input.body mutableCopy];
    objc_setAssociatedObject(carrier, &CSClownSubmissionKey, submission, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    native(carrier);
}
void CSClownSendInput(id controller, id text, id reply, id partial, void (^native)(id)) {
    CSClownQuoteSubmission *submission = NSThread.isMainThread && text ? objc_getAssociatedObject(text, &CSClownSubmissionKey) : nil;
    if (!submission) { native(text); return; }
    objc_setAssociatedObject(text, &CSClownSubmissionKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (submission.page.owner != controller || !CSClownPageIsCurrent(submission.page) ||
        submission.epoch != submission.page.session.epoch) return; // a queued submission must not cross chats/accounts
    if (reply || partial || !CSClownPreferences.sharedPreferences.snapshot.fakeQuoteEnabled) { native(text); return; }
    NSMutableDictionary *thread = NSThread.currentThread.threadDictionary; id prior = thread[CSClownSendScope];
    thread[CSClownSendScope] = submission;
    @try { native(text); }
    @finally { if (prior) thread[CSClownSendScope] = prior; else [thread removeObjectForKey:CSClownSendScope]; }
}
void CSClownDidFormText(id target, id text, id wrap) {
    if (!NSThread.isMainThread || !wrap) return;
    CSClownQuoteSubmission *submission = NSThread.currentThread.threadDictionary[CSClownSendScope];
    CSClownPage *page = submission.page;
    if (!submission || submission.formedWrap || !CSClownPageIsCurrent(page) ||
        ![CSClownString(target) isEqual:page.session.conversationID] || ![submission.body isEqual:text]) return;
    submission.formedWrap = wrap;
    objc_setAssociatedObject(wrap, &CSClownSentWrapKey, submission, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
void CSClownDidAddMessage(id target, id wrap) {
    if (!NSThread.isMainThread || !wrap) return;
    CSClownQuoteSubmission *submission = objc_getAssociatedObject(wrap, &CSClownSentWrapKey);
    CSClownPage *page = submission.page;
    if (!submission || submission.claimed || submission.formedWrap != wrap || !CSClownPageIsCurrent(page) ||
        submission.epoch != page.session.epoch || ![CSClownString(target) isEqual:page.session.conversationID]) return;
    submission.claimed = YES;
    objc_setAssociatedObject(wrap, &CSClownSentWrapKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSClownSentSource *source = [CSClownSentSource new]; source.wrap = wrap;
    CSMessageActionContext *context = [CSMessageActionContext contextWithCell:source controller:page.owner
        accountID:page.session.accountID accountEpoch:page.accountEpoch conversationID:page.session.conversationID bindingGeneration:page.session.epoch];
    if (!context.localID && !context.serverID) return;
    if ([page.session setFakeQuote:submission.quote forContext:context]) dispatch_async(dispatch_get_main_queue(), ^{
        if (CSClownPageIsCurrent(page)) CSClownRefresh(page);
    });
}
void CSClownPageDidAppear(id controller) {
    CSClownPage *page = CSClownPageForController(controller, YES);
    if (!page) {
        CSClownPage *old = objc_getAssociatedObject(controller, &CSClownPageKey);
        if (old.needsNativeReload) { old.needsNativeReload = NO; CSClownRefresh(old); }
        return;
    }
    if (page.needsNativeReload) { page.needsNativeReload = NO; CSClownRefresh(page); }
    for (id cell in [CSMessageNativeTable(controller) visibleCells]) {
        id view = CSClownObject(cell, @"cellView");
        if (view) { [page.cells addObject:view]; CSClownRenderCell(view); CSClownBindTimeCell(view); }
    }
}
void CSClownPageDidDisappear(id controller) {
    CSClownPage *page = CSClownPageForController(controller, NO);
    if (!page) return;
    UIViewController *owner = page.owner;
    BOOL ownPresentation = page.editor && owner.presentedViewController == page.editor;
    BOOL sameNavigation = !owner.navigationController || owner.navigationController.topViewController == owner;
    if (ownPresentation && sameNavigation && !owner.isBeingDismissed && !owner.isMovingFromParentViewController) return;
    CSClownInvalidate(page);
}
void CSClownAccountBoundary(void) {
    atomic_fetch_add_explicit(&CSClownAccountEpoch, 1, memory_order_relaxed);
    if (!NSThread.isMainThread) {
        dispatch_async(dispatch_get_main_queue(), ^{ for (CSClownPage *page in CSClownPages) CSClownInvalidate(page); });
        return;
    }
    for (CSClownPage *page in CSClownPages) CSClownInvalidate(page);
}

static CSClownModelBinding *CSClownBinding(CSClownPage *page, id model) {
    id root = CSClownRoot(model);
    CSClownModelBinding *binding = objc_getAssociatedObject(model, &CSClownModelKey);
    if (binding.page == page && binding.root == root) return binding;
    NSUInteger row = 0;
    id children = CSClownObject(root, @"subViewModels");
    if (root != model && [children isKindOfClass:NSArray.class]) {
        row = [children indexOfObjectIdenticalTo:model]; if (row == NSNotFound) return nil;
    }
    CSClownAssociateModel(page, root, model, row);
    return objc_getAssociatedObject(model, &CSClownModelKey);
}
static UIFont *CSClownFont(id model) {
    id font = CSClownObject(CSClownRoot(model), @"contentTextFont");
    return [font isKindOfClass:UIFont.class] ? font : [UIFont systemFontOfSize:17];
}
static NSAttributedString *CSClownText(NSString *text, UIFont *font, UIColor *color) {
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new]; paragraph.lineSpacing = 2;
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font,
        NSForegroundColorAttributeName:color ?: UIColor.labelColor, NSParagraphStyleAttributeName:paragraph}];
}
static CGSize CSClownTextSize(NSString *text, id model, CGFloat width) {
    CGFloat maximum = MAX(40, MIN(420, width - 136));
    NSAttributedString *attributed = CSClownText(text, CSClownFont(model), nil);
    CGRect rect = [attributed boundingRectWithSize:CGSizeMake(maximum, CGFLOAT_MAX)
        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return CGSizeMake(MAX(1, ceil(MIN(maximum, rect.size.width))), MAX(ceil(CSClownFont(model).lineHeight), ceil(rect.size.height)));
}
static NSString *CSClownDisplayText(CSClownPage *page, CSMessageActionContext *context) {
    CSClownSettings *settings = CSClownPreferences.sharedPreferences.snapshot;
    NSString *manual = settings.textEnabled ? [page.session textForContext:context] : nil;
    if (manual) return manual;
    if (!context || context.outgoing || context.messageType != 1 ||
        ![settings warmsConversation:page.session.conversationID account:page.session.accountID]) return nil;
    NSString *text = CSClownString(CSClownObject(context.sourceWrap, @"m_nsContent"));
    if ([page.session.conversationID hasSuffix:@"@chatroom"]) {
        NSString *sender = CSClownString(CSClownObject(context.sourceWrap, @"m_nsRealChatUsr"));
        if ([sender isEqual:page.session.accountID]) return nil;
        if (sender.length) {
            NSString *prefix = [sender stringByAppendingString:@":\n"];
            if ([text hasPrefix:prefix]) text = [text substringFromIndex:prefix.length];
        }
    }
    return [page.session warmTextForContext:context original:text];
}
static NSString *CSClownQuote(CSClownPage *page, CSMessageActionContext *context) {
    return CSClownPreferences.sharedPreferences.snapshot.fakeQuoteEnabled ? [page.session fakeQuoteForContext:context] : nil;
}
static CGSize CSClownQuoteSize(NSString *text, id model, CGFloat width) {
    if (!text) return CGSizeZero;
    CGFloat maximum = MAX(40, MIN(420, width - 136));
    UIFont *font = [UIFont systemFontOfSize:MAX(12, CSClownFont(model).pointSize - 2)];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAX(1, maximum-20), CGFLOAT_MAX)
        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return CGSizeMake(MIN(maximum, ceil(rect.size.width)+20), ceil(rect.size.height)+16);
}
static CGSize CSClownReplacementSize(CSClownPage *page, id model, CGFloat width, BOOL *suppressed) {
    if (suppressed) *suppressed = NO;
    CSMessageActionContext *context = CSClownContext(page, model);
    if (!context) return CGSizeZero;
    if (context.messageType == 1) {
        NSString *text = CSClownDisplayText(page, context);
        if (text) {
            if (CSClownBinding(page, model).row > 0) { if (suppressed) *suppressed = YES; return CGSizeZero; }
            return CSClownTextSize(text, model, width);
        }
    }
    if (CSClownPreferences.sharedPreferences.snapshot.imageEnabled && context.messageType == 3) {
        UIImage *image = [page.session imageForContext:context];
        if ([image isKindOfClass:UIImage.class]) return CSClownImageSize(image.size, width);
    }
    return CGSizeZero;
}
CGFloat CSClownRowHeight(id controller, UITableView *table, NSIndexPath *path, CGFloat nativeHeight) {
    CSClownPage *page = CSClownPageForController(controller, NO);
    if (!CSClownPageIsCurrent(page) || table != CSMessageNativeTable(controller)) return nativeHeight;
    NSArray *nodes = CSClownNodes(controller);
    if (path.section < 0 || (NSUInteger)path.section >= nodes.count || path.row < 0) return nativeHeight;
    id root = nodes[path.section], model = CSClownRowModel(root, path.row);
    CSClownAssociateModel(page, root, model, path.row);
    BOOL suppressed = NO; CGSize replacement = CSClownReplacementSize(page, model, table.bounds.size.width, &suppressed);
    if (suppressed) return .01;
    CSMessageActionContext *context = CSClownContext(page, model);
    // Native split text is projected only once, on its final row.
    BOOL lastRow = CSClownIsLastRow(root, path.row);
    CGSize quote = lastRow ? CSClownQuoteSize(CSClownQuote(page, context), model, table.bounds.size.width) : CGSizeZero;
    CGFloat extra = quote.height > 0 ? quote.height+6 : 0;
    if (replacement.height <= 0) return nativeHeight + extra;
    CGSize original = CSClownSize(model, @"contentTextSize");
    if (original.height <= 0) original = CSClownSize(model, @"thumbImageSize");
    if (original.height <= 0 && root != model) {
        original = CSClownSize(root, @"contentTextSize");
        original.height = MIN(nativeHeight, original.height);
    }
    if (original.height <= 0) return nativeHeight + extra;
    // Replacement text suppresses subsequent split rows, so its quote belongs to row zero.
    if (CSClownDisplayText(page, context) && !lastRow) {
        quote = CSClownQuoteSize(CSClownQuote(page, context), model, table.bounds.size.width);
        extra = quote.height > 0 ? quote.height+6 : 0;
    }
    return MAX(MIN(44, nativeHeight), CSClownProjectedRowHeight(nativeHeight, original.height, replacement.height)) + extra;
}
void CSClownBindRow(id controller, UITableView *table, NSIndexPath *path, id cell) {
    CSClownPage *page = CSClownPageForController(controller, NO);
    if (!page || table != CSMessageNativeTable(controller)) return;
    UIView *view = CSClownView(CSClownObject(cell, @"cellView"));
    if (!view) return;
    [page.cells addObject:view];
    id model = CSClownObject(view, @"viewModel");
    CSClownBinding(page, model);
    CSClownRenderCell(view); CSClownBindTimeCell(view);
}

static void CSClownSetFrame(CSClownCellState *state, UIView *view, CGRect frame) {
    if (!view || CGRectEqualToRect(view.frame, frame)) return;
    CSClownFrame *record = [CSClownFrame new]; record.view = view; record.nativeFrame = view.frame; record.projectedFrame = frame;
    [state.frames addObject:record]; view.frame = frame;
}
static CSClownCellState *CSClownHideSource(id cell, UIView *source, UIView *overlay) {
    CSClownCellState *state = objc_getAssociatedObject(cell, &CSClownCellKey) ?: [CSClownCellState new];
    if (state.overlay != overlay) [state.overlay removeFromSuperview];
    state.source = source; state.nativeMask = source.layer.mask; state.active = YES;
    state.accessibilityHidden = source.accessibilityElementsHidden; state.frames = [NSMutableArray array]; state.overlay = overlay;
    // A transparent composition mask hides pixels while retaining UIView.alpha,
    // native hit-testing, tap recognizers and long-press menu routing.
    state.concealMask = [CALayer layer]; state.concealMask.frame = source.bounds;
    [CATransaction begin]; [CATransaction setDisableActions:YES];
    source.layer.mask = state.concealMask;
    [CATransaction commit];
    source.accessibilityElementsHidden = YES;
    objc_setAssociatedObject(cell, &CSClownCellKey, state, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return state;
}
static UIView *CSClownExistingOverlay(id cell, Class cls) {
    CSClownCellState *state = objc_getAssociatedObject(cell, &CSClownCellKey);
    return [state.overlay isKindOfClass:cls] ? state.overlay : nil;
}
static void CSClownShowOverlay(UIView *source, UIView *overlay) {
    overlay.frame = source.frame; overlay.hidden = NO;
    if (overlay.superview != source.superview) [source.superview addSubview:overlay];
    else [source.superview bringSubviewToFront:overlay];
}
static void CSClownRenderContent(id cell) {
    if (!NSThread.isMainThread || ![cell isKindOfClass:UIView.class]) return;
    CSClownRestoreCell(cell);
    if (!CSClownPreferences.sharedPreferences.snapshot.enabled) return;
    CSClownPage *page = CSClownPageForCell(cell, NO);
    if (!CSClownPageIsCurrent(page)) return;
    [page.cells addObject:cell];
    id model = CSClownObject(cell, @"viewModel");
    CSMessageActionContext *context = CSClownContext(page, model);
    if (CSClownPreferences.sharedPreferences.snapshot.amountEnabled && context.messageType == 49 &&
        [cell isKindOfClass:NSClassFromString(@"WCPayTransferMessageCellView")]) {
        NSString *amount = [page.session amountForContext:context];
        UILabel *source = CSClownAmountLabel(cell);
        // Only a title containing a currency amount is projected; group summary titles
        // and transfer states retain their native wording and layout.
        if (amount && source.superview) {
            UILabel *label = (id)CSClownExistingOverlay(cell, UILabel.class) ?: [UILabel new];
            label.font = source.font; label.textColor = source.textColor; label.textAlignment = source.textAlignment;
            label.numberOfLines = source.numberOfLines; label.adjustsFontSizeToFitWidth = YES; label.minimumScaleFactor = .55;
            label.text = [source.text stringByReplacingCharactersInRange:CSClownAmountRange(source.text) withString:amount];
            label.userInteractionEnabled = NO; CSClownHideSource(cell, source, label); CSClownShowOverlay(source, label);
        }
        return;
    }
    BOOL suppressed = NO;
    CGFloat width = CSMessageNativeTable(page.owner).bounds.size.width;
    CGSize size = CSClownReplacementSize(page, model, width, &suppressed);
    if (suppressed) { CSClownHideSource(cell, cell, nil); return; }
    if (size.width <= 0 || size.height <= 0) return;
    UIView *source = nil, *overlay = nil;
    if (context.messageType == 1) {
        source = CSClownView(CSClownObject(cell, @"getRichTextView"));
        if (!source) return;
        UILabel *label = (id)CSClownExistingOverlay(cell, UILabel.class) ?: [UILabel new]; label.numberOfLines = 0; label.backgroundColor = UIColor.clearColor;
        id color = CSClownObject(source, @"oTextColor") ?: CSClownObject(model, @"contentTextColor");
        label.attributedText = CSClownText(CSClownDisplayText(page, context), CSClownFont(model), [color isKindOfClass:UIColor.class] ? color : nil);
        overlay = label;
    } else if (context.messageType == 3) {
        source = CSClownView(CSClownIvar(cell, "m_imageView"));
        if (!source) return;
        UIImageView *image = (id)CSClownExistingOverlay(cell, UIImageView.class) ?: [UIImageView new];
        image.image = [page.session imageForContext:context];
        image.contentMode = UIViewContentModeScaleAspectFit; image.clipsToBounds = YES;
        image.layer.cornerRadius = MAX(3, source.layer.cornerRadius); overlay = image;
    }
    if (!source.superview || !overlay || !CGAffineTransformIsIdentity(source.transform)) return;
    [page.cells addObject:cell]; overlay.userInteractionEnabled = NO;
    UIView *container = CSClownView(CSClownObject(cell, @"getContentView"));
    UIView *bubble = CSClownView(CSClownObject(cell, @"getBgImageView"));
    CGRect original = source.frame;
    CGFloat dx = size.width - original.size.width, dy = size.height - original.size.height;
    CSClownCellState *state = CSClownHideSource(cell, source, overlay);
    // Native layout has already placed sender/avatar/name/reply content. Resize its known
    // content lane and bubble while retaining the sender's outside horizontal edge.
    if (container && container != cell && container != source && container != bubble && CGAffineTransformIsIdentity(container.transform)) {
        CGRect frame = container.frame;
        frame.size.height = MAX(CGRectGetMinY(original) + size.height, MAX(1, frame.size.height + dy));
        CSClownSetFrame(state, container, frame);
    }
    CGRect sourceFrame = CSClownResizeFrame(original, size, context.outgoing && source.superview != bubble);
    CSClownSetFrame(state, source, sourceFrame);
    if (bubble && bubble != source && CGAffineTransformIsIdentity(bubble.transform)) {
        CGRect frame = bubble.frame; frame.size.width = MAX(1, frame.size.width + dx); frame.size.height = MAX(1, frame.size.height + dy);
        if (context.outgoing) frame.origin.x -= dx;
        CSClownSetFrame(state, bubble, frame);
    }
    // Translation and reply views below the text follow its new bottom edge.
    for (UIView *sibling in source.superview.subviews) {
        if (sibling == source || sibling == bubble || sibling == overlay || CGRectGetMinY(sibling.frame) < CGRectGetMaxY(original) - 1) continue;
        CGRect frame = sibling.frame; frame.origin.y += dy; CSClownSetFrame(state, sibling, frame);
    }
    CSClownShowOverlay(source, overlay);
    SEL positionTime = NSSelectorFromString(@"cs_messageTimeLayout");
    if (CSMessageNativeSupports(cell, NSStringFromSelector(positionTime), @"v", @[])) CSMessageNativeInvoke(cell, NSStringFromSelector(positionTime), @[]);
}

void CSClownRenderCell(id cell) {
    CSClownRenderContent(cell);
    if (!NSThread.isMainThread || ![cell isKindOfClass:UIView.class]) return;
    CSClownPage *page = CSClownPageForCell(cell, NO);
    if (!CSClownPageIsCurrent(page)) return;
    id model = CSClownObject(cell, @"viewModel"); CSMessageActionContext *context = CSClownContext(page, model);
    NSString *quote = CSClownQuote(page, context);
    if (!quote) return;
    CSClownModelBinding *binding = CSClownBinding(page, model);
    if (CSClownDisplayText(page, context) ? binding.row > 0 : !CSClownIsLastRow(model, binding.row)) return;
    UIView *bubble = CSClownView(CSClownObject(cell, @"getBgImageView"));
    if (!bubble.superview || !CGAffineTransformIsIdentity(bubble.transform)) return;
    CSClownCellState *state = objc_getAssociatedObject(cell, &CSClownCellKey);
    if (!state) {
        state = [CSClownCellState new]; state.frames = [NSMutableArray array];
        objc_setAssociatedObject(cell, &CSClownCellKey, state, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    state.active = YES;
    UILabel *label = state.quoteView;
    if (!label) { label = [UILabel new]; label.numberOfLines = 0; label.userInteractionEnabled = NO; state.quoteView = label; }
    label.font = [UIFont systemFontOfSize:MAX(12, CSClownFont(model).pointSize-2)];
    label.textColor = UIColor.secondaryLabelColor; label.backgroundColor = UIColor.secondarySystemFillColor;
    label.layer.cornerRadius = 5; label.clipsToBounds = YES;
    // A paragraph indent keeps both first and wrapped lines inside the grey surface.
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new]; paragraph.firstLineHeadIndent = 10; paragraph.headIndent = 10; paragraph.tailIndent = -10;
    label.attributedText = [[NSAttributedString alloc] initWithString:quote attributes:@{NSFontAttributeName:label.font,
        NSForegroundColorAttributeName:label.textColor, NSParagraphStyleAttributeName:paragraph}];
    CGSize size = CSClownQuoteSize(quote, model, CSMessageNativeTable(page.owner).bounds.size.width);
    CGRect bubbleRect = [bubble.superview convertRect:bubble.frame toView:cell];
    label.frame = CGRectMake(MAX(0, CGRectGetMaxX(bubbleRect)-size.width), CGRectGetMaxY(bubbleRect)+6, size.width, size.height);
    if (label.superview != cell) [cell addSubview:label];
    CGRect cellFrame = [cell frame]; cellFrame.size.height = MAX(cellFrame.size.height, CGRectGetMaxY(label.frame)+8);
    CSClownSetFrame(state, cell, cellFrame);
    label.hidden = NO; [cell bringSubviewToFront:label];
}

static BOOL CSClownRequestValid(CSClownEditRequest *request, BOOL requireCell) {
    if (![request isKindOfClass:CSClownEditRequest.class]) return NO;
    CSClownPage *page = request.page;
    CSClownSettings *settings = CSClownPreferences.sharedPreferences.snapshot;
    if (!CSClownPageIsCurrent(page) || request.epoch != page.session.epoch ||
        request.context.accountEpoch != CSClownAccountEpoch ||
        (request.editSerial && !request.image && request.editSerial != page.editSerial) ||
        !(request.amount ? settings.amountEnabled : request.image ? settings.imageEnabled : settings.textEnabled)) return NO;
    if (request.image && request.editSerial && [page.pendingPhotos indexOfObjectIdenticalTo:request] == NSNotFound) return NO;
    if (requireCell) {
        CSMessageActionContext *current = [CSMessageActionContext contextWithCell:request.cell controller:page.owner
            accountID:page.session.accountID accountEpoch:CSClownAccountEpoch conversationID:page.session.conversationID bindingGeneration:page.session.epoch];
        return request.cell && [request.context matchesSourceContext:current];
    }
    for (id model in CSClownNodes(page.owner)) if ([request.context matchesSourceContext:CSClownContext(page, model)]) return YES;
    return NO;
}
id CSClownCaptureEdit(id cell, BOOL image) {
    if (!NSThread.isMainThread) return nil;
    CSClownSettings *settings = CSClownPreferences.sharedPreferences.snapshot;
    if (!(image ? settings.imageEnabled : settings.textEnabled)) return nil;
    CSClownPage *page = CSClownPageForCell(cell, YES);
    if (!CSClownPageIsCurrent(page) || page.editor) return nil;
    CSMessageActionContext *context = [CSMessageActionContext contextWithCell:cell controller:page.owner
        accountID:page.session.accountID accountEpoch:CSClownAccountEpoch conversationID:page.session.conversationID bindingGeneration:page.session.epoch];
    id model = CSClownRoot(CSClownObject(cell, @"viewModel"));
    if (!context || context.messageType != (image ? 3u : 1u) || CSMessageNativeUnsigned(model, @"isRecordDetail")) return nil;
    CSClownEditRequest *request = [CSClownEditRequest new]; request.page = page; request.cell = cell;
    request.context = context; request.epoch = page.session.epoch; request.image = image;
    return request;
}
BOOL CSClownEditIsValid(id request) { return CSClownRequestValid(request, YES); }

static NSRange CSClownAmountRange(NSString *text) {
    if (![text isKindOfClass:NSString.class]) return NSMakeRange(NSNotFound, 0);
    static NSRegularExpression *expression, *standalone; static dispatch_once_t once;
    dispatch_once(&once, ^{
        expression = [NSRegularExpression regularExpressionWithPattern:@"[¥￥]\\s*((?:[0-9]{1,3}(?:,[0-9]{3})+|[0-9]+)(?:\\.[0-9]{1,2})?)(?![0-9.,])|(?<![0-9.,])((?:[0-9]{1,3}(?:,[0-9]{3})+|[0-9]+)(?:\\.[0-9]{1,2})?)\\s*元" options:0 error:nil];
        // Native innerTitleText can return m_nsFeeDesc unchanged: a plain number,
        // a currency symbol or a currency code. No Chinese marker is guaranteed.
        standalone = [NSRegularExpression regularExpressionWithPattern:@"^\\s*(?:(?:[A-Z]{1,3}\\s*)?\\p{Sc}\\s*|(?:CNY|RMB|USD|HKD|TWD|EUR|GBP|JPY|KRW|SGD|AUD|CAD|CHF|NZD|THB)\\s*)?((?:[0-9]{1,3}(?:,[0-9]{3})+|[0-9]+)(?:\\.[0-9]{1,2})?)(?:\\s*(?:元|CNY|RMB|USD|HKD|TWD|EUR|GBP|JPY|KRW|SGD|AUD|CAD|CHF|NZD|THB))?\\s*$" options:0 error:nil];
    });
    NSTextCheckingResult *match = [expression firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
    if (!match) {
        match = [standalone firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
        return match ? [match rangeAtIndex:1] : NSMakeRange(NSNotFound, 0);
    }
    NSRange range = [match rangeAtIndex:1]; return range.location == NSNotFound ? [match rangeAtIndex:2] : range;
}
static UILabel *CSClownAmountLabel(id cell) {
    for (NSString *name in @[@"m_titleLabel", @"m_descLabel"]) {
        id label = CSClownIvar(cell, name.UTF8String);
        if ([label isKindOfClass:UILabel.class] && CSClownAmountRange(((UILabel *)label).text).location != NSNotFound) return label;
    }
    return nil;
}
id CSClownCaptureAmountEdit(id cell) {
    if (!NSThread.isMainThread || !CSClownPreferences.sharedPreferences.snapshot.amountEnabled ||
        ![cell isKindOfClass:NSClassFromString(@"WCPayTransferMessageCellView")] || !CSClownAmountLabel(cell)) return nil;
    CSClownPage *page = CSClownPageForCell(cell, YES);
    if (!CSClownPageIsCurrent(page) || page.editor) return nil;
    CSMessageActionContext *context = [CSMessageActionContext contextWithCell:cell controller:page.owner
        accountID:page.session.accountID accountEpoch:CSClownAccountEpoch conversationID:page.session.conversationID bindingGeneration:page.session.epoch];
    if (context.messageType != 49 || CSMessageNativeUnsigned(CSClownRoot(CSClownObject(cell, @"viewModel")), @"isRecordDetail")) return nil;
    CSClownEditRequest *request = [CSClownEditRequest new]; request.page = page; request.cell = cell;
    request.context = context; request.epoch = page.session.epoch; request.amount = YES; return request;
}

@interface CSClownPhotoDelegate : NSObject <PHPickerViewControllerDelegate, UIAdaptivePresentationControllerDelegate>
@property(nonatomic, strong) CSClownEditRequest *request;
@property(nonatomic) BOOL completed;
@end
@implementation CSClownPhotoDelegate
- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController {
    CSClownPage *page = self.request.page;
    if (page.editor == presentationController.presentedViewController) { page.editor = nil; page.editorDelegate = nil; }
    if (!self.completed) [page.pendingPhotos removeObjectIdenticalTo:self.request];
}
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results {
    if (self.completed) return; self.completed = YES;
    CSClownEditRequest *request = self.request;
    NSItemProvider *provider = results.firstObject.itemProvider;
    if (CSClownRequestValid(request, NO) && provider && [provider canLoadObjectOfClass:UIImage.class]) {
        // Committing another choice supersedes this message's older load. Merely
        // opening and cancelling another picker preserves the previous choice.
        for (CSClownEditRequest *prior in request.page.pendingPhotos.copy)
            if (prior != request && [prior.context matchesSourceContext:request.context])
                [request.page.pendingPhotos removeObjectIdenticalTo:prior];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        CSClownPage *page = request.page;
        if (page.editor == picker) { page.editor = nil; page.editorDelegate = nil; }
        if (!provider || !CSClownRequestValid(request, NO) || ![provider canLoadObjectOfClass:UIImage.class]) {
            [page.pendingPhotos removeObjectIdenticalTo:request]; return;
        }
        [provider loadObjectOfClass:UIImage.class completionHandler:^(__kindof id<NSItemProviderReading> object, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error && [object isKindOfClass:UIImage.class] && CSClownRequestValid(request, NO) &&
                    [page.session setImage:object forContext:request.context]) CSClownRefresh(page);
                [page.pendingPhotos removeObjectIdenticalTo:request];
            });
        }];
    }];
}
@end

void CSClownPerformEdit(id value) {
    if (!CSClownEditIsValid(value)) return;
    CSClownEditRequest *captured = value; CSClownPage *page = captured.page;
    if (page.editor || page.owner.presentedViewController) return;
    // A menu may be reused while an earlier image is loading. Each execution owns
    // a new token; mutating the menu's request would accidentally revive that callback.
    CSClownEditRequest *request = [CSClownEditRequest new]; request.page = page; request.cell = captured.cell;
    request.context = captured.context; request.epoch = captured.epoch; request.image = captured.image; request.amount = captured.amount;
    request.editSerial = ++page.editSerial;
    [UIMenuController.sharedMenuController hideMenu];
    if (request.image) {
        [page.pendingPhotos addObject:request];
        PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
        configuration.filter = PHPickerFilter.imagesFilter; configuration.selectionLimit = 1;
        PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
        CSClownPhotoDelegate *delegate = [CSClownPhotoDelegate new]; delegate.request = request;
        page.editor = picker; page.editorDelegate = delegate; picker.delegate = delegate;
        [page.owner presentViewController:picker animated:YES completion:nil]; picker.presentationController.delegate = delegate;
        return;
    }
    id model = CSClownRoot(CSClownObject(request.cell, @"viewModel"));
    NSString *text = [page.session textForContext:request.context] ?: CSClownString(CSClownObject(model, @"originContentText") ?: CSClownObject(model, @"contentText"));
    if (request.amount) {
        UILabel *label = CSClownAmountLabel(request.cell); NSRange range = CSClownAmountRange(label.text);
        if (range.location == NSNotFound) return;
        text = [page.session amountForContext:request.context] ?: [[label.text substringWithRange:range] stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:request.amount ? @"修改金额" : @"修改文字"
        message:request.amount ? @"请输入显示金额，最多两位小数" : @"请输入要修改的文字" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) { field.text = text; field.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (request.amount) field.keyboardType = UIKeyboardTypeDecimalPad; }];
    __weak UIAlertController *weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) { page.editor = nil; }]];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        page.editor = nil;
        if (!CSClownRequestValid(request, NO)) return;
        NSString *input = weakAlert.textFields.firstObject.text ?: @"";
        NSString *amount = request.amount ? CSClownAmountFromInput(input) : nil;
        if (request.amount && !amount) return;
        BOOL applied = request.amount ? [page.session setAmount:amount forContext:request.context] : [page.session setText:input forContext:request.context];
        if (applied) CSClownRefresh(page);
    }];
    [alert addAction:confirm];
    if (request.amount) {
        confirm.enabled = CSClownAmountFromInput(text) != nil;
        CSClownObservation *observation = [CSClownObservation new]; __weak UIAlertAction *weakConfirm = confirm;
        observation.token = [NSNotificationCenter.defaultCenter addObserverForName:UITextFieldTextDidChangeNotification
            object:alert.textFields.firstObject queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) {
                weakConfirm.enabled = CSClownAmountFromInput(((UITextField *)note.object).text) != nil;
            }];
        objc_setAssociatedObject(alert, &CSClownAmountKey, observation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    page.editor = alert; [page.owner presentViewController:alert animated:YES completion:nil];
}

@interface CSClownTimeTarget : NSObject <UIGestureRecognizerDelegate>
@property(nonatomic, weak) UIView *cell;
@property(nonatomic, strong) UILongPressGestureRecognizer *gesture;
@property(nonatomic) BOOL originalInteraction;
- (void)longPress:(UILongPressGestureRecognizer *)gesture;
@end
@implementation CSClownTimeTarget
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other {
    return gesture == self.gesture && [other isKindOfClass:UITapGestureRecognizer.class];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    UILabel *label = CSClownIvar(self.cell, "m_timeLabel");
    if (![label isKindOfClass:UILabel.class] || label.hidden || self.cell.hidden) return NO;
    for (UIView *view = touch.view; view && view != self.cell; view = view.superview) if ([view isKindOfClass:UIControl.class]) return NO;
    CGRect hit = [self.cell convertRect:label.bounds fromView:label];
    CSClownCellState *state = objc_getAssociatedObject(self.cell, &CSClownCellKey);
    if (state.active && state.overlay.superview && !state.overlay.hidden)
        hit = CGRectUnion(hit, [self.cell convertRect:state.overlay.bounds fromView:state.overlay]);
    return CGRectContainsPoint(CGRectInset(hit, -10, -10), [touch locationInView:self.cell]);
}
- (void)longPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state != UIGestureRecognizerStateBegan || !CSClownPreferences.sharedPreferences.snapshot.timeEnabled) return;
    CSClownPage *page = CSClownPageForCell(self.cell, NO);
    id model = CSClownObject(self.cell, @"viewModel"); double timestamp = CSClownTimestamp(model);
    if (!CSClownPageIsCurrent(page) || page.editor || page.owner.presentedViewController || !isfinite(timestamp)) return;
    NSUInteger epoch = page.session.epoch;
    NSUInteger serial = ++page.editSerial;
    NSDate *date = [page.session dateForTimeModel:model] ?: [NSDate dateWithTimeIntervalSince1970:timestamp];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改时间" message:@"请输入要修改的时间\n格式：yyyy-MM-dd HH:mm" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) { field.text = CSClownDateInput(date); field.placeholder = @"2026-11-09 14:30"; }];
    __weak UIAlertController *weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) { page.editor = nil; }]];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        page.editor = nil;
        NSDate *selected = CSClownDateFromInput(weakAlert.textFields.firstObject.text);
        if (selected && CSClownPageIsCurrent(page) && page.session.epoch == epoch && page.editSerial == serial &&
            CSClownPreferences.sharedPreferences.snapshot.timeEnabled && [CSClownNodes(page.owner) containsObject:model] &&
            [page.session setDate:selected forTimeModel:model]) CSClownRefresh(page);
    }];
    [alert addAction:confirm];
    // Invalid input stays in the editor; the system disables confirmation until it is valid.
    CSClownObservation *observation = [CSClownObservation new]; __weak UIAlertAction *weakConfirm = confirm;
    observation.token = [NSNotificationCenter.defaultCenter addObserverForName:UITextFieldTextDidChangeNotification
        object:alert.textFields.firstObject queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) {
            weakConfirm.enabled = CSClownDateFromInput(((UITextField *)note.object).text) != nil;
        }];
    confirm.enabled = CSClownDateFromInput(alert.textFields.firstObject.text) != nil;
    objc_setAssociatedObject(alert, @selector(longPress:), observation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    page.editor = alert; [page.owner presentViewController:alert animated:YES completion:nil];
}
@end

void CSClownBindTimeCell(id value) {
    if (!NSThread.isMainThread || ![value isKindOfClass:UIView.class] ||
        ![value isKindOfClass:NSClassFromString(@"ChatTimeCellView")]) return;
    UIView *cell = value;
    CSClownTimeTarget *target = objc_getAssociatedObject(cell, &CSClownTimeKey);
    CSClownPage *page = CSClownPageForCell(cell, NO);
    BOOL enabled = CSClownPreferences.sharedPreferences.snapshot.timeEnabled && CSClownPageIsCurrent(page);
    if (!enabled) {
        CSClownRestoreCell(cell);
        if (target) { [cell removeGestureRecognizer:target.gesture]; cell.userInteractionEnabled = target.originalInteraction;
            objc_setAssociatedObject(cell, &CSClownTimeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
        return;
    }
    [page.cells addObject:cell];
    if (!target) {
        target = [CSClownTimeTarget new]; target.cell = cell; target.originalInteraction = cell.userInteractionEnabled;
        target.gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:@selector(longPress:)];
        target.gesture.minimumPressDuration = .5; target.gesture.cancelsTouchesInView = NO; target.gesture.delegate = target;
        target.gesture.delaysTouchesBegan = NO; target.gesture.delaysTouchesEnded = NO;
        cell.userInteractionEnabled = YES; [cell addGestureRecognizer:target.gesture];
        objc_setAssociatedObject(cell, &CSClownTimeKey, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    CSClownRestoreCell(cell);
    NSDate *date = [page.session dateForTimeModel:CSClownObject(cell, @"viewModel")];
    UILabel *source = CSClownIvar(cell, "m_timeLabel");
    if (!date || ![source isKindOfClass:UILabel.class] || !source.superview || cell.hidden || source.hidden) return;
    BOOL detail = CSMessageNativeSupports(page.owner, @"isNeedShowTimeInDetail", @"B", @[]) &&
        [CSMessageNativeInvoke(page.owner, @"isNeedShowTimeInDetail", @[]) boolValue];
    UILabel *label = (id)CSClownExistingOverlay(cell, UILabel.class) ?: [UILabel new];
    label.text = CSClownDateDisplayWithDetail(date, detail); label.font = source.font;
    label.textColor = source.textColor; label.textAlignment = NSTextAlignmentCenter; label.userInteractionEnabled = NO;
    CGSize size = [label sizeThatFits:CGSizeMake(cell.bounds.size.width, source.bounds.size.height)];
    CGRect frame = source.frame; frame.origin.x += (frame.size.width - size.width) / 2; frame.size.width = size.width;
    CSClownCellState *state = CSClownHideSource(cell, source, label);
    // The replacement may be wider than the native date. Its full visible width
    // remains part of the original label's tappable region.
    CSClownSetFrame(state, source, frame); CSClownShowOverlay(source, label);
}

void CSClownTimeDisplayModeDidChange(id controller) {
    CSClownPage *page = CSClownPageForController(controller, NO);
    if (!CSClownPageIsCurrent(page)) return;
    for (UIView *cell in page.cells) CSClownBindTimeCell(cell);
}
