#import "TimeHookUnderTest.h"
static NSUInteger checks;
#define CHECK(x) do { checks++;if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x);return 1; } } while(0)
@interface TimeWrap : NSObject
@property(nonatomic) unsigned int m_uiCreateTime;
@end
@implementation TimeWrap @end
@interface TimeModel : NSObject
@property(nonatomic) BOOL isSender;
@property(nonatomic) double createTime;
@property(nonatomic,strong) TimeWrap *messageWrap;
@property(nonatomic,strong) NSArray *subViewModels;
@end
@implementation TimeModel @end
@interface TimePart : NSObject
@property(nonatomic,weak) TimeModel *parentModel;
@end
@implementation TimePart @end
int main(void) { @autoreleasepool {
 timeCells=[NSHashTable weakObjectsHashTable];
 requestTimeRefresh(NO);
 [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.messageTime.enabled":@YES} forName:NSArgumentDomain];
 refreshTimeSettings(NO);
 TimeModel *parent=[TimeModel new];parent.isSender=YES;parent.messageWrap=[TimeWrap new];parent.messageWrap.m_uiCreateTime=1700000000;
 TimePart *part=[TimePart new];part.parentModel=parent;parent.subViewModels=@[part];
 BOOL sender=NO;CHECK(CSMessageTimeReadSender(part,&sender) && sender);
 unsigned int stamp=0;CHECK(CSMessageTimeReadTimestamp(part,&stamp) && stamp==1700000000);
 // No initWithViewModel call, no updateNodeStatus callback. Layout alone must install the label.
 CommonMessageCellView *cell=[CommonMessageCellView new];cell.bounds=CGRectMake(0,0,320,70);UIWindow *window=[UIWindow new];cell.window=window;
 objc_setAssociatedObject(cell,&testModelKey,part,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 UIView *bubble=[UIView new];bubble.frame=CGRectMake(100,8,150,38);bubble.bounds=CGRectMake(0,0,150,38);
 UIView *container=[UIView new];container.frame=CGRectMake(0,0,320,70);
 objc_setAssociatedObject(cell,&testBubbleKey,bubble,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 objc_setAssociatedObject(cell,&testContentKey,container,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 [cell layoutSubviews];UILabel *label=(UILabel *)getTimeView(cell);
 CHECK(label && label.text.length && !label.hidden && label.superview==cell);
 CHECK(label.center.x<100);CHECK(cell.gestureRecognizers.count==1);
 NSUInteger fonts=CSTimeFontCreations;
 for (NSUInteger i=0;i<100;i++) { [cell layoutSubviews];CHECK(getTimeView(cell)==label && !label.hidden); }
 CHECK(CSTimeFontCreations==fonts && cell.gestureRecognizers.count==1 && cell.subviews.count==1);
 // Toggle settings, then tap outside the bubble but inside the full-row content container.
 [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.messageTime.enabled":@YES,@"com.wechat.enhance.messageTime.tapToShow":@YES} forName:NSArgumentDomain];
 refreshTimeSettings(NO);CHECK(label.hidden);
 UITapGestureRecognizer *tap=cell.gestureRecognizers.firstObject;tap.testLocation=CGPointMake(50,20);
 CHECK(tap.delegate && (id)tap.delegate!=cell);
 UITouch *timeTouch=[UITouch new];timeTouch.view=cell;timeTouch.testLocation=CGPointMake(50,20);
 CHECK([tap.delegate gestureRecognizer:tap shouldReceiveTouch:timeTouch]);
 timeTouch.testLocation=CGPointMake(120,20);CHECK(![tap.delegate gestureRecognizer:tap shouldReceiveTouch:timeTouch]);
 timeTouch.testLocation=CGPointMake(50,20);UIControl *button=[UIControl new];[cell addSubview:button];timeTouch.view=button;
 CHECK(![tap.delegate gestureRecognizer:tap shouldReceiveTouch:timeTouch]);
 [cell handleMessageTap:tap];CHECK(!label.hidden);[cell layoutSubviews];CHECK(!label.hidden);
 tap.testLocation=CGPointMake(120,20);[cell handleMessageTap:tap];CHECK(!label.hidden);
 tap.testLocation=CGPointMake(50,20);[cell handleMessageTap:tap];CHECK(label.hidden);
 [cell handleMessageTap:tap];[cell prepareForReuse];CHECK(label.hidden && !getTimeViewVisible(cell));
 // A direct model (image/voice shape), also without native init/update callbacks, refreshes on appearance.
 objc_setAssociatedObject(cell,&testModelKey,parent,OBJC_ASSOCIATION_RETAIN_NONATOMIC);parent.isSender=NO;
 [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.messageTime.enabled":@YES} forName:NSArgumentDomain];refreshTimeSettings(NO);
 [cell onAppear];CHECK(!label.hidden && label.center.x>250 && label.center.x<320);
 [NSUserDefaults.standardUserDefaults setVolatileDomain:@{} forName:NSArgumentDomain];
 refreshTimeSettings(NO);CHECK(label.hidden);
 [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.messageTime.enabled":@YES} forName:NSArgumentDomain];
 refreshTimeSettings(NO);CHECK(!label.hidden);
 NSUInteger version=timeSettingsVersion;fonts=CSTimeFontCreations;refreshTimeSettings(NO);
 CHECK(timeSettingsVersion==version && CSTimeFontCreations==fonts);
 parent.messageWrap=nil;parent.createTime=1700000001;CHECK(CSMessageTimeReadTimestamp(parent,&stamp) && stamp==1700000001);
 parent.createTime=NAN;[cell layoutSubviews];CHECK(label.hidden);
 parent.createTime=1700000000;[cell layoutSubviews];CHECK(!label.hidden);
 TimePart *tail=[TimePart new];tail.parentModel=parent;parent.subViewModels=@[part,tail];
 CHECK(!CSMessageTimeShowsModel(part,NO) && CSMessageTimeShowsModel(tail,NO));
 CHECK(CSMessageTimeShowsModel(part,YES) && !CSMessageTimeShowsModel(tail,YES));
 objc_setAssociatedObject(cell,&testModelKey,part,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 [cell layoutSubviews];CHECK(label.hidden);timeBelowAvatar=YES;[cell layoutSubviews];CHECK(!label.hidden);
 UIView *head=[UIView new];head.frame=CGRectMake(10,8,38,38);head.bounds=CGRectMake(0,0,38,38);
 objc_setAssociatedObject(cell,&testHeadKey,head,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 [cell cs_messageTimeLayout];CHECK(label.center.x==29);head.hidden=YES;
 [cell cs_messageTimeLayout];CHECK(label.center.x>250);
 // Nested native content container: a bubble frame is NOT in cell coordinates.
 timeBelowAvatar=NO;parent.subViewModels=@[part];parent.isSender=NO;
 container.frame=CGRectMake(45,7,260,70);container.bounds=CGRectMake(3,2,260,70);
 [cell addSubview:container];[container addSubview:bubble];
 bubble.frame=CGRectMake(12,9,150,38);bubble.bounds=CGRectMake(0,0,150,38);
 [cell layoutSubviews];
 CHECK(label.center.x==204+1+label.bounds.size.width/2);
 CHECK(label.center.y==52-label.bounds.size.height/2);
 // Moving the whole row for compact spacing must not move the label within the row.
 CGPoint expectedPosition=label.center;cell.frame=CGRectMake(0,-3,320,70);
 [cell layoutSubviews];CHECK(CGPointEqualToPoint(label.center,expectedPosition));
 parent.isSender=YES;[cell layoutSubviews];CHECK(label.center.x==54-1-label.bounds.size.width/2);
 // Avatar positioning also converts its own parent coordinate system.
 [container addSubview:head];head.hidden=NO;timeBelowAvatar=YES;
 [cell cs_messageTimeLayout];CHECK(label.center.x==71);
 CHECK(label.center.y==51+label.bounds.size.height/2-7);
 head.hidden=YES;[cell cs_messageTimeLayout];CHECK(label.center.x==54-1-label.bounds.size.width/2);
 // A later native container layout must update geometry without remeasuring text.
 fonts=CSTimeFontCreations;container.frame=CGRectMake(65,17,260,70);
 [cell layoutSubviews];CHECK(label.center.x==74-1-label.bounds.size.width/2);
 CHECK(label.center.y==62-label.bounds.size.height/2 && fonts==CSTimeFontCreations);
 // Hit testing must use the same converted bubble rectangle as label placement.
 [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.messageTime.enabled":@YES,@"com.wechat.enhance.messageTime.tapToShow":@YES} forName:NSArgumentDomain];
 refreshTimeSettings(NO);CHECK(label.hidden);
 tap.testLocation=CGPointMake(100,40);[cell handleMessageTap:tap];CHECK(label.hidden);
 tap.testLocation=CGPointMake(40,40);[cell handleMessageTap:tap];CHECK(!label.hidden);
 [cell layoutSubviews];CHECK(label.center.x==74-1-label.bounds.size.width/2);
 printf("PASS: %lu message-time production hook lifecycle checks (UIKit double)\n",(unsigned long)checks);
 }return 0; }
