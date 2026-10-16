#import "CSBubbleStyleAdapter.h"
#import "CSBubbleStylePolicy.h"
#import "CSChatNativeBridge.h"
#import "CSChatDiagnostics.h"
#import <objc/runtime.h>
#import <objc/message.h>
#include <math.h>

static char CSBubbleCellKey, CSBubbleImageKey;
static CSBubbleStyleConfiguration *CSStyle;
static NSCache *CSImages;
static NSHashTable<UIView *> *CSCells;
static BOOL CSReloadQueued;

@interface CSBubbleBinding : NSObject
@property(nonatomic, weak) UIView *cell;
@property(nonatomic, weak) id model;
@property(nonatomic, weak) UIImageView *background;
@property(nonatomic, strong) CSBubbleImageOwnership *images;
@property(nonatomic, copy) NSString *key;
@property(nonatomic, copy) NSString *lastFailure;
@property(nonatomic) BOOL applying;
@property(nonatomic) BOOL applyQueued;
@property(nonatomic) BOOL outgoing;
@property(nonatomic) BOOL supported;
@property(nonatomic) NSUInteger position;
@property(nonatomic) BOOL descriptorValid;
@property(nonatomic) NSUInteger appliedGeneration;
@property(nonatomic) BOOL appliedDark;
@end
@implementation CSBubbleBinding @end

static BOOL CSUnsigned(id object, NSString *name, unsigned long long *result) {
    SEL sel=NSSelectorFromString(name); Method method=class_getInstanceMethod([object class],sel);
    if (!method || method_getNumberOfArguments(method)!=2) return NO;
    char type[32]={0}; method_getReturnType(method,type,sizeof(type));
    @try {
        switch (type[0]) {
            case 'B': if (result) *result=((BOOL(*)(id,SEL))objc_msgSend)(object,sel); return YES;
            case 'c': if (result) *result=((char(*)(id,SEL))objc_msgSend)(object,sel); return YES;
            case 'C': if (result) *result=((unsigned char(*)(id,SEL))objc_msgSend)(object,sel); return YES;
            case 'I': if (result) *result=((unsigned int(*)(id,SEL))objc_msgSend)(object,sel); return YES;
            case 'Q': if (result) *result=((unsigned long long(*)(id,SEL))objc_msgSend)(object,sel); return YES;
            default: return NO;
        }
    } @catch (__unused NSException *exception) { return NO; }
}
static BOOL CSIsAsync(UIImageView *view) {
    Class cls=NSClassFromString(@"YYAsyncImageView"); return cls && [view isKindOfClass:cls];
}
static id CSCurrentImage(UIImageView *view, BOOL highlighted) {
    // YYAsyncImageView stores YYImage in its own slots, not necessarily UIImageView.image.
    if (CSIsAsync(view)) {
        Ivar slot=class_getInstanceVariable(view.class, highlighted?"m_highlightedImage":"m_image");
        if (slot && ivar_getTypeEncoding(slot)[0]=='@') return object_getIvar(view,slot);
    }
    return highlighted?view.highlightedImage:view.image;
}
static UIImage *CSDecodedImage(id image, BOOL dark) {
    id origin=CSMessageNativeObject(image,@"originImage");
    if ([origin isKindOfClass:UIImage.class] && [origin CGImage]) return origin;
    if ([image isKindOfClass:UIImage.class] && [image CGImage]) return image;
    // These are already-decoded results only; do not force decoding or wait on a background task.
    origin=CSMessageNativeObject(image,dark?@"decodeImageDM":@"decodeImageLM");
    if ([origin isKindOfClass:UIImage.class] && [origin CGImage]) return origin;
    origin=CSMessageNativeObject(image,dark?@"decodeImageLM":@"decodeImageDM");
    return [origin isKindOfClass:UIImage.class] && [origin CGImage] ? origin : nil;
}
static id CSImageForView(UIImageView *view, UIImage *image) {
    if (!CSIsAsync(view)) return image;
    Class cls=NSClassFromString(@"YYImage"); SEL selector=NSSelectorFromString(@"imageWithUIImage:");
    Method method=class_getClassMethod(cls,selector); char result[32]={0},arg[32]={0};
    if (!method || method_getNumberOfArguments(method)!=3) return nil;
    method_getReturnType(method,result,sizeof(result)); method_getArgumentType(method,2,arg,sizeof(arg));
    if (result[0]!='@' || arg[0]!='@') return nil;
    @try { return ((id(*)(id,SEL,id))objc_msgSend)(cls,selector,image); }
    @catch (__unused NSException *exception) { return nil; }
}
static void CSFailure(CSBubbleBinding *binding, NSString *reason) {
    if (![binding.lastFailure isEqual:reason]) { binding.lastFailure=reason; CSChatRecordEvent(@"bubble",reason); }
}
static void CSRestore(CSBubbleBinding *binding) {
    UIImageView *view=binding.background; if (!view) return;
    binding.applying=YES;
    id current=CSCurrentImage(view,NO), restored=[binding.images restoredImageForCurrent:current highlighted:NO];
    if (current!=restored) view.image=restored;
    current=CSCurrentImage(view,YES); restored=[binding.images restoredImageForCurrent:current highlighted:YES];
    if (current!=restored) view.highlightedImage=restored;
    binding.applying=NO; binding.key=nil;
    binding.images.generatedImage=nil; binding.images.generatedHighlightedImage=nil;
}
static void CSDescribe(CSBubbleBinding *binding, id model) {
    binding.descriptorValid=YES; binding.supported=NO;
    id parent=CSMessageNativeObject(model,@"parentModel"); id logical=parent?:model;
    id wrap=CSMessageNativeObject(logical,@"messageWrap");
    unsigned long long type=0,sender=0,position=0;
    if (!CSUnsigned(logical,@"isSender",&sender) || !CSUnsigned(wrap,@"m_uiMessageType",&type)) { CSFailure(binding,@"missing_message_descriptor"); return; }
    id bubble=CSMessageNativeObject(model,@"bgBubbleInfo");
    if (!CSUnsigned(bubble,@"position",&position) || position>3) { CSFailure(binding,@"unsupported_segment_shape"); return; }
    NSString *className=NSStringFromClass([logical class]);
    unsigned long long innerType=0,isRefer=0;
    BOOL textModel=[className isEqual:@"TextMessageViewModel"];
    BOOL quotedText=textModel && type==49 &&
        ((CSUnsigned(wrap,@"m_uiAppMsgInnerType",&innerType) && innerType==57) ||
         (CSUnsigned(wrap,@"isReferMsgType",&isRefer) && isRefer));
    BOOL ordinary=(textModel && (type==1 || quotedText)) || (type==34 && [className isEqual:@"VoiceMessageViewModel"]);
    if (!ordinary) { CSFailure(binding,@"unsupported_message_kind"); return; }
    binding.outgoing=sender!=0; binding.position=(NSUInteger)position; binding.supported=YES;
}
static BOOL CSDark(UIView *cell) {
    // The private isUseLightStyle flag is not UIKit's appearance contract. Inverting
    // it can select dark colors on a light chat. Honor the effective view appearance,
    // including WeChat's per-window override, before falling back for unattached cells.
    UIUserInterfaceStyle style=cell.traitCollection.userInterfaceStyle;
    if (style==UIUserInterfaceStyleUnspecified) style=cell.window.traitCollection.userInterfaceStyle;
    if (style==UIUserInterfaceStyleUnspecified) style=UITraitCollection.currentTraitCollection.userInterfaceStyle;
    return style==UIUserInterfaceStyleDark;
}
static UIImage *CSTemplate(CSBubbleBinding *binding, UIImage *native, BOOL dark, BOOL highlighted) {
    if (!native || native.imageOrientation!=UIImageOrientationUp || native.images.count) return nil;
    CGFloat scale=native.scale;
    CSBubbleInsets padding;
    if (!CSBubbleNativeBodyPadding(native.CGImage,scale,&padding)) return nil;
    CGFloat radius=CSBubbleFittedRadius(CSStyle.radius,binding.position,scale,padding,binding.background.frame.size);
    if (radius<1) return nil;
    NSString *key=[NSString stringWithFormat:@"%lu/%d/%d/%lu/%.4f/%.4f/%.4f/%.4f/%.4f/%d/%ld/%.4f",(unsigned long)CSStyle.generation,
        binding.outgoing,dark,(unsigned long)binding.position,scale,padding.top,padding.left,padding.bottom,padding.right,highlighted,(long)native.resizingMode,radius];
    UIImage *image=[CSImages objectForKey:key];
    if (image) return image;
    CGImageRef cg=CSBubbleCreateTemplate([CSStyle colorForOutgoing:binding.outgoing dark:dark],radius,binding.position,scale,padding,highlighted);
    if (!cg) return nil;
    CSBubbleTemplateMetrics metrics; CSBubbleTemplateDescribe(radius,binding.position,scale,padding,&metrics);
    image=[UIImage imageWithCGImage:cg scale:scale orientation:UIImageOrientationUp];
    image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(metrics.caps.top,metrics.caps.left,metrics.caps.bottom,metrics.caps.right) resizingMode:native.resizingMode];
    [CSImages setObject:image forKey:key cost:CGImageGetBytesPerRow(cg)*CGImageGetHeight(cg)];
    CGImageRelease(cg); return image;
}
void CSBubbleStyleDetach(UIView *cell) {
    if (!NSThread.isMainThread) return;
    CSBubbleBinding *binding=objc_getAssociatedObject(cell,&CSBubbleCellKey);
    if (!binding) return;
    CSRestore(binding);
    if (objc_getAssociatedObject(binding.background,&CSBubbleImageKey)==binding) objc_setAssociatedObject(binding.background,&CSBubbleImageKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell,&CSBubbleCellKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [CSCells removeObject:cell];
}
void CSBubbleStyleApply(UIView *cell) {
    if (!NSThread.isMainThread || !cell) return;
    [CSCells addObject:cell];
    CSBubbleBinding *binding=objc_getAssociatedObject(cell,&CSBubbleCellKey);
    if (!CSStyle.enabled) { if (binding) CSRestore(binding); return; }
    id model=CSMessageNativeObject(cell,@"viewModel");
    id bg=CSMessageNativeObject(cell,@"getBgImageView");
    if (![bg isKindOfClass:UIImageView.class] || !model) { if (binding) CSBubbleStyleDetach(cell); return; }
    if (!binding || binding.model!=model || binding.background!=bg) {
        CSBubbleStyleDetach(cell);
        binding=[CSBubbleBinding new]; binding.cell=cell; binding.model=model; binding.background=bg; binding.images=[CSBubbleImageOwnership new];
        objc_setAssociatedObject(cell,&CSBubbleCellKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(bg,&CSBubbleImageKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [CSCells addObject:cell];
    }
    if (binding.applying) return;
    unsigned long long currentPosition=0;
    if (binding.descriptorValid && CSUnsigned(CSMessageNativeObject(model,@"bgBubbleInfo"),@"position",&currentPosition) && currentPosition!=binding.position) {
        binding.descriptorValid=NO;binding.key=nil;
    }
    if (!binding.descriptorValid) CSDescribe(binding,model);
    if (!binding.supported) { CSRestore(binding); return; }
    id current=CSCurrentImage(bg,NO),highlighted=CSCurrentImage(bg,YES);
    [binding.images captureImage:current highlighted:NO]; [binding.images captureImage:highlighted highlighted:YES];
    BOOL dark=CSDark(cell);
    NSString *key=[NSString stringWithFormat:@"%lu/%d/%p/%p/%lu/%.4f/%.4f",(unsigned long)CSStyle.generation,dark,
        (__bridge void *)binding.images.nativeImage,(__bridge void *)binding.images.nativeHighlightedImage,(unsigned long)binding.position,
        ((UIImageView *)bg).frame.size.width,((UIImageView *)bg).frame.size.height];
    if ([binding.key isEqual:key]) return;
    UIImage *source=CSDecodedImage(binding.images.nativeImage,dark);
    UIImage *normal=CSTemplate(binding,source,dark,NO);
    id newImage=normal?CSImageForView(bg,normal):nil;
    if (!newImage) { CSRestore(binding); binding.key=key; CSFailure(binding,@"native_background_not_decoded_or_supported"); return; }
    id newHighlight=nil;
    if (binding.images.nativeHighlightedImage) {
        UIImage *highlightSource=CSDecodedImage(binding.images.nativeHighlightedImage,dark);
        UIImage *highlightImage=CSTemplate(binding,highlightSource,dark,YES);
        newHighlight=highlightImage?CSImageForView(bg,highlightImage):nil;
        if (!newHighlight) { CSRestore(binding); binding.key=key; CSFailure(binding,@"native_highlight_not_supported"); return; }
    }
    binding.images.generatedImage=newImage; binding.images.generatedHighlightedImage=newHighlight;
    binding.applying=YES;
    [UIView performWithoutAnimation:^{ ((UIImageView *)bg).image=newImage; if (newHighlight) ((UIImageView *)bg).highlightedImage=newHighlight; }];
    // Some YY implementations wrap/copy assigned UIImage objects. Own the stored results,
    // not just the arguments, so disable/reuse still restores the correct native baseline.
    binding.images.generatedImage=CSCurrentImage(bg,NO);
    if (newHighlight) binding.images.generatedHighlightedImage=CSCurrentImage(bg,YES);
    binding.applying=NO; binding.key=key; binding.appliedGeneration=CSStyle.generation; binding.appliedDark=dark;
    if (![binding.lastFailure isEqual:@"applied"]) { binding.lastFailure=@"applied"; CSChatRecordEvent(@"bubble",@"applied"); }
}
void CSBubbleStyleNativeChanged(UIView *cell) {
    if (!NSThread.isMainThread) return;
    CSBubbleBinding *binding=objc_getAssociatedObject(cell,&CSBubbleCellKey);
    binding.descriptorValid=NO; binding.key=nil;
    CSBubbleStyleApply(cell);
}
id CSBubbleStyleImageAssignment(UIImageView *view, id nativeImage, BOOL highlighted) {
    if (!NSThread.isMainThread) return nativeImage;
    CSBubbleBinding *binding=objc_getAssociatedObject(view,&CSBubbleImageKey);
    if (!binding || binding.applying || !binding.cell) return nativeImage;
    id baseline=highlighted?binding.images.nativeHighlightedImage:binding.images.nativeImage;
    id generated=highlighted?binding.images.generatedHighlightedImage:binding.images.generatedImage;
    // Native layout often reassigns the same cached object. Keep the owned template without
    // decoding pixels or scheduling another turn when its descriptor is still current.
    if (CSStyle.enabled && binding.key && generated && nativeImage==baseline &&
        binding.appliedGeneration==CSStyle.generation && binding.appliedDark==CSDark(binding.cell)) return generated;
    [binding.images captureImage:nativeImage highlighted:highlighted]; binding.key=nil;
    if (binding.applyQueued) return nativeImage;
    binding.applyQueued=YES;
    // Apply after the native setter completes, coalesced per binding, never scanning unrelated views.
    __weak UIView *cell=binding.cell;
    __weak CSBubbleBinding *expected=binding;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *live=cell; CSBubbleBinding *current=expected;
        current.applyQueued=NO;
        if (live && current && objc_getAssociatedObject(live,&CSBubbleCellKey)==current) CSBubbleStyleApply(live);
    });
    return nativeImage;
}
static void CSReload(void) {
    if (CSReloadQueued) return; CSReloadQueued=YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        CSReloadQueued=NO;
        CSBubbleStyleConfiguration *next=[[CSBubbleStyleConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults generation:CSStyle.generation+1];
        if ([next.values isEqual:CSStyle.values]) return;
        CSStyle=next; [CSImages removeAllObjects]; CSChatRecordEvent(@"bubble",@"configuration_changed");
        for (UIView *cell in CSCells.allObjects) CSBubbleStyleApply(cell);
    });
}
static void CSSettingsNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    dispatch_async(dispatch_get_main_queue(), ^{ CSReload(); });
}
void CSBubbleStyleStart(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSStyle=[[CSBubbleStyleConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults generation:1];
        CSImages=[NSCache new]; CSImages.countLimit=128; CSImages.totalCostLimit=8*1024*1024;
        CSCells=[NSHashTable weakObjectsHashTable];
        [NSNotificationCenter.defaultCenter addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) { CSReload(); }];
        [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) { [CSImages removeAllObjects]; }];
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,CSSettingsNotification,CFSTR("com.wechat.enhance.bubble_style.settings_changed"),NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
    });
}

void CSBubbleStyleImageDecoded(UIImageView *view) {
    if (!NSThread.isMainThread) return;
    CSBubbleBinding *binding=objc_getAssociatedObject(view,&CSBubbleImageKey);
    if (binding && !binding.applying) { binding.key=nil; CSBubbleStyleApply(binding.cell); }
}
