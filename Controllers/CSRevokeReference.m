#import "CSRevokeReference.h"
#include <limits.h>
static NSString *CSLinkString(id value) {
    if ([value isKindOfClass:NSString.class]) return value;
    if ([value isKindOfClass:NSURL.class]) return [value absoluteString];
    return nil;
}
static unsigned long long CSDecimal(NSString *text, unsigned long long limit) {
    if (!text.length) return 0;
    unsigned long long n=0;
    for (NSUInteger i=0;i<text.length;i++) {
        unichar c=[text characterAtIndex:i];
        if (c<'0'||c>'9'||n>(limit-(c-'0'))/10) return 0;
        n=n*10+c-'0';
    }
    return n;
}
@implementation CSRevokeReference
+ (instancetype)referenceWithServerID:(long long)serverID localID:(unsigned int)localID {
    if (serverID<=0) return nil;
    CSRevokeReference *r=[self new];r->_serverID=serverID;r->_localID=localID;return r;
}
- (NSString *)link { return [NSString stringWithFormat:@"revoke_jump_v2_%lld_%u",self.serverID,self.localID]; }
@end
BOOL CSRevokeOwnsLink(id link) { return [CSLinkString(link) hasPrefix:@"revoke_jump_"]; }
// The replacement supplies presentation quotes, not part of the actor's name.
NSString *CSRevokeActorName(NSString *replacement) {
    if (![replacement isKindOfClass:NSString.class] || !replacement.length) return nil;
    NSRange action=NSMakeRange(NSNotFound,0);
    for (NSString *marker in @[@"撤回了一条消息",@"撤回了一则消息",@" recalled a message",@" recalled this message"]) {
        NSRange found=[replacement rangeOfString:marker options:NSBackwardsSearch];
        if (found.location!=NSNotFound) { action=found;break; }
    }
    if (action.location==NSNotFound) return nil;
    NSString *name=[[replacement substringToIndex:action.location]
        stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    for (NSArray<NSString *> *pair in @[@[@"\"",@"\""],@[@"“",@"”"],@[@"「",@"」"],@[@"『",@"』"],
                                      @[@"&quot;",@"&quot;"],@[@"&#34;",@"&#34;"],@[@"&#x22;",@"&#x22;"]]) {
        NSUInteger edges=pair[0].length+pair[1].length;
        if (name.length>=edges && [name hasPrefix:pair[0]] && [name hasSuffix:pair[1]]) {
            name=[name substringWithRange:NSMakeRange(pair[0].length,name.length-edges)];
            break; // Preserve quotes which are actually inside the nickname.
        }
    }
    return name.length ? name : nil;
}
NSString *CSRevokeEscapeText(NSString *text) {
    // These values are text nodes, never attributes. Literal quotes are valid here;
    // escaping them as &quot; is displayed literally by some native tip renderers.
    if (![text isKindOfClass:NSString.class]) return @"";
    NSString *result=[text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    result=[result stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    return [result stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
}
BOOL CSRevokeIsSelfReplacement(NSString *text) {
    if (![text isKindOfClass:NSString.class]) return NO;
    NSString *trimmed=[text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    for (NSString *token in @[@"你撤回了一条消息",@"你撤回了一则消息",@"You recalled a message",@"You recalled this message"])
        if ([trimmed caseInsensitiveCompare:token]==NSOrderedSame) return YES;
    return NO;
}
static NSArray *CSOwnedLinks(NSString *content) {
    if (![content isKindOfClass:NSString.class] || content.length>128*1024) return @[];
    static NSRegularExpression *links;
    static dispatch_once_t once;
    dispatch_once(&once,^{ links=[NSRegularExpression regularExpressionWithPattern:@"<a\\b[^>]*\\bhref\\s*=\\s*([\"'])(revoke_jump_[^\"']*)\\1" options:NSRegularExpressionCaseInsensitive error:nil]; });
    NSMutableArray *result=[NSMutableArray array];
    for (NSTextCheckingResult *m in [links matchesInString:content options:0 range:NSMakeRange(0,content.length)])
        [result addObject:[content substringWithRange:[m rangeAtIndex:2]]];
    return result;
}
BOOL CSRevokeHasOwnedReference(NSString *content, NSString *pattern) {
    return CSRevokeOwnsLink(pattern) || CSOwnedLinks(content).count>0;
}
static CSRevokeReference *CSParseLink(id value) {
    NSString *text=CSLinkString(value);
    if ([text hasPrefix:@"revoke_jump_v2_"]) {
        NSArray *parts=[[text substringFromIndex:15] componentsSeparatedByString:@"_"];
        if (parts.count!=2) return nil;
        unsigned long long server=CSDecimal(parts[0],LLONG_MAX),local=CSDecimal(parts[1],UINT_MAX);
        if (!local && ![parts[1] isEqual:@"0"]) return nil;
        return [CSRevokeReference referenceWithServerID:(long long)server localID:(unsigned int)local];
    }
    if (![text hasPrefix:@"revoke_jump_"]) return nil;
    return [CSRevokeReference referenceWithServerID:(long long)CSDecimal([text substringFromIndex:12],LLONG_MAX) localID:0];
}
CSRevokeReference *CSRevokeResolveReference(id clickedLink, NSString *content, NSString *pattern) {
    // A regular URL inside a tip remains native. Never infer its target from unrelated text.
    if (clickedLink && !CSRevokeOwnsLink(clickedLink)) return nil;
    NSMutableArray *candidates=[NSMutableArray array];
    if (clickedLink) [candidates addObject:CSLinkString(clickedLink) ?: @""];
    [candidates addObjectsFromArray:CSOwnedLinks(content)];
    if (CSRevokeOwnsLink(pattern)) [candidates addObject:pattern];
    CSRevokeReference *chosen=nil;
    for (NSString *candidate in candidates) {
        CSRevokeReference *r=CSParseLink(candidate);
        if (!r || (chosen && (chosen.serverID!=r.serverID || (chosen.localID && r.localID && chosen.localID!=r.localID)))) return nil;
        if (!chosen || r.localID) chosen=r;
    }
    return chosen;
}
BOOL CSRevokeSessionMatches(NSString *account, NSString *session, NSString *modelChat, NSString *from, NSString *to) {
    if (![account isKindOfClass:NSString.class]||![session isKindOfClass:NSString.class]||!account.length||!session.length) return NO;
    if (![modelChat isKindOfClass:NSString.class]) modelChat=nil;
    if (![from isKindOfClass:NSString.class]) from=nil;
    if (![to isKindOfClass:NSString.class]) to=nil;
    if (modelChat.length && ![modelChat isEqual:session]) return NO;
    // Current chat binding is authoritative when persisted synthetic tip fields are missing.
    if (!from.length && !to.length) return [modelChat isEqual:session];
    // Group storage may retain either room -> account or member -> room endpoints.
    // Require the exact room endpoint; a different room must never match by member name.
    BOOL group=[session hasSuffix:@"@chatroom"] || [session hasSuffix:@"@im.chatroom"];
    if (group) {
        if (![from isEqual:session] && ![to isEqual:session]) return NO;
        for (NSString *endpoint in @[from ?: @"",to ?: @""])
            if (([endpoint hasSuffix:@"@chatroom"] || [endpoint hasSuffix:@"@im.chatroom"]) &&
                ![endpoint isEqual:session]) return NO;
        return YES;
    }
    for (NSString *user in @[from ?: @"",to ?: @""])
        if (user.length && ![user isEqual:session] && ![user isEqual:account]) return NO;
    return [from isEqual:session] || [to isEqual:session] || [modelChat isEqual:session];
}
@interface CSRevokeXMLParser : NSObject <NSXMLParserDelegate>
@property(nonatomic) NSUInteger depth;
@property(nonatomic) NSUInteger revokeDepth;
@property(nonatomic) BOOL found;
@property(nonatomic) BOOL invalid;
@property(nonatomic,strong) NSMutableDictionary *fields;
@property(nonatomic,strong) NSMutableString *text;
@property(nonatomic,copy) NSString *field;
@end
@implementation CSRevokeXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)q attributes:(NSDictionary *)attrs {
    self.depth++;
    if ((self.depth==1 && ![name isEqual:@"revokemsg"] && !([name isEqual:@"sysmsg"] && [attrs[@"type"] isEqual:@"revokemsg"])) ||
        (self.field && self.depth>self.revokeDepth+1)) {self.invalid=YES;[parser abortParsing];return;}
    if (self.depth>32) { self.invalid=YES;[parser abortParsing];return; }
    if ([name isEqual:@"revokemsg"]) {
        if (self.found) { self.invalid=YES;[parser abortParsing];return; }
        self.found=YES;self.revokeDepth=self.depth;
    } else if (self.revokeDepth && self.depth==self.revokeDepth+1 && [@[@"session",@"newmsgid",@"msgid",@"replacemsg"] containsObject:name]) {
        if (self.fields[name]) {self.invalid=YES;[parser abortParsing];return;}
        self.field=name;self.text=[NSMutableString string];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)text { if(self.field) [self.text appendString:text]; }
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)data {
    NSString *text=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];if (self.field && text) [self.text appendString:text];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)q {
    if (self.field && self.depth==self.revokeDepth+1) {
        self.fields[self.field]=[self.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];self.field=nil;
    }
    if (self.depth==self.revokeDepth) self.revokeDepth=0;
    self.depth--;
}
@end
@implementation CSRevokeEvent
+ (instancetype)eventFromXML:(NSString *)xml {
    if (![xml isKindOfClass:NSString.class]||xml.length>128*1024||!xml.length||[xml rangeOfString:@"<!DOCTYPE" options:NSCaseInsensitiveSearch].location!=NSNotFound) return nil;
    xml=[xml stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    // Some group transports prepend "member:\n". Strip only this bounded envelope,
    // never search arbitrary text for an embedded revoke XML fragment.
    if (![xml hasPrefix:@"<"]) {
        NSRange delimiter=[xml rangeOfString:@":\n"];
        if (delimiter.location==NSNotFound || !delimiter.location || delimiter.location>256) return nil;
        NSString *sender=[xml substringToIndex:delimiter.location];
        NSCharacterSet *allowed=[NSCharacterSet characterSetWithCharactersInString:
            @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-.@"];
        if ([sender rangeOfCharacterFromSet:allowed.invertedSet].location!=NSNotFound) return nil;
        xml=[[xml substringFromIndex:NSMaxRange(delimiter)] stringByTrimmingCharactersInSet:
            NSCharacterSet.whitespaceAndNewlineCharacterSet];
    }
    CSRevokeXMLParser *delegate=[CSRevokeXMLParser new];delegate.fields=[NSMutableDictionary dictionary];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    parser.shouldResolveExternalEntities=NO;parser.delegate=delegate;
    if (![parser parse]||delegate.invalid||!delegate.found) return nil;
    NSString *raw=delegate.fields[@"newmsgid"] ?: delegate.fields[@"msgid"];
    long long server=(long long)CSDecimal(raw,LLONG_MAX);
    if (server<=0) return nil;
    CSRevokeEvent *event=[self new];event->_serverID=server;event->_session=[delegate.fields[@"session"] copy] ?: @"";
    event->_replacement=[delegate.fields[@"replacemsg"] copy] ?: @"";return event;
}
@end
