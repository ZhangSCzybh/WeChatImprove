#import "CSClownTextRules.h"

NSArray<NSString *> *CSClownWarmExpressions(NSString *text) {
    static NSDictionary *rules; static dispatch_once_t once;
    dispatch_once(&once, ^{
        rules = @{@"嗯":@[@"嗯呐",@"嗯嗯～",@"嗯呀"], @"恩":@[@"嗯呐",@"嗯嗯～",@"嗯呀"],
            @"奥":@[@"噢噢～",@"哦哦好呀",@"噢～"], @"嗷":@[@"嗷～",@"嗷嗷～",@"嗷嗷嗷"],
            @"嗷嗷":@[@"嗷嗷嗷～",@"嗷嗷～",@"嗷好的"], @"行":@[@"行呀",@"行哇",@"行的呀"],
            @"好":@[@"好呀",@"好哇",@"好嘞～"], @"可以":@[@"可以呀",@"可以哇",@"可以的～"],
            @"可":@[@"可以呀",@"可以哇",@"可以的～"], @"成":@[@"成呀",@"成嘞",@"成哇"],
            @"ok":@[@"OK呀",@"OK哒",@"OK～"], @"OK":@[@"OK呀",@"OK哒",@"OK～"]};
    });
    return [text isKindOfClass:NSString.class] ? rules[text] ?: @[] : @[];
}

@implementation CSClownFakeQuoteInput
+ (instancetype)parse:(NSString *)text error:(NSString **)error {
    if (error) *error = nil;
    if (![text isKindOfClass:NSString.class] || ![text hasPrefix:@"#假引用"]) return nil;
    NSString *failure = @"格式：#假引用 被引用的内容；真正发送的内容（也支持英文分号）";
    NSUInteger prefix = @"#假引用".length;
    if (text.length <= prefix || ![@" \u3000" containsString:[text substringWithRange:NSMakeRange(prefix, 1)]]) {
        if (error) *error = failure; return nil;
    }
    NSUInteger start = prefix;
    while (start < text.length && [@" \u3000" containsString:[text substringWithRange:NSMakeRange(start, 1)]]) start++;
    NSRange separator = [text rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"；;"]
        options:0 range:NSMakeRange(start, text.length-start)];
    if (separator.location == NSNotFound) { if (error) *error = failure; return nil; }
    NSString *quote = [text substringWithRange:NSMakeRange(start, separator.location-start)];
    NSString *body = [text substringFromIndex:NSMaxRange(separator)];
    if (![quote stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length ||
        ![body stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet].length) {
        if (error) *error = @"引用内容和发送正文都不能为空，草稿已保留。"; return nil;
    }
    CSClownFakeQuoteInput *input = [self new]; input->_quote = [quote copy]; input->_body = [body copy]; return input;
}
@end
