#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSCustomTextMatch.h"
static NSUInteger compilations, checks;
static id (*originalCompile)(id,SEL,id,NSUInteger,NSError **);
static id Compile(id cls,SEL sel,id pattern,NSUInteger options,NSError **error) {
    compilations++; return originalCompile(cls,sel,pattern,options,error);
}
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); return 1; } } while (0)
int main(void) { @autoreleasepool {
    NSArray *patterns=@[@"^微信\\(\\d+\\)$",@"^通讯录\\(\\d+\\)$",@"^\\d+个朋友$"];
    NSMutableArray *reference=[NSMutableArray array];
    for (NSString *p in patterns) [reference addObject:[NSRegularExpression regularExpressionWithPattern:p options:0 error:NULL]];
    Method method=class_getClassMethod(NSRegularExpression.class,@selector(regularExpressionWithPattern:options:error:));
    originalCompile=(void *)method_setImplementation(method,(IMP)Compile);
    for (NSUInteger i=0;i<10000;i++) {
        CHECK(!CSCustomTextMatchesTitle(@"普通聊天正文和昵称",NO));
        CHECK(!CSCustomTextMatchesTitle(@"普通聊天正文和昵称",YES));
        CHECK(!CSCustomTextMatchesFriendsCount(@"普通聊天正文和昵称"));
    }
    CHECK(compilations==0);
    NSArray *values=@[@"",@"微信",@"通讯录",@"微信(未连接)",@"微信()",@"微信(0)",@"微信(123)",@"通讯录(42)",
        @"微信(１２)",@"微信(١٢)",@"微信(𝟙𝟚)",@"微信(-1)",@"微信(1.2)",@"微信(2)尾部",@"微信(2)\n",
        @"微信(2)\r\n",@"微信(2)\u2028",@" 微信(2)",@"3个朋友",@"１２个朋友",@"𝟙个朋友",@"个朋友",@"3个朋友\n",@"三个朋友",@"3个朋友更多"];
    for (NSUInteger repeat=0;repeat<100;repeat++) for (NSString *text in values) for (NSUInteger kind=0;kind<3;kind++) {
        BOOL expected=[reference[kind] firstMatchInString:text options:0 range:NSMakeRange(0,text.length)]!=nil;
        if (kind<2) expected|=[text isEqual:kind ? @"通讯录" : @"微信"];
        CHECK((kind==2 ? CSCustomTextMatchesFriendsCount(text) : CSCustomTextMatchesTitle(text,kind==1))==expected);
    }
    CHECK(compilations==3);
    method_setImplementation(method,(IMP)originalCompile);
    printf("Custom text matching: %lu checks passed; 10,000 ordinary labels compile no regex; three patterns compiled once\n",(unsigned long)checks);
    return 0;
} }
