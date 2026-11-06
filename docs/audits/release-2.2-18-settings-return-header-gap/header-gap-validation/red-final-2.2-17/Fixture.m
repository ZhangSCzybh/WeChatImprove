#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>

// This deliberately small boundary models the public estimate/measurement split.
// It is not a reverse-engineered UIKit implementation or a phone measurement.
typedef struct { CGFloat top, left, bottom, right; } UIEdgeInsets;
static UIEdgeInsets UIEdgeInsetsMake(CGFloat t, CGFloat l, CGFloat b, CGFloat r) { return (UIEdgeInsets){t,l,b,r}; }
enum { UITableViewStyleInsetGrouped=2, UITableViewCellSeparatorStyleSingleLine=1,
       UIViewAutoresizingFlexibleWidth=2, UIViewAutoresizingFlexibleHeight=16 };
static CGFloat const UITableViewAutomaticDimension=-1;

@interface UIColor : NSObject
+ (instancetype)systemGroupedBackgroundColor;
+ (instancetype)systemBackgroundColor;
@end
@implementation UIColor
+ (instancetype)systemGroupedBackgroundColor { return [self new]; }
+ (instancetype)systemBackgroundColor { return [self new]; }
@end

@interface UIView : NSObject
@property CGRect frame;
@property(readonly) CGRect bounds;
@property NSInteger tag;
@property NSUInteger autoresizingMask;
@property BOOL userInteractionEnabled;
@property(strong) UIColor *backgroundColor;
@property(strong) NSMutableArray<UIView *> *subviews;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (UIView *)viewWithTag:(NSInteger)tag;
- (void)removeFromSuperview;
@end
@implementation UIView
- (instancetype)init { if ((self=[super init])) { _subviews=[NSMutableArray new]; _userInteractionEnabled=YES; } return self; }
- (instancetype)initWithFrame:(CGRect)frame { if ((self=[self init])) _frame=frame; return self; }
- (CGRect)bounds { return (CGRect){CGPointZero,self.frame.size}; }
- (void)addSubview:(UIView *)view { [self.subviews addObject:view]; }
- (UIView *)viewWithTag:(NSInteger)tag { for (UIView *v in self.subviews) if(v.tag==tag)return v; return nil; }
- (void)removeFromSuperview {}
@end

@interface UITableView : UIView
@property NSInteger separatorStyle;
@property UIEdgeInsets separatorInset, contentInset, adjustedContentInset;
@property CGPoint contentOffset;
@property(strong) UIView *tableHeaderView;
@property(weak) id delegate, dataSource;
@property CGFloat estimatedSectionHeaderHeight;
@property CGFloat actualSectionHeaderHeight, suppliedEstimateError;
@property BOOL usingEstimate;
@property NSUInteger reloadCount, measurementCount;
- (instancetype)initWithFrame:(CGRect)frame style:(NSInteger)style;
- (void)reloadData;
- (void)measureVisibleSection;
- (CGFloat)firstRowY;
@end
@implementation UITableView
- (instancetype)initWithFrame:(CGRect)frame style:(NSInteger)style {
    (void)style;
    if ((self=[super initWithFrame:frame])) _estimatedSectionHeaderHeight=UITableViewAutomaticDimension;
    return self;
}
- (void)reloadData { self.reloadCount++; self.usingEstimate=self.estimatedSectionHeaderHeight!=0; }
- (void)measureVisibleSection { self.measurementCount++; self.usingEstimate=NO; }
- (CGFloat)firstRowY {
    return CGRectGetHeight(self.tableHeaderView.frame)+self.actualSectionHeaderHeight+
        (self.usingEstimate?self.suppliedEstimateError:0);
}
@end

@interface UIViewController : NSObject
@property(strong) UIView *view;
@property(strong) UIViewController *presentedViewController;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
@end
@implementation UIViewController
- (instancetype)init { if((self=[super init])) _view=[[UIView alloc] initWithFrame:CGRectMake(0,0,393,852)]; return self; }
- (void)viewWillAppear:(BOOL)animated { (void)animated; }
- (void)viewDidAppear:(BOOL)animated { (void)animated; }
- (void)viewWillDisappear:(BOOL)animated { (void)animated; }
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion { (void)animated; if(completion)completion(); }
@end

@interface CSSettingTableViewCell : NSObject
+ (void)registerToTableView:(UITableView *)table;
@end
@implementation CSSettingTableViewCell
+ (void)registerToTableView:(UITableView *)table { (void)table; }
@end

@interface CSAuthorizationManager : NSObject
+ (instancetype)sharedManager;
- (BOOL)isAuthorized;
- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)vc completion:(void (^)(BOOL,NSString *))completion;
@end
@implementation CSAuthorizationManager
+ (instancetype)sharedManager { static id shared; if(!shared)shared=[self new]; return shared; }
- (BOOL)isAuthorized { return YES; }
- (void)requestAuthorizationWithPresentingViewController:(UIViewController *)vc completion:(void (^)(BOOL,NSString *))completion { (void)vc; completion(YES,nil); }
@end
static BOOL CSCloseFriendPluginEntryHidden(void) { return NO; }
static void CSCloseFriendAuthenticate(UIViewController *vc,void (^completion)(BOOL)) { (void)vc; completion(YES); }
static UIViewController *CSNativeSettingsHostForContent(UIViewController *vc) { return vc; }

@interface CSCustomViewController : UIViewController
@property(strong) UITableView *tableView;
@property(strong) UIView *headerView;
@property BOOL returningFromAuthorization, authorizationPromptInFlight, isAuthorized;
@property NSUInteger setupDataCount, agreementCount, quickEntryResetCount;
- (void)setupUI;
- (void)setupData;
- (void)checkUserAgreement;
- (void)returnFromUnauthorizedSettings;
- (void)resetCloseFriendQuickEntry;
@end
@implementation CSCustomViewController
#include "ProductionMethods.h"
- (void)setupData { self.setupDataCount++; }
- (void)checkUserAgreement { self.agreementCount++; }
- (void)returnFromUnauthorizedSettings {}
- (void)resetCloseFriendQuickEntry { self.quickEntryResetCount++; }
@end

#include "Routes.h"

static NSUInteger Checks, Failures;
static void Check(BOOL condition,NSString *description) {
    Checks++;
    if (!condition) {
        Failures++;
        if(Failures<=18)fprintf(stderr,"FAIL %s\n",description.UTF8String);
    }
}
static BOOL Equal(CGFloat a,CGFloat b) { return fabs(a-b)<0.000001; }
static NSMutableArray *Traces;
static void Sample(CSCustomViewController *vc,NSString *route,NSString *phase,CGFloat baselineGap,CGFloat originalOffset,BOOL assertGap) {
    UITableView *table=vc.tableView;
    CGFloat headerBottom=CGRectGetMaxY(table.tableHeaderView.frame);
    CGFloat gap=[table firstRowY]-headerBottom;
    // WXID's frame is inside an unchanged tableHeaderView; no scroll correction
    // is modeled. This independently distinguishes an inter-section gap from scroll.
    CGFloat wxidY=125-table.contentOffset.y;
    NSDictionary *sample=@{@"route":route,@"phase":phase,@"header_height":@(headerBottom),
        @"section_title_height":@(gap),@"first_row_y":@([table firstRowY]),@"wxid_y":@(wxidY),
        @"content_inset_top":@(table.contentInset.top),@"adjusted_inset_top":@(table.adjustedContentInset.top),
        @"content_offset_y":@(table.contentOffset.y),@"estimate_active":@(table.usingEstimate),
        @"reload_count":@(table.reloadCount),@"data_rebuild_count":@(vc.setupDataCount)};
    [Traces addObject:sample];
    if(assertGap)Check(Equal(gap,baselineGap),[NSString stringWithFormat:@"%@ %@ intermediate gap %.3f differs from baseline %.3f (WXID remains %.3f)",route,phase,gap,baselineGap,wxidY]);
    Check(Equal(headerBottom,150),@"fixed profile header is never resized");
    Check(Equal(table.contentOffset.y,originalOffset),@"parent lifecycle preserves return/bounce scroll offset");
    Check(Equal(wxidY,125-originalOffset),@"WXID frame remains independent from section gap");
    Check(Equal(table.contentInset.top,7),@"content inset is preserved");
    Check(Equal(table.adjustedContentInset.top,51),@"adjusted inset is preserved");
}

int main(void) { @autoreleasepool {
    Traces=[NSMutableArray new];
    NSUInteger scenarios=0;
    for(NSString *route in Routes())for(NSNumber *actual in @[@24,@37,@52])for(NSNumber *error in @[@(-19),@(-5),@7,@23])for(NSNumber *offset in @[@0,@135,@(-17)]) {
        scenarios++;
        CSCustomViewController *vc=[CSCustomViewController new];
        vc.headerView=[[UIView alloc] initWithFrame:CGRectMake(0,0,393,150)];
        [vc setupUI];
        UITableView *table=vc.tableView;
        table.actualSectionHeaderHeight=actual.doubleValue;
        table.suppliedEstimateError=error.doubleValue;
        table.contentOffset=CGPointMake(0,offset.doubleValue);
        table.contentInset=UIEdgeInsetsMake(7,0,12,0);
        table.adjustedContentInset=UIEdgeInsetsMake(51,0,46,0);
        [vc viewWillAppear:NO]; [table measureVisibleSection]; [vc viewDidAppear:NO]; [table measureVisibleSection];
        CGFloat baseline=[table firstRowY]-CGRectGetMaxY(table.tableHeaderView.frame);
        Sample(vc,route,@"before-push-settled",baseline,offset.doubleValue,YES);
        [vc viewWillDisappear:YES];
        Sample(vc,route,@"push-first-frame",baseline,offset.doubleValue,YES);
        Sample(vc,route,@"push-in-flight",baseline,offset.doubleValue,YES);
        Check(vc.quickEntryResetCount==1,@"existing quick-entry invalidation still runs on push");
        NSUInteger rebuilds=vc.setupDataCount;
        [vc viewWillAppear:YES];
        Check(vc.setupDataCount==rebuilds+1,@"return data refresh happens before first visible frame");
        Sample(vc,route,@"pop-will-appear-before-visible-measurement",baseline,offset.doubleValue,YES);
        Sample(vc,route,@"pop-first-visible-frame",baseline,offset.doubleValue,YES);
        [table measureVisibleSection];
        Sample(vc,route,@"pop-measured-in-flight",baseline,offset.doubleValue,YES);
        [vc viewDidAppear:YES];
        Sample(vc,route,@"pop-did-appear",baseline,offset.doubleValue,YES);
        Sample(vc,route,@"post-transition-before-deferred-measurement",baseline,offset.doubleValue,YES);
        [table measureVisibleSection];
        Sample(vc,route,@"post-transition-final",baseline,offset.doubleValue,YES);
        // Simulate starting an interactive pop, cancellation back to child, then
        // a subsequent completed pop. Every parent-visible frame is sampled.
        [vc viewWillDisappear:YES]; [vc viewWillAppear:YES];
        Sample(vc,route,@"interactive-pop-visible-before-cancel",baseline,offset.doubleValue,YES);
        [vc viewWillDisappear:YES];
        Sample(vc,route,@"interactive-pop-cancel",baseline,offset.doubleValue,YES);
        [table measureVisibleSection]; [vc viewWillAppear:YES];
        Sample(vc,route,@"pop-after-cancel-first-visible",baseline,offset.doubleValue,YES);
        [table measureVisibleSection]; [vc viewDidAppear:YES];
        Sample(vc,route,@"pop-after-cancel-did-appear",baseline,offset.doubleValue,YES);
        [table measureVisibleSection];
        Sample(vc,route,@"pop-after-cancel-final",baseline,offset.doubleValue,YES);
    }
    NSData *json=[NSJSONSerialization dataWithJSONObject:Traces options:NSJSONWritingPrettyPrinted error:nil];
    NSString *tracePath=[NSProcessInfo.processInfo.environment objectForKey:@"HEADER_GAP_TRACE_PATH"];
    if(tracePath)[json writeToFile:tracePath atomically:YES];
    printf("Header gap lifecycle: %lu checks, %lu failures, %lu scenarios, %lu geometry samples, %lu menu labels\n",Checks,Failures,scenarios,Traces.count,Routes().count);
    return Failures?1:0;
} }
