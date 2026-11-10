#import "CSClownMenuAdapter.h"
#import "CSClownPreferences.h"
#import "CSClownPresentation.h"
#import "CSMessageActionContext.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <TargetConditionals.h>
#include <limits.h>
#include <string.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#endif

@interface NSObject (CSClownNativeMenu)
- (instancetype)initWithTitle:(NSString *)title icon:(id)icon target:(id)target action:(SEL)action;
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end

static const void *CSClownMenuInvocationKey = &CSClownMenuInvocationKey;
static const void *CSClownCellInvocationKey = &CSClownCellInvocationKey;

static const char *CSClownMenuType(const char *type) {
    while (*type && strchr("rnNoORV", *type)) type++;
    return type;
}

// Native menu methods must have concrete signatures; forwarding does not supply ABI evidence.
static Method CSClownMenuMethod(id object, SEL selector, unsigned arguments) {
    if (!object) return NULL;
    Method method = class_getInstanceMethod(object_getClass(object), selector);
    return method && method_getNumberOfArguments(method) == arguments ? method : NULL;
}

static BOOL CSClownMenuSignature(id object, SEL selector, const char *result, NSArray<NSString *> *arguments) {
    Method method = CSClownMenuMethod(object, selector, (unsigned)arguments.count + 2);
    if (!method) return NO;
    char type[128] = {0};
    method_getReturnType(method, type, sizeof(type));
    if (strcmp(CSClownMenuType(type), result) != 0) return NO;
    for (NSUInteger i = 0; i < arguments.count; i++) {
        method_getArgumentType(method, (unsigned)i + 2, type, sizeof(type));
        if (strcmp(CSClownMenuType(type), arguments[i].UTF8String) != 0) return NO;
    }
    return YES;
}

static SEL CSClownMenuAction(id item) {
    SEL selector = @selector(action);
    if (!CSClownMenuSignature(item, selector, ":", @[])) return NULL;
    @try { return ((SEL (*)(id, SEL))objc_msgSend)(item, selector); }
    @catch (__unused NSException *exception) { return NULL; }
}

static unsigned long long CSClownMenuUnsigned(id object, SEL selector) {
    Method method = CSClownMenuMethod(object, selector, 2);
    if (!method) return 0;
    char type[32] = {0};
    method_getReturnType(method, type, sizeof(type));
    @try {
        switch (*CSClownMenuType(type)) {
            case 'I': return ((unsigned int (*)(id, SEL))objc_msgSend)(object, selector);
            case 'Q': return ((unsigned long long (*)(id, SEL))objc_msgSend)(object, selector);
            case 'L': return ((unsigned long (*)(id, SEL))objc_msgSend)(object, selector);
            case 'i': { int value = ((int (*)(id, SEL))objc_msgSend)(object, selector); return value > 0 ? (unsigned)value : 0; }
            case 'q': { long long value = ((long long (*)(id, SEL))objc_msgSend)(object, selector); return value > 0 ? (unsigned long long)value : 0; }
            case 'l': { long value = ((long (*)(id, SEL))objc_msgSend)(object, selector); return value > 0 ? (unsigned long)value : 0; }
            default: return 0;
        }
    } @catch (__unused NSException *exception) { return 0; }
}

static BOOL CSClownSetMenuType(id item, unsigned long long value) {
    SEL selector = NSSelectorFromString(@"setMenuType:");
    Method method = CSClownMenuMethod(item, selector, 3);
    if (!method) return NO;
    char result[32] = {0}, argument[32] = {0};
    method_getReturnType(method, result, sizeof(result));
    method_getArgumentType(method, 2, argument, sizeof(argument));
    if (*CSClownMenuType(result) != 'v') return NO;
    @try {
        switch (*CSClownMenuType(argument)) {
            case 'I': if (value > UINT_MAX) return NO; ((void (*)(id, SEL, unsigned int))objc_msgSend)(item, selector, (unsigned int)value); break;
            case 'Q': ((void (*)(id, SEL, unsigned long long))objc_msgSend)(item, selector, value); break;
            case 'L': if (value > ULONG_MAX) return NO; ((void (*)(id, SEL, unsigned long))objc_msgSend)(item, selector, (unsigned long)value); break;
            case 'i': if (value > INT_MAX) return NO; ((void (*)(id, SEL, int))objc_msgSend)(item, selector, (int)value); break;
            case 'q': if (value > LLONG_MAX) return NO; ((void (*)(id, SEL, long long))objc_msgSend)(item, selector, (long long)value); break;
            case 'l': if (value > LONG_MAX) return NO; ((void (*)(id, SEL, long))objc_msgSend)(item, selector, (long)value); break;
            default: return NO;
        }
        return YES;
    } @catch (__unused NSException *exception) { return NO; }
}

typedef NS_ENUM(NSUInteger, CSClownMenuKind) {
    CSClownMenuText, CSClownMenuImage, CSClownMenuAmount
};

static SEL CSClownSelector(CSClownMenuKind kind) {
    return NSSelectorFromString(kind == CSClownMenuAmount ? @"cs_clownEditAmount:" :
        kind == CSClownMenuImage ? @"cs_clownEditImage:" : @"cs_clownEditText:");
}
static BOOL CSClownKindEnabled(CSClownSettings *settings, CSClownMenuKind kind) {
    return settings.enabled && (kind == CSClownMenuAmount ? settings.amountEnabled :
        kind == CSClownMenuImage ? settings.imageEnabled : settings.textEnabled);
}

@interface CSClownMenuInvocation : NSObject
@property(nonatomic, weak) id cell;
@property(nonatomic, strong) id request;
@property(nonatomic) CSClownMenuKind kind;
- (BOOL)canInvoke;
@end

@implementation CSClownMenuInvocation
- (BOOL)canInvoke {
    if (!NSThread.isMainThread || !self.cell || !self.request) return NO;
    CSClownSettings *settings = CSClownPreferences.sharedPreferences.snapshot;
    return CSClownKindEnabled(settings, self.kind) && CSClownEditIsValid(self.request);
}
- (void)invoke { if ([self canInvoke]) CSClownPerformEdit(self.request); }
- (void)cs_clownEditText:(__unused id)sender { if (self.kind == CSClownMenuText) [self invoke]; }
- (void)cs_clownEditImage:(__unused id)sender { if (self.kind == CSClownMenuImage) [self invoke]; }
- (void)cs_clownEditAmount:(__unused id)sender { if (self.kind == CSClownMenuAmount) [self invoke]; }
- (BOOL)canPerformAction:(SEL)selector withSender:(__unused id)sender {
    return selector == CSClownSelector(self.kind) && [self canInvoke];
}
@end

static id CSClownMakeMenuItem(CSClownMenuInvocation *invocation, unsigned long long menuType) {
    Class cls = NSClassFromString(@"MMMenuItem");
    if (!cls) return nil;
    NSString *title = invocation.kind == CSClownMenuAmount ? @"修改金额" : invocation.kind == CSClownMenuImage ? @"修改图片" : @"修改文字";
    id icon = nil;
#if TARGET_OS_IOS
    NSString *iconName = invocation.kind == CSClownMenuAmount ? @"yensign.circle" : invocation.kind == CSClownMenuImage ? @"photo" : @"square.and.pencil";
    icon = [[[UIImage systemImageNamed:iconName] imageWithTintColor:UIColor.whiteColor]
        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
#endif
    SEL action = CSClownSelector(invocation.kind);
    id allocated = [cls alloc], item = nil;
    @try {
        if (CSClownMenuSignature(allocated, @selector(initWithTitle:icon:target:action:), "@", @[@"@", @"@", @"@", @":"])) {
            item = [allocated initWithTitle:title icon:icon target:invocation action:action];
        } else if (CSClownMenuSignature(allocated, @selector(initWithTitle:target:action:), "@", @[@"@", @"@", @":"])) {
            item = [allocated initWithTitle:title target:invocation action:action];
        }
        if (!item || !CSClownSetMenuType(item, menuType)) return nil;
        // Some host menu versions hold their target weakly. The item owns its immutable request target.
        objc_setAssociatedObject(item, CSClownMenuInvocationKey, invocation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (icon && CSClownMenuSignature(item, NSSelectorFromString(@"setIconImage:"), "v", @[@"@"])) {
            ((void (*)(id, SEL, id))objc_msgSend)(item, NSSelectorFromString(@"setIconImage:"), icon);
        }
        return item;
    } @catch (__unused NSException *exception) { return nil; }
}

@implementation CSClownMenuAdapter
+ (BOOL)isPluginSelector:(SEL)selector {
    return selector == CSClownSelector(CSClownMenuText) || selector == CSClownSelector(CSClownMenuImage) || selector == CSClownSelector(CSClownMenuAmount);
}
+ (NSArray *)itemsByAddingActionsForCell:(id)cell items:(NSArray *)items {
    NSArray *original = [items isKindOfClass:NSArray.class] ? items : @[];
    if (!NSThread.isMainThread || !cell) return original;
    CSClownSettings *settings = CSClownPreferences.sharedPreferences.snapshot;
    unsigned long long type = 0;
    if (settings.textEnabled || settings.imageEnabled || settings.amountEnabled) {
        type = CSClownMenuUnsigned(CSMessageActionResolveSourceWrap(cell), NSSelectorFromString(@"m_uiMessageType"));
    }
    Class transferClass = NSClassFromString(@"WCPayTransferMessageCellView");
    BOOL transfer = type == 49 && transferClass && [cell isKindOfClass:transferClass];
    CSClownMenuKind kind = transfer ? CSClownMenuAmount : type == 3 ? CSClownMenuImage : CSClownMenuText;
    BOOL wanted = (type == 1 || type == 3 || transfer) && CSClownKindEnabled(settings, kind);
    NSString *wantedTitle = kind == CSClownMenuAmount ? @"修改金额" : kind == CSClownMenuImage ? @"修改图片" : @"修改文字";
    SEL wantedSelector = CSClownSelector(kind);
    // An existing native action with the same title keeps its original behavior and position.
    if (wanted) for (id item in original) {
        if (![self isPluginSelector:CSClownMenuAction(item)] &&
            [CSMessageActionObjectGetter(item, @selector(title)) isEqual:wantedTitle]) { wanted = NO; break; }
    }
    NSMutableIndexSet *removed = [NSMutableIndexSet indexSet];
    NSMutableSet<NSNumber *> *used = [NSMutableSet set];
    CSClownMenuInvocation *selected = nil;
    for (NSUInteger i = 0; i < original.count; i++) {
        id item = original[i];
        SEL selector = CSClownMenuAction(item);
        [used addObject:@(CSClownMenuUnsigned(item, NSSelectorFromString(@"menuType")))];
        if (![self isPluginSelector:selector]) continue;
        id value = objc_getAssociatedObject(item, CSClownMenuInvocationKey);
        CSClownMenuInvocation *invocation = [value isKindOfClass:CSClownMenuInvocation.class] ? value : nil;
        if (!wanted || selected || selector != wantedSelector || invocation.cell != cell || invocation.kind != kind || ![invocation canInvoke]) {
            [removed addIndex:i];
        } else selected = invocation;
    }
    NSMutableArray *result = nil;
    if (removed.count) { result = [original mutableCopy]; [result removeObjectsAtIndexes:removed]; }
    if (wanted && !selected) {
        id request = kind == CSClownMenuAmount ? CSClownCaptureAmountEdit(cell) : CSClownCaptureEdit(cell, kind == CSClownMenuImage);
        if (request && CSClownEditIsValid(request)) {
            CSClownMenuInvocation *invocation = [CSClownMenuInvocation new];
            invocation.cell = cell; invocation.kind = kind; invocation.request = request;
            unsigned long long menuType = 0x43534301ULL + kind;
            while ([used containsObject:@(menuType)]) menuType++;
            id item = CSClownMakeMenuItem(invocation, menuType);
            if (item) {
                if (!result) result = [original mutableCopy];
                [result addObject:item]; selected = invocation;
            }
        }
    }
    objc_setAssociatedObject(cell, CSClownCellInvocationKey, selected, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return result ?: original;
}
+ (BOOL)canPerformSelector:(SEL)selector cell:(id)cell {
    if (![self isPluginSelector:selector] || !NSThread.isMainThread) return NO;
    CSClownMenuInvocation *invocation = objc_getAssociatedObject(cell, CSClownCellInvocationKey);
    return invocation && invocation.cell == cell && selector == CSClownSelector(invocation.kind) && [invocation canInvoke];
}
+ (void)performSelector:(SEL)selector cell:(id)cell {
    if (![self canPerformSelector:selector cell:cell]) return;
    CSClownMenuInvocation *invocation = objc_getAssociatedObject(cell, CSClownCellInvocationKey);
    [invocation invoke];
}
@end
