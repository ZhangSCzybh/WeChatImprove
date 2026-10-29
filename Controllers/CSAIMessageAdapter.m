#import "CSAIMessageAdapter.h"
#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>

static const void *OwnedKey=&OwnedKey;
void CSAIMarkOwnedSend(id wrap) { if(wrap)objc_setAssociatedObject(wrap,OwnedKey,@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
BOOL CSAIIsOwnedSend(id wrap) { return wrap && [objc_getAssociatedObject(wrap,OwnedKey) boolValue]; }
static NSString *String(id object,NSString *name) {
    id value=CSMessageActionNativeObject(object,name);return [value isKindOfClass:NSString.class]?[value copy]:@"";
}
static NSRegularExpression *MentionPattern(void) {
    static NSRegularExpression *pattern;static dispatch_once_t once;
    dispatch_once(&once,^{pattern=[NSRegularExpression regularExpressionWithPattern:@"@[^\\n\\u2005]+\\u2005" options:0 error:NULL];});
    return pattern;
}
@interface CSAIMentionParser : NSObject <NSXMLParserDelegate>
@property NSMutableString *list;
@property BOOL inList;
@end
@implementation CSAIMentionParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)qualified attributes:(NSDictionary *)attributes {
    (void)parser;(void)uri;(void)qualified;(void)attributes;if([name isEqual:@"atuserlist"]){self.inList=YES;self.list=[NSMutableString string];}
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)text {(void)parser;if(self.inList)[self.list appendString:text];}
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)data {(void)parser;if(self.inList){NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];if(text)[self.list appendString:text];}}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)qualified {(void)parser;(void)uri;(void)qualified;if([name isEqual:@"atuserlist"])self.inList=NO;}
@end
NSDictionary *CSAIEventFromWrap(id wrap,NSString *account,NSString *session) {return CSAIEventFromWrapWithImages(wrap,account,session,YES);}
static NSDictionary *EventFromWrap(id wrap,NSString *account,NSString *session,BOOL imagesEnabled,NSDictionary *conversations) {
    if(!NSThread.isMainThread || !account.length || !wrap || CSAIIsOwnedSend(wrap))return nil;
    @try {
        // Read type once and reject disabled images before native identity/content parsing.
        unsigned long long type=CSMessageNativeUnsigned(wrap,@"m_uiMessageType");
        if(type!=1 && (type!=3 || !imagesEnabled))return nil;
        NSString *from=String(wrap,@"m_nsFromUsr"),*to=String(wrap,@"m_nsToUsr");
        if(!from.length || [from isEqual:account] || ![to isEqual:account])return nil;
        BOOL group=[from hasSuffix:@"@chatroom"];
        if(session.length && ![session isEqual:from])return nil;
        NSDictionary *policy=conversations[from];
        if(conversations && ![policy[@"enabled"] boolValue])return nil;
        NSString *list=group?String(wrap,@"m_nsAtUserList"):@"";
        if(group && !list.length){
            NSString *source=String(wrap,@"m_nsMsgSource");
            if(source.length && source.length<=16384 && [source rangeOfString:@"atuserlist"].location!=NSNotFound){
                NSXMLParser *parser=[[NSXMLParser alloc]initWithData:[source dataUsingEncoding:NSUTF8StringEncoding]];
                CSAIMentionParser *delegate=[CSAIMentionParser new];parser.delegate=delegate;parser.shouldResolveExternalEntities=NO;
                if([parser parse])list=delegate.list?:@"";
            }
        }
        static NSCharacterSet *separators;static dispatch_once_t once;
        dispatch_once(&once,^{separators=[NSCharacterSet characterSetWithCharactersInString:@",; \t\r\n"];});
        NSArray *mentions=[list componentsSeparatedByCharactersInSet:separators];
        BOOL atAll=group && (CSMessageNativeUnsigned(wrap,@"m_nsAtAll") || [mentions containsObject:@"notify@all"]);
        BOOL mentioned=[mentions containsObject:account];
        if(group && atAll)return nil;
        // This is the same text admission rule as the coordinator. Images must
        // retain their identities for staging, subsequent mentions and late aliases.
        if(group && type==1 && conversations && ![policy[@"allowUnmentioned"] boolValue] && !mentioned)return nil;
        NSString *text=type==1?String(wrap,@"m_nsContent"):@"",*sender=group?String(wrap,@"m_nsRealChatUsr"):from;
        if((type==1 && (!text.length || text.length>12000)) || !sender.length || [sender isEqual:account])return nil;
        if(group){NSString *prefix=[sender stringByAppendingString:@":\n"];if([text hasPrefix:prefix])text=[text substringFromIndex:prefix.length];}
        if(group && [text containsString:@"@"]){
            // WeChat's mention token terminates with U+2005. Do not strip arbitrary prose containing @.
            text=[MentionPattern() stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0,text.length) withTemplate:@""];
        }
        text=[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if(type==1 && (!text.length || (group && [text hasPrefix:@"@"] && [text rangeOfCharacterFromSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].location==NSNotFound)))return nil;
        unsigned long long server=CSMessageNativeUnsigned(wrap,@"m_n64MesSvrID"),local=CSMessageNativeUnsigned(wrap,@"m_uiMesLocalID"),created=CSMessageNativeUnsigned(wrap,@"m_uiCreateTime");
        if(!created || (!server && !local))return nil;
        NSMutableArray *identifiers=[NSMutableArray array];
        if(server)[identifiers addObject:[NSString stringWithFormat:@"%@|%@|s:%llu",account,from,server]];
        if(local)[identifiers addObject:[NSString stringWithFormat:@"%@|%@|l:%llu:%llu",account,from,local,created]];
        NSMutableDictionary *event=[@{@"account":account,@"conversation":from,@"sender":sender,@"identifiers":identifiers,@"text":text,@"type":@(type),@"group":@(group),@"mentioned":@(mentioned),@"atAll":@(atAll),@"created":@((NSTimeInterval)created),@"live":@YES} mutableCopy];
        if(type==3){event[@"imageSource"]=wrap;event[@"imageLocalID"]=@(local);event[@"imageServerID"]=@(server);}
        return event;
    }@catch(__unused NSException *exception){return nil;}
}
NSDictionary *CSAIEventFromWrapWithImages(id wrap,NSString *account,NSString *session,BOOL imagesEnabled) {return EventFromWrap(wrap,account,session,imagesEnabled,nil);}
NSDictionary *CSAIEventFromWrapWithConfiguration(id wrap,NSString *account,NSString *session,NSDictionary *configuration) {return EventFromWrap(wrap,account,session,[configuration[@"imageEnabled"] boolValue],configuration[@"conversations"]);}
