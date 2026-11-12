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
// Keep the exact native PatWrap getter ABI so raw XML, native insertion and
// compound-message callbacks enter the same validation and durable dedup path.
@interface CSAutomationPatSnapshot : NSObject
@property(nonatomic,copy,readonly) NSString *fromUserName,*pattedUserName;
@property(nonatomic,readonly) long long serverId;
@property(nonatomic,readonly) unsigned long long createTime;
- (instancetype)initWithSender:(NSString *)sender target:(NSString *)target server:(long long)server milliseconds:(unsigned long long)milliseconds;
@end
@implementation CSAutomationPatSnapshot
- (instancetype)initWithSender:(NSString *)sender target:(NSString *)target server:(long long)server milliseconds:(unsigned long long)milliseconds{
    if((self=[super init])){_fromUserName=[sender copy];_pattedUserName=[target copy];_serverId=server;_createTime=milliseconds;}return self;
}
@end
@interface CSAutomationPatXML : NSObject<NSXMLParserDelegate>
@property(nonatomic) NSMutableArray<NSString *> *path;
@property(nonatomic) NSMutableDictionary<NSString *,NSMutableString *> *fields;
@property(nonatomic) BOOL valid,sawRoot,sawPat;
@end
@implementation CSAutomationPatXML
- (instancetype)init{if((self=[super init])){_path=[NSMutableArray array];_fields=[NSMutableDictionary dictionary];_valid=YES;}return self;}
- (void)reject:(NSXMLParser *)parser{self.valid=NO;[parser abortParsing];}
- (BOOL)isIdentityField:(NSString *)name{return [@[@"fromusername",@"chatusername",@"pattedusername"] containsObject:name];}
- (BOOL)isPatField:(NSString *)name{return [self isIdentityField:name] || [name isEqual:@"template"];}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)q attributes:(NSDictionary *)attributes{
    (void)q;
    if(uri.length){[self reject:parser];return;}
    if(self.path.count>=16){[self reject:parser];return;}
    if(!self.path.count){
        if(self.sawRoot || ![name isEqual:@"sysmsg"] || ![attributes[@"type"] isEqual:@"pat"]){[self reject:parser];return;}self.sawRoot=YES;
    }else if(self.path.count==1 && [name isEqual:@"pat"]){
        if(self.sawPat){[self reject:parser];return;}self.sawPat=YES;
    }else if(self.path.count==2 && [self.path isEqual:@[@"sysmsg",@"pat"]] && [self isPatField:name]){
        if(self.fields[name]){[self reject:parser];return;}self.fields[name]=[NSMutableString string];
    }else if(self.path.count==3 && [self.path[0] isEqual:@"sysmsg"] && [self.path[1] isEqual:@"pat"] && [self isPatField:self.path[2]]){
        [self reject:parser];return;
    }
    [self.path addObject:name];
}
- (void)append:(NSString *)value parser:(NSXMLParser *)parser{
    if(self.path.count!=3 || ![self.path[0] isEqual:@"sysmsg"] || ![self.path[1] isEqual:@"pat"])return;
    NSMutableString *field=self.fields[self.path[2]];if(!field)return;
    NSUInteger limit=[self.path[2] isEqual:@"template"]?12000:256;
    if(field.length+value.length>limit){[self reject:parser];return;}[field appendString:value];
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)value{[self append:value parser:parser];}
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)data{NSString *value=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];if(!value){[self reject:parser];return;}[self append:value parser:parser];}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)q{(void)name;(void)uri;(void)q;if(!self.path.count){[self reject:parser];return;}[self.path removeLastObject];}
@end
static BOOL CSAutomationPatUsername(NSString *name){
    return name.length && name.length<=256 && [name rangeOfCharacterFromSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].location==NSNotFound && [name rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location==NSNotFound && [name rangeOfString:@"|"].location==NSNotFound;
}
NSDictionary *CSAutomationPatFromXMLMessage(id wrap,NSString *session){
    if(!NSThread.isMainThread || !wrap || ![session isKindOfClass:NSString.class])return nil;
    @try{
        if(!CSMessageNativeSupports(wrap,@"m_uiMessageType",@"I",@[]) || CSMessageNativeUnsigned(wrap,@"m_uiMessageType")!=10002 ||
           !CSMessageNativeSupports(wrap,@"m_n64MesSvrID",@"q",@[]) || !CSMessageNativeSupports(wrap,@"m_uiCreateTime",@"I",@[]))return nil;
        long long server=[CSMessageNativeInvoke(wrap,@"m_n64MesSvrID",@[]) longLongValue];
        unsigned long long seconds=CSMessageNativeUnsigned(wrap,@"m_uiCreateTime");if(server<=0 || !seconds)return nil;
        NSString *from=String(wrap,@"m_nsFromUsr"),*to=String(wrap,@"m_nsToUsr"),*text=String(wrap,@"m_nsContent");
        if(!CSAutomationPatUsername(from) || !CSAutomationPatUsername(to) || !text.length || text.length>65536 ||
           [text rangeOfString:@"<!DOCTYPE" options:NSCaseInsensitiveSearch].location!=NSNotFound || [text rangeOfString:@"<!ENTITY" options:NSCaseInsensitiveSearch].location!=NSNotFound)return nil;
        NSData *data=[text dataUsingEncoding:NSUTF8StringEncoding];if(!data.length || data.length>65536)return nil;
        // Native ChangeForChatRoom splits exactly sender + ":\n". Group
        // type10002 bypasses that conversion in ChangeForDisplay; the native
        // XML reader tolerates its leading text, whereas NSXMLParser does not.
        // Normalize only that bounded envelope, then bind it to the strict
        // XML sender and room below. Never search for XML inside arbitrary text.
        NSString *prefixSender=nil;
        NSRange first=[text rangeOfCharacterFromSet:NSCharacterSet.whitespaceAndNewlineCharacterSet.invertedSet];
        if(first.location!=NSNotFound && [text characterAtIndex:first.location]!='<' && [text characterAtIndex:first.location]!=0xfeff){
            NSRange separator=[text rangeOfString:@":\n" options:0 range:NSMakeRange(0,MIN(text.length,258UL))];
            NSString *specifiedRoute=String(wrap,@"m_nsSpecifiedChatName");
            BOOL roomEnvelope=[from hasSuffix:@"@chatroom"] || [specifiedRoute hasSuffix:@"@chatroom"] || [session hasSuffix:@"@chatroom"];
            if(separator.location!=NSNotFound && roomEnvelope){
                NSString *candidate=[text substringToIndex:separator.location];
                NSString *body=[text substringFromIndex:NSMaxRange(separator)];
                if(CSAutomationPatUsername(candidate) && ![candidate hasSuffix:@"@chatroom"] &&
                   [candidate rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"<>&:"]].location==NSNotFound &&
                   [body hasPrefix:@"<sysmsg"]){
                    prefixSender=candidate;
                    data=[body dataUsingEncoding:NSUTF8StringEncoding];
                }
            }
        }
        NSXMLParser *parser=[[NSXMLParser alloc]initWithData:data];CSAutomationPatXML *xml=[CSAutomationPatXML new];parser.delegate=xml;parser.shouldProcessNamespaces=YES;parser.shouldResolveExternalEntities=NO;
        BOOL parsed=[parser parse];
        if(!parsed || !xml.valid)return nil;
        if(!xml.sawRoot || !xml.sawPat || xml.path.count)return nil;
        NSString *sender=xml.fields[@"fromusername"],*chat=xml.fields[@"chatusername"],*target=xml.fields[@"pattedusername"];
        if(![xml.fields[@"template"] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length)return nil;
        if(!CSAutomationPatUsername(sender) || !CSAutomationPatUsername(chat) || !CSAutomationPatUsername(target) || [sender hasSuffix:@"@chatroom"] || [target hasSuffix:@"@chatroom"])return nil;
        BOOL group=[chat hasSuffix:@"@chatroom"];
        if(prefixSender){
            if(!group || ![prefixSender isEqual:sender])return nil;
        }
        NSString *specified=String(wrap,@"m_nsSpecifiedChatName");
        NSString *route=specified.length?specified:(session.length?session:from);
        // Only incoming pats addressed to this envelope's recipient can be
        // admitted. EventFromPat subsequently binds that target to the account.
        if(![to isEqual:target])return nil;
        if(group){
            // HandleSvrCmd prefers m_nsSpecifiedChatName to the outer sender.
            // Accept a member sender only when that native/session route binds
            // it to the same room as the XML; never substitute the active chat.
            if((![from isEqual:chat] && ![from isEqual:sender]) || ![route isEqual:chat])return nil;
        }else if(![from isEqual:sender] || (![chat isEqual:sender] && ![chat isEqual:target]))return nil;
        NSString *conversation=group?chat:sender;
        if(session.length && ![session isEqual:conversation] && (group || ![session isEqual:chat]))return nil;
        if(specified.length && ![specified isEqual:conversation] && (group || ![specified isEqual:chat]))return nil;
        CSAutomationPatSnapshot *pat=[[CSAutomationPatSnapshot alloc]initWithSender:sender target:target server:server milliseconds:seconds*1000ULL];
        return @{@"pat":pat,@"conversation":[conversation copy]};
    }@catch(__unused NSException *exception){return nil;}
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
        if(!sender.length)return nil;
        if(![target isEqual:account])return nil;
        if([sender isEqual:account])return nil;
        BOOL group=[conversation hasSuffix:@"@chatroom"];if(!group && ![conversation isEqual:sender])return nil;
        if(!CSMessageNativeSupports(pat,@"serverId",@"q",@[]) || !CSMessageNativeSupports(pat,@"createTime",@"Q",@[]))return nil;
        long long server=[CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue];unsigned long long created=CSMessageNativeUnsigned(pat,@"createTime");if(server<=0 || !created)return nil;
        // Native OnGetNewXmlMsg multiplies m_uiCreateTime seconds by 1000;
        // compound-message pats retain that unsigned 64-bit millisecond value.
        return @{@"account":account,@"conversation":conversation,@"sender":sender,@"own":@NO,@"group":@(group),@"text":@"",@"mentioned":@NO,@"created":@((NSTimeInterval)created/1000.0),@"identifiers":@[[NSString stringWithFormat:@"%@|%@|pat:%lld",account,conversation,server]],@"source":pat};
    }@catch(__unused NSException *exception){return nil;}
}
