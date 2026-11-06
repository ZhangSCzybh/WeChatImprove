#import <UIKit/UIKit.h>
#import "CSAvatarRotation.h"
#import "CSInputTextStyle.h"
#import <objc/runtime.h>
#import <assert.h>

static NSUInteger checks;
#define Check(condition) do { checks++; if (!(condition)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#condition); abort(); } } while(0)
static void Pump(void) { [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.03]]; }
@interface CountingDefaults : NSUserDefaults
@property(nonatomic,strong) NSMutableDictionary *values;
@property(nonatomic) NSUInteger reads;
@end
@implementation CountingDefaults
- (instancetype)init { if ((self=[super init])) _values=[NSMutableDictionary dictionary]; return self; }
- (id)objectForKey:(NSString *)key { self.reads++;return self.values[key]; }
- (BOOL)boolForKey:(NSString *)key { return [[self objectForKey:key] boolValue]; }
- (double)doubleForKey:(NSString *)key { return [[self objectForKey:key] doubleValue]; }
- (void)setObject:(id)value forKey:(NSString *)key { self.values[key]=value; }
- (void)removeObjectForKey:(NSString *)key { [self.values removeObjectForKey:key]; }
@end
@interface CountingLayer : CALayer
@property(nonatomic,strong) NSMutableDictionary *submitted;
@property(nonatomic) NSUInteger adds, styleWrites;
@end
@implementation CountingLayer
- (instancetype)init { if ((self=[super init])) _submitted=[NSMutableDictionary dictionary];return self; }
- (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key { self.adds++;self.submitted[key]=[animation copy]; }
- (CAAnimation *)animationForKey:(NSString *)key { return self.submitted[key]; }
- (void)removeAnimationForKey:(NSString *)key { [self.submitted removeObjectForKey:key]; }
- (void)removeAllAnimations { [self.submitted removeAllObjects]; }
- (void)setCornerRadius:(CGFloat)value { self.styleWrites++;[super setCornerRadius:value]; }
- (void)setBorderWidth:(CGFloat)value { self.styleWrites++;[super setBorderWidth:value]; }
- (void)setBorderColor:(CGColorRef)value { self.styleWrites++;[super setBorderColor:value]; }
@end
@interface TestNativeInner : NSObject
@property(nonatomic,strong) UIColor *placeHolderColor;
@property(nonatomic) BOOL placeholderMultiLine;
@end
@implementation TestNativeInner @end
@interface TestNativeInput : UIView
@property(nonatomic,copy) NSString *placeHolder;
@property(nonatomic,copy) NSAttributedString *attributePlaceholder;
@property(nonatomic,strong) TestNativeInner *textView;
@property(nonatomic) NSUInteger writes,nativeLayouts,nativeMoves;
@property(nonatomic,copy) NSString *typedText;
@property(nonatomic) NSRange selectedRange;
- (void)setPlaceHolderColor:(UIColor *)color;
- (void)setPlaceHolderMultiLine:(BOOL)value;
- (void)setPlaceholder:(NSString *)text animated:(BOOL)animated;
- (void)setAttributedPlaceholder:(NSAttributedString *)text animated:(BOOL)animated;
@end
@implementation TestNativeInput
- (instancetype)init { if ((self=[super init])) { self.layer=[CountingLayer layer];_textView=[TestNativeInner new];_textView.placeHolderColor=[UIColor colorWithWhite:.3 alpha:1];_placeHolder=@"Native"; }return self; }
- (void)setPlaceHolder:(NSString *)text { self.writes++;BOOL changed=![_placeHolder isEqual:text];_placeHolder=[text copy];if(changed) self.attributePlaceholder=nil; }
- (void)setAttributePlaceholder:(NSAttributedString *)text { self.writes++;_attributePlaceholder=[text copy]; }
- (void)setPlaceHolderColor:(UIColor *)color { self.writes++;self.textView.placeHolderColor=color; }
- (void)setPlaceHolderMultiLine:(BOOL)value { self.writes++;self.textView.placeholderMultiLine=value; }
- (void)setPlaceholder:(NSString *)text animated:(BOOL)animated { self.placeHolder=text; }
- (void)setAttributedPlaceholder:(NSAttributedString *)text animated:(BOOL)animated { self.attributePlaceholder=text; }
- (void)layoutSubviews { self.nativeLayouts++; }
- (void)didMoveToWindow { self.nativeMoves++; }
@end
@interface TestNativeTool : UIView
@property(nonatomic,strong) TestNativeInput *textView;
@property(nonatomic) NSUInteger nativeUpdates;
- (void)updateToolViewHeight:(BOOL)animated;
- (void)onWillAppear;
- (void)onViewDidInit;
@end
@implementation TestNativeTool
- (void)layoutSubviews { self.nativeUpdates++; }
- (void)updateToolViewHeight:(BOOL)animated { self.nativeUpdates++; }
- (void)onWillAppear { self.nativeUpdates++; }
- (void)onViewDidInit { self.nativeUpdates++; }
@end
#import "StyleHooksUnderTest.h"

static NSProcessInfoThermalState thermal=NSProcessInfoThermalStateNominal;
static NSProcessInfoThermalState TestThermal(id object,SEL selector) { return thermal; }
static IMP decodeOriginal;
static NSUInteger decodes;
static id CountDecode(id cls,SEL selector,Class expected,NSData *data,NSError **error) {
    decodes++;
    return ((id(*)(id,SEL,Class,id,NSError **))decodeOriginal)(cls,selector,expected,data,error);
}
static NSString *Key(NSString *suffix) { return [@"com.wechat.enhance.inputText." stringByAppendingString:suffix]; }
static void InputSet(CountingDefaults *defaults,NSString *key,id value) { [defaults setObject:value forKey:Key(key)]; }
static void Post(NSString *name,id object) { [NSNotificationCenter.defaultCenter postNotificationName:name object:object]; }
static BOOL Rotating(UIView *view) { return [view.layer animationForKey:@"cs.avatar.rotation"]!=nil; }

static void TestAvatars(CountingDefaults *defaults,UIWindow *window) {
    CSAvatarRotationInstall(defaults);CSAvatarRotationInstall(defaults);
    MoreViewController *page=[MoreViewController new];page.view=[[UIView alloc] initWithFrame:window.bounds];[window addSubview:page.view];
    [page viewDidAppear:NO];
    for (Class cls in @[MMHeadImageView.class,FakeHeadImageView.class]) {
        UIView *avatar=[[cls alloc] initWithFrame:CGRectMake(20,20,60,60)];avatar.layer=[CountingLayer layer];avatar.tag=101;[page.view addSubview:avatar];[avatar didMoveToWindow];
        Check(!Rotating(avatar));
        [defaults setObject:@YES forKey:@"rotateAvatar"];CSAvatarRotationPreferencesChanged();Pump();Check(Rotating(avatar));
        CountingLayer *layer=(id)avatar.layer;NSUInteger reads=defaults.reads,adds=layer.adds;
        for(NSUInteger i=0;i<10000;i++)CSAvatarRotationUpdate(avatar);
        Check(defaults.reads==reads);Check(layer.adds==adds);
        CABasicAnimation *unrelated=[CABasicAnimation animationWithKeyPath:@"opacity"];[layer addAnimation:unrelated forKey:@"native"];
        avatar.hidden=YES;Check(!Rotating(avatar));Check([layer animationForKey:@"native"]!=nil);
        avatar.hidden=NO;Check(Rotating(avatar));avatar.alpha=0;Check(!Rotating(avatar));avatar.alpha=1;Check(Rotating(avatar));
        avatar.tag=99;Check(!Rotating(avatar));avatar.tag=101;Check(Rotating(avatar));
        page.view.hidden=YES;[page viewDidLayoutSubviews];Check(!Rotating(avatar));page.view.hidden=NO;[page viewDidLayoutSubviews];Check(Rotating(avatar));
        page.view.clipsToBounds=YES;avatar.frame=CGRectMake(20,1000,60,60);[page viewDidLayoutSubviews];Check(!Rotating(avatar));avatar.frame=CGRectMake(20,20,60,60);[page viewDidLayoutSubviews];Check(Rotating(avatar));
        [page viewWillDisappear:NO];Check(!Rotating(avatar));Post(UIApplicationDidBecomeActiveNotification,nil);Check(!Rotating(avatar));[page viewDidAppear:NO];Check(Rotating(avatar));
        Post(UIApplicationWillResignActiveNotification,nil);Check(!Rotating(avatar));Post(UIApplicationDidBecomeActiveNotification,nil);Check(Rotating(avatar));
        UIApplication.sharedApplication.applicationState=UIApplicationStateBackground;CSAvatarRotationUpdate(avatar);Check(!Rotating(avatar));UIApplication.sharedApplication.applicationState=UIApplicationStateActive;CSAvatarRotationUpdate(avatar);Check(Rotating(avatar));
        Post(UISceneWillDeactivateNotification,window.windowScene);Check(!Rotating(avatar));Post(UISceneDidActivateNotification,window.windowScene);Check(Rotating(avatar));
        UIWindowScene *other=[UIWindowScene new];Post(UISceneWillDeactivateNotification,other);Check(Rotating(avatar));
        window.windowScene.activationState=UISceneActivationStateBackground;CSAvatarRotationUpdate(avatar);Check(!Rotating(avatar));window.windowScene.activationState=UISceneActivationStateForegroundActive;CSAvatarRotationUpdate(avatar);Check(Rotating(avatar));
        for (NSNumber *state in @[@(NSProcessInfoThermalStateSerious),@(NSProcessInfoThermalStateCritical)]) { thermal=state.integerValue;Post(NSProcessInfoThermalStateDidChangeNotification,nil);Check(!Rotating(avatar)); }
        thermal=NSProcessInfoThermalStateFair;Post(NSProcessInfoThermalStateDidChangeNotification,nil);Check(Rotating(avatar));
        CSTestReduceMotionEnabled=YES;Post(UIAccessibilityReduceMotionStatusDidChangeNotification,nil);Check(!Rotating(avatar));CSTestReduceMotionEnabled=NO;Post(UIAccessibilityReduceMotionStatusDidChangeNotification,nil);Check(Rotating(avatar));
        [layer removeAllAnimations];CSAvatarRotationUpdate(avatar);Check(Rotating(avatar));
        [defaults setObject:@10 forKey:@"rotateSpeed"];CSAvatarRotationPreferencesChanged();Pump();Check([layer animationForKey:@"cs.avatar.rotation"].duration==2);
        [defaults setObject:@0 forKey:@"rotateSpeed"];CSAvatarRotationPreferencesChanged();Pump();Check([layer animationForKey:@"cs.avatar.rotation"].duration==7);
        [defaults setObject:@100 forKey:@"rotateSpeed"];CSAvatarRotationPreferencesChanged();Pump();Check([layer animationForKey:@"cs.avatar.rotation"].duration==2);
        [avatar removeFromSuperview];[avatar didMoveToWindow];Check(!Rotating(avatar));[page.view addSubview:avatar];[avatar didMoveToWindow];Check(Rotating(avatar));
        [defaults setObject:@NO forKey:@"rotateAvatar"];CSAvatarRotationPreferencesChanged();Pump();Check(!Rotating(avatar));
        [avatar removeFromSuperview];
    }
    __weak UIView *released;
    @autoreleasepool { UIView *view=[MMHeadImageView new];view.tag=101;released=view;CSAvatarRotationUpdate(view); }
    Check(released==nil);[page.view removeFromSuperview];
}

static void TestInputs(CountingDefaults *defaults,UIWindow *window) {
    CSInputTextStyleInstall(defaults);CSInputTextStyleInstall(defaults);
    BaseMsgContentViewController *chat=[BaseMsgContentViewController new];chat.view=[[UIView alloc] initWithFrame:window.bounds];chat.view.testOwner=chat;[window addSubview:chat.view];
    MMInputToolView *tool=[MMInputToolView new];[chat.view addSubview:tool];
    MMGrowTextView *view=[MMGrowTextView new];[tool addSubview:view];tool.textView=view;
    view.layer.cornerRadius=4;view.layer.borderWidth=2;UIColor *nativeBorder=[UIColor colorWithWhite:.2 alpha:1];view.layer.borderColor=nativeBorder.CGColor;
    UIColor *nativeColor=view.textView.placeHolderColor;view.typedText=@"未发送内容";view.selectedRange=NSMakeRange(2,1);
    [chat viewWillAppear:NO];[view layoutSubviews];Check([view.placeHolder isEqual:@"Native"]);Check(view.writes==0);
    InputSet(defaults,@"enabled",@YES);InputSet(defaults,@"roundedCorners",@YES);InputSet(defaults,@"border.enabled",@YES);InputSet(defaults,@"content",@"Custom");
    NSData *color=[NSKeyedArchiver archivedDataWithRootObject:[UIColor colorWithWhite:.8 alpha:1] requiringSecureCoding:YES error:NULL];Check(color!=nil);InputSet(defaults,@"color",color);InputSet(defaults,@"alpha",@0);
    CSInputTextStylePreferencesChanged();Pump();Check([view.placeHolder isEqual:@"Custom"]);Check(view.textView.placeHolderColor.alpha==0);Check(view.textView.placeholderMultiLine);Check(view.layer.cornerRadius==18);Check(view.layer.borderWidth==1);
    NSAttributedString *cached=view.attributePlaceholder;NSUInteger reads=defaults.reads,decodeCount=decodes,fonts=CSStyleTestFonts,writes=view.writes,layerWrites=((CountingLayer*)view.layer).styleWrites,resolutions=CSStyleTestColorResolutions;
    for(NSUInteger i=0;i<10000;i++) { [view layoutSubviews];[tool layoutSubviews];[tool updateToolViewHeight:NO]; }
    Check(defaults.reads==reads);Check(decodes==decodeCount);Check(CSStyleTestFonts==fonts);Check(view.writes==writes);Check(((CountingLayer*)view.layer).styleWrites==layerWrites);Check(view.attributePlaceholder==cached);Check(view.nativeLayouts==10001);Check(tool.nativeUpdates==20000);
    Check(CSStyleTestColorResolutions==resolutions);
    Check([view.typedText isEqual:@"未发送内容"]);Check(NSEqualRanges(view.selectedRange,NSMakeRange(2,1)));
    for(NSUInteger i=0;i<1000;i++)Post(NSUserDefaultsDidChangeNotification,defaults);Pump();Check(defaults.reads-reads==11);Check(decodes==decodeCount);Check(view.writes==writes);
    [view setPlaceholder:@"新原生占位" animated:YES];Check([view.placeHolder isEqual:@"Custom"]);Check([view.attributePlaceholder.string isEqual:@"Custom"]);
    NSAttributedString *nativeAttributed=[[NSAttributedString alloc] initWithString:@"原生富文本"];
    [view setAttributedPlaceholder:nativeAttributed animated:YES];Check([view.attributePlaceholder.string isEqual:@"Custom"]);
    TestNativeInner *newInner=[TestNativeInner new];newInner.placeHolderColor=nativeColor;view.textView=newInner;[view layoutSubviews];Check(view.textView.placeholderMultiLine);Check(view.textView.placeHolderColor.alpha==0);
    UIColor *laterNativeColor=[UIColor colorWithWhite:.1 alpha:1];[view setPlaceHolderColor:laterNativeColor];[view setPlaceHolderMultiLine:NO];Check(view.textView.placeholderMultiLine);
    UITraitCollection *dark=[UITraitCollection new];dark.userInterfaceStyle=UIUserInterfaceStyleDark;view.traitCollection=dark;[view traitCollectionDidChange:nil];Check(CGColorGetComponents(view.layer.borderColor)[0]>.6);Check(CSStyleTestColorResolutions==resolutions+1);
    view.layer.cornerRadius=6;view.layer.borderWidth=3;[view layoutSubviews];Check(view.layer.cornerRadius==18);Check(view.layer.borderWidth==1);
    InputSet(defaults,@"enabled",@NO);InputSet(defaults,@"roundedCorners",@NO);InputSet(defaults,@"border.enabled",@NO);CSInputTextStylePreferencesChanged();Pump();
    Check([view.placeHolder isEqual:@"新原生占位"]);Check([view.attributePlaceholder isEqual:nativeAttributed]);Check(view.textView.placeHolderColor==laterNativeColor);Check(!view.textView.placeholderMultiLine);Check(view.layer.cornerRadius==6);Check(!view.clipsToBounds);Check(view.layer.borderWidth==3);Check(CGColorEqualToColor(view.layer.borderColor,nativeBorder.CGColor));
    writes=view.writes;[view layoutSubviews];Check(view.writes==writes);
    InputSet(defaults,@"border.enabled",@YES);CSInputTextStylePreferencesChanged();Pump();Check(view.layer.borderWidth==1);Check(view.layer.cornerRadius==6);Check([view.placeHolder isEqual:@"新原生占位"]);
    InputSet(defaults,@"enabled",@YES);InputSet(defaults,@"color",[@"bad archive" dataUsingEncoding:NSUTF8StringEncoding]);InputSet(defaults,@"content",@"Updated");CSInputTextStylePreferencesChanged();Pump();Check([view.placeHolder isEqual:@"Updated"]);decodeCount=decodes;[view layoutSubviews];Check(decodes==decodeCount);
    MMGrowTextView *unrelated=[MMGrowTextView new];[window addSubview:unrelated];[unrelated layoutSubviews];Check([unrelated.placeHolder isEqual:@"Native"]);Check(unrelated.writes==0);
    [chat viewWillDisappear:NO];Check([view.placeHolder isEqual:@"新原生占位"]);Check(view.layer.borderWidth==3);[chat viewWillAppear:NO];Check([view.placeHolder isEqual:@"Updated"]);
    BaseMsgContentViewController *second=[BaseMsgContentViewController new];second.view=[UIView new];second.view.testOwner=second;[second viewWillAppear:NO];[second viewWillDisappear:NO];Check([view.placeHolder isEqual:@"Updated"]);
    [view removeFromSuperview];[window addSubview:view];[view didMoveToSuperview];Check([view.placeHolder isEqual:@"新原生占位"]);[tool addSubview:view];[view didMoveToSuperview];Check([view.placeHolder isEqual:@"Updated"]);
    MMGrowTextView *fresh=[MMGrowTextView new];[tool addSubview:fresh];[fresh didMoveToWindow];Check([fresh.placeHolder isEqual:@"Updated"]);Check(fresh.nativeMoves==1);
    __weak UIView *released;
    @autoreleasepool { MMGrowTextView *temporary=[MMGrowTextView new];[tool addSubview:temporary];[temporary layoutSubviews];[temporary removeFromSuperview];released=temporary; }
    Check(released==nil);
    // Notification delivery must return while the main thread is occupied.
    reads=defaults.reads;dispatch_semaphore_t finished=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{ for(NSUInteger i=0;i<1000;i++)Post(NSUserDefaultsDidChangeNotification,nil);dispatch_semaphore_signal(finished); });
    Check(dispatch_semaphore_wait(finished,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);Check(defaults.reads==reads);Pump();Check(defaults.reads-reads==11);
    [chat.view removeFromSuperview];[unrelated removeFromSuperview];
}
int main(void) { @autoreleasepool {
    Method thermalMethod=class_getInstanceMethod(NSProcessInfo.processInfo.class,@selector(thermalState));IMP thermalOriginal=method_setImplementation(thermalMethod,(IMP)TestThermal);
    Method decode=class_getClassMethod(NSKeyedUnarchiver.class,@selector(unarchivedObjectOfClass:fromData:error:));decodeOriginal=method_setImplementation(decode,(IMP)CountDecode);
    CountingDefaults *avatarDefaults=[CountingDefaults new],*inputDefaults=[CountingDefaults new];
    UIWindow *window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)];window.windowScene=[UIWindowScene new];
    TestAvatars(avatarDefaults,window);TestInputs(inputDefaults,window);
    method_setImplementation(thermalMethod,thermalOriginal);method_setImplementation(decode,decodeOriginal);
    printf("PASS: %lu avatar/input production runtime + extracted hook checks; 20,000 avatar updates and 30,000 input callbacks without repeated hot-path reads/rebuilds/writes; host doubles only\n",(unsigned long)checks);
} return 0; }
