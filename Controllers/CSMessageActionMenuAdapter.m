#import "CSMessageActionMenuAdapter.h"
#import <objc/runtime.h>
#import <TargetConditionals.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#endif
@interface NSObject (CSNativeMenuConstruction)
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
static const void *CSMenuContextKey=&CSMenuContextKey;
- (BOOL)isPluginSelector:(SEL)selector { return selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:") || selector==NSSelectorFromString(@"cs_handleVoiceForwardMenuItem:"); }
- (BOOL)canPerformSelector:(SEL)selector cell:(id)cell {
    if (![self isPluginSelector:selector]) return NO;
    CSMessageActionContext *context=objc_getAssociatedObject(cell,CSMenuContextKey);
    if (!context) context=[self.coordinator captureContextForCell:cell controller:nil bindingGeneration:1];
    BOOL repeat=selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:");
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
        if (item) { objc_setAssociatedObject(item,@selector(itemForCell:repeat:),invocation,OBJC_ASSOCIATION_RETAIN_NONATOMIC); CSMessageNativeSet(item,@"setIconImage:",icon,NO); CSMessageNativeSet(item,@"setLinePosition:",@0,NO); CSMessageNativeSet(item,@"setMenuType:",@0,NO); }
    } @catch (__unused NSException *exception) { return nil; }
    return item;
}
- (NSArray *)itemsByAddingActionsForCell:(id)cell items:(NSArray *)items {
    CSMessageActionContext *context=[self.coordinator captureContextForCell:cell controller:nil bindingGeneration:1];
    objc_setAssociatedObject(cell,CSMenuContextKey,context,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableArray *result=[items isKindOfClass:NSArray.class] ? [items mutableCopy] : [NSMutableArray array];
    // Existing host order is unchanged; voice forwarding precedes repeat as in the baseline.
    for (NSNumber *repeatValue in @[@NO,@YES]) {
        BOOL repeat=repeatValue.boolValue; SEL selector=NSSelectorFromString(repeat ? @"cs_handleRepeatMenuItem:" : @"cs_handleVoiceForwardMenuItem:"); BOOL present=NO;
        for (id item in result) {
            if (!CSMessageNativeSupports(item,@"action",@":",@[])) continue;
            SEL itemAction=NULL;
            NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:[item methodSignatureForSelector:NSSelectorFromString(@"action")]]; invocation.target=item; invocation.selector=NSSelectorFromString(@"action"); [invocation invoke]; [invocation getReturnValue:&itemAction]; if (itemAction==selector) { present=YES; break; }
        }
        if (!present && [self canPerformSelector:selector cell:cell]) { id item=[self itemForCell:cell repeat:repeat]; if (item) [result addObject:item]; }
    }
    return result;
}
- (void)performSelector:(SEL)selector cell:(id)cell {
    if (![self canPerformSelector:selector cell:cell]) return;
    CSMessageActionContext *context=objc_getAssociatedObject(cell,CSMenuContextKey); if (!context) return;
    BOOL repeat=selector==NSSelectorFromString(@"cs_handleRepeatMenuItem:");
    [self.coordinator executeContext:context action:repeat ? CSMessageActionRepeat : CSMessageActionForward entry:repeat ? CSMessageActionEntryMenuRepeat : CSMessageActionEntryMenuVoiceForward];
}
@end
