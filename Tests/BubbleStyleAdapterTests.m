#import <UIKit/UIKit.h>
#import "CSBubbleStylePolicy.h"
#import "CSBubbleStyleAdapter.h"
#import "CSChatNativeBridge.h"
#import <objc/message.h>
#import <objc/runtime.h>
static NSUInteger checks;
#define CHECK(value) do { checks++; if (!(value)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#value); return 1; } } while (0)
// The adapter's real selector checks are used for scalars. The shared object bridge is isolated here.
id CSMessageNativeObject(id object, NSString *selector) {
    SEL sel=NSSelectorFromString(selector); Method method=class_getInstanceMethod([object class],sel);
    if (!method || method_getNumberOfArguments(method)!=2) return nil;
    char result[32]={0}; method_getReturnType(method,result,sizeof(result)); if (result[0]!='@') return nil;
    return ((id(*)(id,SEL))objc_msgSend)(object,sel);
}
@interface BubbleWrap : NSObject
@property(nonatomic) unsigned int m_uiMessageType;
@property(nonatomic) unsigned int m_uiAppMsgInnerType;
@property(nonatomic, strong) id m_oWCPayInfoItem;
@end
@implementation BubbleWrap @end
@interface BubbleInfo : NSObject
@property(nonatomic) unsigned long long position;
@end
@implementation BubbleInfo @end
@interface TextMessageViewModel : NSObject
@property(nonatomic) BOOL isSender;
@property(nonatomic, strong) BubbleWrap *messageWrap;
@property(nonatomic, strong) BubbleInfo *bgBubbleInfo;
@end
@implementation TextMessageViewModel @end
@interface TextMessageSubViewModel : NSObject
@property(nonatomic,weak) TextMessageViewModel *parentModel;
@property(nonatomic,strong) BubbleInfo *bgBubbleInfo;
@end
@implementation TextMessageSubViewModel @end
@interface WCPayTransferMessageViewModel : TextMessageViewModel @end
@implementation WCPayTransferMessageViewModel @end
@interface WCPayC2CMessageViewModel : TextMessageViewModel @end
@implementation WCPayC2CMessageViewModel @end
@interface VoiceMessageViewModel : TextMessageViewModel @end
@implementation VoiceMessageViewModel @end
@interface Payment : NSObject
@property(nonatomic, copy) NSString *m_nsTransferID;
@property(nonatomic, copy) NSString *m_c2cNativeUrl;
@end
@implementation Payment @end
@interface BubbleCell : UIView
@property(nonatomic, strong) TextMessageViewModel *viewModel;
@property(nonatomic, strong) YYAsyncImageView *background;
@property(nonatomic) BOOL isUseLightStyle; // Deliberately conflicts with UIKit appearance.
- (id)getBgImageView;
@end
@implementation BubbleCell
- (id)getBgImageView { return self.background; }
@end
static UIImage *Native(CGFloat red) {
    CGImageRef cg=CSBubbleCreateTemplate((CSBubbleRGBA){red,.5,.5,1},10,0,2,(CSBubbleInsets){1,2,3,4},NO);
    UIImage *image=[UIImage imageWithCGImage:cg scale:2 orientation:UIImageOrientationUp]; CGImageRelease(cg); return image;
}
static BOOL HasColor(id value, CSBubbleRGBA color, BOOL highlighted) {
    UIImage *image=[value isKindOfClass:YYImage.class] ? ((YYImage *)value).originImage : value;
    if (![image isKindOfClass:UIImage.class] || !image.CGImage) return NO;
    CGImageRef cg=image.CGImage;size_t w=CGImageGetWidth(cg),h=CGImageGetHeight(cg);
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx=CGBitmapContextCreate(NULL,w,h,8,w*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(space);if (!ctx) return NO;
    CGContextDrawImage(ctx,CGRectMake(0,0,w,h),cg);
    const unsigned char *pixels=CGBitmapContextGetData(ctx);size_t offset=((h/2)*w+w/2)*4;
    CGFloat factor=highlighted ? .84 : 1;
    BOOL matches=abs(pixels[offset]-(int)round(color.red*factor*255))<=1 &&
        abs(pixels[offset+1]-(int)round(color.green*factor*255))<=1 &&
        abs(pixels[offset+2]-(int)round(color.blue*factor*255))<=1 && pixels[offset+3]==255;
    CGContextRelease(ctx);return matches;
}
static CSBubbleRGBA SchemeColor(BOOL outgoing, BOOL dark) {
    if (dark) return outgoing ? (CSBubbleRGBA){0,0,1,1} : (CSBubbleRGBA){1,1,0,1};
    return outgoing ? (CSBubbleRGBA){1,0,0,1} : (CSBubbleRGBA){0,1,0,1};
}
static void Drain(void) { for (int i=0;i<4;i++) CFRunLoopRunInMode(kCFRunLoopDefaultMode,.005,false); }
static void Settings(BOOL enabled) {
    [NSUserDefaults.standardUserDefaults setVolatileDomain:@{@"com.wechat.enhance.bubble_style.enabled":@(enabled)} forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil]; Drain();
}
int main(void) { @autoreleasepool {
    NSDictionary *saved=[NSUserDefaults.standardUserDefaults volatileDomainForName:NSArgumentDomain];
    Settings(NO); CSBubbleStyleStart();
    TextMessageViewModel *model=[TextMessageViewModel new]; model.messageWrap=[BubbleWrap new]; model.messageWrap.m_uiMessageType=1; model.isSender=YES; model.bgBubbleInfo=[BubbleInfo new];
    BubbleCell *cell=[BubbleCell new]; cell.viewModel=model; cell.background=[YYAsyncImageView new]; cell.frame=CGRectMake(5,7,110,80);
    YYImage *baseline=[YYImage imageWithUIImage:Native(.2)], *nativeHighlight=[YYImage imageWithUIImage:Native(.1)];
    cell.background.image=baseline; cell.background.highlightedImage=nativeHighlight;
    CSBubbleStyleApply(cell); CHECK(cell.background->m_image==baseline);
    Settings(YES); CHECK(cell.background->m_image!=baseline); CHECK([cell.background->m_image isKindOfClass:YYImage.class]);
    CHECK(HasColor(cell.background->m_image,(CSBubbleRGBA){.27,.78,.49,1},NO));
    CHECK(cell.background.image==nil); // Ensure the adapter used the actual YY storage, not UIKit's getter.
    CHECK(cell.background->m_highlightedImage!=nativeHighlight);
    CHECK(CGRectEqualToRect(cell.frame,CGRectMake(5,7,110,80)));
    id custom=cell.background->m_image; NSUInteger writes=cell.background.assignments;
    for (int i=0;i<100;i++) CSBubbleStyleApply(cell);
    CHECK(cell.background->m_image==custom && cell.background.assignments==writes);
    cell.background.image=baseline; CHECK(cell.background->m_image==custom); Drain(); CHECK(cell.background->m_image==custom);
    YYImage *newBaseline=[YYImage imageWithUIImage:Native(.8)]; cell.background.image=newBaseline; Drain(); CHECK(cell.background->m_image!=newBaseline);
    Settings(NO); CHECK(cell.background->m_image==newBaseline); CHECK(cell.background->m_highlightedImage==nativeHighlight);
    Settings(YES); CHECK(cell.background->m_image!=newBaseline);
    cell.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark; custom=cell.background->m_image; CSBubbleStyleApply(cell); CHECK(cell.background->m_image!=custom);
    CSBubbleStyleDetach(cell); CHECK(cell.background->m_image==newBaseline);
    // A late native assignment from the previous message must not recolor a reused unsupported cell.
    cell.background.image=baseline;
    model=[TextMessageViewModel new]; model.messageWrap=[BubbleWrap new]; model.messageWrap.m_uiMessageType=3; model.bgBubbleInfo=[BubbleInfo new]; cell.viewModel=model;
    CSBubbleStyleApply(cell); Drain(); CHECK(cell.background->m_image==baseline);
    // One invalid template is remembered until a native event, rather than reattempted every layout.
    model.messageWrap.m_uiMessageType=1; model.isSender=NO; CSBubbleStyleNativeChanged(cell); CHECK(cell.background->m_image!=baseline);
    YYImage *unready=[YYImage new]; cell.background.image=unready; Drain(); CHECK(cell.background->m_image==unready);
    for (int i=0;i<100;i++) CSBubbleStyleApply(cell); CHECK(cell.background->m_image==unready);
    unready.originImage=Native(.4); CSBubbleStyleImageDecoded(cell.background); CHECK(cell.background->m_image!=unready);
    CSBubbleStyleDetach(cell); CHECK(cell.background->m_image==unready);
    // Quoted replies use TextMessageViewModel with app-message subtype 57.
    model.messageWrap.m_uiMessageType=49;model.messageWrap.m_uiAppMsgInnerType=57;
    cell.background.image=baseline;CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=baseline);
    CSBubbleStyleDetach(cell);CHECK(cell.background->m_image==baseline);
    model.messageWrap.m_uiAppMsgInnerType=5;CSBubbleStyleApply(cell);CHECK(cell.background->m_image==baseline);
    model.messageWrap.m_uiMessageType=1;CSBubbleStyleNativeChanged(cell);
    // A changed native split position must invalidate the cached shape without a new model.
    model.bgBubbleInfo.position=1;CSBubbleStyleApply(cell);
    UIImage *topTemplate=((YYImage *)cell.background->m_image).originImage;
    CHECK(topTemplate.capInsets.bottom==3);
    model.bgBubbleInfo.position=3;CSBubbleStyleApply(cell);
    UIImage *bottomTemplate=((YYImage *)cell.background->m_image).originImage;
    CHECK(bottomTemplate!=topTemplate);CHECK(bottomTemplate.capInsets.top==1);
    CSBubbleStyleDetach(cell);
    // Real separate parent/submodel shape: child has no wrap or sender getter.
    TextMessageSubViewModel *part=[TextMessageSubViewModel new];part.parentModel=model;
    part.bgBubbleInfo=[BubbleInfo new];part.bgBubbleInfo.position=3;
    cell.viewModel=(id)part;cell.background.frame=CGRectMake(0,0,170,24);
    CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=baseline);
    UIImage *shortTemplate=((YYImage *)cell.background->m_image).originImage;
    CHECK(shortTemplate.capInsets.top+shortTemplate.capInsets.bottom<24);
    CHECK(CGRectEqualToRect(cell.background.frame,CGRectMake(0,0,170,24)));
    Settings(NO);CHECK(cell.background->m_image==baseline);
    Settings(YES);CHECK(cell.background->m_image!=baseline);
    CSBubbleStyleDetach(cell);CHECK(cell.background->m_image==baseline);
    cell.background.frame=CGRectZero;
    // Distinct palettes expose wrong theme/direction selection at the rendered pixel level.
    NSMutableDictionary *palettes=[NSMutableDictionary dictionaryWithObject:@YES forKey:@"com.wechat.enhance.bubble_style.enabled"];
    for (NSUInteger i=0;i<4;i++) {
        CSBubbleRGBA c=SchemeColor(i%2==0,i>=2);
        NSString *base=[NSString stringWithFormat:@"com.wechat.enhance.bubble_style.%@_%@_color.",i%2==0?@"sender":@"receiver",i>=2?@"dark":@"light"];
        NSArray *values=@[@(c.red),@(c.green),@(c.blue),@(c.alpha)];
        NSArray *names=@[@"red",@"green",@"blue",@"alpha"];
        for (NSUInteger j=0;j<4;j++) palettes[[base stringByAppendingString:names[j]]]=values[j];
    }
    [NSUserDefaults.standardUserDefaults setVolatileDomain:palettes forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
    UIView *window=[UIView new];cell.window=window;
    for (NSUInteger kind=0;kind<3;kind++) for (NSUInteger outgoing=0;outgoing<2;outgoing++) for (NSUInteger dark=0;dark<2;dark++) {
        TextMessageViewModel *themed=kind==2 ? [VoiceMessageViewModel new] : [TextMessageViewModel new];
        themed.messageWrap=[BubbleWrap new];themed.bgBubbleInfo=[BubbleInfo new];themed.isSender=outgoing;
        themed.messageWrap.m_uiMessageType=kind==2 ? 34 : (kind==1 ? 49 : 1);themed.messageWrap.m_uiAppMsgInnerType=kind==1 ? 57 : 0;
        CSBubbleStyleDetach(cell);cell.viewModel=themed;cell.background.image=baseline;cell.background.highlightedImage=nativeHighlight;
        cell.isUseLightStyle=dark; // Private flag deliberately contradicts UIKit in both themes.
        cell.traitCollection.userInterfaceStyle=dark ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        window.traitCollection.userInterfaceStyle=dark ? UIUserInterfaceStyleLight : UIUserInterfaceStyleDark;
        CSBubbleStyleApply(cell);
        CHECK(HasColor(cell.background->m_image,SchemeColor(outgoing,dark),NO));
        CHECK(HasColor(cell.background->m_highlightedImage,SchemeColor(outgoing,dark),YES));
        id generated=cell.background->m_image;NSUInteger count=cell.background.assignments;
        cell.isUseLightStyle=!cell.isUseLightStyle;CSBubbleStyleApply(cell);
        CHECK(cell.background->m_image==generated && cell.background.assignments==count);
        cell.background.image=baseline;Drain();CHECK(cell.background->m_image==generated);
        cell.traitCollection.userInterfaceStyle=dark ? UIUserInterfaceStyleLight : UIUserInterfaceStyleDark;
        CSBubbleStyleNativeChanged(cell);
        CHECK(HasColor(cell.background->m_image,SchemeColor(outgoing,!dark),NO));
    }
    // Unspecified view appearance falls back to its own window, then the current traits.
    cell.viewModel.isSender=YES;CSBubbleStyleNativeChanged(cell);
    cell.traitCollection.userInterfaceStyle=UIUserInterfaceStyleUnspecified;
    for (NSUInteger dark=0;dark<2;dark++) {
        window.traitCollection.userInterfaceStyle=dark ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        CSBubbleStyleApply(cell);CHECK(HasColor(cell.background->m_image,SchemeColor(YES,dark),NO));
        window.traitCollection.userInterfaceStyle=UIUserInterfaceStyleUnspecified;
        UITraitCollection.currentTraitCollection.userInterfaceStyle=dark ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        CSBubbleStyleApply(cell);CHECK(HasColor(cell.background->m_image,SchemeColor(YES,dark),NO));
    }
    cell.window=nil;UITraitCollection.currentTraitCollection.userInterfaceStyle=UIUserInterfaceStyleUnspecified;
    CSBubbleStyleApply(cell);CHECK(HasColor(cell.background->m_image,SchemeColor(YES,NO),NO));
    // Editing dark colors while light must not change the selected palette; light edits take effect.
    cell.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
    palettes[@"com.wechat.enhance.bubble_style.sender_dark_color.red"]=@0.7;
    [NSUserDefaults.standardUserDefaults setVolatileDomain:palettes forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
    CHECK(HasColor(cell.background->m_image,SchemeColor(YES,NO),NO));
    palettes[@"com.wechat.enhance.bubble_style.sender_light_color.red"]=@0.4;
    [NSUserDefaults.standardUserDefaults setVolatileDomain:palettes forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
    CHECK(HasColor(cell.background->m_image,(CSBubbleRGBA){.4,0,0,1},NO));
    cell.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;CSBubbleStyleNativeChanged(cell);
    CHECK(HasColor(cell.background->m_image,(CSBubbleRGBA){.7,0,1,1},NO));
    CSBubbleStyleDetach(cell);CHECK(cell.background->m_image==baseline && cell.background->m_highlightedImage==nativeHighlight);
    // Payment cards stay native even when valid structured payment metadata is present.
    WCPayTransferMessageViewModel *pay=[WCPayTransferMessageViewModel new]; pay.messageWrap=[BubbleWrap new]; pay.messageWrap.m_uiMessageType=49; pay.bgBubbleInfo=[BubbleInfo new];
    cell.viewModel=pay; cell.background.image=baseline; CSBubbleStyleApply(cell); CHECK(cell.background->m_image==baseline);
    Payment *info=[Payment new]; info.m_nsTransferID=@"verified-structured-field"; pay.messageWrap.m_oWCPayInfoItem=info; CSBubbleStyleNativeChanged(cell); CHECK(cell.background->m_image==baseline);
    WCPayC2CMessageViewModel *redPacket=[WCPayC2CMessageViewModel new];redPacket.messageWrap=[BubbleWrap new];
    redPacket.messageWrap.m_uiMessageType=49;redPacket.bgBubbleInfo=[BubbleInfo new];
    info.m_c2cNativeUrl=@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao";
    redPacket.messageWrap.m_oWCPayInfoItem=info;cell.viewModel=redPacket;CSBubbleStyleApply(cell);
    CHECK(cell.background->m_image==baseline && cell.background->m_highlightedImage==nativeHighlight);
    for (NSUInteger i=0;i<2;i++) {
        cell.traitCollection.userInterfaceStyle=i ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        CSBubbleStyleNativeChanged(cell);CHECK(cell.background->m_image==baseline);
    }
    // Unbound image views are untouched by the narrow YY assignment hook.
    YYAsyncImageView *other=[YYAsyncImageView new]; other.image=baseline; Drain(); CHECK(other->m_image==baseline);
    // Native removal clears the owned state instead of reviving a stale image.
    cell.background.image=nil; Drain(); CHECK(cell.background->m_image==nil);
    Settings(NO); CHECK(cell.background->m_image==nil);
    [NSUserDefaults.standardUserDefaults setVolatileDomain:saved forName:NSArgumentDomain];
    fprintf(stdout,"Bubble real-adapter lifecycle: %lu checks passed\n",(unsigned long)checks);
} return 0; }
