#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
static NSUInteger Checks,NativeCalls,NativeLayouts;
#define CHECK(x) do { Checks++;if (!(x)) {fprintf(stderr,"FAIL %d: %s\n",__LINE__,#x);exit(1);} } while(0)
@interface AttachmentDefaults : NSObject
@property(nonatomic,strong) NSMutableDictionary *values;
@property(nonatomic) NSUInteger reads,writes,syncs;
@end
@implementation AttachmentDefaults
- (id)objectForKey:(NSString *)key {self.reads++;return self.values[key];}
- (NSArray *)arrayForKey:(NSString *)key {id v=[self objectForKey:key];return [v isKindOfClass:NSArray.class]?v:nil;}
- (BOOL)boolForKey:(NSString *)key {return [[self objectForKey:key] boolValue];}
- (NSInteger)integerForKey:(NSString *)key {return [[self objectForKey:key] integerValue];}
- (float)floatForKey:(NSString *)key {return [[self objectForKey:key] floatValue];}
- (void)setObject:(id)value forKey:(NSString *)key {self.writes++;self.values[key]=[value copy];}
- (BOOL)synchronize {self.syncs++;return YES;}
@end
static AttachmentDefaults *Defaults;
static id FixtureDefaults(id owner,SEL selector) {return Defaults;}
static CGFloat viewWidth;
static BOOL currentChatIsOfficial,currentChatIsPrivate,currentChatIsGroup;
static NSString *currentChatID;
#include "AttachmentLayoutSnapshot.inc"
static CGRect CSNativeFrame(id self,unsigned int index,double width) {NativeCalls++;return CGRectMake(-23,index,width,77);}
static void CSNativeLayout(id self) {NativeLayouts++;}
@interface SelectAttachmentView : NSObject
@property(nonatomic) CGRect bounds;
- (void)layoutSubviews;
- (CGRect)calculateEmoticonViewFrameAtIndex:(unsigned int)index forViewWidth:(double)width;
@end
@implementation SelectAttachmentView
#include "AttachmentLayoutMethods.inc"
@end
static NSString *OrderKey(NSUInteger scene) {return scene==3?kChatAttachmentOfficialSortOrderKey:scene==2?kChatAttachmentGroupSortOrderKey:kChatAttachmentPrivateSortOrderKey;}
static NSString *SortKey(NSUInteger scene) {return scene==3?kChatAttachmentOfficialSortEnabledKey:scene==2?kChatAttachmentGroupSortEnabledKey:kChatAttachmentPrivateSortEnabledKey;}
static NSString *HiddenKey(NSUInteger scene) {return scene==3?kChatAttachmentOfficialHiddenButtonsKey:scene==2?kChatAttachmentGroupHiddenButtonsKey:kChatAttachmentPrivateHiddenButtonsKey;}
static NSString *ShowKey(NSUInteger scene) {return scene==3?kChatAttachmentShowInOfficialKey:scene==2?kChatAttachmentShowInGroupKey:kChatAttachmentShowInPrivateKey;}
static void Scene(NSUInteger scene) {
    currentChatIsOfficial=scene==3;currentChatIsGroup=scene==2;currentChatIsPrivate=scene==1;
    currentChatID=[NSString stringWithFormat:@"chat-%lu",(unsigned long)scene];
}
// Independent sequential model of the pre-optimization layout contract.
static CGRect Expected(NSUInteger scene,unsigned int index,CGFloat width,BOOL sorting,NSArray *order,NSArray *hidden,int columns,float spacing) {
    NSUInteger tagCount=scene==3?6:scene==2?16:13;
    NSNumber *tag=@(18000+index%tagCount);
    if (sorting && [hidden containsObject:tag]) return CGRectMake(width*100,0,0,0);
    NSUInteger position=sorting?[order indexOfObject:tag]:NSNotFound;
    if (position==NSNotFound) position=index;
    NSUInteger visible=0;
    if (sorting) for (NSUInteger i=0;i<MIN(position,order.count);i++) if (![hidden containsObject:order[i]]) visible++;
    NSUInteger rowWidth=columns*2,page=visible/rowWidth,offset=visible%rowWidth;
    CGFloat x=(width-(65.0*columns+(8+spacing)*(columns-1)))/2.0+(offset%columns)*(65+8+spacing)+page*width;
    return CGRectMake(x,(offset/columns)*96,65,96);
}
static NSArray *Tags(NSUInteger scene) {NSMutableArray *a=[NSMutableArray array];for (int i=0;i<(scene==3?6:scene==2?16:13);i++) [a addObject:@(18000+i)];return a;}
static void Reset(void) {
    Defaults.values=[NSMutableDictionary dictionaryWithDictionary:@{kChatAttachmentLayoutEnabledKey:@YES,kChatAttachmentShowInOfficialKey:@YES,kChatAttachmentShowInGroupKey:@YES,kChatAttachmentShowInPrivateKey:@YES,kChatAttachmentOfficialSortEnabledKey:@YES,kChatAttachmentGroupSortEnabledKey:@YES,kChatAttachmentPrivateSortEnabledKey:@YES}];
    Defaults.reads=Defaults.writes=Defaults.syncs=0;CSAttachmentLayoutInvalidate();
}
int main(void) { @autoreleasepool {
    Defaults=[AttachmentDefaults new];Method method=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));IMP original=method_setImplementation(method,(IMP)FixtureDefaults);
    SelectAttachmentView *view=[SelectAttachmentView new];
    NSUInteger maxReads=0;
    for (NSUInteger scene=1;scene<=3;scene++) for (NSUInteger variant=0;variant<7;variant++) {
        Reset();Scene(scene);
        NSMutableArray *order=[Tags(scene) mutableCopy],*hidden=[NSMutableArray array];
        if (variant==1) order=[[[order reverseObjectEnumerator] allObjects] mutableCopy];
        if (variant==2) for(NSUInteger i=0;i<order.count;i+=2) [hidden addObject:order[i]];
        if (variant==3) [hidden addObjectsFromArray:order];
        if (variant==4) {[order removeObjectAtIndex:0];[order insertObject:@99999 atIndex:0];[hidden addObject:@99999];}
        if (variant==5) {[order insertObject:order[0] atIndex:2];[hidden addObject:order[2]];}
        BOOL sorting=variant!=6;
        Defaults.values[OrderKey(scene)]=order;Defaults.values[HiddenKey(scene)]=hidden;Defaults.values[SortKey(scene)]=@(sorting);
        for (int columns=3;columns<=6;columns++) for (NSNumber *width in @[@320,@390,@768]) {
            Defaults.values[kChatAttachmentColumnsKey]=@(columns);Defaults.values[kChatAttachmentSpacingKey]=@3.5;
            view.bounds=CGRectMake(0,0,width.doubleValue,200);[view layoutSubviews];
            NSUInteger before=NativeCalls;
            NSUInteger beforeReads=Defaults.reads;
            for (unsigned int index=0;index<40;index++) {
                CGRect actual=[view calculateEmoticonViewFrameAtIndex:index forViewWidth:999];
                CGRect expected=Expected(scene,index,width.doubleValue,sorting,order,hidden,columns,3.5);
                CHECK(CGRectEqualToRect(actual,expected));
            }
            CHECK(NativeCalls==before+40);
            NSUInteger reads=Defaults.reads;
            for (unsigned int index=0;index<40;index++) (void)[view calculateEmoticonViewFrameAtIndex:index forViewWidth:999];
            CHECK(Defaults.reads==reads);maxReads=MAX(maxReads,reads-beforeReads);
        }
    }
    // Missing and empty sort orders still initialize exactly once, only while enabled.
    for (NSUInteger scene=1;scene<=3;scene++) for (NSUInteger empty=0;empty<2;empty++) {
        Reset();Scene(scene);if(empty) Defaults.values[OrderKey(scene)]=@[];
        (void)[view calculateEmoticonViewFrameAtIndex:0 forViewWidth:390];
        CHECK([Defaults.values[OrderKey(scene)] isEqual:Tags(scene)] && Defaults.writes==1 && Defaults.syncs==1);
        NSUInteger reads=Defaults.reads;
        for (int i=0;i<1000;i++) (void)[view calculateEmoticonViewFrameAtIndex:i%20 forViewWidth:390];
        CHECK(Defaults.reads==reads && Defaults.writes==1 && Defaults.syncs==1);
    }
    Reset();Scene(1);Defaults.values[kChatAttachmentLayoutEnabledKey]=@NO;NSUInteger before=NativeCalls;
    CHECK(CGRectEqualToRect([view calculateEmoticonViewFrameAtIndex:7 forViewWidth:123],CGRectMake(-23,7,123,77)));
    CHECK(NativeCalls==before+1 && Defaults.writes==0 && Defaults.syncs==0);
    Reset();Scene(2);Defaults.values[ShowKey(2)]=@NO;
    CHECK(CGRectEqualToRect([view calculateEmoticonViewFrameAtIndex:3 forViewWidth:456],CGRectMake(-23,3,456,77)));
    CHECK(!Defaults.values[OrderKey(2)]);
    Reset();Scene(0);viewWidth=390;
    CHECK(CGRectEqualToRect([view calculateEmoticonViewFrameAtIndex:15 forViewWidth:390],Expected(0,15,390,NO,@[],@[],5,0)));
    CHECK(!Defaults.values[OrderKey(1)]);
    // Scene keys force a fresh snapshot without relying on a settings notification.
    Reset();Scene(1);CSAttachmentLayoutSnapshot *private=CSAttachmentLayoutConfiguration();Scene(3);CSAttachmentLayoutSnapshot *official=CSAttachmentLayoutConfiguration();
    CHECK(official!=private && official.scene==3 && official.tags.count==6);
    currentChatID=@"other-official";CHECK(CSAttachmentLayoutConfiguration()!=official);
    // A configuration revision / a subsequent native layout refreshes changed values.
    Reset();Scene(1);viewWidth=390;CGRect first=[view calculateEmoticonViewFrameAtIndex:2 forViewWidth:390];
    Defaults.values[HiddenKey(1)]=@[@18002];CSAttachmentLayoutInvalidate();
    CHECK(CGRectEqualToRect([view calculateEmoticonViewFrameAtIndex:2 forViewWidth:390],CGRectMake(39000,0,0,0)));
    Defaults.values[HiddenKey(1)]=@[];view.bounds=CGRectMake(0,0,390,300);[view layoutSubviews];
    CHECK(CGRectEqualToRect([view calculateEmoticonViewFrameAtIndex:2 forViewWidth:390],first));
    // Copies must remain immutable even if an externally supplied mutable array changes in place.
    NSMutableArray *order=[Tags(1) mutableCopy];Defaults.values[OrderKey(1)]=order;CSAttachmentLayoutInvalidate();
    CSAttachmentLayoutSnapshot *saved=CSAttachmentLayoutConfiguration();[order exchangeObjectAtIndex:0 withObjectAtIndex:1];
    CHECK([saved.positions[@18000] isEqual:@0]);CSAttachmentLayoutInvalidate();CHECK([CSAttachmentLayoutConfiguration().positions[@18000] isEqual:@1]);
    CSAttachmentLayoutObserveSettings((NSUserDefaults *)Defaults);
    saved=CSAttachmentLayoutConfiguration();Defaults.values[HiddenKey(1)]=@[@18000];
    [NSNotificationCenter.defaultCenter postNotificationName:@"CSChatAttachmentLayoutSettingsChanged" object:nil];
    CHECK(CSAttachmentLayoutConfiguration()!=saved && [CSAttachmentLayoutConfiguration().hidden containsObject:@18000]);
    saved=CSAttachmentLayoutConfiguration();Defaults.values[HiddenKey(1)]=@[];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:Defaults];
    CHECK(CSAttachmentLayoutConfiguration()!=saved && !CSAttachmentLayoutConfiguration().hidden.count);
    method_setImplementation(method,original);
    printf("Attachment layout: %lu checks passed; 3 scenes, 7 sort/hide variants, 4 column counts, 3 widths, unknown indexes, native side effects and disabled native return. Stable 1000 callbacks: 0 additional preference reads; each missing/empty order: 1 initialization + 1 synchronize. Native layouts=%lu, preference reads <=%lu per enabled scene/layout; custom and defaults notifications invalidate snapshots.\n",(unsigned long)Checks,(unsigned long)NativeLayouts,(unsigned long)maxReads);
}return 0;}
