#import "CSAIMessageAdapter.h"
#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>

static const void *OwnedKey=&OwnedKey;
void CSAIMarkOwnedSend(id wrap) { if(wrap)objc_setAssociatedObject(wrap,OwnedKey,@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
BOOL CSAIIsOwnedSend(id wrap) { return wrap && [objc_getAssociatedObject(wrap,OwnedKey) boolValue]; }
static NSString *String(id object,NSString *name) {
    id value=CSMessageActionNativeObject(object,name);return [value isKindOfClass:NSString.class]?[value copy]:@"";
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
NSDictionary *CSAIEventFromWrap(id wrap,NSString *account,NSString *session) {
    if(!NSThread.isMainThread || !account.length || !wrap || CSAIIsOwnedSend(wrap))return nil;
    @try {
        NSString *from=String(wrap,@"m_nsFromUsr"),*to=String(wrap,@"m_nsToUsr");
        if(!from.length || [from isEqual:account] || ![to isEqual:account])return nil;
        BOOL group=[from hasSuffix:@"@chatroom"];
        if(session.length && ![session isEqual:from])return nil;
        if(CSMessageNativeUnsigned(wrap,@"m_uiMessageType")!=1)return nil;
        NSString *text=String(wrap,@"m_nsContent"),*sender=group?String(wrap,@"m_nsRealChatUsr"):from;
        if(!text.length || text.length>12000 || !sender.length || [sender isEqual:account])return nil;
        if(group){NSString *prefix=[sender stringByAppendingString:@":\n"];if([text hasPrefix:prefix])text=[text substringFromIndex:prefix.length];}
        NSString *list=String(wrap,@"m_nsAtUserList");
        if(group && !list.length){
            NSString *source=String(wrap,@"m_nsMsgSource");
            if(source.length && source.length<=16384){
                NSXMLParser *parser=[[NSXMLParser alloc]initWithData:[source dataUsingEncoding:NSUTF8StringEncoding]];
                CSAIMentionParser *delegate=[CSAIMentionParser new];parser.delegate=delegate;parser.shouldResolveExternalEntities=NO;
                if([parser parse])list=delegate.list?:@"";
            }
        }
        NSCharacterSet *separators=[NSCharacterSet characterSetWithCharactersInString:@",; \t\r\n"];
        NSArray *mentions=[list componentsSeparatedByCharactersInSet:separators];
        BOOL atAll=CSMessageNativeUnsigned(wrap,@"m_nsAtAll") || [mentions containsObject:@"notify@all"];
        BOOL mentioned=[mentions containsObject:account];
        if(group && (!mentioned || atAll))return nil;
        if(group){
            // WeChat's mention token terminates with U+2005. Do not strip arbitrary prose containing @.
            NSRegularExpression *mention=[NSRegularExpression regularExpressionWithPattern:@"@[^\\n\\u2005]+\\u2005" options:0 error:NULL];
            text=[mention stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0,text.length) withTemplate:@""];
        }
        text=[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if(!text.length || (group && [text hasPrefix:@"@"] && [text rangeOfCharacterFromSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].location==NSNotFound))return nil;
        unsigned long long server=CSMessageNativeUnsigned(wrap,@"m_n64MesSvrID"),local=CSMessageNativeUnsigned(wrap,@"m_uiMesLocalID"),created=CSMessageNativeUnsigned(wrap,@"m_uiCreateTime");
        if(!created || (!server && !local))return nil;
        NSMutableArray *identifiers=[NSMutableArray array];
        if(server)[identifiers addObject:[NSString stringWithFormat:@"%@|%@|s:%llu",account,from,server]];
        if(local)[identifiers addObject:[NSString stringWithFormat:@"%@|%@|l:%llu:%llu",account,from,local,created]];
        return @{@"account":account,@"conversation":from,@"sender":sender,@"identifiers":identifiers,@"text":text,@"type":@1,@"group":@(group),@"mentioned":@(mentioned),@"atAll":@(atAll),@"created":@((NSTimeInterval)created),@"live":@YES};
    }@catch(__unused NSException *exception){return nil;}
}
