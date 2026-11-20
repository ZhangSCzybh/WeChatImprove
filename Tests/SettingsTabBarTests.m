#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <math.h>

// Only UIKit drawing, layout dispatch, keyboard focus and animation delivery are
// doubles. Geometry and interaction methods are extracted from the real view.
static NSUInteger checks,animationCount;
static BOOL reducedMotion;
static NSTimeInterval lastDuration;
static NSMutableArray *pendingCompletions;
#define Check(value,message) do {checks++;if(!(value)){fprintf(stderr,"FAIL: %s\n",message);exit(1);}} while(0)
static BOOL Near(CGFloat a,CGFloat b) {return fabs(a-b)<0.001;}
static BOOL UIAccessibilityIsReduceMotionEnabled(void) {return reducedMotion;}
enum {UIViewAnimationOptionBeginFromCurrentState=1,UIViewAnimationOptionCurveEaseInOut=2,
      UIAccessibilityTraitButton=1,UIAccessibilityTraitSelected=2,UIControlStateNormal=0,
      UIImageSymbolWeightMedium=1,UIControlStateSelected=1};
static CGFloat const UIViewNoIntrinsicMetric=-1;
@interface UIColor : NSObject
+ (instancetype)whiteColor;
@end
@implementation UIColor
+ (instancetype)whiteColor {static UIColor *white;if(!white)white=[self new];return white;}
@end
static UIColor *testAccent;
@interface CSSettingsHomeTheme : NSObject
+ (UIColor *)accentColor;
@end
@implementation CSSettingsHomeTheme
+ (UIColor *)accentColor {return testAccent;}
@end
@interface TestLayer : NSObject
@property(nonatomic) NSUInteger removals;
- (void)removeAllAnimations;
@end
@implementation TestLayer
- (void)removeAllAnimations {self.removals++;}
@end
@interface UIView : NSObject
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) BOOL hidden,userInteractionEnabled,accessibilityElementsHidden,layoutNeeded;
@property(nonatomic) CGFloat alpha;
@property(nonatomic,strong) TestLayer *layer;
@property(nonatomic,copy) NSString *accessibilityLabel;
@property(nonatomic) NSUInteger accessibilityTraits;
@property(nonatomic,strong) UIColor *backgroundColor,*tintColor;
- (void)layoutSubviews;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
+ (void)performWithoutAnimation:(void(^)(void))actions;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options
                animations:(void(^)(void))animations completion:(void(^)(BOOL finished))completion;
@end
@implementation UIView
- (instancetype)init {if((self=[super init])){_layer=[TestLayer new];_alpha=1;_userInteractionEnabled=YES;}return self;}
- (void)setFrame:(CGRect)frame {_frame=frame;_bounds=CGRectMake(0,0,frame.size.width,frame.size.height);[self setNeedsLayout];}
- (void)layoutSubviews {}
- (void)setNeedsLayout {self.layoutNeeded=YES;}
- (void)layoutIfNeeded {if(self.layoutNeeded){self.layoutNeeded=NO;[self layoutSubviews];}}
+ (void)performWithoutAnimation:(void(^)(void))actions {if(actions)actions();}
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(NSUInteger)options
                animations:(void(^)(void))animations completion:(void(^)(BOOL))completion {
    animationCount++;lastDuration=duration;
    if(animations)animations();
    if(completion)[pendingCompletions addObject:[completion copy]];
}
@end
@interface UIImageSymbolConfiguration : NSObject
+ (instancetype)configurationWithPointSize:(CGFloat)pointSize weight:(NSInteger)weight;
@end
@implementation UIImageSymbolConfiguration
+ (instancetype)configurationWithPointSize:(CGFloat)pointSize weight:(NSInteger)weight {return [self new];}
@end
@interface UIImage : NSObject
+ (instancetype)systemImageNamed:(NSString *)name withConfiguration:(UIImageSymbolConfiguration *)configuration;
@end
@implementation UIImage
+ (instancetype)systemImageNamed:(NSString *)name withConfiguration:(UIImageSymbolConfiguration *)configuration {return [self new];}
@end
@interface UIButton : UIView
@property(nonatomic) BOOL selected;
@property(nonatomic) NSInteger tag;
@property(nonatomic,strong) UIColor *selectedTitleColor;
- (void)setImage:(UIImage *)image forState:(NSUInteger)state;
- (void)setTitleColor:(UIColor *)color forState:(NSUInteger)state;
@end
@implementation UIButton
- (void)setImage:(UIImage *)image forState:(NSUInteger)state {}
- (void)setTitleColor:(UIColor *)color forState:(NSUInteger)state {if(state==UIControlStateSelected)self.selectedTitleColor=color;}
@end
@interface UITextField : UIView
@property(nonatomic,copy) NSString *text;
@property(nonatomic) BOOL firstResponder;
@property(nonatomic) NSUInteger focusCalls,resignCalls;
- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
@end
@implementation UITextField
- (BOOL)becomeFirstResponder {self.firstResponder=YES;self.focusCalls++;return YES;}
- (BOOL)resignFirstResponder {self.firstResponder=NO;self.resignCalls++;return YES;}
@end
@interface CSSettingsTabBar : UIView
@property(nonatomic) NSUInteger selectedIndex;
@property(nonatomic) CGFloat horizontalInset;
@property(nonatomic,getter=isSearching) BOOL searching;
@property(nonatomic) NSUInteger searchTransitionGeneration;
@property(nonatomic,strong) UIView *railView,*selectionView;
@property(nonatomic,strong) NSArray<UIButton *> *tabButtons;
@property(nonatomic,strong) UITextField *searchField;
@property(nonatomic,strong) UIButton *searchButton;
@property(nonatomic,copy) void(^selectionChanged)(NSUInteger index);
@property(nonatomic,copy) void(^searchOpened)(void);
@property(nonatomic,copy) void(^queryChanged)(NSString *query);
@property(nonatomic,copy) void(^searchClosed)(void);
- (CGSize)intrinsicContentSize;
- (void)updateButtonStates;
- (void)reloadTheme;
- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)selectTab:(UIButton *)button;
- (void)toggleSearch;
- (void)cancelSearchAnimations;
- (void)setSearching:(BOOL)searching animated:(BOOL)animated;
- (void)resetSearch;
- (void)searchTextChanged:(UITextField *)field;
- (BOOL)textFieldShouldReturn:(UITextField *)field;
@end
@implementation CSSettingsTabBar
#import "SettingsTabBarUnderTest.h"
@end
static CSSettingsTabBar *NewBar(CGFloat width) {
    CSSettingsTabBar *bar=[CSSettingsTabBar new];
    bar.railView=[UIView new];bar.selectionView=[UIView new];bar.searchField=[UITextField new];bar.searchButton=[UIButton new];
    NSMutableArray *buttons=[NSMutableArray array];
    for(NSUInteger i=0;i<4;i++){UIButton *button=[UIButton new];button.tag=i;[buttons addObject:button];}
    bar.tabButtons=buttons;bar.horizontalInset=20;bar.searchField.hidden=YES;bar.searchField.alpha=0;
    bar.frame=CGRectMake(0,0,width,76);[bar layoutIfNeeded];[bar updateButtonStates];
    return bar;
}
static void CompleteAnimations(BOOL finished) {
    NSArray *completions=[pendingCompletions copy];[pendingCompletions removeAllObjects];
    for(void(^completion)(BOOL) in completions)completion(finished);
}
int main(void) {@autoreleasepool {
    pendingCompletions=[NSMutableArray array];
    testAccent=[UIColor new];
    CSSettingsTabBar *themeBar=NewBar(390);[themeBar reloadTheme];
    Check(themeBar.selectionView.backgroundColor==testAccent,"theme updates selected Tab background");
    Check(themeBar.searchField.tintColor==testAccent&&themeBar.searchButton.tintColor==testAccent,"theme updates inline search cursor and search button");
    for(UIButton *button in themeBar.tabButtons)Check(button.selectedTitleColor==UIColor.whiteColor,"all selected Tab labels remain fixed white");
    testAccent=[UIColor new];[themeBar reloadTheme];
    Check(themeBar.selectionView.backgroundColor==testAccent&&themeBar.tabButtons[0].selectedTitleColor==UIColor.whiteColor,"reloading theme changes accent while keeping selected text white");
    for(NSNumber *number in @[@320,@390,@844]) {
        CSSettingsTabBar *bar=NewBar(number.doubleValue);
        Check(Near(bar.intrinsicContentSize.height,76),"rail and search use one76pt row");
        Check(CGRectEqualToRect(bar.searchField.frame,bar.railView.frame),"search replaces exactly the rail bounds at every width");
        Check(Near(bar.railView.frame.size.height,54)&&Near(bar.searchButton.frame.size.height,54),"rail and separate search button share54pt height");
        Check(Near(CGRectGetMidY(bar.railView.frame),CGRectGetMidY(bar.searchButton.frame)),"search and tabs share one vertical center");
        Check(Near(CGRectGetMinX(bar.searchButton.frame)-CGRectGetMaxX(bar.railView.frame),10),"independent search button stays10pt right of rail");
        Check(CGRectGetMinX(bar.railView.frame)>=0&&CGRectGetMaxX(bar.searchButton.frame)<=number.doubleValue,"controls stay inside phone or landscape bounds");
        for(UIButton *button in bar.tabButtons) {
            Check(Near(button.frame.size.width,bar.tabButtons.firstObject.frame.size.width),"all four hit targets have equal width");
        }
        [bar setSearching:YES animated:NO];CompleteAnimations(YES);
        Check(CGRectEqualToRect(bar.searchField.frame,bar.railView.frame),"opening search keeps the same frame without adding a row");
        [bar setSearching:NO animated:NO];CompleteAnimations(YES);
    }
    CSSettingsTabBar *bar=NewBar(390);
    __block NSUInteger opened=0,closed=0,queries=0;
    __block NSString *query=nil;
    __weak CSSettingsTabBar *weakBar=bar;
    bar.searchOpened=^{opened++;Check(!weakBar.searchField.firstResponder,"controller open callback precedes keyboard focus");};
    bar.searchClosed=^{closed++;Check(!weakBar.searchField.firstResponder&&!weakBar.searchField.text.length,"close callback observes dismissed keyboard and cleared query");};
    bar.queryChanged=^(NSString *value){queries++;query=value;};
    [bar setSelectedIndex:2 animated:NO];
    [bar toggleSearch];
    Check(opened==1&&bar.searching&&bar.searchField.firstResponder,"tap search opens once and focuses the field");
    Check(bar.railView.hidden&&!bar.searchField.hidden,"opening search hides old Tab layer before its animation completes");
    Check(bar.railView.layer.removals>0&&bar.searchField.layer.removals>0&&bar.selectionView.layer.removals>0&&bar.tabButtons[0].layer.removals>0,"search cancels rail, field, selection and label-layer animations");
    Check(Near(lastDuration,0.18),"normal search transition is short180ms");
    CompleteAnimations(YES);
    Check(bar.railView.hidden&&!bar.searchField.hidden&&!bar.railView.userInteractionEnabled&&bar.searchField.userInteractionEnabled,"only search accepts interaction while expanded");
    Check([bar.searchButton.accessibilityLabel isEqualToString:@"取消搜索"]&&bar.railView.accessibilityElementsHidden,"expanded state exposes cancel and hides tabs to accessibility");
    bar.searchField.text=@"气泡";[bar searchTextChanged:bar.searchField];
    Check(queries==1&&[query isEqualToString:@"气泡"],"real editing handler forwards the query");
    Check([bar textFieldShouldReturn:bar.searchField]&&!bar.searchField.firstResponder&&bar.searching&&[bar.searchField.text isEqualToString:@"气泡"],"return dismisses keyboard while preserving query and search");
    [bar toggleSearch];
    Check(!bar.railView.hidden&&bar.searchField.hidden,"cancel hides search layer before the rail fade finishes");
    CompleteAnimations(YES);
    Check(closed==1&&!bar.searching&&bar.selectedIndex==2&&!bar.railView.hidden&&bar.searchField.hidden,"cancel restores rail and original selection");
    [bar searchTextChanged:bar.searchField];
    Check(queries==1,"hidden search cannot publish an edit");
    [bar setSearching:NO animated:YES];
    Check(closed==1,"repeating current state does not repeat callbacks");
    reducedMotion=YES;[bar setSearching:YES animated:YES];
    Check(Near(lastDuration,0.1),"Reduce Motion uses100ms fade");CompleteAnimations(YES);
    [bar setSearching:NO animated:NO];Check(Near(lastDuration,0),"nonanimated restore uses zero duration");CompleteAnimations(YES);reducedMotion=NO;

    for(NSUInteger i=0;i<6;i++)[bar toggleSearch];
    CompleteAnimations(YES);
    Check(!bar.searching&&!bar.railView.hidden&&bar.searchField.hidden&&!bar.searchField.firstResponder,"rapid open/cancel completions resolve to final closed state");
    [bar toggleSearch];[bar toggleSearch];[bar toggleSearch];CompleteAnimations(YES);
    Check(bar.searching&&bar.railView.hidden&&!bar.searchField.hidden&&bar.searchField.firstResponder,"stale callbacks cannot hide the final open search");
    [bar resetSearch];CompleteAnimations(NO);
    Check(!bar.searching&&!bar.railView.hidden&&Near(bar.railView.alpha,1)&&bar.searchField.hidden&&Near(bar.searchField.alpha,0),"silent reset restores deterministic visible state after interruption");
    NSUInteger focusBefore=bar.searchField.focusCalls,animationBefore=animationCount;
    bar.searchOpened=^{[weakBar resetSearch];};
    [bar setSearching:YES animated:YES];
    Check(!bar.searching&&bar.searchField.focusCalls==focusBefore&&animationCount==animationBefore,"account reset inside open callback aborts focus and animation");
    Check(!bar.railView.hidden&&bar.searchField.hidden,"reentrant reset keeps tabs visible");

    CSSettingsTabBar *interrupted=NewBar(390);
    [interrupted setSearching:YES animated:YES];
    [interrupted setSearching:NO animated:YES];
    [interrupted setSearching:YES animated:YES];
    NSArray *outOfOrder=[pendingCompletions copy];[pendingCompletions removeAllObjects];
    Check(outOfOrder.count==3,"rapid search replacement has three independently pending completions");
    void(^oldClose)(BOOL)=outOfOrder[1];oldClose(YES);
    Check(interrupted.railView.hidden&&!interrupted.searchField.hidden&&Near(interrupted.searchField.alpha,1),"stale close completion cannot reveal the Tab rail over an open search");
    void(^latestOpen)(BOOL)=outOfOrder[2];latestOpen(NO);
    Check(interrupted.railView.hidden&&!interrupted.searchField.hidden,"interrupted current fade settles to one search layer");
    [interrupted resetSearch];
    void(^oldOpen)(BOOL)=outOfOrder[0];oldOpen(YES);latestOpen(YES);
    Check(!interrupted.railView.hidden&&interrupted.searchField.hidden&&Near(interrupted.railView.alpha,1)&&Near(interrupted.searchField.alpha,0),"reset invalidates all earlier search completions");
    __weak CSSettingsTabBar *weakInterrupted=interrupted;
    interrupted.searchOpened=^{
        weakInterrupted.searchOpened=nil;
        [weakInterrupted resetSearch];
        [weakInterrupted setSearching:YES animated:YES];
    };
    NSUInteger focusCount=interrupted.searchField.focusCalls;
    [interrupted setSearching:YES animated:YES];
    Check(interrupted.searching&&interrupted.searchField.focusCalls==focusCount+1,"nested reset and reopen focuses once and invalidates outer open");
    CompleteAnimations(YES);
    Check(interrupted.railView.hidden&&!interrupted.searchField.hidden,"nested open finishes with only search visible");

    __block NSUInteger selections=0,lastSelection=NSNotFound;
    bar.selectionChanged=^(NSUInteger value){selections++;lastSelection=value;};
    [bar setSelectedIndex:99 animated:YES];
    Check(bar.selectedIndex==3&&bar.tabButtons[3].selected&&!bar.tabButtons[0].selected,"selection clamps to the fourth tab and updates buttons");
    Check((bar.tabButtons[3].accessibilityTraits&UIAccessibilityTraitSelected)!=0,"selected tab exposes accessibility state");
    Check(Near(lastDuration,0.24),"selection capsule animates240ms");
    [bar selectTab:bar.tabButtons[1]];
    Check(selections==1&&lastSelection==1&&bar.selectedIndex==1,"tab touch forwards exactly the selected category");
    [bar selectTab:bar.tabButtons[1]];Check(selections==1,"current tab does not trigger a duplicate reload");
    NSUInteger countBefore=animationCount;reducedMotion=YES;[bar setSelectedIndex:0 animated:YES];
    Check(animationCount==countBefore&&bar.selectedIndex==0,"Reduce Motion moves selection without sliding animation");reducedMotion=NO;
    bar.searchOpened=nil;[bar setSearching:YES animated:NO];CompleteAnimations(YES);
    [bar selectTab:bar.tabButtons[2]];
    Check(bar.selectedIndex==0&&selections==1,"search overlay blocks hidden tab selection");
    [bar resetSearch];
    printf("SettingsTabBarTests: %lu checks passed\n",(unsigned long)checks);
}}
