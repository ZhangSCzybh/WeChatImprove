#import <UIKit/UIKit.h>
#import "CSBubbleStylePolicy.h"
#import "CSBubbleStyleAdapter.h"
#import "CSBubbleTextColors.h"
#import "CSChatNativeBridge.h"
#import "CSMessageMergeAdapter.h"
#import <objc/message.h>
#import <objc/runtime.h>
static NSUInteger checks;
extern NSUInteger CSBubbleNativePaddingScanCount;
#define CHECK(value) do { checks++; if (!(value)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#value); return 1; } } while (0)
// The adapter's real selector checks are used for scalars. The shared object bridge is isolated here.
id CSMessageNativeObject(id object, NSString *selector) {
    SEL sel=NSSelectorFromString(selector); Method method=class_getInstanceMethod([object class],sel);
    if (!method || method_getNumberOfArguments(method)!=2) return nil;
    char result[32]={0}; method_getReturnType(method,result,sizeof(result)); if (result[0]!='@') return nil;
    return ((id(*)(id,SEL))objc_msgSend)(object,sel);
}
static CSMessageMergeDecision testAppearance;
BOOL CSMessageMergeReadAppearance(id model, CSMessageMergeDecision *decision) {
    if (decision) *decision=testAppearance;
    return model!=nil;
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
// A different actual class may expose the same selector with another integer ABI,
// even when -class reports the ordinary native class.
@interface AlternateBubbleInfo : NSObject
@property(nonatomic) unsigned int position;
@end
@implementation AlternateBubbleInfo
- (Class)class { return BubbleInfo.class; }
@end
static NSUInteger invalidPositionReads;
@interface InvalidBubbleInfo : NSObject
- (id)position;
@end
@implementation InvalidBubbleInfo
- (Class)class { return BubbleInfo.class; }
- (id)position { invalidPositionReads++;return @0; }
@end
@interface LateBubbleInfo : NSObject @end
@implementation LateBubbleInfo @end
static unsigned long long LatePosition(id object, SEL selector) { return 0; }
static NSUInteger replacementTypeReads;
static unsigned int ReplacementMessageType(id object, SEL selector) { replacementTypeReads++;return 49; }
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
@interface VoIPBubbleMessageViewModel : TextMessageViewModel @end
@implementation VoIPBubbleMessageViewModel @end
@interface VoIPSignalMessageViewModel : TextMessageViewModel @end
@implementation VoIPSignalMessageViewModel @end
@interface Payment : NSObject
@property(nonatomic, copy) NSString *m_nsTransferID;
@property(nonatomic, copy) NSString *m_c2cNativeUrl;
@end
@implementation Payment @end
@interface BubbleRichText : UIView
@property(nonatomic, strong) UIColor *oTextColor, *linkColor;
@property(nonatomic) NSUInteger colorAssignments;
@end
@implementation BubbleRichText
- (void)setOTextColor:(UIColor *)color { self.colorAssignments++;_oTextColor=CSBubbleTextColorAssignment(self,color); }
@end
@interface InvalidRichText : UIView
@property(nonatomic) NSUInteger assignments;
- (NSUInteger)oTextColor;
- (void)setOTextColor:(id)color;
@end
@implementation InvalidRichText
- (NSUInteger)oTextColor { return 7; }
- (void)setOTextColor:(id)color { self.assignments++; }
@end
@interface BubbleReply : NSObject
@property(nonatomic, strong) UIView *richTextView;
@end
@implementation BubbleReply @end
@interface BubbleCell : UIView { @public UILabel *m_secLabel; }
@property(nonatomic, strong) TextMessageViewModel *viewModel;
@property(nonatomic, strong) YYAsyncImageView *background;
@property(nonatomic) BOOL isUseLightStyle; // Deliberately conflicts with UIKit appearance.
@property(nonatomic, strong) BubbleRichText *richText;
@property(nonatomic, strong) BubbleReply *reply;
@property(nonatomic, strong) UIView *content;
- (id)getBgImageView;
@end
@implementation BubbleCell
- (id)getBgImageView { return self.background; }
- (id)getRichTextView { return self.richText; }
- (id)getMsgReplyView { return self.reply; }
- (id)getContentView { return self.content; }
@end
// These getters model the native lazy decoder. Layout must only inspect already
// published backing storage, including when a wrapper is not ready or is reused.
@interface LazyYYImage : YYImage @end
@implementation LazyYYImage
- (UIImage *)originImage { [NSException raise:@"UnsafeLazyDecode" format:@"originImage invoked during layout"]; return nil; }
- (CGImageRef)CGImage { [NSException raise:@"UnsafeLazyDecode" format:@"CGImage invoked on YYImage"]; return NULL; }
- (UIImage *)decodeImageLM { [NSException raise:@"UnsafeLazyDecode" format:@"decodeImageLM getter invoked"]; return nil; }
- (UIImage *)decodeImageDM { [NSException raise:@"UnsafeLazyDecode" format:@"decodeImageDM getter invoked"]; return nil; }
@end
static UIImage *Native(CGFloat red) {
    CGImageRef cg=CSBubbleCreateTemplate((CSBubbleRGBA){red,.5,.5,1},10,0,2,(CSBubbleInsets){1,2,3,4},NO);
    UIImage *image=[UIImage imageWithCGImage:cg scale:2 orientation:UIImageOrientationUp]; CGImageRelease(cg); return image;
}
static BOOL HasColor(id value, CSBubbleRGBA color, BOOL highlighted) {
    UIImage *image=[value isKindOfClass:YYImage.class] ?
        (((YYImage *)value)->m_originImage ?: ((YYImage *)value).decodeImageLM ?: ((YYImage *)value).pendingImage) : value;
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
static UIColor *FontColor(NSUInteger palette) {
    return [UIColor colorWithRed:.1+palette*.2 green:.2+palette*.1 blue:.8-palette*.1 alpha:1];
}
static int VerifyTextColors(void) {
    NSDictionary *saved=NSUserDefaults.standardUserDefaults.volatileDomainNames.count ?
        [NSUserDefaults.standardUserDefaults volatileDomainForName:NSArgumentDomain] : @{};
    NSMutableDictionary *settings=[@{@"com.wechat.enhance.bubble_style.enabled":@YES} mutableCopy];
    for (NSUInteger palette=0;palette<4;palette++) {
        UIColor *color=FontColor(palette);
        settings[CSBubbleTextColorPreferenceKey(palette,@"red")]=@(color.red);
        settings[CSBubbleTextColorPreferenceKey(palette,@"green")]=@(color.green);
        settings[CSBubbleTextColorPreferenceKey(palette,@"blue")]=@(color.blue);
    }
    [NSUserDefaults.standardUserDefaults setVolatileDomain:settings forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
    UIColor *native=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    UIColor *link=[UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    BubbleCell *cell=[BubbleCell new];cell.background=[YYAsyncImageView new];cell.background.frame=CGRectMake(0,0,180,38);
    cell.background.image=Native(.3);cell.viewModel=[TextMessageViewModel new];
    cell.viewModel.messageWrap=[BubbleWrap new];cell.viewModel.messageWrap.m_uiMessageType=1;cell.viewModel.bgBubbleInfo=[BubbleInfo new];
    cell.richText=[BubbleRichText new];cell.richText.oTextColor=native;cell.richText.linkColor=link;
    BubbleRichText *refer=[BubbleRichText new];refer.oTextColor=native;refer.linkColor=link;
    cell.reply=[BubbleReply new];cell.reply.richTextView=refer;
    for (NSUInteger palette=0;palette<4;palette++) {
        cell.viewModel.isSender=palette%2==0;
        cell.traitCollection.userInterfaceStyle=palette>=2 ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        CSBubbleStyleNativeChanged(cell);
        CHECK([cell.richText.oTextColor isEqual:FontColor(palette)]);
        CHECK([refer.oTextColor isEqual:FontColor(palette)]);CHECK(cell.richText.linkColor==link && refer.linkColor==link);
    }
    // Text-only preference changes and unchanged layouts reuse all background images.
    NSUInteger images=cell.background.assignments,scans=CSBubbleNativePaddingScanCount;
    settings[CSBubbleTextColorPreferenceKey(3,@"red")]=@.95;
    [NSUserDefaults.standardUserDefaults setVolatileDomain:settings forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
    CHECK(cell.richText.oTextColor.red==.95);CHECK(cell.background.assignments==images && CSBubbleNativePaddingScanCount==scans);
    NSUInteger writes=cell.richText.colorAssignments,draws=cell.richText.displayRequests;
    for (NSUInteger i=0;i<30;i++) CSBubbleStyleApply(cell);
    CHECK(cell.richText.colorAssignments==writes && cell.richText.displayRequests==draws);
    // Quotes and split text retain the logical sender palette.
    cell.viewModel.messageWrap.m_uiMessageType=49;cell.viewModel.messageWrap.m_uiAppMsgInnerType=57;
    CSBubbleStyleNativeChanged(cell);CHECK(cell.richText.oTextColor.red==.95);
    TextMessageViewModel *logical=cell.viewModel;logical.messageWrap.m_uiMessageType=1;
    TextMessageSubViewModel *segment=[TextMessageSubViewModel new];segment.parentModel=logical;segment.bgBubbleInfo=[BubbleInfo new];segment.bgBubbleInfo.position=1;
    CSBubbleStyleDetach(cell);cell.viewModel=(id)segment;CSBubbleStyleApply(cell);CHECK(cell.richText.oTextColor.red==.95);
    CSBubbleStyleDetach(cell);cell.viewModel=logical;CSBubbleStyleApply(cell);
    // A new native color during an owned assignment must become the restore baseline.
    UIColor *updatedNative=[UIColor colorWithRed:.3 green:.4 blue:.5 alpha:1];
    cell.richText.oTextColor=updatedNative;CHECK(cell.richText.oTextColor.red==.95);
    for (NSString *component in @[@"red",@"green",@"blue"]) [settings removeObjectForKey:CSBubbleTextColorPreferenceKey(3,component)];
    [NSUserDefaults.standardUserDefaults setVolatileDomain:settings forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
    CHECK(cell.richText.oTextColor==updatedNative && refer.oTextColor==native);
    // Replacing a content view restores the old view and styles the new one.
    cell.viewModel.isSender=YES;cell.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;CSBubbleStyleNativeChanged(cell);
    BubbleRichText *old=cell.richText;cell.richText=[BubbleRichText new];cell.richText.oTextColor=native;
    CSBubbleStyleApply(cell);CHECK(old.oTextColor==updatedNative);CHECK([cell.richText.oTextColor isEqual:FontColor(0)]);
    Settings(NO);CHECK(cell.richText.oTextColor==native);CHECK(refer.oTextColor==native);
    CSBubbleStyleDetach(cell);
    // Voice duration attributed text preserves links, attachments and other attributes.
    BubbleCell *voice=[BubbleCell new];voice->m_secLabel=[UILabel new];voice->m_secLabel.textColor=native;
    NSMutableAttributedString *original=[[NSMutableAttributedString alloc] initWithString:@"body link X" attributes:@{NSForegroundColorAttributeName:native,@"font":@"native-font"}];
    [original addAttributes:@{NSLinkAttributeName:@"https://example.com",NSForegroundColorAttributeName:link} range:NSMakeRange(5,4)];
    [original addAttribute:NSAttachmentAttributeName value:@"emoji" range:NSMakeRange(10,1)];
    voice->m_secLabel.attributedText=original;
    CSBubbleTextColorsApply(voice,FontColor(0),NO);
    CHECK([[voice->m_secLabel.attributedText attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:NULL] isEqual:FontColor(0)]);
    CHECK([voice->m_secLabel.attributedText attribute:NSForegroundColorAttributeName atIndex:5 effectiveRange:NULL]==link);
    CHECK([voice->m_secLabel.attributedText attribute:NSForegroundColorAttributeName atIndex:10 effectiveRange:NULL]==native);
    CHECK([[voice->m_secLabel.attributedText attribute:@"font" atIndex:0 effectiveRange:NULL] isEqual:@"native-font"]);
    writes=voice->m_secLabel.textAssignments;
    CSBubbleTextColorsApply(voice,FontColor(0),NO);CHECK(voice->m_secLabel.textAssignments==writes);
    CSBubbleTextColorsRestore(voice);CHECK([voice->m_secLabel.attributedText isEqualToAttributedString:original]);CHECK(voice->m_secLabel.textColor==native);
    CSBubbleTextColorsApply(voice,FontColor(0),NO);
    NSAttributedString *replacement=[[NSAttributedString alloc] initWithString:@"new status" attributes:@{NSForegroundColorAttributeName:link}];
    voice->m_secLabel.attributedText=replacement;CSBubbleTextColorsRestore(voice);
    CHECK([voice->m_secLabel.attributedText isEqualToAttributedString:replacement]);
    // Call compatibility searches only getContentView; names/times outside it stay native.
    BubbleCell *call=[BubbleCell new];call.content=[UIView new];UILabel *status=[UILabel new],*name=[UILabel new];
    status.textColor=native;name.textColor=native;[call.content addSubview:status];[call addSubview:call.content];[call addSubview:name];
    CSBubbleTextColorsApply(call,FontColor(1),YES);CHECK([status.textColor isEqual:FontColor(1)]);CHECK(name.textColor==native);
    CSBubbleTextColorsRestore(call);CHECK(status.textColor==native);
    // Missing or whole-cell content contracts fail closed, and detached setters pass through.
    call.content=call;CSBubbleTextColorsApply(call,FontColor(1),YES);CHECK(name.textColor==native);
    UIView *foreign=[UIView new];[foreign addSubview:name];call.content=foreign;
    CSBubbleTextColorsApply(call,FontColor(1),YES);CHECK(name.textColor==native);
    InvalidRichText *invalid=[InvalidRichText new];call.richText=(id)invalid;
    CSBubbleTextColorsApply(call,FontColor(1),NO);CHECK(invalid.assignments==0);
    CHECK(CSBubbleTextColorAssignment(cell.richText,link)==link);
    [NSUserDefaults.standardUserDefaults setVolatileDomain:saved forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
    return 0;
}
// Execute the same display-task boundary used by the Logos hook, including a
// worker completion. The original result and cancellation block are preserved.
static UIImage *RunDisplay(YYAsyncLayerDisplayTask *task, BOOL worker, BOOL cancelled) {
    __block UIImage *result=nil;
    void (^run)(void)=^{ result=task.displayContentsForLayer(CGSizeMake(180,38), ^BOOL { return cancelled; }); };
    if (worker) dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),run); else run();
    return result;
}
static int VerifyNativeDisplayReadiness(void) {
    Settings(YES);
    CSBubbleTestDeferredFactory=YES;
    BubbleCell *cell=[BubbleCell new];cell.background=[YYAsyncImageView new];
    cell.background.frame=CGRectMake(0,0,180,38);
    TextMessageViewModel *model=[TextMessageViewModel new];model.messageWrap=[BubbleWrap new];
    model.messageWrap.m_uiMessageType=1;model.bgBubbleInfo=[BubbleInfo new];cell.viewModel=model;
    UIImage *pixels=Native(.2),*pressedPixels=Native(.3);
    YYImage *normal=[YYImage deferredImageWithUIImage:pixels];
    YYImage *pressed=[YYImage deferredImageWithUIImage:pressedPixels];
    cell.background.image=normal;cell.background.highlightedImage=pressed;
    CSBubbleStyleApply(cell);CHECK(cell.background->m_image==normal);
    NSUInteger displays=cell.background.displayRequests;
    for (NSUInteger i=0;i<100;i++) CSBubbleStyleApply(cell);
    CHECK(cell.background.displayRequests==displays); // At most one request for the unchanged missing snapshot.
    YYAsyncLayerDisplayTask *task=[cell.background newAsyncDisplayTask];
    CHECK(RunDisplay(task,YES,NO)==pixels);
    CHECK(cell.background->m_image==normal); // No UIKit write on the decoding thread.
    UIEdgeInsets unpublished;CHECK(!CSBubbleStyleVisibleInsets(cell.background,&unpublished));
    CHECK(pressed.decodeImageLM==nil); // The inactive state remains lazy indefinitely.
    Drain();CHECK(cell.background->m_image!=normal);
    CHECK(HasColor(cell.background->m_image,(CSBubbleRGBA){.95,.95,.95,1},NO));
    CHECK(cell.background->m_highlightedImage==pressed);
    NSUInteger writes=cell.background.assignments,scans=CSBubbleNativePaddingScanCount;
    task=[cell.background newAsyncDisplayTask];RunDisplay(task,NO,NO);Drain();
    CHECK(cell.background.assignments==writes && CSBubbleNativePaddingScanCount==scans);
    cell.background.highlighted=YES;task=[cell.background newAsyncDisplayTask];
    CHECK(RunDisplay(task,YES,NO)==pressedPixels);Drain();
    CHECK(cell.background->m_highlightedImage!=pressed);
    CHECK(HasColor(cell.background->m_highlightedImage,(CSBubbleRGBA){.95,.95,.95,1},YES));
    UIEdgeInsets insets;
    CHECK(((YYImage *)cell.background->m_highlightedImage).decodeImageLM==nil);
    CHECK(CSBubbleStyleVisibleInsets(cell.background,&insets));
    CHECK(insets.top==1 && insets.bottom==3); // Owned pixels are known before YY decodes our wrapper.
    CSBubbleStyleDetach(cell);CHECK(cell.background->m_image==normal && cell.background->m_highlightedImage==pressed);
    cell.background.highlighted=NO;cell.background.highlightedImage=nil;Drain();

    // Canceled/stale work, feature disable, unsupported reuse, and normal completion.
    // No test calls a pretend "decoded" callback or a second layout to recover.
    for (NSUInteger pass=0;pass<98;pass++) {
        cell.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
        model.messageWrap.m_uiMessageType=1;cell.viewModel=model;Settings(YES);
        normal=[YYImage deferredImageWithUIImage:pixels];cell.background.image=normal;
        CSBubbleStyleNativeChanged(cell);Drain();task=[cell.background newAsyncDisplayTask];
        NSUInteger mode=pass%7;
        if (mode==1) CSBubbleStyleDetach(cell);
        if (mode==2) Settings(NO);
        if (mode==3) {
            TextMessageViewModel *replacement=[TextMessageViewModel new];replacement.messageWrap=[BubbleWrap new];
            replacement.messageWrap.m_uiMessageType=3;replacement.bgBubbleInfo=[BubbleInfo new];
            cell.viewModel=replacement; // Even without a detach, stale model identity must reject completion.
        }
        if (mode==4) {
            YYImage *replacement=[YYImage deferredImageWithUIImage:pressedPixels];
            cell.background.image=replacement;Drain();
        }
        if (mode==6) cell.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;
        writes=cell.background.assignments;
        CHECK(RunDisplay(task,pass%2,mode==0)==pixels);Drain();
        if (mode==5) CHECK(cell.background->m_image!=normal);
        else CHECK(cell.background.assignments==writes);
        CSBubbleStyleDetach(cell);
    }
    Settings(YES);
    YYAsyncImageView *unbound=[YYAsyncImageView new];unbound.image=[YYImage deferredImageWithUIImage:pixels];
    task=[YYAsyncLayerDisplayTask new];task.displayContentsForLayer=^UIImage *(CGSize size, BOOL (^cancelled)(void)) { return pixels; };
    id original=task.displayContentsForLayer;CSBubbleStyleObserveDisplayTask(unbound,task);
    CHECK(task.displayContentsForLayer==original);CHECK(RunDisplay(task,YES,NO)==pixels);Drain();
    CHECK(unbound.assignments==1);
    CSBubbleStyleApply(cell);task=[YYAsyncLayerDisplayTask new];
    CSBubbleStyleObserveDisplayTask(cell.background,task);CHECK(task.displayContentsForLayer==nil);
    CSBubbleStyleObserveDisplayTask(cell.background,[NSObject new]);
    CSBubbleStyleDetach(cell);Settings(NO);CSBubbleTestDeferredFactory=NO;
    return 0;
}
static int VerifyUnownedNativeCache(void) {
    // Match the crash's invalid decoder slot without dereferencing it in the test.
    // The plugin must not read/retain cache storage owned by native worker threads.
    YYImage *image=[YYImage new];UIImageView *view=[UIImageView new];view.image=image;
    view.frame=CGRectMake(0,0,100,100);UIEdgeInsets insets;
    Ivar slot=class_getInstanceVariable(YYImage.class,"_decodeImageLM");CHECK(slot!=NULL);
    unsigned char *storage=(__bridge void *)image;
    uintptr_t poison=0xbad0,empty=0;
    memcpy(storage+ivar_getOffset(slot),&poison,sizeof(poison));
    BOOL ready=CSBubbleStyleVisibleInsets(view,&insets);
    memcpy(storage+ivar_getOffset(slot),&empty,sizeof(empty));
    CHECK(!ready);
    return 0;
}
int main(void) { @autoreleasepool {
    if (VerifyUnownedNativeCache()) return 1;
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
    NSUInteger scans=CSBubbleNativePaddingScanCount;
    for (NSUInteger i=0;i<100;i++) {
        BubbleCell *other=[BubbleCell new]; other.viewModel=model;other.background=[YYAsyncImageView new];
        other.background.image=baseline;other.background.highlightedImage=nativeHighlight;
        CSBubbleStyleApply(other); CHECK(other.background->m_image!=baseline);
        CSBubbleStyleDetach(other); CHECK(other.background->m_image==baseline);
    }
    CHECK(CSBubbleNativePaddingScanCount==scans);
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    CSBubbleStyleNativeChanged(cell); CHECK(CSBubbleNativePaddingScanCount==scans+2);
    scans=CSBubbleNativePaddingScanCount;
    id custom=cell.background->m_image; NSUInteger writes=cell.background.assignments;
    for (int i=0;i<100;i++) CSBubbleStyleApply(cell);
    CHECK(cell.background->m_image==custom && cell.background.assignments==writes);
    // An ABI cache must still dispatch through a hook installed after its first hit.
    Method typeGetter=class_getInstanceMethod(BubbleWrap.class,@selector(m_uiMessageType));
    IMP nativeTypeGetter=method_setImplementation(typeGetter,(IMP)ReplacementMessageType);
    CSBubbleStyleApply(cell);CHECK(replacementTypeReads>0 && cell.background->m_image==baseline);
    method_setImplementation(typeGetter,nativeTypeGetter);
    CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=baseline);
    BubbleInfo *ordinaryInfo=model.bgBubbleInfo;
    AlternateBubbleInfo *alternate=[AlternateBubbleInfo new];alternate.position=1;model.bgBubbleInfo=(id)alternate;
    CSBubbleStyleApply(cell);id alternateShape=cell.background->m_image;CHECK(alternateShape!=baseline);
    alternate.position=3;CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=alternateShape);
    model.bgBubbleInfo=(id)[InvalidBubbleInfo new];CSBubbleStyleApply(cell);
    CHECK(invalidPositionReads==0 && cell.background->m_image==baseline);
    model.bgBubbleInfo=(id)[LateBubbleInfo new];CSBubbleStyleApply(cell);CHECK(cell.background->m_image==baseline);
    CHECK(class_addMethod(LateBubbleInfo.class,@selector(position),(IMP)LatePosition,"Q@:"));
    CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=baseline);
    model.bgBubbleInfo=ordinaryInfo;CSBubbleStyleApply(cell);custom=cell.background->m_image;
    cell.background.image=baseline; CHECK(cell.background->m_image==custom); Drain(); CHECK(cell.background->m_image==custom);
    YYImage *newBaseline=[YYImage imageWithUIImage:Native(.8)]; cell.background.image=newBaseline; Drain(); CHECK(cell.background->m_image!=newBaseline);
    Settings(NO); CHECK(cell.background->m_image==newBaseline); CHECK(cell.background->m_highlightedImage==nativeHighlight);
    Settings(YES); CHECK(cell.background->m_image!=newBaseline);
    cell.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark; custom=cell.background->m_image; CSBubbleStyleApply(cell); CHECK(cell.background->m_image!=custom);
    CSBubbleStyleDetach(cell); CHECK(cell.background->m_image==newBaseline);
    // The merge adapter consumes cached visible margins only for stretchable,
    // upright images at a size/content mode that preserves those margins.
    UIImageView *metricView=[UIImageView new];metricView.frame=CGRectMake(0,0,100,100);
    UIImage *metricImage=Native(.6);UIEdgeInsets measured;
    metricView.image=metricImage;CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured));
    metricView.image=[metricImage resizableImageWithCapInsets:UIEdgeInsetsMake(12,12,12,12) resizingMode:UIImageResizingModeStretch];
    CHECK(CSBubbleStyleVisibleInsets(metricView,&measured));CHECK(measured.top==1 && measured.bottom==3);
    NSUInteger metricScans=CSBubbleNativePaddingScanCount;
    for (NSUInteger pass=0;pass<100;pass++) CHECK(CSBubbleStyleVisibleInsets(metricView,&measured));
    CHECK(CSBubbleNativePaddingScanCount==metricScans);
    UIImage *plainHighlight=Native(.7);metricView.highlightedImage=plainHighlight;
    CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured)); // Unqualified highlighted layout is protected.
    metricView.highlightedImage=[plainHighlight resizableImageWithCapInsets:UIEdgeInsetsMake(12,12,12,12) resizingMode:UIImageResizingModeStretch];
    CHECK(CSBubbleStyleVisibleInsets(metricView,&measured));CHECK(measured.top==1 && measured.bottom==3);
    metricView.highlightedImage=nil;
    metricView.contentMode=UIViewContentModeScaleAspectFit;CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured));
    metricView.contentMode=UIViewContentModeScaleToFill;metricView.frame=CGRectMake(0,0,10,10);
    CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured));
    metricView.frame=CGRectMake(0,0,100,100);metricView.image.imageOrientation=UIImageOrientationDown;
    CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured));
    // A late native assignment from the previous message must not recolor a reused unsupported cell.
    cell.background.image=baseline;
    model=[TextMessageViewModel new]; model.messageWrap=[BubbleWrap new]; model.messageWrap.m_uiMessageType=3; model.bgBubbleInfo=[BubbleInfo new]; cell.viewModel=model;
    CSBubbleStyleApply(cell); Drain(); CHECK(cell.background->m_image==baseline);
    // A pending wrapper can become ready in place without a setter or dynamic-image callback.
    model.messageWrap.m_uiMessageType=1; model.isSender=NO; CSBubbleStyleNativeChanged(cell); CHECK(cell.background->m_image!=baseline);
    YYImage *unready=[LazyYYImage new]; cell.background.image=unready; Drain(); CHECK(cell.background->m_image==unready);
    for (int i=0;i<100;i++) CSBubbleStyleApply(cell); CHECK(cell.background->m_image==unready);
    scans=CSBubbleNativePaddingScanCount;
    unready.originImage=Native(.4); CSBubbleStyleApply(cell); CHECK(cell.background->m_image!=unready);
    CHECK(CSBubbleNativePaddingScanCount==scans+1);
    scans=CSBubbleNativePaddingScanCount;
    unready.originImage=Native(.6); CSBubbleStyleApply(cell);
    CHECK(CSBubbleNativePaddingScanCount==scans+1); // Same YY wrapper, new immutable decoded pixels.
    CSBubbleStyleDetach(cell); CHECK(cell.background->m_image==unready);
    // WeChat leaves the pressed background lazy until it is actually displayed.
    LazyYYImage *dormantHighlight=[LazyYYImage new];
    cell.background.image=baseline;cell.background.highlightedImage=dormantHighlight;
    CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=baseline);
    CHECK(cell.background->m_highlightedImage==dormantHighlight);
    dormantHighlight.originImage=Native(.3);CSBubbleStyleApply(cell);
    CHECK(cell.background->m_highlightedImage!=dormantHighlight);
    CSBubbleStyleDetach(cell);CHECK(cell.background->m_image==baseline);
    CHECK(cell.background->m_highlightedImage==dormantHighlight);
    cell.background.highlightedImage=nativeHighlight;
    // Visible-inset inspection shares the same safe decoder, even with styling off.
    UIImage *loaded=[Native(.4) resizableImageWithCapInsets:UIEdgeInsetsMake(12,12,12,12) resizingMode:UIImageResizingModeStretch];
    LazyYYImage *lazy=[LazyYYImage new];metricView.image=lazy;
    CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured));
    lazy.decodeImageLM=loaded;CHECK(CSBubbleStyleVisibleInsets(metricView,&measured));
    LazyYYImage *pendingHighlight=[LazyYYImage new];metricView.highlightedImage=pendingHighlight;
    CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured));
    pendingHighlight.originImage=loaded;CHECK(CSBubbleStyleVisibleInsets(metricView,&measured));metricView.highlightedImage=nil;
    lazy.decodeImageLM=nil;lazy.decodeImageDM=loaded;CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured));
    metricView.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;CHECK(CSBubbleStyleVisibleInsets(metricView,&measured));
    lazy.decodeImageDM=nil;lazy.originImage=lazy; // A nested wrapper must not invoke CGImage recursively.
    CHECK(!CSBubbleStyleVisibleInsets(metricView,&measured));lazy.originImage=nil;
    for (NSUInteger reuse=0;reuse<600;reuse++) {
        LazyYYImage *pending=[LazyYYImage new];cell.background.image=pending;
        CSBubbleStyleNativeChanged(cell);CHECK(cell.background->m_image==pending);
        pending.originImage=loaded;CSBubbleStyleApply(cell);
        CHECK(cell.background->m_image!=pending);
        CSBubbleStyleDetach(cell);CHECK(cell.background->m_image==pending);
    }
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
    for (NSUInteger kind=0;kind<5;kind++) for (NSUInteger outgoing=0;outgoing<2;outgoing++) for (NSUInteger dark=0;dark<2;dark++) {
        TextMessageViewModel *themed=kind==4 ? [VoIPSignalMessageViewModel new] : (kind==3 ? [VoIPBubbleMessageViewModel new] : (kind==2 ? [VoiceMessageViewModel new] : [TextMessageViewModel new]));
        themed.messageWrap=[BubbleWrap new];themed.bgBubbleInfo=kind>=3 ? nil : [BubbleInfo new];themed.isSender=outgoing;
        themed.messageWrap.m_uiMessageType=kind>=3 ? (kind==3 ? 50 : 64) : (kind==2 ? 34 : (kind==1 ? 49 : 1));themed.messageWrap.m_uiAppMsgInnerType=kind==1 ? 57 : 0;
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
    // A join change with the same model/native images must replace the cached
    // template immediately. A repeated layout with unchanged joins is a no-op.
    palettes[CSBubbleStyleKindKey]=@(CSBubbleStyleStacked);
    [NSUserDefaults.standardUserDefaults setVolatileDomain:palettes forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
    model.bgBubbleInfo.position=0;cell.viewModel=model;cell.background.frame=CGRectMake(0,0,180,38);
    cell.background.image=baseline;cell.background.highlightedImage=nativeHighlight;
    testAppearance=(CSMessageMergeDecision){NO,NO,NO};CSBubbleStyleApply(cell);
    id single=cell.background->m_image;
    CGRect originalFrame=cell.background.frame;
    testAppearance=(CSMessageMergeDecision){NO,YES,NO};CSBubbleStyleApply(cell);
    id first=cell.background->m_image;CHECK(first!=single);
    NSUInteger assignments=cell.background.assignments;scans=CSBubbleNativePaddingScanCount;
    for (NSUInteger i=0;i<30;i++) CSBubbleStyleApply(cell);
    CHECK(cell.background.assignments==assignments);CHECK(CSBubbleNativePaddingScanCount==scans);
    testAppearance=(CSMessageMergeDecision){YES,YES,YES};
    // The native image-setter fast path must notice a stale group shape too.
    cell.background.image=baseline;Drain();id middle=cell.background->m_image;CHECK(middle!=first);
    testAppearance=(CSMessageMergeDecision){YES,NO,YES};CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=middle);
    testAppearance=(CSMessageMergeDecision){NO,NO,NO};CSBubbleStyleApply(cell);CHECK(((YYImage *)cell.background->m_image).originImage==((YYImage *)single).originImage);
    CHECK(CGRectEqualToRect(cell.background.frame,originalFrame));
    // Removing the decorative strip allows a narrow but valid bubble to render.
    cell.background.frame=CGRectMake(0,0,16,38);CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=baseline);
    cell.background.frame=CGRectMake(0,0,8,38);CSBubbleStyleApply(cell);CHECK(cell.background->m_image==baseline);
    cell.background.frame=originalFrame;CSBubbleStyleApply(cell);CHECK(cell.background->m_image!=baseline);
    CSBubbleStyleDetach(cell);CHECK(cell.background->m_image==baseline && cell.background->m_highlightedImage==nativeHighlight);
    palettes[CSBubbleStyleKindKey]=@(CSBubbleStyleRounded);
    [NSUserDefaults.standardUserDefaults setVolatileDomain:palettes forName:NSArgumentDomain];
    [NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];Drain();
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
    CHECK(VerifyTextColors()==0);
    CHECK(VerifyNativeDisplayReadiness()==0);
    [NSUserDefaults.standardUserDefaults setVolatileDomain:saved forName:NSArgumentDomain];
    fprintf(stdout,"Bubble real-adapter lifecycle: %lu checks passed\n",(unsigned long)checks);
} return 0; }
