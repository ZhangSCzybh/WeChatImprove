#import "CSMessageActionMenuAdapter.h"
#import <objc/runtime.h>
#import <TargetConditionals.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#endif
@interface NSObject (CSNativeMenuConstruction)
- (SEL)action;
- (instancetype)initWithTitle:(NSString *)title icon:(id)icon target:(id)target action:(SEL)action;
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
@interface CSMessageMenuInvocation : NSObject
@property(nonatomic, strong) CSMessageActionContext *context;
@property(nonatomic) CSMessageAction pluginAction;
@property(nonatomic) CSMessageActionEntry entry;
@property(nonatomic, strong) CSMessageActionCoordinator *coordinator;
- (void)cs_handleRepeatMenuItem:(id)sender;
- (void)cs_handleVoiceForwardMenuItem:(id)sender;
- (void)cs_handleAddStickerMenuItem:(id)sender;
@end
@implementation CSMessageMenuInvocation
- (void)invoke {
    [_coordinator executeContext:_context action:_pluginAction entry:_entry];
}
- (void)cs_handleRepeatMenuItem:(id)sender { (void)sender; [self invoke]; }
- (void)cs_handleVoiceForwardMenuItem:(id)sender { (void)sender; [self invoke]; }
- (void)cs_handleAddStickerMenuItem:(id)sender { (void)sender; [self invoke]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender { (void)action; (void)sender; return [_coordinator canExecuteContext:_context action:_pluginAction entry:_entry]; }
@end
@interface CSMessageActionMenuAdapter ()
@property(nonatomic, strong) CSMessageActionCoordinator *coordinator;
@end
@implementation CSMessageActionMenuAdapter
- (instancetype)initWithCoordinator:(CSMessageActionCoordinator *)coordinator { if ((self=[super init])) _coordinator=coordinator; return self; }
+ (instancetype)sharedAdapter { static CSMessageActionMenuAdapter *adapter; static dispatch_once_t once; dispatch_once(&once,^{ adapter=[[self alloc] initWithCoordinator:CSMessageActionCoordinator.sharedCoordinator]; }); return adapter; }
+ (NSArray *)itemsByAddingActionsForCell:(id)cell items:(NSArray *)items { return [[self sharedAdapter] itemsByAddingActionsForCell:cell items:items]; }
+ (id)itemsBeforeNativeDedupForCell:(id)cell items:(id)items { return [[self sharedAdapter] itemsBeforeNativeDedupForCell:cell items:items]; }
- (id)itemsBeforeNativeDedupForCell:(id)cell items:(id)items {
    if (!self.coordinator.settings.repeatEnabled || ![items isKindOfClass:NSArray.class] || ![items count] ||
        CSMessageNativeUnsigned(CSMessageActionResolveSourceWrap(cell),@"m_uiMessageType")!=47) return items;
    // Device traces reach uniqMenuItems: without the sticker builder hooks.
    // Retain the two restrictions applied before the normal native builder.
    id model=CSMessageActionObjectGetter(cell,NSSelectorFromString(@"viewModel"));
    for (NSString *selector in @[@"isRecordDetail",@"isChatRoomMessageUnsafe"]) {
        @try {
            if (!CSMessageNativeSupports(model,selector,@"B",@[]) || [CSMessageNativeInvoke(model,selector,@[]) boolValue]) return items;
        } @catch (__unused NSException *exception) { return items; }
    }
    return [self itemsByAddingActionsForCell:cell items:items];
}
+ (BOOL)canPerformSelector:(SEL)selector cell:(id)cell { return [[self sharedAdapter] canPerformSelector:selector cell:cell]; }
+ (void)performSelector:(SEL)selector cell:(id)cell { [[self sharedAdapter] performSelector:selector cell:cell]; }
+ (BOOL)isPluginSelector:(SEL)selector { return selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:") || selector==NSSelectorFromString(@"cs_handleVoiceForwardMenuItem:") || selector==NSSelectorFromString(@"cs_handleAddStickerMenuItem:"); }
static const void *CSMenuContextKey=&CSMenuContextKey;
- (BOOL)isPluginSelector:(SEL)selector { return selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:") || selector==NSSelectorFromString(@"cs_handleVoiceForwardMenuItem:") || selector==NSSelectorFromString(@"cs_handleAddStickerMenuItem:"); }
static CSMessageAction CSMenuAction(SEL selector) {
    if (selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:")) return CSMessageActionRepeat;
    if (selector==NSSelectorFromString(@"cs_handleAddStickerMenuItem:")) return CSMessageActionAddSticker;
    return CSMessageActionForward;
}
static CSMessageActionEntry CSMenuEntry(CSMessageAction action) {
    return action==CSMessageActionRepeat ? CSMessageActionEntryMenuRepeat : action==CSMessageActionAddSticker ? CSMessageActionEntryMenuAddSticker : CSMessageActionEntryMenuVoiceForward;
}
static NSString *CSMenuSelector(CSMessageAction action) {
    return action==CSMessageActionRepeat ? @"cs_handleRepeatMenuItem:" : action==CSMessageActionAddSticker ? @"cs_handleAddStickerMenuItem:" : @"cs_handleVoiceForwardMenuItem:";
}
- (BOOL)canPerformSelector:(SEL)selector cell:(id)cell {
    if (![self isPluginSelector:selector]) return NO;
    CSMessageAction action=CSMenuAction(selector); CSMessageActionEntry entry=CSMenuEntry(action);
    if (!CSMessageActionEntryAllows(self.coordinator.settings,entry,action)) return NO;
    CSMessageActionContext *context=objc_getAssociatedObject(cell,CSMenuContextKey);
    if (!context) context=[self.coordinator captureContextForCell:cell controller:nil bindingGeneration:1];
    return context && (action!=CSMessageActionForward || context.messageType==34) && [self.coordinator canExecuteContext:context action:action entry:entry];
}
- (id)itemForCell:(id)cell action:(CSMessageAction)action {
    Class cls=NSClassFromString(@"MMMenuItem"); if (!cls) return nil;
    id icon=nil;
#if TARGET_OS_IOS
    static NSDictionary *icons; static dispatch_once_t once;
    dispatch_once(&once,^{
        NSMutableDictionary *map=[NSMutableDictionary dictionary];
        for (NSString *name in @[@"repeat",@"arrowshape.turn.up.right",@"face.smiling"]) {
            UIImage *image=[[[UIImage systemImageNamed:name] imageWithTintColor:UIColor.whiteColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; if (image) map[name]=image;
        }
        icons=map;
    });
    icon=icons[action==CSMessageActionRepeat ? @"repeat" : action==CSMessageActionAddSticker ? @"face.smiling" : @"arrowshape.turn.up.right"];
#endif
    NSString *title=action==CSMessageActionRepeat ? @"复读" : action==CSMessageActionAddSticker ? @"添加到表情" : @"语音转发";
    CSMessageMenuInvocation *invocation=[CSMessageMenuInvocation new]; invocation.context=objc_getAssociatedObject(cell,CSMenuContextKey); invocation.pluginAction=action; invocation.entry=CSMenuEntry(action); invocation.coordinator=self.coordinator;
    SEL selector=NSSelectorFromString(CSMenuSelector(action)); id allocated=[cls alloc], item=nil;
    @try {
        if (CSMessageNativeSupports(allocated,@"initWithTitle:icon:target:action:",@"@",@[@"@",@"@",@"@",@":"])) item=[allocated initWithTitle:title icon:icon target:invocation action:selector];
        else if (CSMessageNativeSupports(allocated,@"initWithTitle:target:action:",@"@",@[@"@",@"@",@":"])) item=[allocated initWithTitle:title target:invocation action:selector];
        if (item) { objc_setAssociatedObject(item,@selector(itemForCell:action:),invocation,OBJC_ASSOCIATION_RETAIN_NONATOMIC); CSMessageNativeSet(item,@"setIconImage:",icon,NO); CSMessageNativeSet(item,@"setLinePosition:",@0,NO); }
    } @catch (__unused NSException *exception) { return nil; }
    return item;
}
- (NSArray *)itemsByAddingActionsForCell:(id)cell items:(NSArray *)items {
    NSArray *original=[items isKindOfClass:NSArray.class] ? items : @[];
    CSMessageActionSettings *settings=self.coordinator.settings;
    NSMutableSet<NSNumber *> *wanted=[NSMutableSet set], *present=[NSMutableSet set];
    CSMessageActionContext *context=nil;
    // Disabled/unrelated menus never resolve account/page services.
    if (settings.repeatEnabled || settings.voiceForwardEnabled || settings.imageStickerEnabled) {
        NSUInteger type=(NSUInteger)CSMessageNativeUnsigned(CSMessageActionResolveSourceWrap(cell),@"m_uiMessageType");
        if (settings.repeatEnabled && CSMessageActionSupportsRepeatMenuType(type)) [wanted addObject:@(CSMessageActionRepeat)];
        if (settings.voiceForwardEnabled && type==34) [wanted addObject:@(CSMessageActionForward)];
        if (settings.imageStickerEnabled && type==3) [wanted addObject:@(CSMessageActionAddSticker)];
        if (wanted.count) {
            context=[self.coordinator captureContextForCell:cell controller:nil bindingGeneration:1];
            for (NSNumber *raw in wanted.allObjects) if (![self.coordinator canExecuteContext:context action:raw.integerValue entry:CSMenuEntry(raw.integerValue)]) [wanted removeObject:raw];
        }
    }
    // A host version already providing this exact action keeps its native item.
    for (id item in original) {
        SEL selector=CSMessageNativeSupports(item,@"action",@":",@[])?[item action]:NULL;
        if (![self isPluginSelector:selector]) {
            id title=CSMessageActionObjectGetter(item,@selector(title));
            if ([title isEqual:@"添加到表情"] || [title isEqual:@"添加到表情包"]) [wanted removeObject:@(CSMessageActionAddSticker)];
        }
    }
    objc_setAssociatedObject(cell,CSMenuContextKey,context,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableIndexSet *removed=[NSMutableIndexSet indexSet]; NSMutableSet *used=[NSMutableSet set];
    for (NSUInteger i=0;i<original.count;i++) {
        id item=original[i]; SEL selector=CSMessageNativeSupports(item,@"action",@":",@[])?[item action]:NULL;
        if ([self isPluginSelector:selector]) {
            NSNumber *action=@(CSMenuAction(selector)); id target=CSMessageActionObjectGetter(item,@selector(target));
            CSMessageActionContext *bound=[target isKindOfClass:CSMessageMenuInvocation.class] ? ((CSMessageMenuInvocation *)target).context : nil;
            if (![wanted containsObject:action] || [present containsObject:action] || !context || ![bound matchesSourceContext:context]) { [removed addIndex:i]; continue; }
            [present addObject:action];
        }
        if (wanted.count && CSMessageNativeSupports(item,@"menuType",@"q",@[])) [used addObject:@(CSMessageNativeUnsigned(item,@"menuType"))];
    }
    [wanted minusSet:present];
    if (!removed.count && !wanted.count) return original;
    NSMutableArray *result=[original mutableCopy]; [result removeObjectsAtIndexes:removed];
    // Preserve native item order and the later native uniq/filter stages.
    for (NSNumber *raw in @[@(CSMessageActionForward),@(CSMessageActionRepeat),@(CSMessageActionAddSticker)]) {
        if (![wanted containsObject:raw]) continue;
        CSMessageAction action=raw.integerValue;
        unsigned long long menuType=action==CSMessageActionRepeat ? 0x43535001ULL : action==CSMessageActionForward ? 0x43535002ULL : 0x43535003ULL;
        while ([used containsObject:@(menuType)]) menuType++;
        id item=[self itemForCell:cell action:action];
        if (item && CSMessageNativeSet(item,@"setMenuType:",@(menuType),YES)) { [result addObject:item]; [used addObject:@(menuType)]; }
    }
    return result;
}
- (void)performSelector:(SEL)selector cell:(id)cell {
    if (![self canPerformSelector:selector cell:cell]) return;
    CSMessageActionContext *context=objc_getAssociatedObject(cell,CSMenuContextKey); if (!context) return;
    CSMessageAction action=CSMenuAction(selector); [self.coordinator executeContext:context action:action entry:CSMenuEntry(action)];
}
@end
