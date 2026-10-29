#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSAuthorizationManager.h"
#import "CSServiceCenter.h"
#include <limits.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

static NSUInteger checks, defaultsCalls, logCalls, serviceCalls, followCalls;
static id contactService;
static BOOL followed, throwFollow;
static NSString *lastFollowName;

#define CHECK(condition) do { \
    checks++; \
    if (!(condition)) { \
        fprintf(stderr, "FAIL %d: %s\n", __LINE__, #condition); \
        exit(1); \
    } \
} while (0)

// Catch a regression to defaults-backed authorization without touching a real suite.
@interface AuthorizationTestDefaults : NSObject
+ (instancetype)standardUserDefaults;
- (BOOL)boolForKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;
- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (void)setObject:(id)value forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (BOOL)synchronize;
@end
@implementation AuthorizationTestDefaults
+ (instancetype)standardUserDefaults { defaultsCalls++; return [self new]; }
- (BOOL)boolForKey:(NSString *)key { (void)key; defaultsCalls++; return YES; }
- (id)objectForKey:(NSString *)key { (void)key; defaultsCalls++; return [NSDate date]; }
- (void)setBool:(BOOL)value forKey:(NSString *)key { (void)value; (void)key; defaultsCalls++; }
- (void)setObject:(id)value forKey:(NSString *)key { (void)value; (void)key; defaultsCalls++; }
- (void)removeObjectForKey:(NSString *)key { (void)key; defaultsCalls++; }
- (BOOL)synchronize { defaultsCalls++; return YES; }
@end

static void __attribute__((unused)) AuthorizationTestLog(NSString *format, ...) { (void)format; logCalls++; }

// Exercise the production initializer and authorization implementation verbatim.
#define NSUserDefaults AuthorizationTestDefaults
#define NSLog(...) AuthorizationTestLog(__VA_ARGS__)
#import "AuthorizationReadUnderTest.m"
#undef NSLog
#undef NSUserDefaults

id CSGetService(Class serviceClass) {
    serviceCalls++;
    CHECK(serviceClass == NSClassFromString(@"CContactMgr"));
    return contactService;
}

@interface AuthorizationTestContact : NSObject
@property unsigned int settings;
@property BOOL throwSettings;
@property NSUInteger settingsReads;
- (unsigned int)m_uiBrandSubscriptionSettings;
@end
@implementation AuthorizationTestContact
- (unsigned int)m_uiBrandSubscriptionSettings {
    self.settingsReads++;
    if (self.throwSettings) [NSException raise:@"TestSubscriptionFailure" format:@"synthetic"];
    return self.settings;
}
@end

@interface AuthorizationTestContacts : NSObject
@property id contact;
@property BOOL throwLookup;
@property NSUInteger lookups;
@property(copy) NSString *lastName;
- (id)getContactByName:(NSString *)name;
@end
@implementation AuthorizationTestContacts
- (id)getContactByName:(NSString *)name {
    self.lookups++;
    self.lastName = name;
    if (self.throwLookup) [NSException raise:@"TestContactFailure" format:@"synthetic"];
    return self.contact;
}
@end

static Class RegisterNativeClass(NSString *name) {
    CHECK(NSClassFromString(name) == Nil);
    Class nativeClass = objc_allocateClassPair(NSObject.class, name.UTF8String, 0);
    CHECK(nativeClass != Nil);
    objc_registerClassPair(nativeClass);
    return nativeClass;
}

static BOOL TestBrandFollowed(id receiver, SEL selector, NSString *name) {
    (void)receiver; (void)selector;
    followCalls++;
    lastFollowName = name;
    if (throwFollow) [NSException raise:@"TestFollowFailure" format:@"synthetic"];
    return followed;
}

int main(void) {
    @autoreleasepool {
        CSAuthorizationManager *manager = [CSAuthorizationManager new];
        CHECK([manager.officialAccountUserName isEqual:@"gh_cac882c8f729"]);
        CHECK(CSAuthorizationManager.sharedManager == CSAuthorizationManager.sharedManager);
        CHECK(defaultsCalls == 0 && logCalls == 0);

        // Unsupported hosts and unavailable native services must fail closed.
        CHECK(!manager.isAuthorized);
        CHECK(serviceCalls == 0);
        RegisterNativeClass(@"CContactMgr");
        CHECK(!manager.isAuthorized);
        CHECK(serviceCalls == 1);
        contactService = [NSObject new];
        CHECK(![manager checkAuthorization]);

        AuthorizationTestContacts *contacts = [AuthorizationTestContacts new];
        AuthorizationTestContact *contact = [AuthorizationTestContact new];
        contactService = contacts;
        CHECK(!manager.isAuthorized); // No returned contact.
        contacts.contact = [NSObject new];
        CHECK(!manager.isAuthorized); // No subscription-settings selector.
        contacts.contact = contact;

        // Fallback results must reflect unfollow/follow changes on the next read.
        CHECK(!manager.isAuthorized);
        contact.settings = 1;
        CHECK(manager.isAuthorized);
        contact.settings = UINT_MAX;
        CHECK([manager checkAuthorization]);
        contact.settings = 0;
        CHECK(!manager.isAuthorized);
        CHECK(contact.settingsReads == 4);
        CHECK([contacts.lastName isEqual:manager.officialAccountUserName]);

        contacts.throwLookup = YES;
        CHECK(!manager.isAuthorized);
        contacts.throwLookup = NO;
        contact.settings = 1;
        contact.throwSettings = YES;
        CHECK(!manager.isAuthorized);
        contact.throwSettings = NO;

        // A native class without the brand API still uses the contact fallback.
        Class nativeContact = RegisterNativeClass(@"CContact");
        CHECK(manager.isAuthorized);
        NSString *signature = [NSString stringWithFormat:@"%s@:@", @encode(BOOL)];
        CHECK(class_addMethod(object_getClass(nativeContact), NSSelectorFromString(@"isBrandFollowedWithUsername:"),
                              (IMP)TestBrandFollowed, signature.UTF8String));

        // A definitive NO from the primary API must never fall back to stale YES.
        NSUInteger beforeLookups = contacts.lookups;
        followed = NO;
        CHECK(!manager.isAuthorized);
        followed = YES;
        CHECK(manager.isAuthorized);
        followed = NO;
        CHECK(![manager checkAuthorization]);
        CHECK(followCalls == 3 && contacts.lookups == beforeLookups);
        CHECK([lastFollowName isEqual:manager.officialAccountUserName]);

        // Only an exception enables fallback, and failures remain unauthorized.
        throwFollow = YES;
        contact.settings = 1;
        CHECK(manager.isAuthorized);
        contact.settings = 0;
        CHECK(!manager.isAuthorized);
        contacts.contact = nil;
        CHECK(!manager.isAuthorized);
        contacts.contact = [NSObject new];
        CHECK(!manager.isAuthorized);
        contacts.contact = contact;
        contacts.throwLookup = YES;
        CHECK(!manager.isAuthorized);
        contacts.throwLookup = NO;
        contact.throwSettings = YES;
        CHECK(!manager.isAuthorized);
        contact.throwSettings = NO;
        CHECK(followCalls == 9);

        // Native-service availability is checked on every read, even after YES.
        throwFollow = NO;
        followed = YES;
        CHECK(manager.isAuthorized);
        NSUInteger beforeServiceFailure = followCalls;
        contactService = nil;
        CHECK(!manager.isAuthorized);
        CHECK(followCalls == beforeServiceFailure);
        contactService = contacts;
        followed = NO;
        CHECK(!manager.isAuthorized);
        followed = YES;
        CHECK(manager.isAuthorized);

        CHECK(defaultsCalls == 0);
        CHECK(logCalls == 0);
        fprintf(stdout, "Authorization live-read tests passed (%lu checks; no defaults access or logs).\n", (unsigned long)checks);
    }
    return 0;
}
