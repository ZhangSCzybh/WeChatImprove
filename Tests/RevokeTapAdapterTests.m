#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "CSRevokeTapAdapter.h"
#import "CSChatNativeBridge.h"
#import "CSMessageNavigation.h"
#import "CSServiceCenter.h"

static unsigned checks,failures,handled;
#define CHECK(value) do { checks++;if (!(value)) { failures++;fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#value); } } while(0)
@implementation UIView
- (instancetype)init { if((self=[super init])){_alpha=1;_gestureRecognizers=[NSMutableArray array];}return self; }
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture { [self.gestureRecognizers addObject:gesture]; }
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view { return CGPointMake(point.x-self.frame.origin.x,point.y-self.frame.origin.y); }
@end
@implementation UIWindow @end
@implementation UIScrollView @end
@implementation UITableView @end
@implementation UIGestureRecognizer
- (instancetype)initWithTarget:(id)target action:(SEL)action { if((self=[super init])){_enabled=YES;_testTarget=target;_testAction=action;}return self; }
- (CGPoint)locationInView:(UIView *)view { return self.testPoint; }
- (void)testFire { ((void (*)(id,SEL,id))objc_msgSend)(self.testTarget,self.testAction,self); }
@end
@implementation UITapGestureRecognizer @end
@implementation UITouch
- (CGPoint)locationInView:(UIView *)view { return self.testPoint; }
@end

static NSString *account=@"account";
static id lastSource,lastLink;
@interface MMContext : NSObject
+ (NSString *)currentUserName;
@end
@implementation MMContext
+ (NSString *)currentUserName { return account; }
@end
@interface CMessageMgr : NSObject @end
@implementation CMessageMgr @end
id CSGetService(Class serviceClass) { return serviceClass==CMessageMgr.class ? @"manager" : nil; }
BOOL CSMessageHandleRevokeLink(id source,id manager,id clickedLink,id explicitWrap) {
    CHECK([manager isEqual:@"manager"]);CHECK(explicitWrap==nil);
    handled++;lastSource=source;lastLink=clickedLink;return YES;
}
@interface TestWrap : NSObject
@property(nonatomic,copy) NSString *m_nsContent,*m_nsPattern;
@end
@implementation TestWrap @end
@interface TestModel : NSObject
@property(nonatomic,strong) TestWrap *messageWrap;
@end
@implementation TestModel @end
@interface TestStyle : NSObject
@property(nonatomic,copy) NSString *nsUrl;
@end
@implementation TestStyle @end
@interface RichTextView : UIView
@property(nonatomic,strong) NSArray *arrStyles;
+ (id)targetLinkStyleFromStyles:(id)styles withPoint:(CGPoint)point;
@end
@implementation RichTextView
+ (id)targetLinkStyleFromStyles:(id)styles withPoint:(CGPoint)point {
    if (point.y<5 || point.y>25) return nil;
    if(point.x>=20 && point.x<=100)return [styles firstObject];
    if(point.x>=120 && point.x<=180)return [styles lastObject];
    return nil;
}
@end
@interface TestCell : UIView
@property(nonatomic,strong) TestModel *viewModel;
@property(nonatomic,strong) id rich;
- (id)getRichTextView;
@end
@implementation TestCell
- (id)getRichTextView { return self.rich; }
@end
static TestModel *model(NSString *content) {
    TestModel *m=[TestModel new];m.messageWrap=[TestWrap new];m.messageWrap.m_nsContent=content;return m;
}
static TestCell *cell(void) {
    TestCell *c=[TestCell new];c.viewModel=model(@"tip <a href='revoke_jump_v2_601_501'>original</a>");
    static UIWindow *window; if(!window)window=[UIWindow new];c.window=window;
    TestStyle *owned=[TestStyle new];owned.nsUrl=@"revoke_jump_v2_601_501";
    TestStyle *web=[TestStyle new];web.nsUrl=@"https://example.com";
    RichTextView *rich=[RichTextView new];rich.frame=CGRectMake(10,30,200,40);rich.arrStyles=@[owned,web];c.rich=rich;
    return c;
}
static BOOL begin(TestCell *c,CGPoint point) {
    UIGestureRecognizer *g=c.gestureRecognizers.firstObject;g.state=UIGestureRecognizerStatePossible;g.testPoint=point;
    UITouch *t=[UITouch new];t.testPoint=point;
    return [g.delegate gestureRecognizer:g shouldReceiveTouch:t];
}
static void end(TestCell *c,UIGestureRecognizerState state) {
    UIGestureRecognizer *g=c.gestureRecognizers.firstObject;g.state=state;[g testFire];
}
static void feature(BOOL enabled) {
    // Argument-domain override is process-local; never write the user's preferences.
    [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.revoke.enabled":@(enabled)} forName:NSArgumentDomain];
}
int main(void) { @autoreleasepool {
    feature(YES);
    CGPoint blue=CGPointMake(60,45),text=CGPointMake(20,45),url=CGPointMake(150,45);
    TestCell *c=cell();CSRevokeTapBind(c,YES);
    CHECK(c.gestureRecognizers.count==1);
    UIGestureRecognizer *g=c.gestureRecognizers.firstObject;
    CHECK(g.enabled);CHECK(g.cancelsTouchesInView);CHECK(g.delaysTouchesEnded);
    for (NSUInteger i=0;i<10;i++)CSRevokeTapBind(c,YES);
    CHECK(c.gestureRecognizers.count==1);
    CHECK(begin(c,blue));CHECK([g.delegate gestureRecognizerShouldBegin:g]);
    CHECK(![g.delegate gestureRecognizer:g shouldRecognizeSimultaneouslyWithGestureRecognizer:[UIGestureRecognizer new]]);
    // The route reaches the shared handler even when the native cell link callback never fires.
    end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);CHECK(lastSource==c);CHECK([lastLink isEqual:@"revoke_jump_v2_601_501"]);
    end(c,UIGestureRecognizerStateEnded);CHECK(handled==1); // One touch cannot deliver twice.
    CHECK(!begin(c,text));end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    CHECK(!begin(c,url));end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    CHECK(!begin(c,CGPointMake(60,20))); // Outside the rich-text blue line.
    CHECK(begin(c,blue));g.testPoint=url;end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    CHECK(begin(c,blue));account=@"another";CHECK(![g.delegate gestureRecognizerShouldBegin:g]);
    end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);account=@"account";
    CHECK(begin(c,blue));feature(NO);CHECK(![g.delegate gestureRecognizerShouldBegin:g]);
    end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);CHECK(!begin(c,blue));feature(YES);
    CHECK(begin(c,blue));c.viewModel=model(c.viewModel.messageWrap.m_nsContent);
    end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    CHECK(begin(c,blue));c.viewModel.messageWrap.m_nsContent=@"ordinary system text";
    end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    CHECK(!begin(c,blue)); // Same model and stale link styles, without another layout callback.
    c.viewModel.messageWrap.m_nsContent=@"<a href='revoke_jump_v2_601_501'>original</a>";
    CHECK(begin(c,blue));end(c,UIGestureRecognizerStateCancelled);CHECK(handled==1);
    CHECK(begin(c,blue));end(c,UIGestureRecognizerStateFailed);CHECK(handled==1);
    UIScrollView *scroll=[UIScrollView new];c.superview=scroll;scroll.dragging=YES;
    CHECK(!begin(c,blue));scroll.dragging=NO;CHECK(begin(c,blue));scroll.dragging=YES;
    CHECK(![g.delegate gestureRecognizerShouldBegin:g]);end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    scroll.dragging=NO;scroll.decelerating=YES;CHECK(!begin(c,blue));scroll.decelerating=NO;
    CHECK(begin(c,blue));CSRevokeTapBind(c,NO);CHECK(!g.enabled);end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    CSRevokeTapBind(c,YES);CHECK(g.enabled);CHECK(begin(c,blue));
    c.viewModel.messageWrap.m_nsPattern=@"revoke_jump_999";
    end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    CSRevokeTapBind(c,YES);CHECK(!g.enabled);c.viewModel.messageWrap.m_nsPattern=nil;
    c.viewModel=model(@"ordinary system text");CSRevokeTapBind(c,YES);CHECK(!g.enabled);
    CHECK(c.gestureRecognizers.count==1);
    TestCell *plain=cell();plain.viewModel=model(@"<a href='https://example.com'>web</a>");
    CSRevokeTapBind(plain,YES);CHECK(plain.gestureRecognizers.count==0);
    plain.viewModel=model(@"<a href='revoke_jump_v2_601_bad'>invalid</a>");CSRevokeTapBind(plain,YES);CHECK(plain.gestureRecognizers.count==0);
    plain=cell();CSRevokeTapBind(plain,NO);CHECK(plain.gestureRecognizers.count==0);
    plain=cell();account=@"";CSRevokeTapBind(plain,YES);CHECK(!begin(plain,blue));account=@"account";
    c=cell();((RichTextView *)c.rich).hidden=YES;CSRevokeTapBind(c,YES);CHECK(!begin(c,blue));
    ((RichTextView *)c.rich).hidden=NO;((RichTextView *)c.rich).alpha=0;CHECK(!begin(c,blue));
    ((RichTextView *)c.rich).alpha=1;
    CHECK(begin(c,blue));c.window=nil;end(c,UIGestureRecognizerStateEnded);CHECK(handled==1);
    CHECK(!begin(c,blue));
    c=cell();CSRevokeTapBind(c,YES);
    c.rich=[NSObject new];CHECK(!begin(c,blue));
    printf("%s: %u exact revoke-link tap checks, %u failures (UIKit double; no device run)\n",failures?"FAIL":"PASS",checks,failures);
    return failures?1:0;
} }
