#import "CSCloseFriendEntryState.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CoreFoundation/CoreFoundation.h>

@interface CSCloseFriendEntryState ()
@property(nonatomic,strong) NSUserDefaults *defaults;
@end

@implementation CSCloseFriendEntryState
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults {
    if((self=[super init])) _defaults=defaults;
    return self;
}
- (NSString *)keyForSnapshot:(CSCloseFriendSnapshot *)snapshot {
    if(!snapshot || snapshot.blocked || !snapshot.accountID.length)return nil;
    NSData *data=[snapshot.accountID dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes,(CC_LONG)data.length,hash);
    NSMutableString *key=[NSMutableString stringWithString:@"discovered.v1."];
    for(NSUInteger i=0;i<sizeof(hash);i++)[key appendFormat:@"%02x",hash[i]];
    return key;
}
- (BOOL)hasDiscoveredEntryForSnapshot:(CSCloseFriendSnapshot *)snapshot hasCredential:(BOOL)hasCredential {
    NSString *key=[self keyForSnapshot:snapshot];
    if(!key)return NO;
    // A valid existing credential also covers users who never enabled protection.
    if(hasCredential)return YES;
    id value=[self.defaults objectForKey:key];
    return [value isKindOfClass:NSNumber.class] && CFGetTypeID((__bridge CFTypeRef)value)==CFBooleanGetTypeID() && [value boolValue];
}
- (BOOL)isEntryVisibleForSnapshot:(CSCloseFriendSnapshot *)snapshot hasCredential:(BOOL)hasCredential {
    if(![self hasDiscoveredEntryForSnapshot:snapshot hasCredential:hasCredential])return NO;
    return !(snapshot.enabled && !snapshot.revealed && [snapshot.options[@"hideSettingsEntry"] boolValue]);
}
- (BOOL)discoverEntryForSnapshot:(CSCloseFriendSnapshot *)snapshot hasCredential:(BOOL)hasCredential {
    NSString *key=[self keyForSnapshot:snapshot];
    if(!key || [self hasDiscoveredEntryForSnapshot:snapshot hasCredential:hasCredential])return NO;
    id previous=[self.defaults objectForKey:key];
    [self.defaults setBool:YES forKey:key];
    // This is a one-time write; finish it before acknowledging discovery to the user.
    if([self.defaults synchronize])return YES;
    if(previous)[self.defaults setObject:previous forKey:key];
    else [self.defaults removeObjectForKey:key];
    return NO;
}
@end
