#import "CSCustomTextMatch.h"

BOOL CSCustomTextMatchesTitle(NSString *text, BOOL contacts) {
    NSString *title=contacts ? @"通讯录" : @"微信";
    if ([text isEqualToString:title]) return YES;
    if (![text hasPrefix:contacts ? @"通讯录(" : @"微信("]) return NO;
    static NSRegularExpression *wechat, *addressBook;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        wechat=[NSRegularExpression regularExpressionWithPattern:@"^微信\\(\\d+\\)$" options:0 error:NULL];
        addressBook=[NSRegularExpression regularExpressionWithPattern:@"^通讯录\\(\\d+\\)$" options:0 error:NULL];
    });
    return [(contacts ? addressBook : wechat) firstMatchInString:text options:0 range:NSMakeRange(0,text.length)]!=nil;
}

BOOL CSCustomTextMatchesFriendsCount(NSString *text) {
    if (!text.length || [text rangeOfString:@"个朋友"].location==NSNotFound) return NO;
    static NSRegularExpression *friends;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ friends=[NSRegularExpression regularExpressionWithPattern:@"^\\d+个朋友$" options:0 error:NULL]; });
    return [friends firstMatchInString:text options:0 range:NSMakeRange(0,text.length)]!=nil;
}
