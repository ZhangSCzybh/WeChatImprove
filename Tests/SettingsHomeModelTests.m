#import <Foundation/Foundation.h>
#import "CSSettingsHomeLayout.h"

// Foundation-only fixtures expose the same data API as the native setting models.
// The runner compiles the unmodified production presentation model below them.
@interface CSSettingItem : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *detail;
@property(nonatomic, copy) void (^actionBlock)(void);
@end
@implementation CSSettingItem @end

@interface CSSettingSection : NSObject
@property(nonatomic, copy) NSString *header;
@property(nonatomic, copy) NSArray<CSSettingItem *> *items;
+ (instancetype)sectionWithHeader:(NSString *)header items:(NSArray<CSSettingItem *> *)items;
@end
@implementation CSSettingSection
+ (instancetype)sectionWithHeader:(NSString *)header items:(NSArray<CSSettingItem *> *)items {
    CSSettingSection *section=[self new]; section.header=header; section.items=items; return section;
}
@end

#import "SettingsHomeModelUnderTest.h"

static NSUInteger checks, failures;
static void Check(BOOL result, NSString *message) {
    checks++;
    if (!result) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static BOOL Near(CGFloat a, CGFloat b) { return fabs(a-b)<0.001; }
static CSSettingItem *Item(NSString *title) {
    CSSettingItem *item=[CSSettingItem new]; item.title=title; return item;
}
static NSArray<CSSettingSection *> *Sections(BOOL includeConditional) {
    NSMutableArray *account=[NSMutableArray arrayWithArray:@[Item(@"账号信息"),Item(@"收藏验证")]];
    if (includeConditional) [account addObject:Item(@"可见测试入口")];
    return @[
        [CSSettingSection sectionWithHeader:@"账号与安全" items:account],
        [CSSettingSection sectionWithHeader:@"界面定制" items:@[Item(@"顶栏信息"),Item(@"头像设置"),Item(@"Café 字体")]],
        [CSSettingSection sectionWithHeader:@"功能增强" items:@[Item(@"后台运行"),Item(@"API设置")]],
        [CSSettingSection sectionWithHeader:@"插件设置" items:@[Item(@"入口设置")]],
        [CSSettingSection sectionWithHeader:@"关于" items:@[Item(@"版本信息"),Item(@"支持作者")]]
    ];
}
static NSUInteger VisibleItemCount(NSArray<CSSettingSection *> *sections) {
    NSUInteger count=0; for (CSSettingSection *section in sections) count+=section.items.count; return count;
}
static CSSettingItem *OnlyMatch(CSSettingsHomeModel *model, NSString *query) {
    model.query=query;
    Check(model.displayedSections.count==1 && VisibleItemCount(model.displayedSections)==1,
          [@"one matching item for query " stringByAppendingString:query]);
    return model.displayedSections.firstObject.items.firstObject;
}
static void TestModel(void) {
    CSSettingsHomeModel *model=[CSSettingsHomeModel new];
    Check(model.selectedIndex==0 && !model.searching && model.query.length==0,@"a fresh page starts in the first Tab outside search");
    Check(model.displayedSections.count==0,@"an unloaded model has no stale visible entries");
    NSArray *source=Sections(YES);
    Check(![model replaceSections:source accountIdentifier:@"account-a:42"],@"initial account setup does not report a switch");
    for (NSUInteger tab=0; tab<4; tab++) {
        model.selectedIndex=tab;
        NSArray *displayed=model.displayedSections;
        Check(displayed.count==2,@"each Tab contains its functional group and About");
        Check(displayed.firstObject==source[tab],@"Tab selection preserves the original section object");
        Check(displayed.lastObject==source.lastObject,@"all four Tabs share the same About section");
        Check([displayed.lastObject items][0]==[source.lastObject items][0] &&
              [displayed.lastObject items][1]==[source.lastObject items][1],@"version and author actions retain the same objects in every Tab");
    }
    model.selectedIndex=NSUIntegerMax;
    Check(model.selectedIndex==3 && model.displayedSections.firstObject==source[3],@"invalid Tab indices clamp to the final valid category");
    model.searching=YES;
    for (NSString *query in @[@"",@" \n\t "]) {
        model.query=query;
        Check(model.displayedSections.count==5 && VisibleItemCount(model.displayedSections)==11,@"empty or whitespace search includes every visible entry once");
        Check(model.displayedSections.lastObject==source.lastObject,@"empty search includes About once without creating per-Tab duplicates");
    }
    Check(OnlyMatch(model,@" \n头像\t ")==[source[1] items][1],@"query trimming preserves the exact matching navigation item");
    Check(OnlyMatch(model,@"api")==[source[2] items][1],@"English title matching is case insensitive");
    Check(OnlyMatch(model,@"ａｐｉ")==[source[2] items][1],@"fullwidth and normal-width English queries match the same title");
    Check(OnlyMatch(model,@"cafe")==[source[1] items][2],@"diacritic-insensitive matching retains the source item");
    Check(OnlyMatch(model,@"版本信息")==[source.lastObject items][0],@"search reaches About even from another selected Tab");
    model.query=@"界面定制";
    Check(model.displayedSections.count==1 && VisibleItemCount(model.displayedSections)==3,@"a full category name finds all entries in its group");
    Check([model.displayedSections.firstObject.header isEqual:@"界面定制"],@"search retains the full category heading");
    Check([model.displayedSections.firstObject.items isEqual:[source[1] items]],@"category search retains entry order and identity");
    model.query=@"设置";
    Check(model.displayedSections.count==3,@"title and category matches are grouped in source order");
    Check([model.displayedSections[0].header isEqual:@"界面定制"] &&
          [model.displayedSections[1].header isEqual:@"功能增强"] &&
          [model.displayedSections[2].header isEqual:@"插件设置"],@"cross-category results preserve their original headings and ordering");
    model.query=@"未匹配到的条目";
    Check(model.displayedSections.count==0,@"no-match queries return a real empty result");
    CSSettingItem *routed=[source[2] items][1];
    __block NSUInteger actions=0;
    routed.actionBlock=^{actions++;};
    CSSettingItem *result=OnlyMatch(model,@"API设置");
    result.actionBlock();
    Check(result==routed && actions==1,@"search does not clone or alter the navigation/action item");
    routed.detail=@"detail-only-secret";
    model.query=@"detail-only-secret";
    Check(model.displayedSections.count==0,@"search indexes entry titles and categories rather than unrelated detail values");
    model.selectedIndex=2;
    Check(OnlyMatch(model,@"可见测试入口")==[source[0] items][2],@"a currently visible conditional item can be searched");
    NSArray *newSource=Sections(NO);
    Check(![model replaceSections:newSource accountIdentifier:@"account-a:42"],@"same-account visibility rebuild does not reset page state");
    Check(model.searching && model.selectedIndex==2 && [model.query isEqual:@"可见测试入口"],@"same-account rebuild preserves selected Tab and current query");
    Check(model.displayedSections.count==0,@"removed conditional entries disappear from current search immediately");
    Check(OnlyMatch(model,@"头像")==[newSource[1] items][1],@"search rebuild uses current source items rather than stale cached actions");
    model.searching=NO;
    Check(model.selectedIndex==2 && model.displayedSections.firstObject==newSource[2],@"leaving search returns to the previously selected functional group");
    model.searching=YES;
    model.query=@"入口";
    Check([model replaceSections:Sections(YES) accountIdentifier:@"account-a:43"],@"a changed account epoch resets transient state even with the same account name");
    Check(model.selectedIndex==0 && !model.searching && model.query.length==0,@"epoch reset clears selected Tab, search mode and query together");
    model.selectedIndex=1; model.searching=YES; model.query=@"设置";
    Check([model replaceSections:Sections(NO) accountIdentifier:@"account-b:43"],@"a new account identifier reports a state reset");
    Check(model.selectedIndex==0 && !model.searching && model.query.length==0,@"account changes cannot inherit another account's search or selected category");
    [model replaceSections:@[] accountIdentifier:@"account-b:43"];
    Check(model.displayedSections.count==0,@"temporarily incomplete source sections fail closed in normal mode");
    model.searching=YES;
    Check(model.displayedSections.count==0,@"temporarily incomplete source sections fail closed in search mode");
}

static void TestGeometry(void) {
    // Exercise representative safe areas, profile sizes, viewport sizes and list lengths.
    // Assertions describe the user-visible invariants rather than a second implementation.
    for (NSNumber *profileValue in @[@196,@216,@230,@250]) {
        CGFloat profile=profileValue.doubleValue;
        for (NSNumber *topValue in @[@0,@44,@88]) {
            CGFloat top=topValue.doubleValue;
            Check(Near(CSSettingsHomeRailY(profile,0,top),top+profile),@"at natural top the rail sits immediately below the complete profile card");
            Check(Near(CSSettingsHomeRailY(profile,profile,top),top),@"the rail reaches the navigation-safe edge exactly at the dynamic profile bottom");
            Check(Near(CSSettingsHomeRailY(profile,profile+100,top),top),@"continued scrolling keeps the rail pinned below navigation");
            Check(Near(CSSettingsHomeRailY(profile,profile-1,top),top+1),@"the rail has no jump just before its pinning threshold");
            for (NSNumber *viewportValue in @[@568,@667,@844]) {
                CGFloat viewport=viewportValue.doubleValue;
                for (NSNumber *bottomValue in @[@0,@34,@320]) {
                    CGFloat bottom=bottomValue.doubleValue;
                    CGFloat shortContent=profile+76+6*54;
                    CGFloat maximum=CSSettingsHomeMaximumDistance(shortContent,viewport,top,bottom);
                    Check(maximum>=0,@"legal scroll distance never becomes negative for a short Tab");
                    Check(Near(CSSettingsHomeClampedDistance(-200,maximum),0),@"negative saved positions restore to the natural top");
                    Check(Near(CSSettingsHomeClampedDistance(maximum+300,maximum),maximum),@"oversized saved positions restore within the new list's bottom boundary");
                    CGFloat mid=maximum/2;
                    Check(Near(CSSettingsHomeClampedDistance(mid,maximum),mid),@"already legal per-Tab scroll distances remain unchanged");
                    CGFloat tallerContent=shortContent+400;
                    CGFloat tallerMaximum=CSSettingsHomeMaximumDistance(tallerContent,viewport,top,bottom);
                    Check(tallerMaximum>=maximum,@"more function rows cannot shorten the legal scroll range");
                    CGFloat enoughContent=MAX(shortContent,viewport-top-bottom+profile);
                    CGFloat paddedMaximum=CSSettingsHomeMaximumDistance(enoughContent,viewport,top,bottom);
                    Check(paddedMaximum+0.001>=profile,@"minimum content padding can retain a pinned rail when changing to a short Tab");
                }
            }
        }
    }
    for (NSNumber *oldValue in @[@196,@216,@230]) {
        CGFloat oldHeight=oldValue.doubleValue;
        for (NSNumber *newValue in @[@196,@216,@230,@250]) {
            CGFloat newHeight=newValue.doubleValue;
            CGFloat pinnedDistance=oldHeight+80;
            CGFloat adjusted=CSSettingsHomeAdjustedDistance(pinnedDistance,oldHeight,newHeight);
            Check(Near(adjusted-newHeight,pinnedDistance-oldHeight),@"an asynchronous verse reflow preserves the same position beneath the pinned rail");
            Check(Near(CSSettingsHomeRailY(newHeight,adjusted,88),88),@"an asynchronous verse reflow keeps an already pinned rail pinned");
            Check(Near(CSSettingsHomeAdjustedDistance(oldHeight/2,oldHeight,newHeight),oldHeight/2),@"reflow while viewing the profile preserves the current natural scroll distance");
            Check(Near(CSSettingsHomeAdjustedDistance(oldHeight,oldHeight,newHeight),newHeight),@"reflow at the exact threshold keeps the rail on the safe edge");
        }
    }
    Check(Near(CSSettingsHomeAdjustedDistance(0,0,230),0),@"the first header measurement does not cause an initial scroll jump");
    Check(Near(CSSettingsHomeClampedDistance(50,-1),0),@"defensive clamping handles an invalid negative maximum");
}

int main(void) { @autoreleasepool {
    TestModel(); TestGeometry();
    printf("SettingsHomeModelTests: %lu checks, %lu failures (real production model and layout helpers; four Tabs/shared About, global visible-only search, identity/routes, rebuild/account reset, sticky rail/safe areas, legal scrolling and asynchronous reflow)\n",(unsigned long)checks,(unsigned long)failures);
} return failures ? 1 : 0; }
