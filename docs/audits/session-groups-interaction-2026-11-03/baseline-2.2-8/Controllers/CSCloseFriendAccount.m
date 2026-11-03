#import "CSCloseFriendAccount.h"
#import "CSCloseFriendSignatures.h"
#import <objc/message.h>
static id CSAccountGetter(id object, NSString *name) {
    SEL selector=NSSelectorFromString(name);
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod(object_getClass(object),selector),"@@:"))return nil;
    return ((id(*)(id,SEL))objc_msgSend)(object,selector);
}
NSString *CSCloseFriendResolveAccount(Class (^lookup)(NSString *)) {
    @try {
        for(NSArray *entry in @[@[@"MMContext",@"currentUserName"],@[@"SettingUtil",@"getCurUsrName"]]) {
            Class provider=lookup(entry[0]); SEL selector=NSSelectorFromString(entry[1]);
            if(class_getClassMethod(provider,selector)) {
                id value=CSAccountGetter(provider,entry[1]);
                return [value isKindOfClass:NSString.class] && [value length]?value:nil;
            }
        }
        id center=nil; Class contextClass=lookup(@"MMContext");
        if(class_getClassMethod(contextClass,NSSelectorFromString(@"currentContext"))) {
            id context=CSAccountGetter(contextClass,@"currentContext");
            if(!context)return nil;
            if(CSCloseFriendMethodMatches(class_getInstanceMethod(object_getClass(context),NSSelectorFromString(@"getService:")),"@@:#"))center=context;
            else center=CSAccountGetter(context,@"serviceCenter");
        } else {
            for(NSString *className in @[@"MMServiceCenter",@"ServiceCenter"]) {
                center=CSAccountGetter(lookup(className),@"defaultCenter"); if(center)break;
            }
        }
        SEL service=NSSelectorFromString(@"getService:"); Class contactClass=lookup(@"CContactMgr");
        if(!contactClass || !CSCloseFriendMethodMatches(class_getInstanceMethod(object_getClass(center),service),"@@:#"))return nil;
        id manager=((id(*)(id,SEL,Class))objc_msgSend)(center,service,contactClass);
        id value=CSAccountGetter(CSAccountGetter(manager,@"getSelfContact"),@"m_nsUsrName");
        return [value isKindOfClass:NSString.class] && [value length]?value:nil;
    } @catch(__unused NSException *exception) { return nil; }
}
