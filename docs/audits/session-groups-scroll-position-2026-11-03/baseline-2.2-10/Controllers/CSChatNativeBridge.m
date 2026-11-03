#import "CSChatNativeBridge.h"
#import <objc/runtime.h>
#import <objc/message.h>
static Method CSGetter(id object, SEL selector) {
    if (!object) return NULL;
    Method method=class_getInstanceMethod(object_getClass(object),selector);
    return method && method_getNumberOfArguments(method)==2 ? method : NULL;
}
static NSString *CSString(id value) { return [value isKindOfClass:NSString.class] ? value : @""; }
static id CSParent(id model) { return CSMessageNativeObject(model,@"parentModel") ?: model; }
id CSMessageNativeObject(id object, NSString *selector) {
    SEL sel = NSSelectorFromString(selector);
    Method method = CSGetter(object,sel);
    if (!method || method_getTypeEncoding(method)[0] != '@') return nil;
    return ((id (*)(id, SEL))objc_msgSend)(object, sel);
}
UITableView *CSMessageNativeTable(id controller) {
    id table = CSMessageNativeObject(controller,@"getTableView") ?: CSMessageNativeObject(controller,@"getMsgTableView");
    return [table isKindOfClass:UITableView.class] ? table : nil;
}
NSString *CSMessageCurrentAccount(void) {
    return CSString(CSMessageNativeObject(NSClassFromString(@"MMContext"),@"currentUserName") ?:
                    CSMessageNativeObject(NSClassFromString(@"SettingUtil"),@"getCurUsrName"));
}
NSString *CSMessageModelChatName(id model) {
    id parent = CSParent(model);
    id contact = CSMessageNativeObject(parent,@"chatContact");
    NSString *name = CSString(CSMessageNativeObject(contact,@"m_nsUsrName"));
    if (name.length) return name;
    // The view-model delegate is owned by the actual conversation, not the frontmost window.
    if (!NSThread.isMainThread) return @"";
    id delegate = CSMessageNativeObject(parent,@"delegate");
    id controller = CSMessageNativeObject(delegate,@"getViewController");
    return CSString(CSMessageNativeObject(controller,@"getCurrentChatName"));
}
