#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"
#import "CSCloseFriendPolicy.h"
static CSCloseFriendSnapshot *policy;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return policy; }
typedef NSUInteger UIViewAutoresizing;
static const UIViewAutoresizing UIViewAutoresizingFlexibleWidth=1,UIViewAutoresizingFlexibleHeight=2;
static NSString *UIFontTextStyleBody=@"body";
@interface UIColor : NSObject
+ (instancetype)labelColor;
+ (instancetype)systemBackgroundColor;
@end
@implementation UIColor
+ (instancetype)labelColor { return [self new]; }
+ (instancetype)systemBackgroundColor { return [self new]; }
@end
@interface UIFont : NSObject
+ (instancetype)preferredFontForTextStyle:(NSString *)style;
@end
@implementation UIFont
+ (instancetype)preferredFontForTextStyle:(NSString *)style { (void)style;return [self new]; }
@end
@interface UIView : NSObject
@property(nonatomic) CGRect bounds;
@property(nonatomic) BOOL hidden,userInteractionEnabled,isAccessibilityElement;
@property(nonatomic) UIViewAutoresizing autoresizingMask;
@property(nonatomic,strong) UIColor *backgroundColor;
@property(nonatomic,copy) NSString *accessibilityLabel;
@property(nonatomic,strong) id accessibilityElements;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,strong) NSMutableArray<UIView *> *children;
@property(nonatomic,readonly) NSArray<UIView *> *subviews;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)bringSubviewToFront:(UIView *)view;
- (void)removeFromSuperview;
@end
@implementation UIView
- (instancetype)initWithFrame:(CGRect)frame { if ((self=[super init])) {self.bounds=frame;self.children=[NSMutableArray array];self.userInteractionEnabled=YES;} return self; }
- (NSArray *)subviews { return [self.children copy]; }
- (void)addSubview:(UIView *)view { [view removeFromSuperview];[self.children addObject:view];view.superview=self; }
- (void)bringSubviewToFront:(UIView *)view { [self.children removeObject:view];[self.children addObject:view]; }
- (void)removeFromSuperview { [self.superview.children removeObject:self];self.superview=nil; }
@end
@interface UILabel : UIView
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,copy) NSString *text;
@end
@implementation UILabel @end
@interface UITableViewCell : UIView @end
@implementation UITableViewCell @end
#include "SessionPresentationBody.h"
static NSUInteger checks,failures;
static void Check(BOOL pass,NSString *name) {checks++;if(!pass){failures++;fprintf(stderr,"FAIL: %s\n",name.UTF8String);}}
static CSCloseFriendSnapshot *Policy(BOOL revealed) { return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@YES,@"friends":@[@"hidden"],@"groups":@[],@"options":@{}} revealed:revealed revision:1 blocked:NO]; }
int main(void) {@autoreleasepool {
 policy=Policy(NO);UITableViewCell *cell=[[UITableViewCell alloc] initWithFrame:CGRectMake(0,0,320,60)];
 UIView *content=[[UIView alloc] initWithFrame:cell.bounds],*dot=[[UIView alloc] initWithFrame:cell.bounds];dot.hidden=YES;
 [cell addSubview:content];[cell addSubview:dot];cell.isAccessibilityElement=YES;cell.accessibilityLabel=@"private preview";NSArray *originalElements=@[content];cell.accessibilityElements=originalElements;
 NSUInteger indexes[]={0,0};CSGroupRow *row=[[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:indexes length:2] userName:@"chatroom_session_box" kind:CSGroupRowKindAggregate category:CSGroupRowCategoryGroup top:NO unreadCount:12 redDot:YES];
 CSGroupRow *sourceRow=row;
 CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:@[@[row]] tabs:@[[WESessionTabItem tabWithType:WETabTypeAll]] selectedTabID:@"preset_0" filterDuplicates:NO accountID:@"fixture" hiddenUserNames:[NSSet setWithObject:@"hidden"] privacyRevision:1 previousProjection:nil];
 row=projection.sections[0][0];
 CSCloseFriendUpdateSessionCover(cell,row);UIView *cover=cell.subviews.lastObject;
 Check(content.hidden && dot.hidden && cell.subviews.count==3,@"native content and dot hidden behind owned neutral presentation");
 Check(!cover.userInteractionEnabled && cell.userInteractionEnabled,@"cover leaves native row interaction intact");
 Check(!cell.isAccessibilityElement && !cell.accessibilityLabel && [cell.accessibilityElements isEqual:@[cover]] && [cover.accessibilityLabel isEqual:@"折叠的群聊"],@"native accessibility preview replaced with neutral folded title");
 Check(sourceRow.unreadCount==12 && sourceRow.redDot,@"presentation leaves source aggregate unread immutable");
 content.hidden=NO;cell.accessibilityLabel=@"native changed preview";
 UIView *late=[[UIView alloc] initWithFrame:cell.bounds];[cell addSubview:late];
 CSCloseFriendRefreshSessionCover(cell);
 Check(content.hidden && late.hidden && !cell.accessibilityLabel && cell.subviews.lastObject==cover,@"native relayout/new subview cannot reveal summary and accessibility");
 policy=Policy(YES);CSCloseFriendRefreshSessionCover(cell);
 Check(!content.hidden && dot.hidden && !late.hidden && cell.subviews.count==3,@"reveal removes only owned cover and restores per-view hidden state");
 Check(cell.isAccessibilityElement && [cell.accessibilityLabel isEqual:@"private preview"] && cell.accessibilityElements==originalElements,@"reveal restores original accessibility semantics");
 policy=Policy(NO);CSCloseFriendUpdateSessionCover(cell,row);CSCloseFriendUpdateSessionCover(cell,nil);
 Check(!content.hidden && dot.hidden && cell.subviews.count==3,@"reuse removes aggregate presentation before native updates");
 fprintf(stdout,"Close-friend session presentation: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
 return failures?1:0;
}}
