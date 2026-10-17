#import "CSMessageActionMenuAdapter.h"
#import "CSMessageActionDiagnostics.h"
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
@property(nonatomic) BOOL repeat;
@property(nonatomic, strong) CSMessageActionCoordinator *coordinator;
- (void)cs_handleRepeatMenuItem:(id)sender;
- (void)cs_handleVoiceForwardMenuItem:(id)sender;
@end
@implementation CSMessageMenuInvocation
- (void)invoke {
    [_coordinator executeContext:_context action:_repeat ? CSMessageActionRepeat : CSMessageActionForward entry:_repeat ? CSMessageActionEntryMenuRepeat : CSMessageActionEntryMenuVoiceForward];
}
- (void)cs_handleRepeatMenuItem:(id)sender { (void)sender; [self invoke]; }
- (void)cs_handleVoiceForwardMenuItem:(id)sender { (void)sender; [self invoke]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender { (void)action; (void)sender; return [_coordinator canExecuteContext:_context action:_repeat ? CSMessageActionRepeat : CSMessageActionForward entry:_repeat ? CSMessageActionEntryMenuRepeat : CSMessageActionEntryMenuVoiceForward]; }
@end
@interface CSMessageActionMenuAdapter ()
@property(nonatomic, strong) CSMessageActionCoordinator *coordinator;
@end
@implementation CSMessageActionMenuAdapter
- (instancetype)initWithCoordinator:(CSMessageActionCoordinator *)coordinator { if ((self=[super init])) _coordinator=coordinator; return self; }
+ (instancetype)sharedAdapter { static CSMessageActionMenuAdapter *adapter; static dispatch_once_t once; dispatch_once(&once,^{ adapter=[[self alloc] initWithCoordinator:CSMessageActionCoordinator.sharedCoordinator]; }); return adapter; }
+ (NSArray *)itemsByAddingActionsForCell:(id)cell items:(NSArray *)items { return [[self sharedAdapter] itemsByAddingActionsForCell:cell items:items]; }
+ (BOOL)canPerformSelector:(SEL)selector cell:(id)cell { return [[self sharedAdapter] canPerformSelector:selector cell:cell]; }
+ (void)performSelector:(SEL)selector cell:(id)cell { [[self sharedAdapter] performSelector:selector cell:cell]; }
+ (BOOL)isPluginSelector:(SEL)selector { return selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:") || selector==NSSelectorFromString(@"cs_handleVoiceForwardMenuItem:"); }
+ (void)recordMenuStage:(NSString *)stage cell:(id)cell items:(id)items {
    if (!CSMessageActionDiagnostics.isEnabled) return;
    NSUInteger repeats=0,forwards=0;
    NSArray *array=[items isKindOfClass:NSArray.class] ? items : @[];
    for (id item in array) {
        @try {
            if (!CSMessageNativeSupports(item,@"action",@":",@[])) continue;
            SEL action=[item action];
            if (action==NSSelectorFromString(@"cs_handleRepeatMenuItem:")) repeats++;
            if (action==NSSelectorFromString(@"cs_handleVoiceForwardMenuItem:")) forwards++;
        } @catch (__unused NSException *exception) {}
    }
    id wrap=CSMessageActionResolveSourceWrap(cell);
    [CSMessageActionDiagnostics record:stage fields:@{@"cell":NSStringFromClass([cell class]) ?: @"nil",@"wrap":NSStringFromClass([wrap class]) ?: @"nil",@"type":@(CSMessageNativeUnsigned(wrap,@"m_uiMessageType")),@"count":@(array.count),@"repeat":@(repeats),@"forward":@(forwards)}];
}
static const void *CSMenuContextKey=&CSMenuContextKey;
- (BOOL)isPluginSelector:(SEL)selector { return selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:") || selector==NSSelectorFromString(@"cs_handleVoiceForwardMenuItem:"); }
- (BOOL)canPerformSelector:(SEL)selector cell:(id)cell {
    if (![self isPluginSelector:selector]) return NO;
    BOOL repeat=selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:");
    if (!CSMessageActionEntryAllows(self.coordinator.settings,repeat ? CSMessageActionEntryMenuRepeat : CSMessageActionEntryMenuVoiceForward,repeat ? CSMessageActionRepeat : CSMessageActionForward)) return NO;
    CSMessageActionContext *context=objc_getAssociatedObject(cell,CSMenuContextKey);
    if (!context) context=[self.coordinator captureContextForCell:cell controller:nil bindingGeneration:1];
    return context && (repeat || context.messageType==34) && [self.coordinator canExecuteContext:context action:repeat ? CSMessageActionRepeat : CSMessageActionForward entry:repeat ? CSMessageActionEntryMenuRepeat : CSMessageActionEntryMenuVoiceForward];
}
- (id)itemForCell:(id)cell repeat:(BOOL)repeat {
    Class cls=NSClassFromString(@"MMMenuItem"); if (!cls) return nil;
    id icon=nil;
#if TARGET_OS_IOS
    static UIImage *repeatIcon, *forwardIcon; static dispatch_once_t once;
    dispatch_once(&once,^{ repeatIcon=[[[UIImage systemImageNamed:@"repeat"] imageWithTintColor:UIColor.whiteColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; forwardIcon=[[[UIImage systemImageNamed:@"arrowshape.turn.up.right"] imageWithTintColor:UIColor.whiteColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; });
    icon=repeat ? repeatIcon : forwardIcon;
#endif
    NSString *title=repeat ? @"复读" : @"语音转发"; SEL selector=NSSelectorFromString(repeat ? @"cs_handleRepeatMenuItem:" : @"cs_handleVoiceForwardMenuItem:");
    CSMessageMenuInvocation *invocation=[CSMessageMenuInvocation new]; invocation.context=objc_getAssociatedObject(cell,CSMenuContextKey); invocation.repeat=repeat; invocation.coordinator=self.coordinator;
    id allocated=[cls alloc], item=nil;
    @try {
        if (CSMessageNativeSupports(allocated,@"initWithTitle:icon:target:action:",@"@",@[@"@",@"@",@"@",@":"])) item=[allocated initWithTitle:title icon:icon target:invocation action:selector];
        else if (CSMessageNativeSupports(allocated,@"initWithTitle:target:action:",@"@",@[@"@",@"@",@":"])) item=[allocated initWithTitle:title target:invocation action:selector];
        if (item) { objc_setAssociatedObject(item,@selector(itemForCell:repeat:),invocation,OBJC_ASSOCIATION_RETAIN_NONATOMIC); CSMessageNativeSet(item,@"setIconImage:",icon,NO); CSMessageNativeSet(item,@"setLinePosition:",@0,NO); }
    } @catch (__unused NSException *exception) { [CSMessageActionDiagnostics record:@"menu.construct" fields:@{@"reason":@"exception"}]; return nil; }
    if (CSMessageActionDiagnostics.isEnabled) {
        @try { [CSMessageActionDiagnostics record:@"menu.construct" fields:@{@"item":NSStringFromClass([item class]) ?: @"nil",@"accepted":@(item!=nil),@"actionMatches":@(CSMessageNativeSupports(item,@"action",@":",@[]) && [item action]==selector),@"targetPresent":@(CSMessageActionObjectGetter(item,NSSelectorFromString(@"target"))!=nil)}]; }
        @catch (__unused NSException *exception) { [CSMessageActionDiagnostics record:@"menu.construct" fields:@{@"reason":@"observation_exception"}]; }
    }
    return item;
}
- (NSArray *)itemsByAddingActionsForCell:(id)cell items:(NSArray *)items {
    NSArray *original=[items isKindOfClass:NSArray.class] ? items : @[];
    [CSMessageActionMenuAdapter recordMenuStage:@"menu.builder.in" cell:cell items:original];
    CSMessageActionSettings *settings=self.coordinator.settings;
    BOOL repeat=NO,forward=NO;
    CSMessageActionContext *context=nil;
    // Decide whether the message can need our menu before resolving account/page
    // services. Disabled or unrelated menus retain the original array unchanged.
    if (settings.repeatEnabled || settings.voiceForwardEnabled) {
        NSUInteger type=(NSUInteger)CSMessageNativeUnsigned(CSMessageActionResolveSourceWrap(cell),@"m_uiMessageType");
        repeat=settings.repeatEnabled && CSMessageActionSupportsRepeatMenuType(type);
        forward=settings.voiceForwardEnabled && type==34;
        if (repeat || forward) {
            context=[self.coordinator captureContextForCell:cell controller:nil bindingGeneration:1];
            repeat=repeat && [self.coordinator canExecuteContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryMenuRepeat];
            forward=forward && [self.coordinator canExecuteContext:context action:CSMessageActionForward entry:CSMessageActionEntryMenuVoiceForward];
        }
    }
    objc_setAssociatedObject(cell,CSMenuContextKey,context,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (CSMessageActionDiagnostics.isEnabled) [CSMessageActionDiagnostics record:@"menu.admission" fields:@{@"cell":NSStringFromClass([cell class]) ?: @"nil",@"repeatEnabled":@(settings.repeatEnabled),@"voiceEnabled":@(settings.voiceForwardEnabled),@"context":@(context!=nil),@"controller":NSStringFromClass([context.controller class]) ?: @"nil",@"repeat":@(repeat),@"forward":@(forward)}];
    SEL repeatAction=NSSelectorFromString(@"cs_handleRepeatMenuItem:"), forwardAction=NSSelectorFromString(@"cs_handleVoiceForwardMenuItem:");
    BOOL hasRepeat=NO,hasForward=NO;
    NSMutableIndexSet *removed=nil;
    NSMutableSet *used=(repeat || forward) ? [NSMutableSet set] : nil;
    for (NSUInteger i=0;i<original.count;i++) {
        id item=original[i]; SEL action=NULL;
        if (CSMessageNativeSupports(item,@"action",@":",@[])) action=[item action];
        BOOL isRepeat=action==repeatAction,isForward=action==forwardAction;
        if (isRepeat || isForward) {
            id target=CSMessageActionObjectGetter(item,@selector(target));
            CSMessageActionContext *bound=[target isKindOfClass:CSMessageMenuInvocation.class] ? ((CSMessageMenuInvocation *)target).context : nil;
            BOOL keep=(isRepeat ? repeat && !hasRepeat : forward && !hasForward) && context && [bound matchesSourceContext:context];
            if (!keep) { if (!removed) removed=[NSMutableIndexSet indexSet]; [removed addIndex:i]; continue; }
            if (isRepeat) hasRepeat=YES; else hasForward=YES;
        }
        if (used && CSMessageNativeSupports(item,@"menuType",@"q",@[])) [used addObject:@(CSMessageNativeUnsigned(item,@"menuType"))];
    }
    BOOL addForward=forward && !hasForward,addRepeat=repeat && !hasRepeat;
    if (!removed.count && !addForward && !addRepeat) { [CSMessageActionMenuAdapter recordMenuStage:@"menu.builder.out" cell:cell items:original]; return original; }
    NSMutableArray *result=[original mutableCopy];
    if (removed.count) [result removeObjectsAtIndexes:removed];
    // Add only our items, before native uniq/filter stages, preserving host order.
    for (NSUInteger i=0;i<2;i++) {
        BOOL addingRepeat=i==1;
        if (!(addingRepeat ? addRepeat : addForward)) continue;
        unsigned long long menuType=addingRepeat ? 0x43535001ULL : 0x43535002ULL;
        while ([used containsObject:@(menuType)]) menuType++;
        id item=[self itemForCell:cell repeat:addingRepeat];
        BOOL typeSet=item && CSMessageNativeSet(item,@"setMenuType:",@(menuType),YES);
        if (typeSet) { [result addObject:item]; [used addObject:@(menuType)]; }
        if (CSMessageActionDiagnostics.isEnabled) [CSMessageActionDiagnostics record:@"menu.insert" fields:@{@"repeat":@(addingRepeat),@"typeSet":@(typeSet),@"menuType":@(CSMessageNativeUnsigned(item,@"menuType"))}];
    }
    [CSMessageActionMenuAdapter recordMenuStage:@"menu.builder.out" cell:cell items:result];
    return result;
}
- (void)performSelector:(SEL)selector cell:(id)cell {
    if (![self canPerformSelector:selector cell:cell]) return;
    CSMessageActionContext *context=objc_getAssociatedObject(cell,CSMenuContextKey); if (!context) return;
    BOOL repeat=selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:");
    [self.coordinator executeContext:context action:repeat ? CSMessageActionRepeat : CSMessageActionForward entry:repeat ? CSMessageActionEntryMenuRepeat : CSMessageActionEntryMenuVoiceForward];
}
@end
