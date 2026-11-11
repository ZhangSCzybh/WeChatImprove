#import "CSGroupChatNoticeReference.h"

static NSString *const CSNoticePrefix=@"csgroupmember_v1.";
static BOOL CSNoticeIdentifier(id value, NSUInteger limit) {
    if (![value isKindOfClass:NSString.class] || ![value length] || [value length]>limit) return NO;
    static NSCharacterSet *invalid; static dispatch_once_t once;
    dispatch_once(&once,^{ invalid=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_@.-"].invertedSet; });
    return [value rangeOfCharacterFromSet:invalid].location==NSNotFound;
}
static NSString *CSNoticeEncode(NSString *value) {
    NSString *text=[[value dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    return [[[text stringByReplacingOccurrencesOfString:@"+" withString:@"-"] stringByReplacingOccurrencesOfString:@"/" withString:@"_"] stringByReplacingOccurrencesOfString:@"=" withString:@""];
}
static NSString *CSNoticeDecode(NSString *value) {
    if (!value.length || value.length>2048) return nil;
    static NSCharacterSet *invalid; static dispatch_once_t once;
    dispatch_once(&once,^{ invalid=[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-"].invertedSet; });
    if ([value rangeOfCharacterFromSet:invalid].location!=NSNotFound || value.length%4==1) return nil;
    NSMutableString *base=[[[value stringByReplacingOccurrencesOfString:@"-" withString:@"+"] stringByReplacingOccurrencesOfString:@"_" withString:@"/"] mutableCopy];
    while (base.length%4) [base appendString:@"="];
    NSData *data=[[NSData alloc] initWithBase64EncodedString:base options:0];
    NSString *decoded=data?[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]:nil;
    return decoded && [CSNoticeEncode(decoded) isEqual:value] ? decoded : nil;
}
NSString *CSGroupChatNoticeLink(NSString *account, NSString *room, NSString *member, NSString *event) {
    if (!CSNoticeIdentifier(account,256) || !CSNoticeIdentifier(room,256) || ![room hasSuffix:@"@chatroom"] ||
        !CSNoticeIdentifier(member,256) || [member hasSuffix:@"@chatroom"] || ![event isKindOfClass:NSString.class] || !event.length || event.length>1024 ||
        [event rangeOfCharacterFromSet:NSCharacterSet.controlCharacterSet].location!=NSNotFound) return nil;
    if ([[event dataUsingEncoding:NSUTF8StringEncoding] length]>1024) return nil;
    return [CSNoticePrefix stringByAppendingString:[@[CSNoticeEncode(account),CSNoticeEncode(room),CSNoticeEncode(member),CSNoticeEncode(event)] componentsJoinedByString:@"."]];
}
NSDictionary<NSString *,NSString *> *CSGroupChatParseNoticeLink(id link) {
    if ([link isKindOfClass:NSURL.class]) link=[link absoluteString];
    if (![link isKindOfClass:NSString.class] || [link length]>4096 || ![link hasPrefix:CSNoticePrefix]) return nil;
    NSArray *pieces=[[link substringFromIndex:CSNoticePrefix.length] componentsSeparatedByString:@"."];
    if (pieces.count!=4) return nil;
    NSString *account=CSNoticeDecode(pieces[0]), *room=CSNoticeDecode(pieces[1]), *member=CSNoticeDecode(pieces[2]), *event=CSNoticeDecode(pieces[3]);
    NSString *canonical=CSGroupChatNoticeLink(account,room,member,event);
    return canonical && [canonical isEqual:link] ? @{@"account":account,@"room":room,@"member":member,@"event":event,@"link":canonical} : nil;
}
NSDictionary<NSString *,NSString *> *CSGroupChatResolveNoticeLink(id clickedLink, NSString *content, NSString *pattern) {
    if (![content isKindOfClass:NSString.class] || !content.length || content.length>65536 || (pattern && ![pattern isKindOfClass:NSString.class])) return nil;
    NSDictionary *chosen=clickedLink?CSGroupChatParseNoticeLink(clickedLink):nil;
    if (clickedLink && !chosen) return nil;
    static NSRegularExpression *anchors; static dispatch_once_t once;
    dispatch_once(&once,^{ anchors=[NSRegularExpression regularExpressionWithPattern:@"<a\\b[^>]*\\bhref\\s*=\\s*([\"'])(csgroupmember_v1\\.[^\"']*)\\1" options:0 error:nil]; });
    NSArray *matches=[anchors matchesInString:content options:0 range:NSMakeRange(0,content.length)];
    if (!matches.count || matches.count>16) return nil;
    for (NSTextCheckingResult *match in matches) {
        NSDictionary *candidate=CSGroupChatParseNoticeLink([content substringWithRange:[match rangeAtIndex:2]]);
        if (!candidate || (chosen && ![chosen[@"link"] isEqual:candidate[@"link"]])) return nil;
        chosen=candidate;
    }
    if (pattern.length && ![pattern isEqual:chosen[@"link"]]) return nil;
    return chosen;
}
