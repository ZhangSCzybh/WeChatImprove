#import <Foundation/Foundation.h>
@interface Label : NSObject
@property(nonatomic) BOOL hidden;
@property(nonatomic,copy) NSString *text;
@end
@implementation Label @end
@interface WETabButton : NSObject
@property(nonatomic) NSInteger unreadCount;
@property(nonatomic) BOOL hasRedDot;
@property(nonatomic,strong) Label *unreadBadge;
@property(nonatomic,copy) NSString *accessibilityValue;
@property(nonatomic) NSUInteger layouts;
@end
@implementation WETabButton
- (void)setNeedsLayout { self.layouts++; }
#include "BadgeBody.h"
@end
@interface Container : NSObject
@property(nonatomic,strong) NSArray<WETabButton *> *tabButtons;
@property(nonatomic) NSUInteger layouts;
@end
@implementation Container
- (void)setNeedsLayout { self.layouts++; }
#include "ContainerBody.h"
@end
static NSUInteger checks,failures;
static void Check(BOOL ok) { checks++; if (!ok) failures++; }
int main(void) { @autoreleasepool {
    WETabButton *b=[WETabButton new]; b.unreadBadge=[Label new]; b.unreadBadge.hidden=YES;
    Container *c=[Container new]; c.tabButtons=@[b];
    [c updateUnreadCount:0 hasRedDot:NO forTabIndex:0]; Check(!c.layouts && !b.layouts);
    [c updateUnreadCount:3 hasRedDot:NO forTabIndex:0]; Check(c.layouts==1 && b.layouts==1 && [b.unreadBadge.text isEqual:@"3"] && !b.unreadBadge.hidden);
    [c updateUnreadCount:3 hasRedDot:NO forTabIndex:0]; Check(c.layouts==1 && b.layouts==1);
    [c updateUnreadCount:0 hasRedDot:YES forTabIndex:0]; Check(!b.unreadBadge.hidden && !b.unreadBadge.text && c.layouts==2);
    [c updateUnreadCount:-2 hasRedDot:YES forTabIndex:0]; Check(c.layouts==2);
    [c updateUnreadCount:100 hasRedDot:YES forTabIndex:0]; Check([b.unreadBadge.text isEqual:@"99+"]);
    [c updateUnreadCount:0 hasRedDot:NO forTabIndex:0]; Check(b.unreadBadge.hidden && !b.accessibilityValue);
    NSUInteger old=c.layouts; [c updateUnreadCount:3 hasRedDot:NO forTabIndex:2]; Check(c.layouts==old);
    fprintf(stdout,"Group appearance: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
