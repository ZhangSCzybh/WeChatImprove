#pragma once
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// Selector registration supplies one process-wide key across independently
// compiled senders. These inline helpers intentionally need no automation
// implementation or storage linkage, including in isolated host fixtures.
static inline void CSAutomationTagOwnedSend(id _Nullable wrap) {
    if(wrap)objc_setAssociatedObject(wrap,(const void *)sel_registerName("cs_automationOwnedSend"),@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static inline BOOL CSAutomationHasOwnedTag(id _Nullable wrap) {
    return wrap && [objc_getAssociatedObject(wrap,(const void *)sel_registerName("cs_automationOwnedSend")) boolValue];
}
