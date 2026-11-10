#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSClownMenuAdapter.h"
#import "CSClownPreferences.h"
#import "CSClownPresentation.h"
#include <stdlib.h>
#include <string.h>

static NSUInteger checks, captures, amountCaptures, executions, modernInitializers, wrongGetters;
static BOOL captureAllowed = YES, requestsAllowed = YES, constructorFails, constructorThrows, constructorUnusable;
static BOOL lastPerformedAmount;
static NSUInteger accountEpoch = 1;
static CSClownPreferences *testPreferences;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr, "FAIL line %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); } } while (0)

@interface ClownTestWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType;
@end
@implementation ClownTestWrap @end

@interface ClownWrongTypeWrap : NSObject
@end
@implementation ClownWrongTypeWrap
- (id)m_uiMessageType { wrongGetters++; [NSException raise:@"WrongABI" format:@"must not invoke"]; return @1; }
@end

@interface ClownTestCell : NSObject
@property(nonatomic, strong) id wrap;
@end
@implementation ClownTestCell
- (id)getCurrentMessageWrap { return self.wrap; }
@end

@interface WCPayTransferMessageCellView : ClownTestCell @end
@implementation WCPayTransferMessageCellView @end
@interface ClownTransferSubclass : WCPayTransferMessageCellView @end
@implementation ClownTransferSubclass @end
@interface WCPayC2CMessageCellView : ClownTestCell @end
@implementation WCPayC2CMessageCellView @end

@interface ClownTestRequest : NSObject
@property(nonatomic, weak) ClownTestCell *cell;
@property(nonatomic, strong) id wrap;
@property(nonatomic) BOOL image;
@property(nonatomic) BOOL amount;
@property(nonatomic) NSUInteger epoch;
@end
@implementation ClownTestRequest @end

id CSClownCaptureEdit(id cell, BOOL image) {
    captures++;
    if (!captureAllowed) return nil;
    ClownTestRequest *request = [ClownTestRequest new];
    request.cell = cell; request.wrap = [cell wrap]; request.image = image; request.epoch = accountEpoch;
    return request;
}
id CSClownCaptureAmountEdit(id cell) {
    amountCaptures++;
    ClownTestRequest *request = CSClownCaptureEdit(cell, NO);
    request.amount = YES;
    return request;
}
BOOL CSClownEditIsValid(id value) {
    if (![value isKindOfClass:ClownTestRequest.class]) return NO;
    ClownTestRequest *request = value;
    return requestsAllowed && request.cell && request.cell.wrap == request.wrap && request.epoch == accountEpoch;
}
void CSClownPerformEdit(id request) { executions++; lastPerformedAmount = ((ClownTestRequest *)request).amount; }

@interface MMMenuItem : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, weak) id target;
@property(nonatomic) SEL action;
@property(nonatomic) long long menuType;
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
@implementation MMMenuItem
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    if (constructorThrows) [NSException raise:@"ConstructorFailure" format:@"native menu unavailable"];
    if (constructorFails) return nil;
    if (constructorUnusable) return (id)[NSObject new];
    if ((self = [super init])) { _title = [title copy]; _target = target; _action = action; }
    return self;
}
@end

@interface ClownModernMenuStub : MMMenuItem
- (instancetype)initWithTitle:(NSString *)title icon:(id)icon target:(id)target action:(SEL)action;
@end
@implementation ClownModernMenuStub
- (instancetype)initWithTitle:(NSString *)title icon:(__unused id)icon target:(id)target action:(SEL)action {
    modernInitializers++;
    return [super initWithTitle:title target:target action:action];
}
@end
static BOOL WrongInitializer(__unused id object, __unused SEL selector, __unused id title, __unused id icon, __unused id target, __unused SEL action) {
    modernInitializers++;
    return YES;
}
static id TestSharedPreferences(__unused id cls, __unused SEL selector) { return testPreferences; }
static void Drain(void) {
    for (NSUInteger i = 0; i < 3; i++) [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
static void Settings(NSUserDefaults *defaults, BOOL master, BOOL text, BOOL image) {
    [defaults setBool:master forKey:CSClownEnabledKey];
    [defaults setBool:text forKey:CSClownTextEnabledKey];
    [defaults setBool:image forKey:CSClownImageEnabledKey];
    [testPreferences requestRefresh]; Drain();
}
static ClownTestWrap *Wrap(unsigned int type) { ClownTestWrap *wrap = [ClownTestWrap new]; wrap.m_uiMessageType = type; return wrap; }
static MMMenuItem *Native(NSString *title, long long menuType) {
    MMMenuItem *item = [MMMenuItem new]; item.title = title; item.menuType = menuType; item.action = NSSelectorFromString(@"nativeAction:"); return item;
}
static NSArray *Menu(ClownTestCell *cell, NSArray *native) { return [CSClownMenuAdapter itemsByAddingActionsForCell:cell items:native]; }
static void Invoke(MMMenuItem *item) {
    CHECK(item.target != nil);
    ((void (*)(id, SEL, id))objc_msgSend)(item.target, item.action, nil);
}

static void TestMenus(NSUserDefaults *defaults) {
    SEL textAction = NSSelectorFromString(@"cs_clownEditText:"), imageAction = NSSelectorFromString(@"cs_clownEditImage:");
    CHECK([CSClownMenuAdapter isPluginSelector:textAction]);
    CHECK([CSClownMenuAdapter isPluginSelector:imageAction]);
    CHECK(![CSClownMenuAdapter isPluginSelector:NSSelectorFromString(@"nativeAction:")]);
    ClownTestCell *cell = [ClownTestCell new]; cell.wrap = Wrap(1);
    MMMenuItem *copy = Native(@"复制", 1), *forward = Native(@"转发", 2);
    NSArray *native = @[copy, forward];
    NSUInteger before = captures;
    CHECK(Menu(cell, native) == native);
    CHECK(captures == before);
    CHECK(![CSClownMenuAdapter canPerformSelector:textAction cell:cell]);
    Settings(defaults, NO, YES, YES);
    CHECK(Menu(cell, native) == native && captures == before);

    Settings(defaults, YES, YES, YES);
    NSArray *items = Menu(cell, native);
    CHECK(items.count == 3 && items[0] == copy && items[1] == forward);
    CHECK(native.count == 2);
    MMMenuItem *edit = items.lastObject;
    CHECK([edit.title isEqual:@"修改文字"] && edit.action == textAction && edit.target);
    CHECK(edit.menuType != copy.menuType && edit.menuType != forward.menuType);
    CHECK([CSClownMenuAdapter canPerformSelector:textAction cell:cell]);
    CHECK(![CSClownMenuAdapter canPerformSelector:imageAction cell:cell]);
    before = captures;
    CHECK(Menu(cell, items) == items && captures == before);
    NSArray *deduplicated = Menu(cell, @[copy, edit, edit, forward]);
    CHECK(deduplicated.count == 3 && deduplicated[0] == copy && deduplicated[1] == edit && deduplicated[2] == forward);
    NSUInteger performed = executions;
    Invoke(edit); CHECK(executions == performed + 1);
    [CSClownMenuAdapter performSelector:textAction cell:cell]; CHECK(executions == performed + 2);
    [CSClownMenuAdapter performSelector:imageAction cell:cell]; CHECK(executions == performed + 2);

    // A retained menu item cannot edit the message that reuses its old cell.
    cell.wrap = Wrap(1);
    CHECK(![CSClownMenuAdapter canPerformSelector:textAction cell:cell]);
    Invoke(edit); CHECK(executions == performed + 2);
    NSArray *rebound = Menu(cell, items);
    CHECK(rebound.count == 3 && rebound.lastObject != edit);
    MMMenuItem *newEdit = rebound.lastObject;
    Invoke(newEdit); CHECK(executions == performed + 3);
    accountEpoch++;
    CHECK(![CSClownMenuAdapter canPerformSelector:textAction cell:cell]);
    Invoke(newEdit); CHECK(executions == performed + 3);

    cell.wrap = Wrap(3);
    items = Menu(cell, native); edit = items.lastObject;
    CHECK(items.count == 3 && [edit.title isEqual:@"修改图片"] && edit.action == imageAction);
    CHECK([CSClownMenuAdapter canPerformSelector:imageAction cell:cell]);
    CHECK(![CSClownMenuAdapter canPerformSelector:textAction cell:cell]);
    Invoke(edit); CHECK(executions == performed + 4);
    Settings(defaults, YES, YES, NO);
    CHECK(![CSClownMenuAdapter canPerformSelector:imageAction cell:cell]);
    Invoke(edit); CHECK(executions == performed + 4);
    CHECK([Menu(cell, items) isEqual:native]);

    cell.wrap = Wrap(1);
    MMMenuItem *sameTitle = Native(@"修改文字", 6);
    NSArray *nativeSameTitle = @[copy, sameTitle, forward];
    before = captures;
    CHECK(Menu(cell, nativeSameTitle) == nativeSameTitle && captures == before);
    CHECK(![CSClownMenuAdapter canPerformSelector:textAction cell:cell]);
    MMMenuItem *collision = Native(@"其他", 0x43534301LL);
    items = Menu(cell, @[copy, collision]);
    CHECK(items.count == 3 && ((MMMenuItem *)items.lastObject).menuType != collision.menuType);
    MMMenuItem *foreign = Native(@"修改文字", 30); foreign.action = textAction;
    items = Menu(cell, @[copy, foreign]);
    CHECK(items.count == 2 && items[0] == copy && items[1] != foreign);

    for (NSNumber *type in @[@0, @34, @43, @47, @49, @10000]) {
        cell.wrap = Wrap(type.unsignedIntValue); before = captures;
        CHECK(Menu(cell, native) == native && captures == before);
    }
    cell.wrap = [ClownWrongTypeWrap new];
    CHECK(Menu(cell, native) == native && wrongGetters == 0);
    cell.wrap = nil;
    CHECK(Menu(cell, native) == native);

    cell.wrap = Wrap(1); captureAllowed = NO;
    CHECK(Menu(cell, native) == native);
    captureAllowed = YES; requestsAllowed = NO;
    CHECK(Menu(cell, native) == native);
    requestsAllowed = YES; constructorFails = YES;
    CHECK(Menu(cell, native) == native);
    constructorFails = NO; constructorThrows = YES;
    CHECK(Menu(cell, native) == native);
    constructorThrows = NO; constructorUnusable = YES;
    CHECK(Menu(cell, native) == native);
    constructorUnusable = NO;
    CHECK(Menu(cell, nil).count == 1);
    CHECK([CSClownMenuAdapter itemsByAddingActionsForCell:nil items:native] == native);

    // A weak native target survives after the cell's current menu association changes.
    items = Menu(cell, native); edit = items.lastObject;
    __weak id target = edit.target;
    Menu(cell, nativeSameTitle);
    CHECK(target != nil && edit.target == target);
    performed = executions; Invoke(edit); CHECK(executions == performed + 1);
    Settings(defaults, NO, YES, YES);
    Invoke(edit); CHECK(executions == performed + 1);
    CHECK([Menu(cell, items) isEqual:native]);

    dispatch_group_t group = dispatch_group_create();
    __block BOOL backgroundUntouched = NO;
    dispatch_group_async(group, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        backgroundUntouched = Menu(cell, native) == native && ![CSClownMenuAdapter canPerformSelector:textAction cell:cell];
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    CHECK(backgroundUntouched);
}

static void TestAmountMenus(NSUserDefaults *defaults) {
    SEL action = NSSelectorFromString(@"cs_clownEditAmount:");
    CHECK([CSClownMenuAdapter isPluginSelector:action]);
    WCPayTransferMessageCellView *transfer = [WCPayTransferMessageCellView new]; transfer.wrap = Wrap(49);
    NSArray *native = @[Native(@"转发", 1), Native(@"删除", 2)];
    Settings(defaults, YES, NO, NO);
    NSUInteger before = amountCaptures;
    CHECK(Menu(transfer, native) == native && amountCaptures == before);
    [defaults setBool:YES forKey:CSClownAmountEnabledKey];
    [testPreferences requestRefresh]; Drain();
    CHECK(testPreferences.snapshot.amountEnabled);
    NSArray *items = Menu(transfer, native);
    CHECK(items.count == 3 && items[0] == native[0] && items[1] == native[1]);
    MMMenuItem *edit = items.lastObject;
    CHECK([edit.title isEqual:@"修改金额"] && edit.action == action && edit.target);
    CHECK(amountCaptures == before + 1);
    CHECK([CSClownMenuAdapter canPerformSelector:action cell:transfer]);
    CHECK(![CSClownMenuAdapter canPerformSelector:NSSelectorFromString(@"cs_clownEditText:") cell:transfer]);
    CHECK(![CSClownMenuAdapter canPerformSelector:NSSelectorFromString(@"cs_clownEditImage:") cell:transfer]);
    NSUInteger performed = executions;
    Invoke(edit); CHECK(executions == performed + 1 && lastPerformedAmount);
    [CSClownMenuAdapter performSelector:action cell:transfer]; CHECK(executions == performed + 2 && lastPerformedAmount);
    before = amountCaptures;
    CHECK(Menu(transfer, items) == items && amountCaptures == before);
    NSArray *deduplicated = Menu(transfer, @[native[0], edit, edit, native[1]]);
    CHECK(deduplicated.count == 3 && deduplicated[0] == native[0] && deduplicated[1] == edit && deduplicated[2] == native[1]);

    // Other app cards and red packets share type 49 but must never receive this action.
    ClownTestCell *appCard = [ClownTestCell new]; appCard.wrap = Wrap(49);
    WCPayC2CMessageCellView *redPacket = [WCPayC2CMessageCellView new]; redPacket.wrap = Wrap(49);
    CHECK(Menu(appCard, native) == native && amountCaptures == before);
    CHECK(Menu(redPacket, native) == native && amountCaptures == before);
    ClownTransferSubclass *subclass = [ClownTransferSubclass new]; subclass.wrap = Wrap(49);
    CHECK(Menu(subclass, native).count == 3 && amountCaptures == before + 1);
    before = amountCaptures;
    for (NSNumber *type in @[@1, @3, @34, @47, @10000]) {
        transfer.wrap = Wrap(type.unsignedIntValue);
        CHECK(Menu(transfer, native) == native && amountCaptures == before);
    }
    CHECK(![CSClownMenuAdapter canPerformSelector:action cell:transfer]);
    Invoke(edit); CHECK(executions == performed + 2);

    transfer.wrap = Wrap(49);
    MMMenuItem *sameTitle = Native(@"修改金额", 3);
    NSArray *nativeSameTitle = @[native[0], sameTitle, native[1]];
    CHECK(Menu(transfer, nativeSameTitle) == nativeSameTitle && amountCaptures == before);
    CHECK(![CSClownMenuAdapter canPerformSelector:action cell:transfer]);
    MMMenuItem *collision = Native(@"其他", 0x43534303LL);
    items = Menu(transfer, @[collision]);
    CHECK(items.count == 2 && ((MMMenuItem *)items.lastObject).menuType != collision.menuType);
    edit = items.lastObject;
    accountEpoch++;
    Invoke(edit); CHECK(executions == performed + 2);
    items = Menu(transfer, native); edit = items.lastObject;
    [defaults setBool:NO forKey:CSClownAmountEnabledKey];
    [testPreferences requestRefresh]; Drain();
    CHECK(![CSClownMenuAdapter canPerformSelector:action cell:transfer]);
    Invoke(edit); CHECK(executions == performed + 2);
    CHECK([Menu(transfer, items) isEqual:native]);

    [defaults setBool:YES forKey:CSClownAmountEnabledKey];
    Settings(defaults, NO, YES, YES);
    before = amountCaptures;
    CHECK(Menu(transfer, native) == native && amountCaptures == before);
    CHECK(!testPreferences.snapshot.amountEnabled);
}

int main(int argc, const char *argv[]) { @autoreleasepool {
    BOOL modern = argc > 1 && strcmp(argv[1], "modern") == 0;
    BOOL wrongModern = argc > 1 && strcmp(argv[1], "wrong-modern") == 0;
    SEL modernSelector = NSSelectorFromString(@"initWithTitle:icon:target:action:");
    Method modernMethod = class_getInstanceMethod(ClownModernMenuStub.class, modernSelector);
    if (modern || wrongModern) CHECK(class_addMethod(MMMenuItem.class, modernSelector,
        modern ? method_getImplementation(modernMethod) : (IMP)WrongInitializer,
        modern ? method_getTypeEncoding(modernMethod) : "B@:@@@:"));
    NSString *suite = [@"wechat-clown-menu-tests-" stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:suite];
    testPreferences = [[CSClownPreferences alloc] initWithDefaults:defaults];
    Method singleton = class_getClassMethod(CSClownPreferences.class, @selector(sharedPreferences));
    IMP original = method_setImplementation(singleton, (IMP)TestSharedPreferences);
    TestMenus(defaults);
    CHECK(modern ? modernInitializers > 0 : modernInitializers == 0);
    NSUInteger originalChecks = checks;
    TestAmountMenus(defaults);
    method_setImplementation(singleton, original);
    [defaults removePersistentDomainForName:suite];
    printf("Clown menu (%s): %lu checks passed (%lu original, %lu amount)\n", modern ? "modern" : wrongModern ? "wrong-modern" : "legacy",
        (unsigned long)checks, (unsigned long)originalChecks, (unsigned long)(checks - originalChecks));
    return 0;
} }
