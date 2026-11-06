#import "CSMessageMergeAdapter.h"
#import "CSMessageMergePolicy.h"
#import "CSMessageNavigation.h"
#import "CSBubbleStyleAdapter.h"
#import <objc/runtime.h>
#import <objc/message.h>
#include <math.h>

// All private dispatch is signature checked. Dumped headers do not prove runtime inheritance.
static Method CSGetter(id object, SEL selector) {
    if (!object) return NULL;
    Method method = class_getInstanceMethod(object_getClass(object),selector);
    return method && method_getNumberOfArguments(method) == 2 ? method : NULL;
}
static BOOL CSBoolSelector(id object, SEL sel, BOOL fallback) {
    Method method = CSGetter(object,sel);
    if (!method) return fallback;
    char type = method_getTypeEncoding(method)[0];
    if (type != 'B' && type != 'c') return fallback;
    return ((BOOL (*)(id, SEL))objc_msgSend)(object, sel);
}
static BOOL CSBool(id object, NSString *name, BOOL fallback) {
    return CSBoolSelector(object,NSSelectorFromString(name),fallback);
}
static unsigned long long CSUInt(id object, NSString *name) {
    SEL sel = NSSelectorFromString(name);
    Method method = CSGetter(object,sel);
    if (!method) return 0;
    switch (method_getTypeEncoding(method)[0]) {
        case 'I': return ((unsigned int (*)(id,SEL))objc_msgSend)(object,sel);
        case 'Q': return ((unsigned long long (*)(id,SEL))objc_msgSend)(object,sel);
        case 'q': { long long n = ((long long (*)(id,SEL))objc_msgSend)(object,sel); return n > 0 ? n : 0; }
        default: return 0;
    }
}
static void CSVoid(id object, NSString *name) {
    SEL sel = NSSelectorFromString(name);
    Method method = CSGetter(object,sel);
    if (method && method_getTypeEncoding(method)[0] == 'v') ((void (*)(id,SEL))objc_msgSend)(object,sel);
}
static NSString *CSString(id object) { return [object isKindOfClass:NSString.class] ? object : @""; }
static id CSParent(id model) { return CSMessageNativeObject(model, @"parentModel") ?: model; }
static NSArray *CSNodes(id controller) {
    id nodes = CSMessageNativeObject(controller, @"GetMessageNodeDataArray");
    return [nodes isKindOfClass:NSArray.class] ? nodes : nil;
}
static id CSRowModel(id node, NSUInteger row) {
    SEL sel = @selector(cellDataForRow:);
    Method method = class_getInstanceMethod(object_getClass(node),sel);
    char argument[16] = {0};
    if (method) method_getArgumentType(method,2,argument,sizeof(argument));
    if (method && method_getNumberOfArguments(method) == 3 && method_getTypeEncoding(method)[0] == '@' &&
        strcmp(argument,@encode(unsigned long long)) == 0)
        return ((id (*)(id,SEL,unsigned long long))objc_msgSend)(node,sel,row);
    return row == 0 ? node : nil;
}
NSString *CSMessageNativeIdentity(id model) {
    id wrap = CSMessageNativeObject(CSParent(model),@"messageWrap");
    if (!wrap) wrap = model; // Also accepts a message wrap for navigation.
    unsigned long long local = CSUInt(wrap,@"m_uiMesLocalID"), server = CSUInt(wrap,@"m_n64MesSvrID");
    if (local) return [NSString stringWithFormat:@"l:%llu",local];
    if (server) return [NSString stringWithFormat:@"s:%llu",server];
    return @"";
}

@class CSMessageMergeContext;
@interface CSMessageMergeState : NSObject
@property(nonatomic, weak) CSMessageMergeContext *context;
@property(nonatomic, weak) id model;
@property(nonatomic, copy) NSString *identity;
@property(nonatomic, copy) NSString *account, *session;
@property(nonatomic, strong) CSMessageMergeConfiguration *configuration;
@property(nonatomic) CSMessageMergeDecision decision;
@property(nonatomic) BOOL active;
@property(nonatomic) BOOL group;
@property(nonatomic) BOOL singleRow;
@property(nonatomic) BOOL geometryRejected;
@property(nonatomic) BOOL needsLayout;
@property(nonatomic) BOOL measurementDecided;
@property(nonatomic) BOOL hasMeasuredHeight;
@property(nonatomic) BOOL resettingModel;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) CGFloat nativeHeight;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat appliedDelta;
@property(nonatomic) CGFloat appliedOriginDelta;
@property(nonatomic) BOOL dark, outgoing;
@property(nonatomic) UIEdgeInsets bubbleInsets;
@property(nonatomic) BOOL hasBubbleInsets;
@property(nonatomic) CGFloat contentHeight;
@property(nonatomic) CGFloat contentWidth;
@property(nonatomic) BOOL hasNativeGeometry;
@property(nonatomic) CGFloat occupiedTop;
@property(nonatomic) CGFloat occupiedBottom;
@property(nonatomic) NSUInteger auxiliaryFlags;
@property(nonatomic) BOOL showsName;
@end
@implementation CSMessageMergeState @end

@interface CSMessageMergeDescriptor : NSObject
@property(nonatomic, strong) CSMessageMergeItem *item;
@property(nonatomic) unsigned long long localID, serverID;
@end
@implementation CSMessageMergeDescriptor @end

@interface CSMessageViewOverride : NSObject
@property(nonatomic, weak) UIView *view;
@property(nonatomic) BOOL hidden;
@end
@implementation CSMessageViewOverride @end

@interface CSMessageOriginOverride : NSObject
@property(nonatomic, weak) UIView *view;
@property(nonatomic) CGPoint originalOrigin;
@property(nonatomic) CGPoint appliedOrigin;
@end
@implementation CSMessageOriginOverride @end

@interface CSMessageMergeContext : NSObject
@property(nonatomic, weak) id owner;
@property(nonatomic, weak) UITableView *table;
@property(nonatomic, copy) NSString *account;
@property(nonatomic, copy) NSString *session;
@property(nonatomic, strong) CSMessageMergeConfiguration *config;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic) NSUInteger mutationDepth;
@property(nonatomic) BOOL active;
@property(nonatomic) BOOL scheduled;
@property(nonatomic) BOOL dirty;
@property(nonatomic) BOOL refreshing;
@property(nonatomic) BOOL restorePending;
- (void)schedule;
- (void)flush;
@end

static char CSContextKey, CSStateKey, CSViewStateKey, CSOverridesKey, CSOriginKey, CSHeadOriginKey, CSDescriptorKey;
static NSHashTable *CSContexts;
static NSHashTable *CSInactiveScenes;
static BOOL CSAppInactive;
static CSMessageMergeConfiguration *CSConfig;
static BOOL CSCanPublish(CSMessageMergeContext *ctx) {
    if (CSAppInactive || UIApplication.sharedApplication.applicationState!=UIApplicationStateActive) return NO;
    UIScene *scene=ctx.table.window.windowScene;
    return !scene || (![CSInactiveScenes containsObject:scene] && scene.activationState==UISceneActivationStateForegroundActive);
}
static void CSSettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info);
static void CSInit(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSConfig = [[CSMessageMergeConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults];
        CSContexts = [NSHashTable weakObjectsHashTable];
        CSInactiveScenes=[NSHashTable weakObjectsHashTable];
        CSAppInactive=UIApplication.sharedApplication.applicationState!=UIApplicationStateActive;
        for (NSString *name in @[UIApplicationWillResignActiveNotification,UIApplicationDidEnterBackgroundNotification,
                                 UIApplicationDidBecomeActiveNotification,UISceneWillDeactivateNotification,UISceneDidActivateNotification]) {
            [NSNotificationCenter.defaultCenter addObserverForName:name object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) {
                if ([note.name isEqual:UIApplicationDidBecomeActiveNotification]) CSAppInactive=NO;
                else if ([note.name isEqual:UIApplicationWillResignActiveNotification] || [note.name isEqual:UIApplicationDidEnterBackgroundNotification]) CSAppInactive=YES;
                if (note.object && [note.name isEqual:UISceneWillDeactivateNotification]) [CSInactiveScenes addObject:note.object];
                if (note.object && [note.name isEqual:UISceneDidActivateNotification]) [CSInactiveScenes removeObject:note.object];
                for (CSMessageMergeContext *ctx in CSContexts) if (ctx.dirty && CSCanPublish(ctx)) [ctx schedule];
            }];
        }
        [NSNotificationCenter.defaultCenter addObserverForName:UIMenuControllerDidHideMenuNotification
            object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) {
                // WillHide may arrive while menuVisible is still true. Resume on the actual end event.
                for (CSMessageMergeContext *ctx in CSContexts) if (ctx.dirty) [ctx schedule];
            }];
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,CSSettingsChanged,
            (__bridge CFStringRef)CSMessageMergeSettingsNotification,NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
    });
}
static CSMessageMergeContext *CSContext(id owner, BOOL create) {
    if (!NSThread.isMainThread || !owner) return nil;
    CSInit();
    CSMessageMergeContext *ctx = objc_getAssociatedObject(owner,&CSContextKey);
    if (!ctx && create) {
        ctx = [CSMessageMergeContext new]; ctx.owner = owner; ctx.table = CSMessageNativeTable(owner);
        ctx.account = CSMessageCurrentAccount();
        ctx.session = CSString(CSMessageNativeObject(owner,@"getCurrentChatName"));
        if (!ctx.session.length) ctx.session = CSString(CSMessageNativeObject(CSMessageNativeObject(owner,@"GetContact"),@"m_nsUsrName"));
        ctx.config = CSConfig; ctx.epoch = 1; ctx.active = YES;
        objc_setAssociatedObject(owner,&CSContextKey,ctx,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [CSContexts addObject:ctx];
    }
    return ctx;
}
static BOOL CSSupported(id model) {
    // Exact classes: subclasses with extra dynamic content require explicit qualification.
    NSString *name = NSStringFromClass([CSParent(model) class]);
    static NSSet *classes;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ classes = [NSSet setWithArray:@[@"TextMessageViewModel",@"ImageMessageViewModel",@"VoiceMessageViewModel",@"VideoMessageViewModel",@"EmoticonMessageViewModel"]]; });
    return [classes containsObject:name];
}
#ifdef CS_MERGE_TESTING
NSUInteger CSMessageMergeDescriptorBuildCount;
#endif
static CSMessageMergeItem *CSItem(id node, CSMessageMergeContext *ctx) {
    BOOL eligible = CSSupported(node) && CSUInt(node,@"numberOfRowsInSection")==1 &&
        !CSMessageNativeObject(node,@"parentModel");
    id parent = CSParent(node), wrap = CSMessageNativeObject(parent,@"messageWrap");
    BOOL hasSender=wrap && [parent respondsToSelector:@selector(isSender)];
    eligible &= hasSender;
    BOOL outgoing=hasSender && CSBool(parent,@"isSender",NO);
    BOOL group = [ctx.session hasSuffix:@"@chatroom"];
    NSString *sender=hasSender ? (outgoing ? ctx.account : CSString(CSMessageNativeObject(wrap,group ? @"m_nsRealChatUsr" : @"m_nsFromUsr"))) : @"";
    if ([sender isEqual:ctx.session] && group) sender=@"";
    unsigned long long local=CSUInt(wrap?:node,@"m_uiMesLocalID"),server=local ? 0 : CSUInt(wrap?:node,@"m_n64MesSvrID");
    CSMessageMergeDescriptor *cached=objc_getAssociatedObject(node,&CSDescriptorKey);
    CSMessageMergeItem *item=cached.item;
    // Validate scalar identity and mutable sender/eligibility on every access. A pointer/count
    // cache alone misses equal-count replacements and in-place native model changes.
    if (cached && cached.localID==local && cached.serverID==server && item.eligible==eligible && item.outgoing==outgoing &&
        [item.account isEqual:ctx.account] && [item.session isEqual:ctx.session] && [item.sender isEqual:sender]) return item;
#ifdef CS_MERGE_TESTING
    CSMessageMergeDescriptorBuildCount++;
#endif
    item=[CSMessageMergeItem new]; item.account=ctx.account; item.session=ctx.session;
    item.identity=local ? [NSString stringWithFormat:@"l:%llu",local] : (server ? [NSString stringWithFormat:@"s:%llu",server] : @"");
    item.sender=sender;item.eligible=eligible;item.outgoing=outgoing;
    cached=[CSMessageMergeDescriptor new];cached.item=item;cached.localID=local;cached.serverID=server;
    objc_setAssociatedObject(node,&CSDescriptorKey,cached,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return item;
}
static CSMessageMergeState *CSState(id model) { return objc_getAssociatedObject(model,&CSStateKey); }
static void CSResetModel(CSMessageMergeState *state) {
    if (!state || CSMessageNativeObject(state.model,@"parentModel")) return; // Shared text cache is owned by the parent.
    state.resettingModel=YES;
    @try { CSVoid(state.model,@"resetLayoutCache"); }
    @finally { state.resettingModel=NO; }
}
static BOOL CSConfigEqual(CSMessageMergeConfiguration *a, CSMessageMergeConfiguration *b) {
    return a.enabled==b.enabled && a.scope==b.scope && a.avatarPosition==b.avatarPosition &&
        a.spacingMode==b.spacingMode && a.reservesAvatarTime==b.reservesAvatarTime && a.hasLargeTimeLabel==b.hasLargeTimeLabel;
}
static BOOL CSModelMetricsChanged(CSMessageMergeState *s);
static CSMessageMergeState *CSPrepareModel(CSMessageMergeContext *ctx, NSIndexPath *path) {
    NSArray *nodes = CSNodes(ctx.owner);
    if (path.section < 0 || (NSUInteger)path.section >= nodes.count || path.row < 0) return nil;
    id node = nodes[path.section], model = CSRowModel(node,path.row);
    if (!model) return nil;
    // Split rows share the parent's text/layout cache. Even resetting a child here can
    // invalidate content after WeChat has measured it, leaving an empty occupied row.
    BOOL singleRow=CSUInt(node,@"numberOfRowsInSection")==1 &&
        (model==node || (CSMessageNativeObject(model,@"parentModel")==node &&
         [NSStringFromClass([model class]) isEqual:@"TextMessageSubViewModel"]));
    if (!singleRow) {
        CSMessageMergeState *logical=CSState(node);
        if (logical.context==ctx) { logical.active=NO;logical.singleRow=NO;logical.appliedDelta=0;logical.needsLayout=NO; }
        CSMessageMergeState *old=CSState(model);
        if (old.context==ctx) { old.active=NO;old.singleRow=NO;old.needsLayout=NO;old.appliedDelta=0; }
        return nil; // Bind restores only overrides we own; never reset the native split model.
    }
    if (!ctx.config.enabled) {
        CSMessageMergeState *old = CSState(model);
        if (old.context == ctx && old.active) { old.active = NO; old.measurementDecided=NO; old.needsLayout = old.hasMeasuredHeight; CSResetModel(old); }
        return old.context == ctx ? old : nil;
    }
    BOOL group = [ctx.session hasSuffix:@"@chatroom"];
    CSMessageMergeItem *current = CSItem(node,ctx);
    BOOL active = [ctx.config appliesToGroup:group] && current.eligible && current.identity.length && ctx.account.length && ctx.session.length;
    CSMessageMergeDecision decision = {NO,NO,NO};
    if (active) decision = CSMessageMergeDecide(path.section ? CSItem(nodes[path.section-1],ctx) : nil,current,
        (NSUInteger)path.section+1 < nodes.count ? CSItem(nodes[path.section+1],ctx) : nil,ctx.config.avatarPosition);
    CSMessageMergeState *state = CSState(model);
    if (state.context && state.context != ctx && state.context.active) return nil;
    BOOL changed = !state || state.model != model || state.context != ctx || ![state.identity isEqual:current.identity] || state.active != active || state.singleRow != singleRow ||
        state.decision.hidesIdentity != decision.hidesIdentity || state.decision.joinsPrevious != decision.joinsPrevious ||
        state.decision.joinsNext != decision.joinsNext || state.group!=group || state.outgoing!=current.outgoing ||
        ![state.account isEqual:ctx.account] || ![state.session isEqual:ctx.session] ||
        !CSConfigEqual(state.configuration,ctx.config);
    BOOL metricsChanged=state.hasMeasuredHeight && state.epoch!=ctx.epoch && CSModelMetricsChanged(state);
    if (!state || state.model != model || state.context != ctx || ![state.identity isEqual:current.identity]) {
        state = [CSMessageMergeState new]; state.context = ctx; state.model = model; state.identity = current.identity;
        objc_setAssociatedObject(model,&CSStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (model!=node) objc_setAssociatedObject(node,&CSStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    state.active = active; state.group = group; state.decision = decision;
    state.singleRow = singleRow;state.outgoing=current.outgoing;
    state.epoch=ctx.epoch;state.account=ctx.account;state.session=ctx.session;state.configuration=ctx.config;
    if (changed || metricsChanged) {
        // A new row is measured by the native height request; it must not request a second
        // table transaction merely because it was first encountered while scrolling.
        state.needsLayout = state.hasMeasuredHeight;
        state.epoch=ctx.epoch;state.measurementDecided=NO;
        state.geometryRejected=NO;state.hasNativeGeometry=NO;state.hasBubbleInsets=NO;
        if (changed) CSResetModel(state);
    }
    return state;
}

void CSMessageMergePrepare(id controller, UITableView *table, NSIndexPath *path) {
    CSMessageMergeContext *ctx = CSContext(controller,YES);
    if (ctx.table != table || !ctx.active) return;
    CSPrepareModel(ctx,path);
}
CGFloat CSMessageMergeRowHeight(id controller, UITableView *table, NSIndexPath *path, CGFloat nativeHeight) {
    CSMessageMergeContext *ctx=CSContext(controller,NO);
    if (!ctx.active || ctx.table!=table) return nativeHeight;
    NSArray *nodes=CSNodes(controller);
    if (path.section<0 || (NSUInteger)path.section>=nodes.count) return nativeHeight;
    CSMessageMergeState *s=CSState(CSRowModel(nodes[path.section],path.row));
    if (s.context!=ctx || !s.singleRow) return nativeHeight;
    s.needsLayout=NO;s.hasMeasuredHeight=isfinite(nativeHeight) && nativeHeight>0;
    // The native model and its cached metrics remain native. Only this table boundary
    // projects the external spacing, exactly once for both cached and freshly measured rows.
    return CSMessageMergeMeasure(s.model,CGSizeMake(table.bounds.size.width,nativeHeight)).height;
}
void CSMessageMergeBind(id controller, UITableView *table, NSIndexPath *path, id cell) {
    CSMessageMergeContext *ctx = CSContext(controller,YES);
    if (ctx.table != table || !ctx.active) return;
    UIView *view = CSMessageNativeObject(cell,@"cellView");
    if (![view isKindOfClass:UIView.class]) return;
    CSMessageMergeState *state = CSPrepareModel(ctx,path);
    id actual = CSMessageNativeObject(view,@"viewModel");
    if (!state || actual != state.model) { CSMessageMergeReuse(view); return; }
    CSMessageMergeRestore(view);
    objc_setAssociatedObject(view,&CSViewStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSBubbleStyleApply(view);
    [view setNeedsLayout];
    if (ctx.dirty) [ctx schedule];
}
BOOL CSMessageMergeReadAppearance(id model, CSMessageMergeDecision *decision) {
    if (decision) *decision=(CSMessageMergeDecision){NO,NO,NO};
    if (!NSThread.isMainThread) return NO;
    CSMessageMergeState *s=CSState(model);
    if (!s || s.model!=model || !s.context.active || !s.context.config.enabled || !s.active || !s.singleRow ||
        ![s.identity isEqual:CSMessageNativeIdentity(model)]) return NO;
    if (decision) *decision=s.decision;
    return YES;
}
BOOL CSMessageMergeHidesName(id model) {
    if (!NSThread.isMainThread) return NO;
    CSMessageMergeState *s = CSState(model);
    // Multi-row layout has a separate parent/submodel protocol; don't mutate its metrics.
    return s.context.active && s.context.config.enabled && s.active && s.singleRow && s.group && s.decision.hidesIdentity;
}
static BOOL CSIsQuotedText(id model) {
    id wrap=CSMessageNativeObject(model,@"messageWrap");
    return [NSStringFromClass([model class]) isEqual:@"TextMessageViewModel"] && CSUInt(wrap,@"m_uiMessageType")==49 &&
        (CSUInt(wrap,@"m_uiAppMsgInnerType")==57 || CSBool(wrap,@"isReferMsgType",NO));
}
static BOOL CSReadSize(id model, NSString *name, CGSize *size) {
    SEL sel=NSSelectorFromString(name);
    NSMethodSignature *signature=[model methodSignatureForSelector:sel];
    if (signature.numberOfArguments!=2 || strcmp(signature.methodReturnType,@encode(CGSize))!=0) return NO;
    *size=((CGSize (*)(id,SEL))objc_msgSend)(model,sel);
    // WeChat 8.0.78 can return {0, positiveHeight}: width is unspecified here.
    // The spacing calculation uses height and the actual table width, not this width.
    // Still reject negative/non-finite dimensions and missing/non-positive height.
    return isfinite(size->width) && size->width>=0 && isfinite(size->height) && size->height>0;
}
static BOOL CSMeasuredContentSize(id model, CGSize *size) {
    if (!CSReadSize(model,@"contentViewSize",size)) return NO;
    if (!CSIsQuotedText(model)) return YES;
    // In 8.0.78 the reply is a separate view BELOW the text bubble. The native
    // CommonMessageViewModel measure: adds 4pt + replyTextSize.height + vertical
    // replyTextInset; TextMessageViewModel.contentViewSize does not include it.
    // Require the complete native metrics before compacting either quote seam.
    CGSize reply=CGSizeZero;
    if (!CSBool(model,@"canShowReplyMessage",NO) || !CSReadSize(model,@"replyTextSize",&reply)) return NO;
    SEL sel=NSSelectorFromString(@"replyTextInset");
    NSMethodSignature *signature=[model methodSignatureForSelector:sel];
    if (signature.numberOfArguments!=2 || strcmp(signature.methodReturnType,@encode(UIEdgeInsets))) return NO;
    UIEdgeInsets inset=((UIEdgeInsets (*)(id,SEL))objc_msgSend)(model,sel);
    if (!isfinite(inset.top) || !isfinite(inset.bottom) || !isfinite(inset.left) || !isfinite(inset.right) ||
        inset.top<0 || inset.bottom<0 || inset.left<0 || inset.right<0) return NO;
    size->height+=4+reply.height+inset.top+inset.bottom;
    size->width=MAX(size->width,reply.width+inset.left+inset.right);
    return isfinite(size->height) && isfinite(size->width);
}
static const NSUInteger CSVoiceTranscriptFlag=1UL<<12;
static const NSUInteger CSVoiceQuickTipFlag=1UL<<14;
static BOOL CSIsVoice(id model) {
    return [NSStringFromClass([model class]) isEqual:@"VoiceMessageViewModel"];
}
static NSUInteger CSAuxiliaryContentFlags(id model) {
    NSUInteger flags=0;
    // Most auxiliary layouts are not covered by the measured content rectangle.
    // The verified voice transcript is included in contentViewSize; retain its flag
    // as a vertical-layout input and qualify it separately in CSCanCompact.
    static SEL selectors[19];static dispatch_once_t once;
    dispatch_once(&once,^{
      NSUInteger index=0;
      for (NSString *name in @[@"isShowSourceView",@"shouldShowRoomTodoView",@"isShowAppMessageBlockButton",
                             @"canShowTranslateView",@"canShowTranslatedText",@"canShowTextTranslateView",
                             @"canShowTranslateLoadingView",@"bSolitaire",@"foldText",
                             @"canShowAutoTransButton",@"canShowAIReply",@"hasCommonTail",
                             @"canShowTranslateText",@"canShowTextTranslateText",@"bShowingQuickTranTips",
                             @"dialectFeedbackShowing",@"isRecordDetail",@"isShareConfirm",@"isCustAsstContext"])
          selectors[index++]=NSSelectorFromString(name);
    });
    for (NSUInteger i=0;i<sizeof(selectors)/sizeof(selectors[0]);i++)
        if (CSBoolSelector(model,selectors[i],NO)) flags|=(1UL<<i);
    // 8.0.78's quick-transcribe button is centered beside the voice body, with a
    // 20pt container and alpha-only show/hide. Its visibility is not a height input.
    // The actual cell child still participates in Render's overflow/transform guard.
    if ((flags&CSVoiceQuickTipFlag) && CSIsVoice(model)) flags&=~CSVoiceQuickTipFlag;
    id wrap=CSMessageNativeObject(model,@"messageWrap");
    if ((CSUInt(wrap,@"m_uiMessageType")==49 || CSBool(wrap,@"isReferMsgType",NO)) && !CSIsQuotedText(model)) flags|=(1UL<<30);
    return flags;
}
// Qualify first-pass geometry only for inspected native message implementations.
// 8.0.80 retains CommonMessageViewModel's top/name/reply metrics, the cell's
// separate avatar/content lanes, and VoiceMessageViewModel's complete transcript
// height (including its 4pt internal gap). Render still validates actual children.
// A published height/translation pair never shrinks from a later cell sample.
#ifdef CS_MERGE_TESTING
NSString *CSMessageMergeTestProfileVersion=@"8.0.78";
#endif
static BOOL CSNativeProfile(CSMessageMergeState *s, id logical, CGFloat *top, CGFloat *bottom) {
    if (!CSSupported(logical)) return NO;
    NSString *kind=NSStringFromClass([logical class]);
    BOOL usesTemplate=[kind isEqual:@"TextMessageViewModel"] || [kind isEqual:@"VoiceMessageViewModel"];
#ifdef CS_MERGE_TESTING
    NSString *version=CSMessageMergeTestProfileVersion;
#else
    NSString *version=NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
#endif
    BOOL qualified=[version isEqual:@"8.0.78"] || [version hasPrefix:@"8.0.78."] ||
        [version isEqual:@"8.0.80"] || [version hasPrefix:@"8.0.80."];
    if (!qualified) return NO;
    BOOL identity=!s.decision.hidesIdentity;
    BOOL named=s.group && !CSBool(logical,@"isSender",NO) && identity && CSBool(logical,@"isShowChatRoomDisplayName",YES);
    // Native origins, not UILabel height or an additive name budget. The avatar
    // extent is a conservative first-pass profile, never a substitute for validation.
    CGSize body=CGSizeZero;
    if (!CSReadSize(logical,@"contentViewSize",&body)) return NO;
    UIEdgeInsets insets={0,0,0,0};
    s.hasBubbleInsets=usesTemplate && CSBubbleStyleModelInsets(logical,s.context.table,body,&insets);s.bubbleInsets=insets;
    if (usesTemplate && !s.hasBubbleInsets) return NO; // Freeze a safe native fallback; never learn a late shrink.
    *top=named ? 0 : 8+s.bubbleInsets.top;
    // Voice contentViewSize already includes the complete transcription box and
    // its native 4pt internal gap. The lower edge is that box, not the voice bubble's
    // transparent inset; subtracting it would undercount the occupied height.
    BOOL hasLowerContent=CSIsQuotedText(logical) || ((s.auxiliaryFlags&CSVoiceTranscriptFlag) && CSIsVoice(logical));
    *bottom=(named ? 17 : 8)+s.contentHeight-(hasLowerContent ? 0 : s.bubbleInsets.bottom);
    if (identity) {
        if (!s.decision.joinsPrevious) *top=MIN(*top,named ? 3 : 8);
        if (!s.decision.joinsNext) *bottom=MAX(*bottom,(named ? 3 : 8)+38);
    }
    return *bottom<=s.nativeHeight;
}
static BOOL CSCanCompact(CSMessageMergeState *s, NSUInteger flags) {
    CSMessageMergeConfiguration *config=s.context.config;
    // Loading, secondary language translation and dialect controls remain guarded.
    // CSNativeProfile still restricts first-pass compaction to inspected versions.
    if ((flags&CSVoiceTranscriptFlag) && CSIsVoice(CSParent(s.model))) flags&=~CSVoiceTranscriptFlag;
    return config.spacingMode==CSMessageSpacingCompact && !s.geometryRejected && s.contentHeight>0 &&
        !(!s.decision.hidesIdentity && config.reservesAvatarTime) && !config.hasLargeTimeLabel &&
        !flags;
}
static BOOL CSModelMetricsChanged(CSMessageMergeState *s) {
    CGSize size=CGSizeZero;id logical=CSParent(s.model);
    BOOL valid=CSMeasuredContentSize(logical,&size) && size.width<=s.width+.5 && size.height<=s.nativeHeight;
    BOOL named=s.group && !CSBool(logical,@"isSender",NO) && !s.decision.hidesIdentity && CSBool(logical,@"isShowChatRoomDisplayName",YES);
    // A native cache reset may temporarily expose {0,0} before %orig measures.
    // That absence is not evidence of a smaller layout. The row-height boundary
    // validates the complete result after native measurement has finished.
    return (valid && (fabs(size.width-s.contentWidth)>.01 || fabs(size.height-s.contentHeight)>.01)) ||
        fabs(s.context.table.bounds.size.width-s.width)>.01 ||
        CSAuxiliaryContentFlags(logical)!=s.auxiliaryFlags || named!=s.showsName ||
        CSBubbleStyleIsDark(s.context.table)!=s.dark;
}
CGSize CSMessageMergeMeasure(id model, CGSize nativeSize) {
    if (!NSThread.isMainThread) return nativeSize;
    CSMessageMergeState *s=CSState(model);
    if (!s.context.active || !s.context.config.enabled || !s.active || !s.singleRow ||
        (!s.decision.joinsPrevious && !s.decision.joinsNext) ||
        !isfinite(nativeSize.height) || nativeSize.height<=0) return nativeSize;
    CGSize contentSize=CGSizeZero;
    id logical=CSParent(model);
    BOOL hasContent=CSMeasuredContentSize(logical,&contentSize) && contentSize.width<=nativeSize.width+.5 &&
        contentSize.height<=nativeSize.height;
    if (!hasContent) contentSize=CGSizeZero;
    NSUInteger flags=CSAuxiliaryContentFlags(logical);
    BOOL showsName=s.group && !CSBool(logical,@"isSender",NO) && !s.decision.hidesIdentity && CSBool(logical,@"isShowChatRoomDisplayName",YES);
    if (fabs(s.contentWidth-contentSize.width)>.01 || fabs(s.width-nativeSize.width)>.01 || fabs(s.nativeHeight-nativeSize.height)>.01 ||
        fabs(s.contentHeight-contentSize.height)>.01 || s.auxiliaryFlags!=flags || s.showsName!=showsName ||
        s.dark!=CSBubbleStyleIsDark(s.context.table)) {
        s.geometryRejected=NO;s.measurementDecided=NO;s.hasNativeGeometry=NO;
    }
    s.width=nativeSize.width;s.nativeHeight=nativeSize.height;s.contentHeight=contentSize.height;s.contentWidth=contentSize.width;
    s.auxiliaryFlags=flags;s.showsName=showsName;s.dark=CSBubbleStyleIsDark(s.context.table);
    if (!s.measurementDecided) {
        s.appliedDelta=0;s.appliedOriginDelta=0;
        CGFloat top=s.occupiedTop,bottom=s.occupiedBottom;
        if (CSCanCompact(s,flags) && (s.hasNativeGeometry || CSNativeProfile(s,logical,&top,&bottom))) {
            CSMessageMergeLayoutPlan plan=CSMessageMergePlanLayout(s.context.config.spacingMode,s.nativeHeight,
                top,bottom,s.decision.joinsPrevious,s.decision.joinsNext);
            if (plan.valid && (s.decision.hidesIdentity || plan.height>=38)) {
                s.appliedDelta=plan.height-s.nativeHeight;s.appliedOriginDelta=plan.originDelta;
                s.occupiedTop=top;s.occupiedBottom=bottom;s.hasNativeGeometry=YES;
            }
        }
        s.measurementDecided=YES;
    }
    nativeSize.height+=s.appliedDelta;
    return nativeSize;
}
void CSMessageMergeResetGeometry(id model) {
    // Native cache eviction is advisory. Measure validates actual dimensions; Render
    // validates safety. Keep the published pair and any rejection across no-op resets.
}
static void CSRestoreOrigin(UIView *view) {
    CSMessageOriginOverride *record=objc_getAssociatedObject(view,&CSOriginKey);
    if (!record) return;
    CGRect frame=view.frame;
    if (CGPointEqualToPoint(frame.origin,record.appliedOrigin)) {
        frame.origin=record.originalOrigin;view.frame=frame;
    }
    objc_setAssociatedObject(view,&CSOriginKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static void CSRestoreOrigins(UIView *view) {
    CSMessageOriginOverride *head=objc_getAssociatedObject(view,&CSHeadOriginKey);
    CSRestoreOrigin(head.view);
    objc_setAssociatedObject(view,&CSHeadOriginKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSRestoreOrigin(view);
}
void CSMessageMergeRestore(UIView *view) {
    if (!NSThread.isMainThread) return;
    CSRestoreOrigins(view);
    NSArray<CSMessageViewOverride *> *overrides = objc_getAssociatedObject(view,&CSOverridesKey);
    for (CSMessageViewOverride *record in overrides) {
        // Only hidden is owned here; never override alpha/transform from native animations.
        if (record.view.hidden) record.view.hidden = record.hidden;
    }
    objc_setAssociatedObject(view,&CSOverridesKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static UIView *CSIvarView(UIView *view, const char *name) {
    Ivar ivar = class_getInstanceVariable(view.class,name);
    if (!ivar || ivar_getTypeEncoding(ivar)[0] != '@') return nil;
    id value = object_getIvar(view,ivar);
    return [value isKindOfClass:UIView.class] ? value : nil;
}
static BOOL CSIsNativeVoiceGlyphMirror(UIView *cell, UIView *child, id model) {
    // 8.0.78 mirrors the outgoing VoicePlayingView horizontally, including idle
    // messages. This preserves its occupied rectangle and is not a layout error.
    // Qualify the exact native slot and transform; keep all other transforms on
    // the safety path. The caller still measures this child's converted bounds.
    CGAffineTransform t=child.transform;
    return t.a==-1 && t.b==0 && t.c==0 && t.d==1 && t.tx==0 && t.ty==0 &&
        [NSStringFromClass([model class]) isEqual:@"VoiceMessageViewModel"] &&
        child==CSIvarView(cell,"m_playingImageView");
}
static void CSHide(UIView *view, NSMutableArray *records) {
    if (!view || view.hidden) return;
    CSMessageViewOverride *record = [CSMessageViewOverride new]; record.view = view; record.hidden = view.hidden;
    [records addObject:record]; view.hidden = YES;
}
void CSMessageMergeRender(UIView *view) {
    if (!NSThread.isMainThread) return;
    CSRestoreOrigins(view);
    CSBubbleStyleApply(view);
    CSMessageMergeState *s = objc_getAssociatedObject(view,&CSViewStateKey);
    id model = CSMessageNativeObject(view,@"viewModel");
    if (s.model != model || !s.context.active || !s.context.config.enabled || !s.active) { CSMessageMergeRestore(view); CSVoid(view,@"cs_messageTimeLayout"); return; }
    NSMutableArray *records = [objc_getAssociatedObject(view,&CSOverridesKey) mutableCopy] ?: [NSMutableArray array];
    if (s.decision.hidesIdentity) {
        CSHide(CSMessageNativeObject(view,@"getHeadImageView"),records);
        if (s.group) for (NSString *name in @[@"m_chatRoomNameLabel",@"m_chatRoomDescLabel",@"m_chatRoomTextStateView"])
            CSHide(CSIvarView(view,name.UTF8String),records);
    }
    if (records.count) objc_setAssociatedObject(view,&CSOverridesKey,records,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CSVoid(view,@"cs_messageTimeLayout");
    if (!s.singleRow || s.nativeHeight<=0 || (!s.decision.joinsPrevious && !s.decision.joinsNext)) return;
    BOOL transformed=!CGAffineTransformIsIdentity(view.transform);
    if (!CSCanCompact(s,CSAuxiliaryContentFlags(CSParent(model))) || transformed) {
        if (s.appliedDelta<0 && !s.geometryRejected) {
            s.geometryRejected=YES;s.hasNativeGeometry=NO;s.measurementDecided=NO;
            s.needsLayout=YES;[s.context schedule];
        }
        return;
    }
    CGFloat plannedHeight=s.nativeHeight+s.appliedDelta;
    if (view.bounds.size.height<=0 || !isfinite(plannedHeight)) return;
    CGFloat bottom=0,top=CGFLOAT_MAX;BOOL geometryValid=YES;
    UIView *bubble=CSMessageNativeObject(view,@"getBgImageView");
    UIView *head=CSMessageNativeObject(view,@"getHeadImageView");
    UIView *container=CSMessageNativeObject(view,@"getContentView");
    // BaseMessageCellView owns m_contentView; backgrounds and reply views live
    // in that container, while the avatar is on the cell in 8.0.78. Its full bounds
    // are not visible content. Inspect this known level, never a recursive tree.
    BOOL hasContainer=[container isKindOfClass:UIView.class] && container!=bubble &&
        container!=view && container.superview==view && !container.hidden && container.alpha>.01;
    if (hasContainer && !CGAffineTransformIsIdentity(container.transform)) geometryValid=NO;
    // The standard avatar occupies a different horizontal lane. Keep it wholly
    // inside the row without charging its transparent-free height to the bubble seam.
    // In 8.0.78 the avatar is a direct child of the cell, while the text/voice
    // background lives in m_contentView. Their local frames are incomparable.
    // Only accept the two known parents, then compare the separate lanes in
    // cell coordinates; unrelated or transformed hierarchies keep the safety path.
    BOOL headKnown=[head isKindOfClass:UIView.class] &&
        (head.superview==view || (hasContainer && head.superview==container));
    BOOL bubbleKnown=[bubble isKindOfClass:UIView.class] &&
        (bubble.superview==view || (hasContainer && bubble.superview==container));
    BOOL canPlaceHead=headKnown && bubbleKnown && !head.hidden &&
        CGAffineTransformIsIdentity(head.transform) && CGAffineTransformIsIdentity(bubble.transform) &&
        !CGRectIsEmpty(head.bounds) && !CGRectIsEmpty(bubble.bounds) &&
        head.bounds.size.height<=38.01 && head.bounds.size.height<=plannedHeight;
    if (canPlaceHead) {
        CGRect headRect=[view convertRect:head.bounds fromView:head];
        CGRect bubbleRect=[view convertRect:bubble.bounds fromView:bubble];
        canPlaceHead=isfinite(CGRectGetMinX(headRect)) && isfinite(CGRectGetMaxX(headRect)) &&
            isfinite(CGRectGetMinX(bubbleRect)) && isfinite(CGRectGetMaxX(bubbleRect)) &&
            (CGRectGetMaxX(headRect)<=CGRectGetMinX(bubbleRect) || CGRectGetMaxX(bubbleRect)<=CGRectGetMinX(headRect));
    }
    UIEdgeInsets insets={0,0,0,0};
    BOOL visibleInsets=s.hasBubbleInsets;
    if (visibleInsets) insets=s.bubbleInsets;
    for (NSUInteger level=0;level<2 && geometryValid;level++) {
      NSArray *children=level ? (hasContainer ? container.subviews : nil) : view.subviews;
      for (UIView *child in children) {
        if (!level && hasContainer && child==container) continue;
        if (child.hidden || child.alpha<=.01 || CGRectIsEmpty(child.bounds)) continue;
        if (!CGAffineTransformIsIdentity(child.transform) && !CSIsNativeVoiceGlyphMirror(view,child,model)) {
            geometryValid=NO;break;
        }
        CGRect bounds=child.bounds;
        if (child==bubble && visibleInsets && insets.top+insets.bottom<bounds.size.height) {
            bounds.origin.y+=insets.top;bounds.size.height-=insets.top+insets.bottom;
        }
        CGRect rect=[view convertRect:bounds fromView:child];
        if (!isfinite(CGRectGetMaxY(rect)) || !isfinite(CGRectGetMinY(rect))) { geometryValid=NO;break; }
        if (child!=head || !canPlaceHead || !s.decision.joinsPrevious)
            top=MIN(top,view.frame.origin.y+CGRectGetMinY(rect)-view.bounds.origin.y);
        if (child!=head || !canPlaceHead || !s.decision.joinsNext)
            bottom=MAX(bottom,view.frame.origin.y+CGRectGetMaxY(rect)-view.bounds.origin.y);
      }
    }
    CSMessageMergeLayoutPlan actual=CSMessageMergePlanLayout(s.context.config.spacingMode,s.nativeHeight,
        top,bottom,s.decision.joinsPrevious,s.decision.joinsNext);
    if (!geometryValid || !actual.valid) {
        // An unknown/overflowing native child is never clipped to a guessed footprint.
        if (s.appliedDelta<0 && !s.geometryRejected) {
            s.geometryRejected=YES;s.hasNativeGeometry=NO;s.measurementDecided=NO;
            s.needsLayout=YES;[s.context schedule];
        }
        return;
    }
    // Keep a monotonic safety envelope. A smaller body, lazy highlight, or another
    // layout pass must never replace the height/translation pair already in the table.
    if (s.hasNativeGeometry && (top<s.occupiedTop-.01 || bottom>s.occupiedBottom+.01)) {
        CGFloat safeTop=MIN(top,s.occupiedTop),safeBottom=MAX(bottom,s.occupiedBottom);
        CSMessageMergeLayoutPlan safe=CSMessageMergePlanLayout(s.context.config.spacingMode,s.nativeHeight,
            safeTop,safeBottom,s.decision.joinsPrevious,s.decision.joinsNext);
        if (safe.valid && safe.height>plannedHeight+.01) {
            s.occupiedTop=safeTop;s.occupiedBottom=safeBottom;s.measurementDecided=NO;
            s.needsLayout=YES;[s.context schedule];
        }
    }
    if (s.appliedDelta>=0) return;
    if (canPlaceHead) {
        CGRect frame=head.frame;
        CGRect rect=[view convertRect:head.bounds fromView:head];
        CGFloat projectedTop=view.frame.origin.y+s.appliedOriginDelta+CGRectGetMinY(rect)-view.bounds.origin.y;
        CGFloat y=MAX(0,MIN(projectedTop,plannedHeight-head.bounds.size.height));
        if (fabs(y-projectedTop)>.01) {
            CSMessageOriginOverride *record=[CSMessageOriginOverride new];record.view=head;
            record.originalOrigin=frame.origin;frame.origin.y+=y-projectedTop;record.appliedOrigin=frame.origin;
            objc_setAssociatedObject(head,&CSOriginKey,record,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            objc_setAssociatedObject(view,&CSHeadOriginKey,record,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            head.frame=frame;
        }
    }
    if (s.appliedOriginDelta==0) return;
    CGRect frame=view.frame;
    CSMessageOriginOverride *record=[CSMessageOriginOverride new];
    record.originalOrigin=frame.origin;frame.origin.y+=s.appliedOriginDelta;record.appliedOrigin=frame.origin;
    objc_setAssociatedObject(view,&CSOriginKey,record,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    view.frame=frame;
}

void CSMessageMergeReuse(UIView *view) {
    CSMessageMergeRestore(view);
    objc_setAssociatedObject(view,&CSViewStateKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@implementation CSMessageMergeContext
- (void)schedule {
    if (!self.config.enabled && !self.restorePending) return;
    self.dirty = YES;
    if (self.scheduled || !self.active || !CSCanPublish(self) || self.mutationDepth || self.refreshing) return;
    self.scheduled = YES;
    __weak CSMessageMergeContext *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{ CSMessageMergeContext *ctx = weakSelf; ctx.scheduled = NO; [ctx flush]; });
}
- (void)flush {
    UITableView *table = self.table;
    if (!self.dirty || !self.active || !CSCanPublish(self) || !table.window || self.mutationDepth || self.refreshing) return;
    if (table.dragging || table.decelerating || table.editing || table.hasUncommittedUpdates ||
        UIMenuController.sharedMenuController.menuVisible || CSBool(self.owner,@"isBeingDismissed",NO)) return;
    self.dirty = NO; self.refreshing = YES;
    @try {
        NSArray<NSIndexPath *> *paths = [table.indexPathsForVisibleRows sortedArrayUsingSelector:@selector(compare:)];
        NSIndexPath *anchor = paths.firstObject;
        NSString *anchorID = nil;
        CGFloat anchorOffset = 0;
        if (anchor) {
            NSArray *nodes = CSNodes(self.owner);
            if ((NSUInteger)anchor.section < nodes.count) anchorID = CSMessageNativeIdentity(nodes[anchor.section]);
            anchorOffset = [table rectForRowAtIndexPath:anchor].origin.y - table.contentOffset.y;
        }
        // User/native navigation owns scrolling; see CSMessageNavigation.
        BOOL navigating = CSMessageNavigationIsActive(self.owner);
        BOOL changed = NO;
        for (NSIndexPath *path in paths) {
            CSMessageMergeState *s = CSPrepareModel(self,path);
            // Native insert/delete/replace may already have consumed the height work.
            // Appearance must still refresh the visible neighbors without another row update.
            id visibleCell=[table cellForRowAtIndexPath:path];
            UIView *visibleView=CSMessageNativeObject(visibleCell,@"cellView");
            if ([visibleView isKindOfClass:UIView.class]) CSBubbleStyleApply(visibleView);
            if (!s.needsLayout) continue;
            changed = YES; s.needsLayout = NO;
            CSResetModel(s);
            id cell = [table cellForRowAtIndexPath:path];
            CSMessageMergeBind(self.owner,table,path,cell);
            UIView *view = CSMessageNativeObject(cell,@"cellView");
            if (!CSMessageNativeObject(s.model,@"parentModel")) CSVoid(view,@"resetLayoutCache");
            [view setNeedsLayout];
        }
        if (changed) [UIView performWithoutAnimation:^{ [table beginUpdates]; [table endUpdates]; [table layoutIfNeeded]; }];
        // Only correct plugin-induced height changes; never force bottom on new messages.
        NSArray *nodes = CSNodes(self.owner);
        if (changed && !navigating && anchorID.length && (NSUInteger)anchor.section < nodes.count &&
            [anchorID isEqual:CSMessageNativeIdentity(nodes[anchor.section])] && !table.dragging) {
            CGFloat y = [table rectForRowAtIndexPath:anchor].origin.y - anchorOffset;
            CGFloat minY = -table.adjustedContentInset.top;
            CGFloat maxY = MAX(minY,table.contentSize.height-table.bounds.size.height+table.adjustedContentInset.bottom);
            if (isfinite(y)) [table setContentOffset:CGPointMake(table.contentOffset.x,MAX(minY,MIN(maxY,y))) animated:NO];
        }
    } @finally { self.refreshing = NO; self.restorePending = NO; }
    if (self.dirty) [self schedule];
    CSMessageNavigationLayoutReady(self.owner);
}
@end

void CSMessageMergeActivate(id controller) {
    CSMessageMergeContext *ctx = CSContext(controller,YES);
    if (!ctx) return;
    ctx.active=YES;ctx.table=CSMessageNativeTable(controller);
    NSString *account=CSMessageCurrentAccount();
    NSString *session=CSString(CSMessageNativeObject(controller,@"getCurrentChatName"));
    CSMessageMergeConfiguration *latest=[[CSMessageMergeConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults];
    BOOL contextChanged=![ctx.account isEqual:account] || (session.length && ![ctx.session isEqual:session]);
    BOOL changed=contextChanged || !CSConfigEqual(ctx.config,latest);
    ctx.restorePending |= ctx.config.enabled && !latest.enabled;
    ctx.account=account;if (session.length) ctx.session=session;
    ctx.config=latest;
    if (changed) { ctx.epoch++;[ctx schedule]; }
    else if (ctx.dirty) [ctx schedule];
}
void CSMessageMergeDeactivate(id controller) { CSMessageMergeContext *ctx = CSContext(controller,NO); ctx.active = NO; }
void CSMessageMergeWillMutate(id controller) {
    CSMessageMergeContext *ctx = CSContext(controller,NO);
    if (!ctx) return;
    ctx.mutationDepth++;
}
void CSMessageMergeInvalidateLayout(id controller) { CSMessageMergeContext *ctx = CSContext(controller,NO); ctx.epoch++; }
void CSMessageMergeDidMutate(id controller) {
    CSMessageNavigationLayoutReady(controller);
    CSMessageMergeContext *ctx = CSContext(controller,NO);
    if (!ctx) return;
    if (ctx.mutationDepth) ctx.mutationDepth--;
    [ctx schedule];
}
void CSMessageMergeFlush(id controller) { [CSContext(controller,NO) flush]; }
static void CSSettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    dispatch_async(dispatch_get_main_queue(), ^{
        CSConfig = [[CSMessageMergeConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults];
        for (CSMessageMergeContext *ctx in CSContexts) {
            if (CSConfigEqual(ctx.config,CSConfig)) continue;
            ctx.restorePending |= ctx.config.enabled && !CSConfig.enabled;
            ctx.config=CSConfig;ctx.epoch++;[ctx schedule];
        }
    });
}

BOOL CSMessageMergeLayoutSettled(id controller) {
    CSMessageMergeContext *ctx=CSContext(controller,NO);
    return !ctx || ((!ctx.config.enabled && !ctx.restorePending) || (!ctx.dirty && !ctx.refreshing && !ctx.mutationDepth));
}
