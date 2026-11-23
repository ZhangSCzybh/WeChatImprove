#import "CSQuickPanelBackgroundView.h"
#import "CSQuickPanelPreferences.h"
#import "CSQuickPanelBackgroundImageStore.h"
#import <ImageIO/ImageIO.h>
#import <math.h>

static UIColor *CSQuickPanelColor(NSString *hex) {
    unsigned int rgb=0;
    if (hex.length!=7 || ![[NSScanner scannerWithString:[hex substringFromIndex:1]] scanHexInt:&rgb]) return UIColor.secondarySystemGroupedBackgroundColor;
    return [UIColor colorWithRed:((rgb>>16)&255)/255.0 green:((rgb>>8)&255)/255.0 blue:(rgb&255)/255.0 alpha:1];
}

static CGFloat CSQuickPanelLinearComponent(CGFloat component) {
    return component<=.04045 ? component/12.92 : pow((component+.055)/1.055,2.4);
}

static BOOL CSQuickPanelPrefersLightContent(UIColor *color, CGFloat opacity, UITraitCollection *traits) {
    CGFloat r=1,g=1,b=1,a=1,br=1,bg=1,bb=1;
    [[UIColor.secondarySystemGroupedBackgroundColor resolvedColorWithTraitCollection:traits] getRed:&br green:&bg blue:&bb alpha:NULL];
    if (![[color resolvedColorWithTraitCollection:traits] getRed:&r green:&g blue:&b alpha:&a]) { r=br; g=bg; b=bb; }
    CGFloat effectiveAlpha=a*opacity;
    r=r*effectiveAlpha+br*(1-effectiveAlpha);
    g=g*effectiveAlpha+bg*(1-effectiveAlpha);
    b=b*effectiveAlpha+bb*(1-effectiveAlpha);
    CGFloat luminance=.2126*CSQuickPanelLinearComponent(r)+.7152*CSQuickPanelLinearComponent(g)+.0722*CSQuickPanelLinearComponent(b);
    return 1.05/(luminance+.05)>(luminance+.05)/.05;
}

static UIColor *CSQuickPanelImageAverageColor(CGImageRef image) {
    unsigned char pixel[4]={0,0,0,0};
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(pixel,1,1,8,4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(space);
    if (!context) return UIColor.secondarySystemGroupedBackgroundColor;
    CGContextDrawImage(context,CGRectMake(0,0,1,1),image);
    CGContextRelease(context);
    CGFloat alpha=pixel[3]/255.0;
    return alpha>0 ? [UIColor colorWithRed:pixel[0]/(255.0*alpha) green:pixel[1]/(255.0*alpha) blue:pixel[2]/(255.0*alpha) alpha:alpha] : UIColor.clearColor;
}

@interface CSQuickPanelBackgroundView ()
@property(nonatomic, strong) UIView *fillView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, copy) NSString *requestedImagePath;
@property(nonatomic) NSUInteger imageGeneration;
@property(nonatomic, strong) UIColor *imageAverageColor;
@property(nonatomic) BOOL usesLightContent;
@end

@implementation CSQuickPanelBackgroundView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        self.userInteractionEnabled=NO;
        self.isAccessibilityElement=NO;
        self.clipsToBounds=YES;
        self.backgroundColor=UIColor.clearColor;
        _fillView=[UIView new];
        [self addSubview:_fillView];
        _imageView=[UIImageView new];
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds=YES;
        [self addSubview:_imageView];
        for (NSNotificationName name in @[CSQuickPanelPreferencesDidChangeNotification,@"CSPreferencesDidRestoreNotification"])
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(preferencesChanged:) name:name object:nil];
        [self reloadAppearance];
    }
    return self;
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)layoutSubviews {
    [super layoutSubviews];
    self.fillView.frame=self.bounds;
    self.imageView.frame=self.bounds;
}
- (void)preferencesChanged:(NSNotification *)note {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf preferencesChanged:note]; });
        return;
    }
    if ([note.name isEqual:@"CSPreferencesDidRestoreNotification"]) {
        self.imageGeneration++;
        self.requestedImagePath=nil;
        self.imageView.image=nil;
    }
    [self reloadAppearance];
}
- (void)reloadAppearance {
    if (!NSThread.isMainThread) {
        __weak typeof(self) weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf reloadAppearance]; });
        return;
    }
    NSString *path=[CSQuickPanelPreferences.backgroundStyle isEqual:CSQuickPanelBackgroundStyleImage] ? CSQuickPanelPreferences.backgroundImagePath : nil;
    if (![(self.requestedImagePath ?: @"") isEqual:(path ?: @"")]) {
        self.imageGeneration++;
        self.requestedImagePath=path;
        self.imageView.image=nil;
        if (path.length) [self loadImageAtPath:path generation:self.imageGeneration];
    }
    [self applyAppearance];
}
- (void)loadImageAtPath:(NSString *)path generation:(NSUInteger)generation {
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0), ^{
        @autoreleasepool {
            NSData *data=[CSQuickPanelBackgroundImageStore imageDataAtPath:path];
            CGImageSourceRef source=data.length ? CGImageSourceCreateWithData((__bridge CFDataRef)data,(__bridge CFDictionaryRef)@{(__bridge id)kCGImageSourceShouldCache:@NO}) : NULL;
            CGImageRef pixels=source ? CGImageSourceCreateThumbnailAtIndex(source,0,(__bridge CFDictionaryRef)@{
                (__bridge id)kCGImageSourceCreateThumbnailFromImageAlways:@YES,
                (__bridge id)kCGImageSourceCreateThumbnailWithTransform:@YES,
                (__bridge id)kCGImageSourceThumbnailMaxPixelSize:@1536,
                (__bridge id)kCGImageSourceShouldCacheImmediately:@YES}) : NULL;
            UIImage *image=pixels ? [UIImage imageWithCGImage:pixels] : nil;
            UIColor *averageColor=pixels ? CSQuickPanelImageAverageColor(pixels) : nil;
            if (pixels) CGImageRelease(pixels);
            if (source) CFRelease(source);
            dispatch_async(dispatch_get_main_queue(), ^{
                CSQuickPanelBackgroundView *live=weakSelf;
                if (!live || generation!=live.imageGeneration || ![live.requestedImagePath isEqual:path] ||
                    ![CSQuickPanelPreferences.backgroundStyle isEqual:CSQuickPanelBackgroundStyleImage] ||
                    ![CSQuickPanelPreferences.backgroundImagePath isEqual:path]) return;
                live.imageView.image=image;
                live.imageAverageColor=averageColor;
                [live applyAppearance];
            });
        }
    });
}
- (void)applyAppearance {
    NSString *style=CSQuickPanelPreferences.backgroundStyle;
    BOOL hasImage=[style isEqual:CSQuickPanelBackgroundStyleImage] && self.imageView.image!=nil;
    UIColor *fill=[style isEqual:CSQuickPanelBackgroundStyleColor] ? CSQuickPanelColor(CSQuickPanelPreferences.backgroundColorHex) : UIColor.secondarySystemGroupedBackgroundColor;
    CGFloat opacity=CSQuickPanelPreferences.backgroundOpacity;
    // A missing/deleted image has the same effective appearance as the default.
    self.fillView.backgroundColor=fill;
    self.fillView.hidden=hasImage;
    self.fillView.alpha=opacity;
    self.imageView.hidden=!hasImage;
    self.imageView.alpha=opacity;
    self.usesLightContent=CSQuickPanelPrefersLightContent(hasImage ? self.imageAverageColor : fill,opacity,self.traitCollection);
    if (self.appearanceChanged) self.appearanceChanged(self.usesLightContent);
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self applyAppearance];
}
@end
