#import "CSCloseFriendPolicy.h"
#import <CoreFoundation/CoreFoundation.h>
#import <math.h>
static BOOL CSBoolean(id value) { return [value isKindOfClass:NSNumber.class] && CFGetTypeID((__bridge CFTypeRef)value)==CFBooleanGetTypeID(); }
static BOOL CSName(id value) { return [value isKindOfClass:NSString.class] && [value length]>0 && [value length]<=512 && [value rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location==NSNotFound; }
static id CSInvalid(NSError **error) { if(error)*error=[NSError errorWithDomain:@"CSCloseFriendPolicy" code:1 userInfo:@{NSLocalizedDescriptionKey:@"Invalid close-friend profile."}]; return nil; }
NSDictionary *CSCloseFriendDefaultOptions(void) {
    return @{@"hideSessions":@YES,@"hideContacts":@YES,@"hideForwarding":@YES,@"hideTags":@YES,@"hideSearch":@YES,@"hideTimeline":@YES,@"hideInteractions":@YES,@"hideStatus":@YES,@"maskProfiles":@YES,@"hideScheduledTasks":@NO,@"hideAIReply":@NO,@"silenceMessages":@YES,@"rejectVoice":@YES,@"rejectVideo":@YES,@"callReplyEnabled":@NO,@"callReplyText":@"现在不方便接听，请留言。",@"hidePrivacyIcons":@YES,@"showBadges":@NO,@"hideSettingsEntry":@NO,@"hidePluginEntry":@NO,@"biometric":@NO,@"shakeToLock":@NO,@"longPressUnlockEnabled":@YES,@"longPressUnlockDuration":@1.0,@"unlockSeconds":@300};
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
        // Retired in 1.8-58. Accept old encrypted profiles without restoring the feature.
        if([key isEqual:@"autoMute"]) { if(!CSBoolean(input[key]))return CSInvalid(error); continue; }
        if(!options[key])return CSInvalid(error);
        id value=input[key];
        if([key isEqual:@"unlockSeconds"]) {
            if(![value isKindOfClass:NSNumber.class] || CSBoolean(value) || !isfinite([value doubleValue]) || [value doubleValue] != [value integerValue] || [value integerValue]<1 || [value integerValue]>86400) return CSInvalid(error);
            options[key]=@([value integerValue]);
        } else if([key isEqual:@"longPressUnlockDuration"]) {
            if(![value isKindOfClass:NSNumber.class] || CSBoolean(value) || !isfinite([value doubleValue]) || [value doubleValue]<0.5 || [value doubleValue]>2.0) return CSInvalid(error);
            options[key]=@([value doubleValue]);
        } else if([key isEqual:@"callReplyText"]) {
            if(![value isKindOfClass:NSString.class]) return CSInvalid(error);
            NSString *text=[value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
            if(!text.length || text.length>200 || [text rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location!=NSNotFound) return CSInvalid(error);
            options[key]=[text copy];
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
- (BOOL)concealsSurface:(CSCloseFriendSurface)surface {
    if(self.blocked)return YES;
    if(!self.enabled || self.revealed || !self.protectedUserNames.count)return NO;
    static NSString *const keys[]={@"hideSessions",@"hideContacts",@"hideForwarding",@"hideTags",@"hideSearch",@"hideTimeline",@"hideInteractions",@"hideStatus",@"maskProfiles",@"hideScheduledTasks",@"hideAIReply"};
    return surface<sizeof(keys)/sizeof(*keys) && [self.options[keys[surface]] boolValue];
}
- (BOOL)hidesUserName:(NSString *)name surface:(CSCloseFriendSurface)surface {
    if(![self concealsSurface:surface] || !CSName(name))return NO;
    return self.blocked || [self.protectedUserNames containsObject:name];
}
- (BOOL)silencesSession:(NSString *)session sender:(NSString *)sender { return self.enabled && [self.options[@"silenceMessages"] boolValue] && ([self containsUserName:session] || [self containsUserName:sender]); }
- (BOOL)rejectsCaller:(NSString *)caller chatRoom:(NSString *)room video:(BOOL)video { return self.enabled && !self.revealed && [self.options[video?@"rejectVideo":@"rejectVoice"] boolValue] && ([self containsUserName:caller] || [self containsUserName:room]); }
@end
