#import "CSMessageMergeAdapter.h"
#import "CSMessageMergePolicy.h"
#import "CSMessageNavigation.h"
#import "CSChatDiagnostics.h"
#import <objc/runtime.h>
#import <objc/message.h>
#include <math.h>

// All private dispatch is signature checked. Dumped headers do not prove runtime inheritance.
static Method CSGetter(id object, SEL selector) {
    if (!object) return NULL;
    Method method = class_getInstanceMethod(object_getClass(object),selector);
    return method && method_getNumberOfArguments(method) == 2 ? method : NULL;
}
static BOOL CSBool(id object, NSString *name, BOOL fallback) {
    SEL sel = NSSelectorFromString(name);
    Method method = CSGetter(object,sel);
    if (!method) return fallback;
    char type = method_getTypeEncoding(method)[0];
    if (type != 'B' && type != 'c') return fallback;
    return ((BOOL (*)(id, SEL))objc_msgSend)(object, sel);
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
@property(nonatomic) CGFloat contentHeight;
@property(nonatomic) CGFloat contentWidth;
@end
@implementation CSMessageMergeState @end

@interface CSMessageViewOverride : NSObject
@property(nonatomic, weak) UIView *view;
@property(nonatomic) BOOL hidden;
@end
@implementation CSMessageViewOverride @end

@interface CSMessageOriginOverride : NSObject
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

static char CSContextKey, CSStateKey, CSViewStateKey, CSOverridesKey, CSOriginKey;
static NSHashTable *CSContexts;
static CSMessageMergeConfiguration *CSConfig;
static void CSSettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info);
static void CSInit(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSConfig = [[CSMessageMergeConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults];
        CSContexts = [NSHashTable weakObjectsHashTable];
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
static CSMessageMergeItem *CSItem(id node, CSMessageMergeContext *ctx) {
    CSMessageMergeItem *item = [CSMessageMergeItem new];
    item.account = ctx.account; item.session = ctx.session; item.identity = CSMessageNativeIdentity(node);
    item.eligible = CSSupported(node) && CSUInt(node,@"numberOfRowsInSection")==1 &&
        !CSMessageNativeObject(node,@"parentModel");
    id parent = CSParent(node), wrap = CSMessageNativeObject(parent,@"messageWrap");
    if (!wrap || ![parent respondsToSelector:@selector(isSender)]) { item.eligible = NO; return item; }
    item.outgoing = CSBool(parent,@"isSender",NO);
    BOOL group = [ctx.session hasSuffix:@"@chatroom"];
    item.sender = item.outgoing ? ctx.account : CSString(CSMessageNativeObject(wrap,group ? @"m_nsRealChatUsr" : @"m_nsFromUsr"));
    if ([item.sender isEqual:ctx.session] && group) item.sender = @"";
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
        state.decision.hidesIdentity != decision.hidesIdentity || state.decision.joinsNext != decision.joinsNext || state.epoch != ctx.epoch;
    if (!state || state.model != model || state.context != ctx || ![state.identity isEqual:current.identity]) {
        state = [CSMessageMergeState new]; state.context = ctx; state.model = model; state.identity = current.identity;
        objc_setAssociatedObject(model,&CSStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (model!=node) objc_setAssociatedObject(node,&CSStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    state.active = active; state.group = group; state.decision = decision;
    state.singleRow = singleRow;
    if (changed) {
        // A new row is measured by the native height request; it must not request a second
        // table transaction merely because it was first encountered while scrolling.
        state.needsLayout = state.hasMeasuredHeight;
        state.epoch=ctx.epoch;state.measurementDecided=NO;
        state.geometryRejected=NO;state.appliedDelta=0;
        CSResetModel(state);
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
    [view setNeedsLayout];
    if (ctx.dirty) [ctx schedule];
}
BOOL CSMessageMergeHidesName(id model) {
    if (!NSThread.isMainThread) return NO;
    CSMessageMergeState *s = CSState(model);
    // Multi-row layout has a separate parent/submodel protocol; don't mutate its metrics.
    return s.context.active && s.context.config.enabled && s.active && s.singleRow && s.group && s.decision.hidesIdentity;
}
static BOOL CSMeasuredContentSize(id model, CGSize *size) {
    SEL sel=NSSelectorFromString(@"contentViewSize");
    NSMethodSignature *signature=[model methodSignatureForSelector:sel];
    if (signature.numberOfArguments!=2 || strcmp(signature.methodReturnType,@encode(CGSize))!=0) return NO;
    *size=((CGSize (*)(id,SEL))objc_msgSend)(model,sel);
    // WeChat 8.0.78 can return {0, positiveHeight}: width is unspecified here.
    // The spacing calculation uses height and the actual table width, not this width.
    // Still reject negative/non-finite dimensions and missing/non-positive height.
    return isfinite(size->width) && size->width>=0 && isfinite(size->height) && size->height>0;
}
static NSUInteger CSAuxiliaryContentFlags(id model) {
    NSUInteger flags=0,index=0;
    // These layouts have content outside the core bubble's measured rectangle. Never
    // treat contentViewSize as their complete occupied bounds.
    for (NSString *name in @[@"isShowSourceView",@"shouldShowRoomTodoView",@"isShowAppMessageBlockButton",
                             @"canShowTranslateView",@"canShowTranslatedText",@"canShowTextTranslateView",
                             @"canShowTranslateLoadingView",@"bSolitaire",@"foldText"])
        { if (CSBool(model,name,NO)) flags|=(1UL<<index); index++; }
    id wrap=CSMessageNativeObject(model,@"messageWrap");
    if (CSUInt(wrap,@"m_uiMessageType")==49 || CSBool(wrap,@"isReferMsgType",NO)) flags|=(1UL<<10);
    return flags;
}
CGSize CSMessageMergeMeasure(id model, CGSize nativeSize) {
    if (!NSThread.isMainThread) return nativeSize;
    CSMessageMergeState *s = CSState(model);
    if (!s.context.active || !s.context.config.enabled || !s.active || !s.singleRow || !s.decision.joinsNext ||
        !isfinite(nativeSize.height) || nativeSize.height <= 0) return nativeSize;
    CGSize contentSize=CGSizeZero;
    id logical=CSParent(model);
    BOOL hasContent=CSMeasuredContentSize(logical,&contentSize) && contentSize.width<=nativeSize.width+.5 &&
        contentSize.height<=nativeSize.height;
    CGSize diagnosticContentSize=contentSize;
    if (!hasContent) contentSize=CGSizeZero;
    if (fabs(s.contentWidth-contentSize.width)>.5 || fabs(s.width-nativeSize.width)>.5 || fabs(s.nativeHeight-nativeSize.height)>.5 ||
        fabs(s.contentHeight-contentSize.height)>.5) {
        s.geometryRejected=NO;s.measurementDecided=NO;
    }
    s.width=nativeSize.width;s.nativeHeight=nativeSize.height;s.contentHeight=contentSize.height;s.contentWidth=contentSize.width;
    if (!s.measurementDecided) {
        CSMessageMergeConfiguration *config=s.context.config;
        BOOL identity=!s.decision.hidesIdentity;
        NSUInteger blockers=(!hasContent ? 1 : 0) | (s.geometryRejected ? 2 : 0) |
            (identity && config.reservesAvatarTime ? 4 : 0) | (config.hasLargeTimeLabel ? 8 : 0) |
            (CSAuxiliaryContentFlags(logical)<<8);
        BOOL canCompact=blockers==0;
        // Native name visibility has already been decided by isShowChatRoomDisplayName.
        // 8.0.78.34 geometry evidence: the named row spans [0,55] for 38pt content.
        // Its occupied leading span is 17pt; unlike an unnamed row it starts at zero.
        // Plan 17pt leading + content + 2pt bottom. The policy already includes 4pt
        // edges, so the additional budget is 17-2=15pt. Native row height differences
        // alone cannot supply this budget: named/unnamed rows use different padding.
        // This profile is not a measured UILabel height. Render still validates all
        // actual bounds; measurement never depends on neighbour/display order.
        const double groupNameIncrement=15;
        double nameHeight=s.group && identity && CSBool(logical,@"isShowChatRoomDisplayName",YES) ? groupNameIncrement : 0;
        s.appliedDelta=CSMessageMergePlannedDelta(config.spacingMode,nativeSize.height,
            canCompact ? contentSize.height : 0,identity ? 44 : 0,nameHeight);
        s.measurementDecided=YES;
        if (config.spacingMode==CSMessageSpacingCompact) {
            CSChatRecordEvent(@"merge",s.appliedDelta<0 ? @"compact-height-applied" : @"compact-height-protected");
            CSChatRecordMergeMeasurement(nativeSize.height,diagnosticContentSize.width,diagnosticContentSize.height,s.appliedDelta,blockers);
        }
    }
    nativeSize.height+=s.appliedDelta;
    return nativeSize;
}
void CSMessageMergeResetGeometry(id model) {
    if (!NSThread.isMainThread) return;
    CSMessageMergeState *s = CSState(model);
    if (!s.resettingModel && !s.context.refreshing) {
        s.nativeHeight=0;s.contentHeight=0;s.contentWidth=0;s.geometryRejected=NO;s.measurementDecided=NO;
        s.appliedDelta=0;
    }
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
void CSMessageMergeRestore(UIView *view) {
    if (!NSThread.isMainThread) return;
    CSRestoreOrigin(view);
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
static void CSRecordGeometryParts(UIView *view) {
    if (![NSUserDefaults.standardUserDefaults boolForKey:CSChatDiagnosticsEnabledKey]) return;
    id head=CSMessageNativeObject(view,@"getHeadImageView");
    id content=CSMessageNativeObject(view,@"getContentView");
    id bubble=CSMessageNativeObject(view,@"getBgImageView");
    UIView *name=CSIvarView(view,"m_chatRoomNameLabel");
    UIView *desc=CSIvarView(view,"m_chatRoomDescLabel");
    UIView *state=CSIvarView(view,"m_chatRoomTextStateView");
    NSUInteger count=0;
    // Only on a rejected layout; cap diagnostic work, never log text or identities.
    for (UIView *child in view.subviews) {
        if (child.hidden || child.alpha<=.01 || CGRectIsEmpty(child.bounds)) continue;
        if (count++==12) break;
        NSUInteger role=(child==head ? 1 : 0) | (child==name ? 2 : 0) |
            (child==desc ? 4 : 0) | (child==state ? 8 : 0) |
            (child==content ? 16 : 0) | (child==bubble ? 32 : 0);
        CGRect rect=[view convertRect:child.bounds fromView:child];
        CSChatRecordMergePart(role,view.frame.origin.y+CGRectGetMinY(rect)-view.bounds.origin.y,
            view.frame.origin.y+CGRectGetMaxY(rect)-view.bounds.origin.y);
    }
}
static void CSHide(UIView *view, NSMutableArray *records) {
    if (!view || view.hidden) return;
    CSMessageViewOverride *record = [CSMessageViewOverride new]; record.view = view; record.hidden = view.hidden;
    [records addObject:record]; view.hidden = YES;
}
void CSMessageMergeRender(UIView *view) {
    if (!NSThread.isMainThread) return;
    CSRestoreOrigin(view);
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
    if (!s.singleRow || s.appliedDelta>=0 || s.nativeHeight<=0 || s.geometryRejected ||
        !CGAffineTransformIsIdentity(view.transform)) return;
    // Rendering consumes the measured row height; it never learns a new spacing value.
    // Validate all direct occupied children, including plugin time/status views. A violated
    // private-layout contract restores space once rather than clipping unknown content.
    CGFloat plannedHeight=s.nativeHeight+s.appliedDelta;
    if (view.bounds.size.height<=0 || !isfinite(plannedHeight)) return;
    CGFloat bottom=0,top=CGFLOAT_MAX;BOOL geometryValid=YES;
    for (UIView *child in view.subviews) {
        if (child.hidden || child.alpha<=.01 || CGRectIsEmpty(child.bounds)) continue;
        if (!CGAffineTransformIsIdentity(child.transform)) { geometryValid=NO;break; }
        CGRect rect=[view convertRect:child.bounds fromView:child];
        if (!isfinite(CGRectGetMaxY(rect)) || !isfinite(CGRectGetMinY(rect))) { geometryValid=NO;break; }
        top=MIN(top,view.frame.origin.y+CGRectGetMinY(rect)-view.bounds.origin.y);
        bottom=MAX(bottom,view.frame.origin.y+CGRectGetMaxY(rect)-view.bounds.origin.y);
    }
    // Native coordinates and hit testing stay together: translate the entire cell view
    // without changing its size, child frames, transforms, or native gesture rectangles.
    CGFloat shift=MAX(0,bottom+2-plannedHeight);
    if (geometryValid && shift>0 && shift<=MAX(0,top-2)) {
        CGRect frame=view.frame;
        CSMessageOriginOverride *record=[CSMessageOriginOverride new];
        record.originalOrigin=frame.origin;frame.origin.y-=shift;record.appliedOrigin=frame.origin;
        objc_setAssociatedObject(view,&CSOriginKey,record,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        view.frame=frame;
        return;
    }
    if (!geometryValid || bottom+2>plannedHeight+.5) {
        s.geometryRejected=YES;s.measurementDecided=NO;s.needsLayout=YES;
        CSChatRecordEvent(@"merge",@"native-layout-contract-fallback");
        CSChatRecordMergeGeometry(plannedHeight,top,bottom);
        CSRecordGeometryParts(view);
        [s.context schedule];
    }
}
void CSMessageMergeReuse(UIView *view) {
    CSMessageMergeRestore(view);
    objc_setAssociatedObject(view,&CSViewStateKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@implementation CSMessageMergeContext
- (void)schedule {
    if (!self.config.enabled && !self.restorePending) return;
    self.dirty = YES;
    if (self.scheduled || !self.active || self.mutationDepth || self.refreshing) return;
    self.scheduled = YES;
    __weak CSMessageMergeContext *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{ CSMessageMergeContext *ctx = weakSelf; ctx.scheduled = NO; [ctx flush]; });
}
- (void)flush {
    UITableView *table = self.table;
    if (!self.dirty || !self.active || !table.window || self.mutationDepth || self.refreshing) return;
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
