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
static NSString *UIFontTextStyleSubheadline=@"subheadline";
@interface UIColor : NSObject
@property(nonatomic) BOOL transparent;
+ (instancetype)labelColor;
+ (instancetype)secondaryLabelColor;
+ (instancetype)systemBackgroundColor;
+ (instancetype)clearColor;
@end
@implementation UIColor
+ (instancetype)labelColor { return [self new]; }
+ (instancetype)secondaryLabelColor { return [self new]; }
+ (instancetype)systemBackgroundColor { return [self new]; }
+ (instancetype)clearColor { UIColor *color=[self new];color.transparent=YES;return color; }
@end
@interface UIFont : NSObject
+ (instancetype)preferredFontForTextStyle:(NSString *)style;
@end
@implementation UIFont
+ (instancetype)preferredFontForTextStyle:(NSString *)style { (void)style;return [self new]; }
@end
@interface UIView : NSObject
@property(nonatomic) CGRect bounds,frame;
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
- (BOOL)isDescendantOfView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
@end
@implementation UIView
- (instancetype)initWithFrame:(CGRect)frame { if ((self=[super init])) {self.frame=frame;self.children=[NSMutableArray array];self.userInteractionEnabled=YES;} return self; }
- (void)setFrame:(CGRect)frame { _frame=frame;_bounds=(CGRect){CGPointZero,frame.size}; }
- (NSArray *)subviews { return [self.children copy]; }
- (void)addSubview:(UIView *)view { [view removeFromSuperview];[self.children addObject:view];view.superview=self; }
- (void)bringSubviewToFront:(UIView *)view { [self.children removeObject:view];[self.children addObject:view]; }
- (void)removeFromSuperview { [self.superview.children removeObject:self];self.superview=nil; }
- (BOOL)isDescendantOfView:(UIView *)view { for(UIView *v=self;v;v=v.superview)if(v==view)return YES;return NO; }
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view {
    for(UIView *v=self;v;v=v.superview){rect.origin.x+=v.frame.origin.x-v.bounds.origin.x;rect.origin.y+=v.frame.origin.y-v.bounds.origin.y;}
    for(UIView *v=view;v;v=v.superview){rect.origin.x-=v.frame.origin.x-v.bounds.origin.x;rect.origin.y-=v.frame.origin.y-v.bounds.origin.y;}
    return rect;
}
@end
@interface UILabel : UIView
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,copy) NSString *text;
@end
@implementation UILabel @end
@interface UITableViewCell : UIView @end
@implementation UITableViewCell @end
// Match the checked native ivars; no private selectors or WeChat connection.
@interface MainFrameItemView : UIView {
@public UILabel *m_nameLabel,*m_messageLabel,*m_timeLabel;
    UIView *m_frameHeadView,*m_unreadCountView;
}
@end
@implementation MainFrameItemView @end
@interface NewMainFrameCell : UITableViewCell { @public MainFrameItemView *m_itemView; }
@end
@implementation NewMainFrameCell @end
#include "SessionPresentationBody.h"
#include "FoldedItemLayoutHook.h"
static NSUInteger checks,failures;
static void Check(BOOL pass,NSString *name) {checks++;if(!pass){failures++;fprintf(stderr,"FAIL: %s\n",name.UTF8String);}}
static CSCloseFriendSnapshot *Policy(BOOL revealed) { return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@YES,@"friends":@[@"hidden"],@"groups":@[],@"options":@{}} revealed:revealed revision:1 blocked:NO]; }
static CSGroupRow *ScopedRow(NSUInteger count,BOOL known,NSUInteger revision) {
    WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];NSMutableArray *children=[NSMutableArray array];
    for (NSUInteger i=0;i<count;i++) {
        NSUInteger path[]={0,i};[children addObject:[[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:path length:2]
            userName:[NSString stringWithFormat:@"visible-%lu",(unsigned long)i] kind:CSGroupRowKindSession category:CSGroupRowCategoryGroup top:NO unreadCount:0 redDot:NO]];
    }
    CSGroupProjection *child=known ? [[CSGroupProjection alloc] initWithSections:@[children] tabs:@[all] selectedTabID:all.tabId filterDuplicates:NO accountID:@"fixture"] : nil;
    NSUInteger path[]={0,0};CSGroupRow *entry=[[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:path length:2]
        userName:@"chatroom_session_box" kind:CSGroupRowKindAggregate category:CSGroupRowCategoryGroup top:NO unreadCount:99 redDot:YES];
    CSGroupProjection *main=[[CSGroupProjection alloc] initWithSections:@[@[entry]] tabs:@[all] selectedTabID:all.tabId filterDuplicates:NO accountID:@"fixture"
        hiddenUserNames:[NSSet setWithObject:@"hidden"] unmaskedAggregateUserNames:[NSSet set] privacyRevision:revision scopeFoldedEntry:YES foldedProjection:child previousProjection:nil];
    return [main rowAtDisplayPath:[NSIndexPath indexPathWithIndexes:path length:2]];
}
#include "FoldedEntryVisualTests.h"
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
 CSGroupRow *scoped=ScopedRow(2,YES,1);CSCloseFriendUpdateSessionCover(cell,scoped);cover=cell.subviews.lastObject;
 Check(cell.subviews.count==4 && content.hidden && late.hidden && [cover.accessibilityLabel isEqual:@"折叠的聊天（2）"],@"group count shares one owned cover and hides global preview/time/unread");
 Check(!cover.userInteractionEnabled && cell.userInteractionEnabled && [cell.accessibilityElements isEqual:@[cover]],@"group summary keeps native tap behavior and accessible local count");
 policy=Policy(YES);CSCloseFriendRefreshSessionCover(cell);
 Check(cell.subviews.lastObject==cover && cell.subviews.count==4 && content.hidden && [cover.accessibilityLabel isEqual:@"折叠的聊天（2）"],@"privacy reveal does not remove scoped summary or expose global preview");
 scoped=ScopedRow(3,YES,1);CSCloseFriendUpdateSessionCover(cell,scoped);
 Check(cell.subviews.lastObject==cover && cell.subviews.count==4 && [cover.accessibilityLabel isEqual:@"折叠的聊天（3）"],@"changed group count reuses single presentation owner");
 CSCloseFriendUpdateSessionCover(cell,ScopedRow(0,NO,1));
 Check([cover.accessibilityLabel isEqual:@"折叠的聊天"] && content.hidden,@"unknown folded source shows neutral title without zero");
 CSCloseFriendUpdateSessionCover(cell,scoped);
 policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":@{}} revealed:YES revision:2 blocked:NO];
 CSCloseFriendRefreshSessionCover(cell);
 Check([cover.accessibilityLabel isEqual:@"折叠的聊天"] && cell.subviews.lastObject==cover,@"policy revision invalidates previously verified count immediately");
 CSCloseFriendUpdateSessionCover(cell,ScopedRow(3,YES,2));
 Check([cover.accessibilityLabel isEqual:@"折叠的聊天（3）"],@"same-count republication restores title with current policy provenance");
 policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"other-account" profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":@{}} revealed:YES revision:2 blocked:NO];
 CSCloseFriendRefreshSessionCover(cell);
 Check([cover.accessibilityLabel isEqual:@"折叠的聊天"] && content.hidden,@"account transition never displays previous account count");
 policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@NO,@"friends":@[],@"groups":@[],@"options":@{}} revealed:YES revision:2 blocked:YES];
 CSCloseFriendRefreshSessionCover(cell);
 Check([cover.accessibilityLabel isEqual:@"折叠的聊天"] && content.hidden,@"blocked policy retains neutral cover regardless of matching revision");
 policy=Policy(NO);CSCloseFriendUpdateSessionCover(cell,ScopedRow(2,YES,1));
 content.hidden=NO;cell.accessibilityLabel=@"global native preview";CSCloseFriendRefreshSessionCover(cell);
 Check(content.hidden && cell.accessibilityLabel==nil && cell.subviews.lastObject==cover,@"native relayout cannot reveal content behind scoped summary");
 NSUInteger ordinaryPath[]={0,0};CSGroupRow *ordinary=[[CSGroupRow alloc] initWithNativePath:[NSIndexPath indexPathWithIndexes:ordinaryPath length:2] userName:@"normal" kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:0 redDot:NO];
 CSCloseFriendUpdateSessionCover(cell,ordinary);
 Check(!content.hidden && dot.hidden && !late.hidden && cell.subviews.count==3 && cell.isAccessibilityElement && cell.accessibilityElements==originalElements,@"ordinary cell reuse restores owned visual/accessibility state exactly");
 NativeFoldedLayoutTests();
 fprintf(stdout,"Close-friend session presentation: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
 return failures?1:0;
}}
