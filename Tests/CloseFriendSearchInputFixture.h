// Minimal native boundary doubles; the consumed helper/dispatch bodies are production code.
@interface UITextField : NSObject
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) id markedTextRange;
@end
@implementation UITextField @end
@interface FTSHomeViewController : NSObject
@property(nonatomic,strong) UITextField *searchTextField;
@property(nonatomic,strong) id presenter;
@property(nonatomic) NSUInteger reloads, resigns;
- (NSString *)searchBarText;
- (void)reloadList;
- (void)resignSearchFirstResponder;
@end
@implementation FTSHomeViewController
- (NSString *)searchBarText {return self.searchTextField.text;}
- (void)reloadList {self.reloads++;}
- (void)resignSearchFirstResponder {self.resigns++;}
@end
@interface CSCloseFriendManager : NSObject
@property(nonatomic) NSUInteger probes;
+ (instancetype)sharedManager;
- (BOOL)consumeHomepageSearchPassword:(NSString *)query;
@end
@implementation CSCloseFriendManager
+ (instancetype)sharedManager {static id manager; if(!manager)manager=[self new];return manager;}
- (BOOL)consumeHomepageSearchPassword:(NSString *)query {self.probes++; return [query isEqual:@"654321"];}
@end
static BOOL CSCFCallVoid(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name); if(![object respondsToSelector:selector]) return NO;
    ((void(*)(id,SEL))[object methodForSelector:selector])(object,selector); return YES;
}
static BOOL CSCFSetObject(id object,NSString *name,id value) {
    SEL selector=NSSelectorFromString(name); if(![object respondsToSelector:selector]) return NO;
    ((void(*)(id,SEL,id))[object methodForSelector:selector])(object,selector,value); return YES;
}
static __thread NSUInteger PasswordDispatchDepth;
#include "SearchInputBodies.h"
static void SearchInputChecks(void) {
    FTSHomeViewController *page=[FTSHomeViewController new];page.searchTextField=[UITextField new];
    __block NSUInteger nativeCalls=0;page.searchTextField.text=@"654321";
    DispatchSearchInput(page,page.searchTextField,NO,^{nativeCalls++;});
    Check(!nativeCalls && !page.searchTextField.text.length && page.reloads==1 && page.resigns==1,@"full homepage password is consumed and cleared before native search/history");
    page.searchTextField.text=@"ordinary";
    NSUInteger probes=CSCloseFriendManager.sharedManager.probes;
    DispatchSearchInput(page,page.searchTextField,NO,^{DispatchSearchInput(page,@"ordinary",NO,^{nativeCalls++;});});
    Check(nativeCalls==1 && CSCloseFriendManager.sharedManager.probes==probes+1,@"ordinary search flows through once without repeated verifier work in nested callbacks");
    page.searchTextField.text=@"654321";page.searchTextField.markedTextRange=[NSObject new];
    DispatchSearchInput(page,page.searchTextField,NO,^{nativeCalls++;});
    Check(nativeCalls==2 && page.searchTextField.text.length==6,@"uncommitted IME composition is not consumed");
    page.searchTextField.markedTextRange=nil;
    DispatchSearchInput([NSObject new],@"654321",NO,^{nativeCalls++;});
    Check(nativeCalls==3,@"non-homepage search remains untouched");
    @try {DispatchSearchInput(page,@"ordinary",NO,^{@throw [NSException exceptionWithName:@"Native" reason:nil userInfo:nil];});} @catch(__unused NSException *e) {}
    Check(PasswordDispatchDepth==0,@"native exception cannot leave password dispatch bypassed");
}
