#import "CSCloseFriendNotificationAdapter.h"
#import "CSCloseFriendBridge.h"
#import <objc/runtime.h>
static char SubjectKey;
static NSString *const ScopeKey=@"CSCloseFriendAlertScope";
static NSString *Name(id value) { return [value isKindOfClass:NSString.class] && [value length] ? value : nil; }
@interface CSCloseFriendAlertSubject ()
@property(nonatomic,copy,readwrite) NSString *account, *session, *sender;
@property(nonatomic,readwrite) NSUInteger epoch;
@end
@implementation CSCloseFriendAlertSubject
+ (instancetype)subjectForSession:(NSString *)session sender:(NSString *)sender {
    NSUInteger epoch=CSCloseFriendAccountEpoch(); CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
    if(policy.blocked || !policy.accountID.length || (!Name(session) && !Name(sender)))return nil;
    CSCloseFriendAlertSubject *s=[self new]; s.account=policy.accountID; s.epoch=epoch; s.session=Name(session); s.sender=Name(sender);
    return [s isCurrent]?s:nil;
}
- (BOOL)isCurrent { CSCloseFriendSnapshot *p=CSCloseFriendCurrentSnapshot(); return !p.blocked && self.epoch==CSCloseFriendAccountEpoch() && [self.account isEqual:p.accountID]; }
- (BOOL)shouldSilence { return [self isCurrent] && [CSCloseFriendCurrentSnapshot() silencesSession:self.session sender:self.sender]; }
- (BOOL)shouldDiscardOutput { return ![self isCurrent] || [self shouldSilence]; }
@end
void CSCFBindAlert(id object, CSCloseFriendAlertSubject *subject) { if(object && subject)objc_setAssociatedObject(object,&SubjectKey,subject,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
CSCloseFriendAlertSubject *CSCFBoundAlert(id object) { return object?objc_getAssociatedObject(object,&SubjectKey):nil; }
CSCloseFriendAlertSubject *CSCFMessageSubject(id message, id contact) {
    CSCloseFriendAlertSubject *bound=CSCFBoundAlert(message); if(bound)return bound; // Never rebind a stale message to a new account.
    CSCloseFriendSnapshot *p=CSCloseFriendCurrentSnapshot();
    NSString *from=Name(CSCloseFriendRead(message,@"m_nsFromUsr")), *to=Name(CSCloseFriendRead(message,@"m_nsToUsr"));
    if(p.blocked || ![to isEqual:p.accountID] || !from.length || [from isEqual:p.accountID])return nil;
    NSString *session=CSCloseFriendUserName(contact);
    if(session.length && ![session isEqual:from])return nil;
    NSString *sender=Name(CSCloseFriendRead(message,@"m_nsRealChatUsr"));
    CSCloseFriendAlertSubject *s=[CSCloseFriendAlertSubject subjectForSession:from sender:sender?:from]; CSCFBindAlert(message,s); return s;
}
CSCloseFriendAlertSubject *CSCFCurrentAlert(void) { return NSThread.currentThread.threadDictionary[ScopeKey]; }
void CSCFWithAlert(CSCloseFriendAlertSubject *subject, void (^action)(void)) {
    NSMutableDictionary *d=NSThread.currentThread.threadDictionary; id old=d[ScopeKey];
    if(subject)d[ScopeKey]=subject;else [d removeObjectForKey:ScopeKey];
    @try { if(action)action(); } @finally { if(old)d[ScopeKey]=old;else [d removeObjectForKey:ScopeKey]; }
}
BOOL CSCFPaymentOutputAllowed(NSString *account, NSString *session, NSString *sender) {
    CSCloseFriendSnapshot *p=CSCloseFriendCurrentSnapshot();
    if(p.blocked || ![p.accountID isEqual:account])return NO;
    return !p.enabled || (![p containsUserName:session] && ![p containsUserName:sender]);
}
