#import "CSAutomationEventAdapter.h"
#import "CSAutomationOwnership.h"
#import "CSAutomationStore.h"
#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>
void CSAutomationMarkOwnedSend(id wrap){CSAutomationTagOwnedSend(wrap);}
BOOL CSAutomationIsOwnedSend(id wrap){return CSAutomationHasOwnedTag(wrap);}
static NSString *String(id object,NSString *selector){id value=CSMessageActionNativeObject(object,selector);return [value isKindOfClass:NSString.class]?value:@"";}
NSArray<NSString *> *CSAutomationMessageIdentifiers(id wrap,NSString *account,NSString *conversation){
    if(!account.length || !conversation.length || !wrap)return @[];
    unsigned long long server=CSMessageNativeUnsigned(wrap,@"m_n64MesSvrID"),local=CSMessageNativeUnsigned(wrap,@"m_uiMesLocalID"),created=CSMessageNativeUnsigned(wrap,@"m_uiCreateTime");
    if((long long)server<=0)server=0;
    NSMutableArray *keys=[NSMutableArray array];if(server)[keys addObject:[NSString stringWithFormat:@"%@|%@|s:%llu",account,conversation,server]];
    if(local && created)[keys addObject:[NSString stringWithFormat:@"%@|%@|l:%llu:%llu",account,conversation,local,created]];return keys;
}
static NSURL *OwnedURL(NSString *account){NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;NSURL *config=CSAutomationFileURL([library URLByAppendingPathComponent:@"Preferences/WeChatImprove"],account);return [config.URLByDeletingPathExtension URLByAppendingPathExtension:@"owned.plist"];}
static NSMutableSet<NSString *> *OwnedFailureAccounts(void){static NSMutableSet *accounts;static dispatch_once_t once;dispatch_once(&once,^{accounts=[NSMutableSet set];});return accounts;}
void CSAutomationRememberOwnedSend(id wrap,NSString *account,NSString *conversation){
    if(!CSAutomationIsOwnedSend(wrap))return;NSArray *ids=CSAutomationMessageIdentifiers(wrap,account,conversation);if(!ids.count)return;
    // Called after AddMsg has assigned local/server IDs. Persist before another
    // hook's queued callback sees a reconstructed own-message wrapper.
    @synchronized(CSAutomationLedger.class){
        NSError *error=nil;CSAutomationLedger *ledger=[[CSAutomationLedger alloc]initWithURL:OwnedURL(account) account:account error:&error];
        BOOL fresh=[ledger claimIdentifiers:ids action:@"owned" now:NSDate.date error:&error];
        // If persistence fails after the native send, a rebuilt own wrapper
        // must not become a fresh manual trigger. Keep a process-long barrier;
        // a cold start admits only events newer than its admission boundary.
        if(!ledger || error || (!fresh && ![ledger hasIdentifiers:ids action:@"owned"]))[OwnedFailureAccounts() addObject:account];
    }
}
static BOOL PreviouslyOwned(NSArray *ids,NSString *account){
    NSError *error=nil;@synchronized(CSAutomationLedger.class){
        if([OwnedFailureAccounts() containsObject:account])return YES;
        CSAutomationLedger *ledger=[[CSAutomationLedger alloc]initWithURL:OwnedURL(account) account:account error:&error];
        if(error || !ledger)return YES;
        BOOL owned=[ledger hasIdentifiers:ids action:@"owned"];
        if(owned){NSError *mergeError=nil;[ledger claimIdentifiers:ids action:@"owned" now:NSDate.date error:&mergeError];if(mergeError)[OwnedFailureAccounts() addObject:account];}
        return owned;
    }
}
@interface CSAutomationXML : NSObject<NSXMLParserDelegate>
@property NSMutableArray<NSString *> *path;
@property NSMutableString *mentions,*title,*type;
@end
@implementation CSAutomationXML
- (instancetype)init{if((self=[super init])){_path=[NSMutableArray array];_mentions=[NSMutableString string];_title=[NSMutableString string];_type=[NSMutableString string];}return self;}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)q attributes:(NSDictionary *)attributes{(void)uri;(void)q;(void)attributes;[self.path addObject:name];if(self.path.count>32)[parser abortParsing];}
- (void)append:(NSString *)value{if([self.path isEqual:@[@"msgsource",@"atuserlist"]])[self.mentions appendString:value];else if([self.path isEqual:@[@"msg",@"appmsg",@"title"]])[self.title appendString:value];else if([self.path isEqual:@[@"msg",@"appmsg",@"type"]])[self.type appendString:value];}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)value{(void)parser;[self append:value];}
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)data{(void)parser;NSString *value=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];if(value)[self append:value];}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)q{(void)parser;(void)name;(void)uri;(void)q;if(self.path.count)[self.path removeLastObject];}
@end
static CSAutomationXML *XML(NSString *text){
    if(!text.length || text.length>65536 || [text rangeOfString:@"<!DOCTYPE" options:NSCaseInsensitiveSearch].location!=NSNotFound || [text rangeOfString:@"<!ENTITY" options:NSCaseInsensitiveSearch].location!=NSNotFound)return nil;
    NSXMLParser *parser=[[NSXMLParser alloc]initWithData:[text dataUsingEncoding:NSUTF8StringEncoding]];CSAutomationXML *delegate=[CSAutomationXML new];parser.delegate=delegate;parser.shouldResolveExternalEntities=NO;return [parser parse]?delegate:nil;
}
NSDictionary *CSAutomationEventFromWrap(id wrap,NSString *account,NSString *session){
    if(!NSThread.isMainThread || !account.length || !wrap)return nil;
    @try{
        unsigned long long type=CSMessageNativeUnsigned(wrap,@"m_uiMessageType");if(type!=1 && type!=49)return nil;
        NSString *from=String(wrap,@"m_nsFromUsr"),*to=String(wrap,@"m_nsToUsr");if(!from.length || !to.length)return nil;
        BOOL outgoing=[from isEqual:account];if(!outgoing && ![to isEqual:account])return nil;
        NSString *conversation=outgoing?to:from;if(session.length && ![session isEqual:conversation])return nil;
        // A later sync callback on the original owned object can add its
        // server ID. Retain that alias before excluding the object itself.
        if(CSAutomationIsOwnedSend(wrap)){CSAutomationRememberOwnedSend(wrap,account,conversation);return nil;}
        BOOL group=[conversation hasSuffix:@"@chatroom"];NSString *sender=group?String(wrap,@"m_nsRealChatUsr"):(outgoing?account:from);
        if(group && !sender.length && outgoing)sender=account;if(!sender.length)return nil;BOOL own=[sender isEqual:account];
        NSArray *ids=CSAutomationMessageIdentifiers(wrap,account,conversation);if(!ids.count || (own && PreviouslyOwned(ids,account)))return nil;
        NSString *text=String(wrap,@"m_nsContent");if(group){NSString *prefix=[sender stringByAppendingString:@":\n"];if([text hasPrefix:prefix])text=[text substringFromIndex:prefix.length];}
        if(type==49){CSAutomationXML *parsed=XML(text);if(![parsed.type isEqual:@"57"])return nil;text=parsed.title;}
        if(!text.length || text.length>12000)return nil;
        NSString *at=String(wrap,@"m_nsAtUserList");if(!at.length)at=XML(String(wrap,@"m_nsMsgSource")).mentions?:@"";
        NSArray *mentioned=[at componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",; \t\r\n"]];
        unsigned long long created=CSMessageNativeUnsigned(wrap,@"m_uiCreateTime");if(!created)return nil;
        return @{@"account":account,@"conversation":conversation,@"sender":sender,@"own":@(own),@"group":@(group),@"text":text,@"mentioned":@([mentioned containsObject:account]),@"created":@((NSTimeInterval)created),@"identifiers":ids,@"source":wrap};
    }@catch(__unused NSException *exception){return nil;}
}
NSDictionary *CSAutomationEventFromPat(id pat,NSString *account,NSString *conversation){
    if(!NSThread.isMainThread || !account.length || !conversation.length || !pat)return nil;
    @try{
        NSString *sender=String(pat,@"fromUserName"),*target=String(pat,@"pattedUserName");
        if(!sender.length || ![target isEqual:account] || [sender isEqual:account])return nil;
        BOOL group=[conversation hasSuffix:@"@chatroom"];if(!group && ![conversation isEqual:sender])return nil;
        if(!CSMessageNativeSupports(pat,@"serverId",@"q",@[]))return nil;
        long long server=[CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue];unsigned long long created=CSMessageNativeUnsigned(pat,@"createTime");if(server<=0 || !created)return nil;
        return @{@"account":account,@"conversation":conversation,@"sender":sender,@"own":@NO,@"group":@(group),@"text":@"",@"mentioned":@NO,@"created":@((NSTimeInterval)created/1000.0),@"identifiers":@[[NSString stringWithFormat:@"%@|%@|pat:%lld",account,conversation,server]],@"source":pat};
    }@catch(__unused NSException *exception){return nil;}
}
