#import <Foundation/Foundation.h>
#import "CSClownTextRules.h"
#include <stdlib.h>
static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)
int main(void) { @autoreleasepool {
    for (NSString *word in @[@"嗯",@"奥",@"恩",@"嗷",@"嗷嗷",@"行",@"好",@"可以",@"可",@"成",@"ok",@"OK"]) {
        NSArray *choices = CSClownWarmExpressions(word); CHECK(choices.count >= 3);
        for (NSString *choice in choices) CHECK(choice.length && ![choice isEqual:word]);
    }
    for (NSString *word in @[@"好的",@"好。",@" 好",@"好 ",@"好\n",@"Ok",@"oK",@"",@"嗷嗷嗷"]) CHECK(!CSClownWarmExpressions(word).count);
    for (NSString *separator in @[@";",@"；"]) {
        NSString *error = nil;
        CSClownFakeQuoteInput *input = [CSClownFakeQuoteInput parse:[NSString stringWithFormat:@"#假引用 引用%@正文;继续；保留",separator] error:&error];
        CHECK(input && !error && [input.quote isEqual:@"引用"] && [input.body isEqual:@"正文;继续；保留"]);
    }
    CHECK([[CSClownFakeQuoteInput parse:@"#假引用　　多行\n引用； 正文\n " error:nil].body isEqual:@" 正文\n "]);
    for (NSString *text in @[@"#假引用+引用；正文",@"#假引用",@"#假引用 引用",@"#假引用 ；正文",@"#假引用 引用； \n",@"#假引用\n引用；正文"]) {
        NSString *error = nil; CHECK(![CSClownFakeQuoteInput parse:text error:&error] && error.length);
    }
    for (NSString *text in @[@"普通文本",@"前文#假引用 引用；正文"]) {
        NSString *error = nil; CHECK(![CSClownFakeQuoteInput parse:text error:&error] && !error);
    }
    printf("Clown text rules passed %lu checks.\n",(unsigned long)checks);
} return 0; }
