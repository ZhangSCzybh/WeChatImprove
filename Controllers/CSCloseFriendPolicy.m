#import "CSCloseFriendPolicy.h"
#import <CoreFoundation/CoreFoundation.h>
#import <math.h>
static BOOL CSBoolean(id value) { return [value isKindOfClass:NSNumber.class] && CFGetTypeID((__bridge CFTypeRef)value)==CFBooleanGetTypeID(); }
static BOOL CSName(id value) { return [value isKindOfClass:NSString.class] && [value length]>0 && [value length]<=512 && [value rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location==NSNotFound; }
static id CSInvalid(NSError **error) { if(error)*error=[NSError errorWithDomain:@"CSCloseFriendPolicy" code:1 userInfo:@{NSLocalizedDescriptionKey:@"Invalid close-friend profile."}]; return nil; }
NSDictionary *CSCloseFriendDefaultOptions(void) {
    return @{@"hideSessions":@YES,@"hideContacts":@YES,@"hideForwarding":@YES,@"hideTags":@YES,@"hideSearch":@YES,@"hideTimeline":@YES,@"hideInteractions":@YES,@"hideStatus":@YES,@"maskProfiles":@YES,@"silenceMessages":@YES,@"autoMute":@YES,@"rejectVoice":@YES,@"rejectVideo":@YES,@"hidePrivacyIcons":@YES,@"showBadges":@NO,@"hideSettingsEntry":@NO,@"hidePluginEntry":@NO,@"biometric":@NO,@"shakeToLock":@NO,@"unlockSeconds":@300};
}
NSDictionary *CSCloseFriendNormalizeProfile(id profile, NSError **error) {
    if (![profile isKindOfClass:NSDictionary.class] || [profile count]>4) return CSInvalid(error);
    NSSet *keys=[NSSet setWithArray:@[@"enabled",@"friends",@"groups",@"options"]];
    for(id key in profile) if (![keys containsObject:key]) return CSInvalid(error);
    if (!CSBoolean(profile[@"enabled"])) return CSInvalid(error);
    NSMutableDictionary *result=[NSMutableDictionary dictionaryWithObject:profile[@"enabled"] forKey:@"enabled"];
    for(NSString *key in @[@"friends",@"groups"]) {
        id names=profile[key];
        if (![names isKindOfClass:NSArray.class] || [names count]>10000) return CSInvalid(error);
        NSMutableOrderedSet *copy=[NSMutableOrderedSet orderedSet];
        for(id name in names) { if(!CSName(name))return CSInvalid(error); [copy addObject:[name copy]]; }
        result[key]=[copy.array copy];
    }
    id input=profile[@"options"];
    if (![input isKindOfClass:NSDictionary.class]) return CSInvalid(error);
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy];
    for(id key in input) {
        if(!options[key])return CSInvalid(error);
        id value=input[key];
        if([key isEqual:@"unlockSeconds"]) {
            if(![value isKindOfClass:NSNumber.class] || CSBoolean(value) || !isfinite([value doubleValue]) || [value doubleValue] != [value integerValue] || [value integerValue]<1 || [value integerValue]>86400) return CSInvalid(error);
            options[key]=@([value integerValue]);
        } else { if(!CSBoolean(value))return CSInvalid(error); options[key]=value; }
    }
    result[@"options"]=[options copy];
    return [result copy];
}
@implementation CSCloseFriendSnapshot
- (instancetype)initWithAccountID:(NSString *)accountID profile:(NSDictionary *)profile revealed:(BOOL)revealed revision:(NSUInteger)revision blocked:(BOOL)blocked {
    if((self=[super init])) {
        NSDictionary *valid=CSCloseFriendNormalizeProfile(profile,NULL);
        _accountID=CSName(accountID)?[accountID copy]:@"";
        _revision=revision; _blocked=blocked || !valid || !_accountID.length;
        _enabled=[valid[@"enabled"] boolValue]; _revealed=revealed && !_blocked;
        NSMutableSet *names=[NSMutableSet setWithArray:valid[@"friends"]?:@[]]; [names addObjectsFromArray:valid[@"groups"]?:@[]];
        _protectedUserNames=[names copy]; _options=valid[@"options"]?:CSCloseFriendDefaultOptions();
    } return self;
}
- (BOOL)containsUserName:(NSString *)name { return CSName(name) && [self.protectedUserNames containsObject:name]; }
- (BOOL)hidesUserName:(NSString *)name surface:(CSCloseFriendSurface)surface {
    if(!CSName(name))return NO;
    // An unreadable/unknown-account snapshot cannot safely classify membership. Fail closed on presentation.
    if(self.blocked)return YES;
    if(!self.enabled || self.revealed || ![self containsUserName:name])return NO;
    NSArray *keys=@[@"hideSessions",@"hideContacts",@"hideForwarding",@"hideTags",@"hideSearch",@"hideTimeline",@"hideInteractions",@"hideStatus",@"maskProfiles"];
    return surface<keys.count && [self.options[keys[surface]] boolValue];
}
- (BOOL)silencesSession:(NSString *)session sender:(NSString *)sender { return self.enabled && [self.options[@"silenceMessages"] boolValue] && ([self containsUserName:session] || [self containsUserName:sender]); }
- (BOOL)rejectsCaller:(NSString *)caller chatRoom:(NSString *)room video:(BOOL)video { return self.enabled && [self.options[video?@"rejectVideo":@"rejectVoice"] boolValue] && ([self containsUserName:caller] || [self containsUserName:room]); }
@end
