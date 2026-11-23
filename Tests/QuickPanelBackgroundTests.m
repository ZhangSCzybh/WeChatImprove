#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <objc/runtime.h>
#import "CSQuickPanelBackgroundView.h"
#import "CSQuickPanelPreferences.h"
#import "CSQuickPanelBackgroundImageStore.h"
#include <math.h>

// Compile the unchanged production renderer, preferences and image store. Only
// process-local storage lookup and an image read gate are substituted by tests.
@interface CSQuickPanelBackgroundView (TestInspection)
@property(nonatomic, readonly) UIView *fillView;
@property(nonatomic, readonly) UIImageView *imageView;
@property(nonatomic, readonly) NSUInteger imageGeneration;
@end

static NSUInteger checks;
static NSLock *readLock;
static NSString *heldPath;
static dispatch_semaphore_t readStarted, readResume;
static BOOL holdNextRead;

static void Check(BOOL condition, NSString *message) {
    checks++;
    if (!condition) { fprintf(stderr,"FAIL: %s\n",message.UTF8String); exit(1); }
}

static void DrainFor(NSTimeInterval duration) {
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:duration]];
}

static BOOL WaitUntil(BOOL (^condition)(void)) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:2];
    while (!condition() && deadline.timeIntervalSinceNow>0) DrainFor(.002);
    return condition();
}

static NSData *ImageBytesWithAlpha(CGFloat brightness, CGFloat alpha) {
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(NULL,8,8,8,0,space,(CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(space);
    CGContextSetRGBFillColor(context,brightness,brightness,brightness,alpha);
    CGContextFillRect(context,CGRectMake(0,0,8,8));
    CGImageRef pixels=CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    NSMutableData *data=[NSMutableData data];
    CGImageDestinationRef destination=CGImageDestinationCreateWithData((__bridge CFMutableDataRef)data,CFSTR("public.png"),1,NULL);
    CGImageDestinationAddImage(destination,pixels,NULL);
    BOOL finished=CGImageDestinationFinalize(destination);
    CGImageRelease(pixels); CFRelease(destination);
    return finished ? data.copy : nil;
}

static NSData *ImageBytes(CGFloat brightness) { return ImageBytesWithAlpha(brightness,1); }

static NSString *ImportImage(CGFloat brightness) {
    NSError *error=nil;
    NSString *path=[CSQuickPanelBackgroundImageStore storeImageData:ImageBytes(brightness) error:&error];
    Check(path && !error,@"isolated real image import succeeds");
    return path;
}

static void StartHeldRead(CSQuickPanelBackgroundView *surface, NSString *path) {
    [readLock lock];
    heldPath=path; holdNextRead=YES;
    readStarted=dispatch_semaphore_create(0); readResume=dispatch_semaphore_create(0);
    [readLock unlock];
    [CSQuickPanelPreferences setBackgroundImagePath:path];
    [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleImage];
    [surface reloadAppearance];
    Check(dispatch_semaphore_wait(readStarted,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0,@"real renderer asynchronous image read reached deterministic gate");
}

static void FinishHeldRead(uint64_t countBefore) {
    dispatch_semaphore_signal(readResume);
    Check(WaitUntil(^BOOL{ return CSQuickPanelTestImageCreationCount()>countBefore; }),@"held real ImageIO decode resumes");
    // UIImage construction immediately precedes dispatching the production
    // completion to main. Drain that queue before observing discarded work.
    DrainFor(.03);
    [readLock lock]; heldPath=nil; [readLock unlock];
}

int main(void) { @autoreleasepool {
    NSString *suite=[@"com.wechatimprove.tests.quick-panel-background." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
    [defaults removePersistentDomainForName:suite];
    NSURL *resources=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
    readLock=[NSLock new];

    Method defaultsMethod=class_getClassMethod(CSQuickPanelPreferences.class,NSSelectorFromString(@"cs_defaults"));
    IMP oldDefaults=method_setImplementation(defaultsMethod,imp_implementationWithBlock(^NSUserDefaults *(id owner){ (void)owner; return defaults; }));
    Method directoryMethod=class_getClassMethod(CSQuickPanelBackgroundImageStore.class,@selector(resourceDirectoryURL));
    IMP oldDirectory=method_setImplementation(directoryMethod,imp_implementationWithBlock(^NSURL *(id owner){ (void)owner; return resources; }));
    Method readMethod=class_getClassMethod(CSQuickPanelBackgroundImageStore.class,@selector(imageDataAtPath:));
    IMP oldRead=method_getImplementation(readMethod);
    IMP gatedRead=imp_implementationWithBlock(^NSData *(id owner,NSString *path){
        NSData *data=((NSData *(*)(id,SEL,NSString *))oldRead)(owner,@selector(imageDataAtPath:),path);
        [readLock lock]; BOOL shouldHold=holdNextRead && [heldPath isEqual:path];
        if (shouldHold) holdNextRead=NO;
        dispatch_semaphore_t started=readStarted,resume=readResume; [readLock unlock];
        if (shouldHold) {
            dispatch_semaphore_signal(started);
            dispatch_semaphore_wait(resume,dispatch_time(DISPATCH_TIME_NOW,2*NSEC_PER_SEC));
        }
        return data;
    });
    method_setImplementation(readMethod,gatedRead);
    @try {
        CSQuickPanelBackgroundView *surface=[[CSQuickPanelBackgroundView alloc]initWithFrame:CGRectMake(0,0,340,240)];
        __block NSUInteger appearanceChanges=0;
        __block BOOL callbacksOnMain=YES;
        surface.appearanceChanged=^(BOOL light){ (void)light; appearanceChanges++; callbacksOnMain&=NSThread.isMainThread; };
        surface.alpha=.73;
        [surface layoutSubviews];
        Check(surface.subviews.count==2 && !surface.userInteractionEnabled && !surface.isAccessibilityElement,@"surface contains only two noninteractive background layers");
        Check(CGRectEqualToRect(surface.fillView.frame,surface.bounds) && CGRectEqualToRect(surface.imageView.frame,surface.bounds),@"background layers fill the surface bounds");
        Check(!surface.fillView.hidden && surface.imageView.hidden && !surface.usesLightContent,@"default light appearance uses system fill and dark foreground");

        [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleColor];
        [CSQuickPanelPreferences setBackgroundColorHex:@"#000000"];
        [CSQuickPanelPreferences setBackgroundOpacity:1]; [surface reloadAppearance];
        Check(surface.usesLightContent && surface.fillView.backgroundColor.red==0 && surface.fillView.alpha==1,@"black fill selects readable light foreground");
        [CSQuickPanelPreferences setBackgroundColorHex:@"#FFFFFF"]; [surface reloadAppearance];
        Check(!surface.usesLightContent && surface.fillView.backgroundColor.red==1,@"white fill selects readable dark foreground");
        [CSQuickPanelPreferences setBackgroundColorHex:@"#808080"]; [surface reloadAppearance];
        Check(!surface.usesLightContent,@"middle gray selects black text with the higher linear-sRGB contrast ratio");
        [CSQuickPanelPreferences setBackgroundOpacity:.25]; [surface reloadAppearance];
        Check(surface.fillView.alpha==.25 && surface.imageView.alpha==.25 && surface.alpha==.73,@"opacity changes background layers without fading their surface");
        [CSQuickPanelPreferences setBackgroundColorHex:@"#000000"];
        [CSQuickPanelPreferences setBackgroundOpacity:0]; [surface reloadAppearance];
        Check(!surface.usesLightContent && surface.fillView.alpha==0 && surface.alpha==.73,@"transparent black fill uses effective light background for foreground contrast");
        surface.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;
        [surface traitCollectionDidChange:nil];
        Check(surface.usesLightContent,@"transparent fill follows effective dark system appearance");
        surface.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;

        NSString *black=ImportImage(0);
        [CSQuickPanelPreferences setBackgroundImagePath:black];
        [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleImage];
        [CSQuickPanelPreferences setBackgroundOpacity:1]; [surface reloadAppearance];
        Check(WaitUntil(^BOOL{ return surface.imageView.image!=nil; }),@"real asynchronous image decode populates the image layer");
        Check(surface.fillView.hidden && !surface.imageView.hidden && surface.usesLightContent && surface.alpha==.73,@"black image selects light foreground without changing surface alpha");
        [CSQuickPanelPreferences setBackgroundOpacity:.4]; [surface reloadAppearance];
        Check(surface.imageView.alpha==.4 && surface.fillView.alpha==.4 && surface.alpha==.73,@"image opacity remains confined to background layers");

        NSString *white=ImportImage(1);
        [CSQuickPanelPreferences setBackgroundImagePath:white];
        [CSQuickPanelPreferences setBackgroundOpacity:1]; [surface reloadAppearance];
        Check(WaitUntil(^BOOL{ return surface.imageView.image && !surface.usesLightContent; }),@"white image selects dark foreground after replacing a black image");

        NSError *alphaError=nil;
        NSString *transparent=[CSQuickPanelBackgroundImageStore storeImageData:ImageBytesWithAlpha(0,0) error:&alphaError];
        Check(transparent && !alphaError,@"fully transparent PNG survives real image normalization");
        [CSQuickPanelPreferences setBackgroundImagePath:transparent]; [surface reloadAppearance];
        Check(WaitUntil(^BOOL{ return surface.imageView.image!=nil; }),@"transparent PNG decodes through the real asynchronous image path");
        Check(!surface.usesLightContent,@"fully transparent image uses the light background's contrast instead of invisible RGB");
        surface.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;
        [surface traitCollectionDidChange:nil];
        Check(surface.usesLightContent,@"fully transparent image follows the dark background's contrast");
        surface.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
        [surface traitCollectionDidChange:nil];
        NSString *translucent=[CSQuickPanelBackgroundImageStore storeImageData:ImageBytesWithAlpha(0,.25) error:&alphaError];
        Check(translucent && !alphaError,@"partially transparent PNG survives real image normalization");
        [CSQuickPanelPreferences setBackgroundImagePath:translucent]; [surface reloadAppearance];
        Check(WaitUntil(^BOOL{ return surface.imageView.image!=nil; }),@"partially transparent image decodes");
        Check(!surface.usesLightContent,@"image alpha composes black pixels with the light background before choosing dark text");
        [CSQuickPanelPreferences setBackgroundOpacity:.5]; [surface reloadAppearance];
        Check(!surface.usesLightContent && surface.imageView.alpha==.5 && surface.alpha==.73,@"image alpha and configured opacity compose without fading the surface");
        [CSQuickPanelPreferences setBackgroundOpacity:1];

        NSString *missing=ImportImage(0);
        [CSQuickPanelBackgroundImageStore removeImageAtPath:missing error:NULL];
        [CSQuickPanelPreferences setBackgroundImagePath:missing]; [surface reloadAppearance];
        DrainFor(.05);
        Check(!surface.imageView.image && surface.imageView.hidden && !surface.fillView.hidden && !surface.usesLightContent,@"missing image falls back to the system background");
        NSString *corrupt=ImportImage(0);
        [[@"invalid" dataUsingEncoding:NSUTF8StringEncoding]writeToFile:corrupt atomically:YES];
        [CSQuickPanelPreferences setBackgroundImagePath:corrupt]; [surface reloadAppearance];
        DrainFor(.05);
        Check(!surface.imageView.image && surface.imageView.hidden && !surface.fillView.hidden,@"corrupt image falls back without presenting stale pixels");

        [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleDefault]; [surface reloadAppearance];
        NSString *lateStyle=ImportImage(0);
        uint64_t before=CSQuickPanelTestImageCreationCount();
        StartHeldRead(surface,lateStyle);
        [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleColor];
        [CSQuickPanelPreferences setBackgroundColorHex:@"#FFFFFF"]; [surface reloadAppearance];
        FinishHeldRead(before);
        Check(!surface.imageView.image && surface.imageView.hidden && !surface.usesLightContent && surface.fillView.backgroundColor.red==1,@"image callback after style change is discarded");

        NSString *lateReset=ImportImage(0);
        before=CSQuickPanelTestImageCreationCount();
        StartHeldRead(surface,lateReset);
        Check([CSQuickPanelPreferences resetBackgroundWithError:NULL],@"background reset during a pending decode succeeds");
        [surface reloadAppearance]; FinishHeldRead(before);
        Check(!surface.imageView.image && surface.imageView.hidden && !surface.fillView.hidden &&
              [CSQuickPanelPreferences.backgroundStyle isEqual:CSQuickPanelBackgroundStyleDefault],@"late image callback cannot resurrect a reset background");

        NSString *restored=ImportImage(0);
        [CSQuickPanelPreferences setBackgroundImagePath:restored];
        [CSQuickPanelPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleImage]; [surface reloadAppearance];
        Check(WaitUntil(^BOOL{ return surface.imageView.image && surface.usesLightContent; }),@"restore fixture initially displays the black resource");
        UIImage *oldImage=surface.imageView.image;
        Check([ImageBytes(1)writeToFile:restored atomically:YES],@"restore fixture replaces resource bytes at exactly the same path");
        [NSNotificationCenter.defaultCenter postNotificationName:@"CSPreferencesDidRestoreNotification" object:nil];
        Check(WaitUntil(^BOOL{ return surface.imageView.image && surface.imageView.image!=oldImage && !surface.usesLightContent; }),@"restore notification reloads changed bytes despite an unchanged path");
        Check(surface.alpha==.73 && appearanceChanges>0 && callbacksOnMain,@"all asynchronous appearance updates preserve surface alpha and notify on main");
        surface.appearanceChanged=nil;
        surface=nil;
        DrainFor(.03);
        printf("Quick panel background: %lu checks passed\n",(unsigned long)checks);
    } @finally {
        method_setImplementation(readMethod,oldRead); imp_removeBlock(gatedRead);
        IMP block=method_setImplementation(defaultsMethod,oldDefaults); imp_removeBlock(block);
        block=method_setImplementation(directoryMethod,oldDirectory); imp_removeBlock(block);
        [defaults removePersistentDomainForName:suite];
        [NSFileManager.defaultManager removeItemAtURL:resources error:NULL];
    }
} return 0; }
