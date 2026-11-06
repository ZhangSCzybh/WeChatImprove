#import <UIKit/UIKit.h>
#import <objc/runtime.h>
static double testTime;
static double CSTestMediaTime(void) { return testTime; }
#define CACurrentMediaTime CSTestMediaTime
static NSUInteger nativeEvents, imageReads, checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#x); exit(1); } } while (0)
NSString *const UIScreenCapturedDidChangeNotification=@"screenCapture";
@implementation UIEvent (TouchTest)
- (UIEventType)type { return [objc_getAssociatedObject(self,@selector(type)) integerValue]; }
- (void)setType:(UIEventType)value { objc_setAssociatedObject(self,@selector(type),@(value),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
- (NSSet *)allTouches { return objc_getAssociatedObject(self,@selector(allTouches)); }
- (void)setAllTouches:(NSSet *)value { objc_setAssociatedObject(self,@selector(allTouches),value,OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end
@implementation UITouch
- (CGPoint)locationInView:(UIView *)view { (void)view; return _location; }
@end
@implementation UIScreen
+ (instancetype)mainScreen { static UIScreen *screen; if (!screen) screen=[self new]; return screen; }
@end
@implementation UIColor (TouchTest)
+ (instancetype)redColor { return [self colorWithRed:1 green:0 blue:0 alpha:1]; }
+ (instancetype)whiteColor { return [self colorWithRed:1 green:1 blue:1 alpha:1]; }
@end
@implementation UIView (TouchTest)
+ (void)animateWithDuration:(double)duration animations:(void (^)(void))animations completion:(void (^)(BOOL))completion { (void)duration; animations(); if (completion) completion(YES); }
@end
@interface TouchDefaults : NSUserDefaults
@property(nonatomic) NSUInteger reads;
@end
@implementation TouchDefaults
- (id)objectForKey:(NSString *)key { self.reads++; return [super objectForKey:key]; }
- (BOOL)boolForKey:(NSString *)key { self.reads++; return [super boolForKey:key]; }
- (float)floatForKey:(NSString *)key { self.reads++; return [super floatForKey:key]; }
@end
static TouchDefaults *testDefaults;
static id Defaults(id cls, SEL selector) { (void)cls; (void)selector; return testDefaults; }
static id LoadImage(id cls, SEL selector, NSString *path) { (void)cls; (void)selector; imageReads++; UIImage *image=[UIImage new]; image.path=path; return image; }
#import "TouchHookUnderTest.h"
static void pump(void) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:.03]; while (end.timeIntervalSinceNow>0) [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:end]; }
int main(void) { @autoreleasepool {
    NSString *suite=[@"touch.test." stringByAppendingString:NSUUID.UUID.UUIDString];
    testDefaults=[[TouchDefaults alloc] initWithSuiteName:suite];
    method_setImplementation(class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults)),(IMP)Defaults);
    method_setImplementation(class_getClassMethod(UIImage.class,@selector(imageWithContentsOfFile:)),(IMP)LoadImage);
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString];
    CHECK([[@"image" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES]);
    [testDefaults setBool:YES forKey:kTouchTrailKey]; [testDefaults setBool:YES forKey:kTouchTrailTailEnabledKey];
    [testDefaults setBool:YES forKey:kTouchTrailCustomImageEnabledKey]; [testDefaults setObject:path forKey:kTouchTrailCustomImagePathKey];
    [testDefaults setFloat:100 forKey:kTouchTrailTailDensityKey];
    CSInstallTouchRuntime(); pump(); CHECK(isTrailEnabled && imageReads==1);
    UIWindow *window=[[UIWindow alloc] initWithFrame:CGRectMake(0,0,390,844)]; UITouch *touch=[UITouch new]; touch.window=window;
    UIEvent *event=[UIEvent new]; event.allTouches=[NSSet setWithObject:touch];
    testTime=1; touch.phase=UITouchPhaseBegan; [UIApplication.sharedApplication sendEvent:event];
    CHECK(touchViews.count==1 && window.subviews.count==1);
    NSUInteger reads=testDefaults.reads;
    touch.phase=UITouchPhaseMoved;
    for (NSUInteger i=0;i<10000;i++) { @autoreleasepool {
        testTime+=.04; touch.location=CGPointMake(i*2,100); [UIApplication.sharedApplication sendEvent:event];
        CHECK(window.subviews.count<=CSTouchTrailMaximumDots+1);
        if (i%100==0) { for (UIView *v in [window.subviews copy]) if ([v isKindOfClass:WBTouchTrailDotView.class]) [v removeFromSuperview]; }
    } }
    CHECK(testDefaults.reads==reads && imageReads==1 && nativeEvents==10001);
    NSHashTable *dots=touchTailViews.allValues.firstObject;
    for (UIView *v in [window.subviews copy]) if ([v isKindOfClass:WBTouchTrailDotView.class]) [v removeFromSuperview];
    CHECK(dots.allObjects.count==0); // Expired dots are not retained until the finger lifts.
    [testDefaults setObject:@"unrelated" forKey:@"wechat.unrelated"];
    CSReloadTouchTrails(); CHECK(imageReads==1);
    [NSNotificationCenter.defaultCenter postNotificationName:@"CSTouchTrailImageDidChange" object:nil]; pump(); CHECK(imageReads==2);
    [testDefaults setBool:YES forKey:kTouchTrailOnlyWhenRecordingKey]; CSReloadTouchTrails(); CHECK(!isTrailEnabled && !window.subviews.count);
    UIScreen.mainScreen.isCaptured=YES;
    [NSNotificationCenter.defaultCenter postNotificationName:UIScreenCapturedDidChangeNotification object:nil]; pump(); CHECK(isTrailEnabled);
    touch.phase=UITouchPhaseBegan; [UIApplication.sharedApplication sendEvent:event]; CHECK(window.subviews.count==1);
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationWillResignActiveNotification object:nil]; pump(); CHECK(!isTrailEnabled && !window.subviews.count);
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidBecomeActiveNotification object:nil]; pump(); CHECK(isTrailEnabled);
    UIScreen.mainScreen.isCaptured=NO;
    [NSNotificationCenter.defaultCenter postNotificationName:UIScreenCapturedDidChangeNotification object:nil]; pump(); CHECK(!isTrailEnabled);
    CHECK(CSTouchTrailSampleInterval(100)>=1.0/30 && !CSTouchTrailShouldSample(1,.999,10,10));
    CHECK(!CSTouchTrailShouldSample(1,0,0,0));
    [NSFileManager.defaultManager removeItemAtPath:path error:nil]; [testDefaults removePersistentDomainForName:suite];
    printf("Touch runtime: %lu checks passed; 10000 moves, zero preference/image reads, <=48 live dots\n",(unsigned long)checks);
} return 0; }
