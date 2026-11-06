//
// CSServiceCenter.m
// 服务中心适配器实现
//

#import "CSServiceCenter.h"
#import <objc/message.h>
#import <objc/runtime.h>

static id cs_callClassSelectorIfExists(Class cls, SEL selector) {
    if (!cls || !selector) return nil;
    if (![cls respondsToSelector:selector]) return nil;
    return ((id (*)(id, SEL))objc_msgSend)(cls, selector);
}

static id cs_getServiceCenterFromMMContext(void) {
    Class ctxClass = objc_getClass("MMContext");
    if (!ctxClass) return nil;

    id ctx = cs_callClassSelectorIfExists(ctxClass, @selector(currentContext));
    if (!ctx) return nil;

    if ([ctx respondsToSelector:@selector(getService:)]) {
        return ctx;
    }

    if ([ctx respondsToSelector:@selector(serviceCenter)]) {
        @try {
            id center = ((id (*)(id, SEL))objc_msgSend)(ctx, @selector(serviceCenter));
            if (center && [center respondsToSelector:@selector(getService:)]) {
                return center;
            }
        } @catch (NSException *exception) {
            NSLog(@"[红包] 获取serviceCenter异常: %@", exception);
        }
    }

    return nil;
}

static id cs_getServiceCenterForClass(Class cls) {
    if (!cls) return nil;

    const SEL selectors[] = {
        @selector(defaultCenter),
        @selector(defaultServiceCenter),
        @selector(sharedCenter),
        @selector(sharedInstance),
        @selector(sharedServiceCenter),
    };

    for (NSUInteger i = 0; i < sizeof(selectors) / sizeof(selectors[0]); i++) {
        id center = cs_callClassSelectorIfExists(cls, selectors[i]);
        if (center) {
            return center;
        }
    }

    return nil;
}

static id cs_getServiceFromCenter(id center, Class serviceClass) {
    if (!center || !serviceClass) return nil;
    if (![center respondsToSelector:@selector(getService:)]) return nil;
    return ((id (*)(id, SEL, Class))objc_msgSend)(center, @selector(getService:), serviceClass);
}

id CSGetServiceCenter(void) {
    id ctxCenter = cs_getServiceCenterFromMMContext();
    if (ctxCenter) return ctxCenter;

    id center = cs_getServiceCenterForClass(objc_getClass("MMServiceCenter"));
    if (center) return center;
    return cs_getServiceCenterForClass(objc_getClass("ServiceCenter"));
}

id CSGetService(Class serviceClass) {
    if (!serviceClass) return nil;

    id ctxCenter = cs_getServiceCenterFromMMContext();
    id service = cs_getServiceFromCenter(ctxCenter, serviceClass);
    if (service) return service;

    id mmCenter = cs_getServiceCenterForClass(objc_getClass("MMServiceCenter"));
    service = cs_getServiceFromCenter(mmCenter, serviceClass);
    if (service) return service;

    id legacyCenter = cs_getServiceCenterForClass(objc_getClass("ServiceCenter"));
    service = cs_getServiceFromCenter(legacyCenter, serviceClass);
    return service;
}
