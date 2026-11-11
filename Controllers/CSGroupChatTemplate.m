#import "CSGroupChatTemplate.h"
NSString *CSGroupChatDefaultWelcome(void) { return @"欢迎@昵称加入@群昵称"; }
NSString *CSGroupChatDefaultDeparture(void) { return @"@昵称 退出了群聊\n检测时间：@时间\n当前剩余人数@群人数，江湖再见！\n点击昵称可进入资料页"; }
NSString *CSGroupChatDefaultRoomDeparture(void) { return @"@昵称 已离开「@群昵称」\n离群类型：@离群类型\n检测时间：@时间\n当前剩余 @群人数 人"; }
NSString *CSGroupChatNameValue(id value) {
    if (![value isKindOfClass:NSString.class]) return @"";
    NSString *trimmed=[value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    return !trimmed.length || [trimmed caseInsensitiveCompare:@"null"]==NSOrderedSame || [trimmed caseInsensitiveCompare:@"(null)"]==NSOrderedSame ? @"" : value;
}
static NSString *Nickname(id nickname,id remark,NSString *memberID) {
    NSString *name=CSGroupChatNameValue(nickname);if(name.length)return name;
    name=CSGroupChatNameValue(remark);return name.length?name:memberID;
}
NSString *CSGroupChatEscapeXML(NSString *text) {
    NSMutableString *result=[text mutableCopy] ?: [NSMutableString string];
    for (NSUInteger i=result.length;i>0;i--) {
        unichar ch=[result characterAtIndex:i-1];
        if ((ch<0x20 && ch!='\t' && ch!='\n' && ch!='\r') || ch==0xfffe || ch==0xffff)
            [result deleteCharactersInRange:NSMakeRange(i-1,1)];
    }
    for (NSArray *pair in @[@[@"&",@"&amp;"],@[@"<",@"&lt;"],@[@">",@"&gt;"],@[@"\"",@"&quot;"],@[@"'",@"&apos;"]])
        [result replaceOccurrencesOfString:pair[0] withString:pair[1] options:0 range:NSMakeRange(0,result.length)];
    return result;
}
// Remove only source-authored parentheses made empty by the missing ID.
// A stack supports nested pairs without ever scanning substituted values.
static NSIndexSet *EmptyIDParens(NSString *format) {
    NSString *token=@"@微信ID";
    if([format rangeOfString:token].location==NSNotFound)return nil;
    NSMutableArray<NSNumber *> *starts=[NSMutableArray array],*states=[NSMutableArray array];
    NSMutableIndexSet *remove=[NSMutableIndexSet indexSet];
    NSCharacterSet *whitespace=NSCharacterSet.whitespaceAndNewlineCharacterSet;
    for(NSUInteger i=0;i<format.length;i++){
        unichar ch=[format characterAtIndex:i];
        if(ch=='(' || ch==0xff08){[starts addObject:@(i)];[states addObject:@0];continue;}
        if(!starts.count)continue;
        NSUInteger top=starts.count-1;
        if(ch==')' || ch==0xff09){
            NSUInteger start=starts[top].unsignedIntegerValue;
            BOOL empty=states[top].integerValue==1 && [format characterAtIndex:start]==(ch==')'?'(':0xff08);
            [starts removeLastObject];[states removeLastObject];
            if(empty)[remove addIndexesInRange:NSMakeRange(start,i-start+1)];
            if(states.count && states.lastObject.integerValue>=0)states[states.count-1]=empty?@1:@(-1);
        }else if(ch=='@' && i+token.length<=format.length &&
            [format compare:token options:NSLiteralSearch range:NSMakeRange(i,token.length)]==NSOrderedSame){
            if(states[top].integerValue>=0)states[top]=@1;
            i+=token.length-1;
        }else if(![whitespace characterIsMember:ch])states[top]=@(-1);
    }
    return remove.count?remove:nil;
}
NSString *CSGroupChatRenderTemplate(NSString *format, NSDictionary<NSString *,NSString *> *values) {
    if (![format isKindOfClass:NSString.class]) return @"";
    id memberID=values[@"@微信ID"];
    NSIndexSet *omitted=[memberID isKindOfClass:NSString.class] && ![memberID length]?EmptyIDParens(format):nil;
    static NSRegularExpression *pattern;static dispatch_once_t once;
    dispatch_once(&once,^{pattern=[NSRegularExpression regularExpressionWithPattern:@"@群昵称|@群人数|@离群类型|@昵称|@备注|@微信ID|@时间" options:0 error:NULL];});
    NSMutableString *result=[NSMutableString string];__block NSUInteger cursor=0;
    void (^appendLiteral)(NSRange)=^(NSRange literal){
        __block NSUInteger start=literal.location;
        [omitted enumerateRangesInRange:literal options:0 usingBlock:^(NSRange range,BOOL *stop){
            (void)stop;[result appendString:[format substringWithRange:NSMakeRange(start,range.location-start)]];start=NSMaxRange(range);
        }];
        [result appendString:[format substringWithRange:NSMakeRange(start,NSMaxRange(literal)-start)]];
    };
    [pattern enumerateMatchesInString:format options:0 range:NSMakeRange(0,format.length) usingBlock:^(NSTextCheckingResult *match,NSMatchingFlags flags,BOOL *stop){
        (void)flags;(void)stop;appendLiteral(NSMakeRange(cursor,match.range.location-cursor));
        NSString *token=[format substringWithRange:match.range],*value=values[token];
        if(![omitted containsIndex:match.range.location])[result appendString:[value isKindOfClass:NSString.class]?value:token];
        cursor=NSMaxRange(match.range);
    }];
    appendLiteral(NSMakeRange(cursor,format.length-cursor));return result;
}
NSString *CSGroupChatDateText(NSDate *date) {
    NSDateFormatter *formatter=[NSDateFormatter new];formatter.locale=[NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    formatter.timeZone=NSTimeZone.localTimeZone;formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";return [formatter stringFromDate:date];
}
NSDictionary *CSGroupChatWelcomeText(NSString *format, NSArray<NSString *> *members, NSDictionary<NSString *,NSString *> *names, NSString *roomName, NSUInteger count, NSDate *date) {
    return CSGroupChatWelcomeTextWithRemarks(format,members,names,@{},roomName,count,date);
}
NSDictionary *CSGroupChatWelcomeTextWithRemarks(NSString *format, NSArray<NSString *> *members, NSDictionary<NSString *,NSString *> *names, NSDictionary<NSString *,NSString *> *remarks, NSString *roomName, NSUInteger count, NSDate *date) {
    NSMutableArray *mentions=[NSMutableArray array],*ids=[NSMutableArray array],*memberRemarks=[NSMutableArray array],*memberIDs=[NSMutableArray array];NSMutableSet *seen=[NSMutableSet set];
    BOOL usesMention=[format rangeOfString:@"@昵称"].location!=NSNotFound;
    NSCharacterSet *mentionBreaks=[NSCharacterSet characterSetWithCharactersInString:@"\r\n\u2005"];
    for (NSString *member in members) {
        if (![member isKindOfClass:NSString.class] || !member.length || [member isEqual:@"notify@all"] || [seen containsObject:member])continue;
        [seen addObject:member];NSString *remark=CSGroupChatNameValue(remarks[member]),*name=Nickname(names[member],remark,member);
        // A display name must not inject another apparent mention segment.
        name=[[name componentsSeparatedByCharactersInSet:mentionBreaks] componentsJoinedByString:@" "];
        [mentions addObject:[NSString stringWithFormat:@"@%@\u2005",name]];if(usesMention)[ids addObject:member];
        if(remark.length)[memberRemarks addObject:[[remark componentsSeparatedByCharactersInSet:mentionBreaks] componentsJoinedByString:@" "]];
        NSString *memberID=CSGroupChatNameValue(member);
        if(memberID.length)[memberIDs addObject:memberID];
    }
    NSString *text=CSGroupChatRenderTemplate(format,@{@"@昵称":[mentions componentsJoinedByString:@" "],@"@备注":[memberRemarks componentsJoinedByString:@"、"],@"@微信ID":[memberIDs componentsJoinedByString:@"、"],@"@群昵称":roomName?:@"群聊",@"@群人数":[@(count) stringValue],@"@时间":CSGroupChatDateText(date)});
    return @{@"text":text,@"mentions":[ids copy]};
}
NSDictionary<NSString *,NSString *> *CSGroupChatDepartureValues(NSString *memberID, NSString *nickname, NSString *remark, NSString *roomName, NSUInteger count, NSDate *date, NSString *reason) {
    return @{@"@昵称":Nickname(nickname,remark,memberID)?:@"",@"@备注":CSGroupChatNameValue(remark),@"@微信ID":CSGroupChatNameValue(memberID),@"@群昵称":roomName,
        @"@群人数":[@(count) stringValue],@"@时间":CSGroupChatDateText(date),@"@离群类型":reason};
}
