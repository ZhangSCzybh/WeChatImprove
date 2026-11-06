#import "CSPreferenceRefresh.h"
#import "CSBubbleStyleAdapter.h"
#import "CSBubbleStylePolicy.h"
#import "CSBubbleTextColors.h"
#import "CSMessageMergeAdapter.h"
#import "CSChatNativeBridge.h"
#import <objc/runtime.h>
#import <objc/message.h>
#include <math.h>

static char CSBubbleCellKey, CSBubbleImageKey, CSBubbleReadyImageKey, CSBubbleObservedImageKey;
static CSBubbleStyleConfiguration *CSStyle;
static NSCache *CSImages;
static NSCache *CSBodyMetrics;
static NSHashTable<UIView *> *CSCells;
static atomic_bool CSReloadQueued;
static UIColor *CSTextColors[4];
static void CSLoadTextColors(void) {
    for (NSUInteger i=0;i<4;i++) {
        CSBubbleRGBA color;
        CSTextColors[i]=[CSStyle textColorForOutgoing:i%2==0 dark:i>=2 color:&color] ?
            [UIColor colorWithRed:color.red green:color.green blue:color.blue alpha:1] : nil;
    }
}

@interface CSBubbleBinding : NSObject
@property(nonatomic, weak) UIView *cell;
@property(nonatomic, weak) id model;
@property(nonatomic, weak) UIImageView *background;
@property(nonatomic, strong) CSBubbleImageOwnership *images;
@property(nonatomic, strong) UIImage *source, *highlightSource;
@property(nonatomic, copy) NSString *key;
@property(nonatomic, copy) NSString *modelSourceKey;
@property(nonatomic, strong) UIImage *modelSource, *modelHighlightSource;
@property(nonatomic) BOOL applying;
@property(nonatomic) BOOL applyQueued;
@property(nonatomic) BOOL outgoing;
@property(nonatomic) BOOL supported;
@property(nonatomic) BOOL callRecord;
@property(nonatomic) NSUInteger position;
@property(nonatomic) CSBubbleGroupPosition group;
@property(nonatomic) BOOL descriptorValid;
@property(nonatomic, weak) id describedWrap;
@property(nonatomic) unsigned long long describedType, describedInnerType, describedRefer;
@property(nonatomic) NSUInteger appliedGeneration;
@property(nonatomic) BOOL appliedDark;
@end
@implementation CSBubbleBinding @end

@interface CSBubbleDecodedImages : NSObject
@property(nonatomic,strong) UIImage *light, *dark;
@end
@implementation CSBubbleDecodedImages @end
@interface CSBubbleDecodeCapture : NSObject
@property(nonatomic,strong) id normal, highlighted;
@property(nonatomic,strong) UIImage *normalPixels, *highlightedPixels;
@end
@implementation CSBubbleDecodeCapture @end
// A synchronous native decoder call belongs to exactly the enclosing display task.
// No global image registry or cross-thread access to a mutable native image cache.
static _Thread_local void *CSActiveDecodeCapture;

@interface CSBubbleBodyMetrics : NSObject
@property(nonatomic) CSBubbleInsets padding;
@property(nonatomic) BOOL valid;
- (instancetype)initWithImage:(CGImageRef)image scale:(CGFloat)scale;
@end
@implementation CSBubbleBodyMetrics {
    CGImageRef _image;
}
- (instancetype)initWithImage:(CGImageRef)image scale:(CGFloat)scale {
    if ((self=[super init])) {
        // Keep the immutable CGImage alive: an evicted/reused pointer must never hit stale metrics.
        _image=CGImageRetain(image);
        _valid=CSBubbleNativeBodyPadding(image,scale,&_padding);
    }
    return self;
}
- (void)dealloc { if (_image) CGImageRelease(_image); }
@end

static BOOL CSBodyPadding(UIImage *native, CSBubbleInsets *padding) {
    CGImageRef image=native.CGImage;
    if (!image || !isfinite(native.scale) || native.scale<1 || native.scale>4) return NO;
    NSString *key=[NSString stringWithFormat:@"%p/%.17g",image,(double)native.scale];
    CSBubbleBodyMetrics *metrics=[CSBodyMetrics objectForKey:key];
    if (!metrics) {
        metrics=[[CSBubbleBodyMetrics alloc] initWithImage:image scale:native.scale];
        size_t width=CGImageGetWidth(image),height=CGImageGetHeight(image);
        // Oversized/unsupported sources stay native, without retaining large images in this cache.
        if (width && height && width<=512 && height<=512)
            [CSBodyMetrics setObject:metrics forKey:key cost:CGImageGetBytesPerRow(image)*height];
    }
    if (metrics.valid) *padding=metrics.padding;
    return metrics.valid;
}

static char CSUnsignedABIKey;
static BOOL CSUnsigned(id object, NSString *name, unsigned long long *result) {
    Class cls=object_getClass(object);
    if (!cls) return NO;
    SEL sel=NSSelectorFromString(name);
    // Main-thread owned, per actual runtime class. Cache only a supported ABI,
    // never a native value or IMP: later hooks and in-place model updates remain visible.
    NSMutableDictionary *abis=objc_getAssociatedObject(cls,&CSUnsignedABIKey);
    NSNumber *cached=abis[name];
    char type=cached.charValue;
    if (!cached) {
        Method method=class_getInstanceMethod(cls,sel);
        if (!method || method_getNumberOfArguments(method)!=2) return NO;
        char encoding[32]={0}; method_getReturnType(method,encoding,sizeof(encoding));
        type=encoding[0];
        if (type!='B' && type!='c' && type!='C' && type!='I' && type!='Q') return NO;
        if (!abis) {
            abis=[NSMutableDictionary dictionary];
            objc_setAssociatedObject(cls,&CSUnsignedABIKey,abis,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        abis[name]=@(type);
    }
    @try {
        switch (type) {
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
static UIImage *CSReadyUIImage(id image, Class wrapperClass) {
    // YYImage's getters can enter the lazy decoder. Even a nested YYImage must
    // never reach CGImage here; wait for native display to publish decoded pixels.
    if (![image isKindOfClass:UIImage.class] || (wrapperClass && [image isKindOfClass:wrapperClass])) return nil;
    return [image CGImage] ? image : nil;
}
static void CSPublishDecodedImage(id source, UIImage *decoded, BOOL dark) {
    if (!NSThread.isMainThread || !source) return;
    UIImage *ready=CSReadyUIImage(decoded,NSClassFromString(@"YYImage"));
    CSBubbleDecodedImages *pixels=objc_getAssociatedObject(source,&CSBubbleObservedImageKey);
    if (!pixels && ready) {
        pixels=[CSBubbleDecodedImages new];
        objc_setAssociatedObject(source,&CSBubbleObservedImageKey,pixels,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (dark) pixels.dark=ready; else pixels.light=ready;
}
#ifdef CS_BUBBLE_TESTING
void CSBubbleStyleTestPublishDecodedImage(id source, UIImage *decoded, BOOL dark) { CSPublishDecodedImage(source,decoded,dark); }
#endif
void CSBubbleStyleObserveDecodedImage(id source, UIImage *decoded) {
    if (!CSActiveDecodeCapture) return;
    CSBubbleDecodeCapture *capture=(__bridge id)CSActiveDecodeCapture;
    if (source!=capture.normal && source!=capture.highlighted) return;
    UIImage *ready=CSReadyUIImage(decoded,NSClassFromString(@"YYImage"));
    if (source==capture.normal) capture.normalPixels=ready;
    if (source==capture.highlighted) capture.highlightedPixels=ready;
}
static UIImage *CSDecodedImage(id image, BOOL dark) {
    Class wrapperClass=NSClassFromString(@"YYImage");
    if (!wrapperClass || ![image isKindOfClass:wrapperClass]) return CSReadyUIImage(image,wrapperClass);
    // Our own templates are already decoded before being wrapped by YYImage's
    // lazy factory. Keep their known pixels available to layout immediately.
    UIImage *owned=objc_getAssociatedObject(image,&CSBubbleReadyImageKey);
    if (owned) return owned;
    // Native decode slots are nonatomic and can change on a worker thread.
    // Reading an object ivar and retaining it are not one atomic operation:
    // the 1.8-33 crash occurred in that retain. Keep only owned snapshots of
    // results returned by native display, published and consumed on the main thread.
    CSBubbleDecodedImages *pixels=objc_getAssociatedObject(image,&CSBubbleObservedImageKey);
    return dark ? pixels.dark : pixels.light;
}
static id CSImageForView(UIImageView *view, UIImage *image) {
    if (!CSIsAsync(view)) return image;
    Class cls=NSClassFromString(@"YYImage"); SEL selector=NSSelectorFromString(@"imageWithUIImage:");
    Method method=class_getClassMethod(cls,selector); char result[32]={0},arg[32]={0};
    if (!method || method_getNumberOfArguments(method)!=3) return nil;
    method_getReturnType(method,result,sizeof(result)); method_getArgumentType(method,2,arg,sizeof(arg));
    if (result[0]!='@' || arg[0]!='@') return nil;
    @try {
        id wrapped=((id(*)(id,SEL,id))objc_msgSend)(cls,selector,image);
        if (wrapped && [wrapped isKindOfClass:cls])
            objc_setAssociatedObject(wrapped,&CSBubbleReadyImageKey,image,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return wrapped;
    }
    @catch (__unused NSException *exception) { return nil; }
}
BOOL CSBubbleStyleVisibleInsets(UIView *background, UIEdgeInsets *insets) {
    if (!NSThread.isMainThread || ![background isKindOfClass:UIImageView.class] || !insets ||
        background.contentMode!=UIViewContentModeScaleToFill) return NO;
    CSBubbleStyleStart();
    UIEdgeInsets result={0,0,0,0};
    for (NSUInteger slot=0;slot<2;slot++) {
        id source=CSCurrentImage((UIImageView *)background,slot!=0);
        if (slot && !source) continue;
        UIImage *image=CSDecodedImage(source,CSBubbleStyleIsDark(background));
        // Only upright stretchable templates preserve transparent margins in points.
        // Protect the union of normal/highlighted pixels, including native highlights.
        // The destination may collapse the stretchable center to zero while the
        // fixed caps stay intact (8.0.78: top 30 + bottom 8 == a 38pt short bubble).
        // A center pixel is required in the source template, not in the destination.
        if (!image || image.images.count || image.imageOrientation!=UIImageOrientationUp ||
            (image.capInsets.top<=0 && image.capInsets.bottom<=0) ||
            background.frame.size.height<image.capInsets.top+image.capInsets.bottom ||
            background.frame.size.width<image.capInsets.left+image.capInsets.right) return NO;
        CSBubbleInsets padding;
        if (!CSBodyPadding(image,&padding)) return NO;
        if (!slot) result=UIEdgeInsetsMake(padding.top,padding.left,padding.bottom,padding.right);
        else result=UIEdgeInsetsMake(MIN(result.top,padding.top),MIN(result.left,padding.left),
                                    MIN(result.bottom,padding.bottom),MIN(result.right,padding.right));
    }
    *insets=result;return YES;
}

static void CSRestore(CSBubbleBinding *binding) {
    CSBubbleTextColorsRestore(binding.cell);
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
    // Missing metadata is transient, not a permanently unsupported message.
    binding.descriptorValid=NO; binding.supported=NO;
    id parent=CSMessageNativeObject(model,@"parentModel"); id logical=parent?:model;
    id wrap=CSMessageNativeObject(logical,@"messageWrap");
    unsigned long long type=0,sender=0,position=0;
    if (!CSUnsigned(logical,@"isSender",&sender) || !CSUnsigned(wrap,@"m_uiMessageType",&type)) { return; }
    NSString *className=NSStringFromClass([logical class]);
    BOOL callRecord=[className isEqual:@"VoIPBubbleMessageViewModel"] || [className isEqual:@"VoIPSignalMessageViewModel"];
    id bubble=CSMessageNativeObject(model,@"bgBubbleInfo");
    // Independent call records need no text-segment metadata. If present, still
    // validate it; never treat an unknown text segment as a complete message.
    if ((!CSUnsigned(bubble,@"position",&position) && !callRecord) || position>3) return;
    binding.descriptorValid=YES;
    unsigned long long innerType=0,isRefer=0;
    CSUnsigned(wrap,@"m_uiAppMsgInnerType",&innerType);CSUnsigned(wrap,@"isReferMsgType",&isRefer);
    binding.describedWrap=wrap;binding.describedType=type;
    binding.describedInnerType=innerType;binding.describedRefer=isRefer;
    binding.outgoing=sender!=0;binding.position=(NSUInteger)position;
    BOOL textModel=[className isEqual:@"TextMessageViewModel"];
    BOOL quotedText=textModel && type==49 &&
        ((CSUnsigned(wrap,@"m_uiAppMsgInnerType",&innerType) && innerType==57) ||
         (CSUnsigned(wrap,@"isReferMsgType",&isRefer) && isRefer));
    BOOL ordinary=(textModel && (type==1 || quotedText)) || (type==34 && [className isEqual:@"VoiceMessageViewModel"]);
    // Both native call-record variants expose voice/video status and the same
    // background contract. Exact classes and a real background are required;
    // message type numbers alone also identify signaling/system content.
    if (!ordinary && !callRecord) { return; }
    binding.outgoing=sender!=0; binding.position=(NSUInteger)position; binding.supported=YES;binding.callRecord=callRecord;
}
BOOL CSBubbleStyleIsDark(UIView *cell) {
    // The private isUseLightStyle flag is not UIKit's appearance contract. Inverting
    // it can select dark colors on a light chat. Honor the effective view appearance,
    // including WeChat's per-window override, before falling back for unattached cells.
    UIUserInterfaceStyle style=cell.traitCollection.userInterfaceStyle;
    if (style==UIUserInterfaceStyleUnspecified) style=cell.window.traitCollection.userInterfaceStyle;
    if (style==UIUserInterfaceStyleUnspecified) style=UITraitCollection.currentTraitCollection.userInterfaceStyle;
    return style==UIUserInterfaceStyleDark;
}
static BOOL CSModelTemplates(id model, BOOL dark, UIImage **normal, UIImage **pressed) {
    if (!NSThread.isMainThread) return NO;
    *normal=nil;*pressed=nil;
#ifndef CS_BUBBLE_TESTING
    NSString *version=NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
    if (![version isEqual:@"8.0.78"] && ![version hasPrefix:@"8.0.78."] &&
        ![version isEqual:@"8.0.80"] && ![version hasPrefix:@"8.0.80."]) return NO;
#endif
    id info=CSMessageNativeObject(model,@"bgBubbleInfo");
    if (![NSStringFromClass([info class]) isEqual:@"BubbleInfo"]) return NO;
    SEL sel=NSSelectorFromString(@"getBubbleImage:isDarkMode:useCache:");
    Method method=class_getInstanceMethod([info class],sel);
    if (!method || method_getNumberOfArguments(method)!=5) return NO;
    char type[32]={0};method_getReturnType(method,type,sizeof(type));
    if (type[0]!='@') return NO;
    for (unsigned int i=2;i<5;i++) {
        method_getArgumentType(method,i,type,sizeof(type));
        if (strcmp(type,@encode(BOOL))) return NO;
    }
    @try {
        for (NSUInteger slot=0;slot<2;slot++) {
            // Verified 8.0.78/8.0.80 contract: returns a cached, stretchable UIImage;
            // useCache:YES avoids resolving/rasterizing a template for every row.
            id source=((id(*)(id,SEL,BOOL,BOOL,BOOL))objc_msgSend)(info,sel,slot!=0,dark,YES);
            UIImage *image=CSReadyUIImage(source,NSClassFromString(@"YYImage"));
            if (slot && !source) continue;
            if (!image) return NO;
            if (slot) *pressed=image; else *normal=image;
        }
    } @catch (__unused NSException *exception) { return NO; }
    return *normal!=nil;
}
BOOL CSBubbleStyleModelInsets(id model, UIView *appearance, CGSize size, UIEdgeInsets *insets) {
    if (!NSThread.isMainThread || !insets || !isfinite(size.height) || size.height<=0) return NO;
    CSBubbleStyleStart();
    UIImage *normal=nil,*pressed=nil;
    if (!CSModelTemplates(model,CSBubbleStyleIsDark(appearance),&normal,&pressed)) return NO;
    unsigned long long position=0;
    BOOL custom=CSStyle.enabled && CSUnsigned(CSMessageNativeObject(model,@"bgBubbleInfo"),@"position",&position) && position<=3;
    UIEdgeInsets result={0,0,0,0};
    for (NSUInteger slot=0;slot<2;slot++) {
        UIImage *image=slot ? pressed : normal;if (!image) continue;
        if (image.images.count || image.imageOrientation!=UIImageOrientationUp) return NO;
        CSBubbleInsets padding;
        if (!CSBodyPadding(image,&padding)) return NO;
        if (custom) {
            // Native short-message height follows the chosen font (the report is
            // 37pt). Our renderer fits NEW caps to that height; the source's 30+8
            // caps do not define the minimum size of the generated background.
            CGSize fitted=size;
            if (fitted.width<=0) fitted.width=2*(CSStyle.radius+2)+padding.left+padding.right+1;
            CGFloat radius=CSBubbleFittedRadius(CSStyle.radius,(NSUInteger)position,image.scale,padding,fitted);
            CSBubbleTemplateMetrics metrics;
            if (!CSBubbleStyledTemplateDescribe(radius,(NSUInteger)position,image.scale,padding,CSStyle.kind,&metrics) ||
                metrics.caps.top+metrics.caps.bottom>=size.height ||
                (size.width>0 && metrics.caps.left+metrics.caps.right>=size.width)) return NO;
        } else {
            // With native styling, undersized caps may rescale transparent margins.
            // An opaque perimeter needs no adjustment; otherwise keep the safe fallback.
            if ((image.capInsets.top<=0 && image.capInsets.bottom<=0) ||
                (size.height<image.capInsets.top+image.capInsets.bottom && (padding.top>0 || padding.bottom>0)) ||
                (size.width>0 && size.width<image.capInsets.left+image.capInsets.right && (padding.left>0 || padding.right>0))) return NO;
        }
        if (!slot) result=UIEdgeInsetsMake(padding.top,padding.left,padding.bottom,padding.right);
        else result=UIEdgeInsetsMake(MIN(result.top,padding.top),MIN(result.left,padding.left),
                                    MIN(result.bottom,padding.bottom),MIN(result.right,padding.right));
    }
    *insets=result;return YES;
}
static CSBubbleGroupPosition CSGroupPosition(id model, NSUInteger nativePosition) {
    if (CSStyle.kind!=CSBubbleStyleStacked || nativePosition!=0) return CSBubbleGroupSingle;
    CSMessageMergeDecision decision;
    if (!CSMessageMergeReadAppearance(model,&decision)) return CSBubbleGroupSingle;
    return CSBubbleGroupPositionForJoins(decision.joinsPrevious,decision.joinsNext);
}
static UIImage *CSTemplate(CSBubbleBinding *binding, UIImage *native, BOOL dark, BOOL highlighted) {
    if (!native || native.imageOrientation!=UIImageOrientationUp || native.images.count) return nil;
    CGFloat scale=native.scale;
    CSBubbleInsets padding;
    if (!CSBodyPadding(native,&padding)) return nil;
    CGFloat radius=CSBubbleFittedRadius(CSStyle.radius,binding.position,scale,padding,binding.background.frame.size);
    if (radius<1) return nil;
    CSBubbleTemplateMetrics metrics;
    if (!CSBubbleStyledTemplateDescribe(radius,binding.position,scale,padding,CSStyle.kind,&metrics) ||
        (binding.background.frame.size.width>0 && metrics.caps.left+metrics.caps.right>=binding.background.frame.size.width)) return nil;
    NSString *key=[NSString stringWithFormat:@"%lu/%d/%d/%lu/%lu/%.4f/%.4f/%.4f/%.4f/%.4f/%d/%ld/%.4f",(unsigned long)CSStyle.generation,
        binding.outgoing,dark,(unsigned long)binding.position,(unsigned long)binding.group,scale,padding.top,padding.left,padding.bottom,padding.right,highlighted,(long)native.resizingMode,radius];
    UIImage *image=[CSImages objectForKey:key];
    if (image) return image;
    CGImageRef cg=CSBubbleCreateStyledTemplate([CSStyle colorForOutgoing:binding.outgoing dark:dark],radius,binding.position,scale,padding,highlighted,CSStyle.kind,binding.group,binding.outgoing);
    if (!cg) return nil;
    image=[UIImage imageWithCGImage:cg scale:scale orientation:UIImageOrientationUp];
    image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(metrics.caps.top,metrics.caps.left,metrics.caps.bottom,metrics.caps.right) resizingMode:native.resizingMode];
    [CSImages setObject:image forKey:key cost:CGImageGetBytesPerRow(cg)*CGImageGetHeight(cg)];
    CGImageRelease(cg); return image;
}
void CSBubbleStyleDetach(UIView *cell) {
    if (!NSThread.isMainThread) return;
    CSBubbleTextColorsRestore(cell);
    CSBubbleBinding *binding=objc_getAssociatedObject(cell,&CSBubbleCellKey);
    if (!binding) return;
    CSRestore(binding);
    if (objc_getAssociatedObject(binding.background,&CSBubbleImageKey)==binding) objc_setAssociatedObject(binding.background,&CSBubbleImageKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell,&CSBubbleCellKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [CSCells removeObject:cell];
}
void CSBubbleStyleApply(UIView *cell) {
    if (!NSThread.isMainThread || ![cell isKindOfClass:UIView.class]) return;
    CSBubbleStyleStart();
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
    unsigned long long currentPosition=0,type=0,inner=0,refer=0,sender=0;
    id logical=CSMessageNativeObject(model,@"parentModel")?:model;
    id wrap=CSMessageNativeObject(logical,@"messageWrap");
    BOOL positioned=CSUnsigned(CSMessageNativeObject(model,@"bgBubbleInfo"),@"position",&currentPosition);
    BOOL typed=CSUnsigned(wrap,@"m_uiMessageType",&type),directed=CSUnsigned(logical,@"isSender",&sender);
    CSUnsigned(wrap,@"m_uiAppMsgInnerType",&inner);CSUnsigned(wrap,@"isReferMsgType",&refer);
    if (binding.descriptorValid && ((!positioned && !binding.callRecord) || !typed || !directed ||
        currentPosition!=binding.position || wrap!=binding.describedWrap || type!=binding.describedType ||
        inner!=binding.describedInnerType || refer!=binding.describedRefer || (sender!=0)!=binding.outgoing)) {
        binding.descriptorValid=NO;binding.key=nil;binding.modelSourceKey=nil;
    }
    if (!binding.descriptorValid) CSDescribe(binding,model);
    if (!binding.supported) { CSRestore(binding); return; }
    id current=CSCurrentImage(bg,NO),highlighted=CSCurrentImage(bg,YES);
    [binding.images captureImage:current highlighted:NO]; [binding.images captureImage:highlighted highlighted:YES];
    BOOL dark=CSBubbleStyleIsDark(cell);
    binding.group=CSGroupPosition(model,binding.position);
    NSString *key=[NSString stringWithFormat:@"%lu/%d/%p/%p/%lu/%lu/%.4f/%.4f",(unsigned long)CSStyle.generation,dark,
        (__bridge void *)binding.images.nativeImage,(__bridge void *)binding.images.nativeHighlightedImage,(unsigned long)binding.position,(unsigned long)binding.group,
        ((UIImageView *)bg).frame.size.width,((UIImageView *)bg).frame.size.height];
    UIColor *textColor=CSTextColors[(dark ? 2 : 0)+(binding.outgoing ? 0 : 1)];
    if (![binding.modelSourceKey isEqual:key]) {
        UIImage *normal=nil,*pressed=nil;
        CSModelTemplates(model,dark,&normal,&pressed);
        binding.modelSource=normal;binding.modelHighlightSource=pressed;binding.modelSourceKey=key;
    }
    // Use the same cached templates as first-pass geometry, before YY decoding.
    // The observed return-value path handles native layouts without this contract.
    UIImage *source=binding.modelSource ?: CSDecodedImage(binding.images.nativeImage,dark);
    UIImage *highlightSource=binding.modelHighlightSource ?: CSDecodedImage(binding.images.nativeHighlightedImage,dark);
    BOOL samePixels=binding.source==source && binding.highlightSource==highlightSource;
    // A YYImage is populated in place. Wrapper identity alone cannot cache a
    // pending/failed attempt. Retain the compared images to prevent pointer reuse.
    binding.source=source;binding.highlightSource=highlightSource;
    if ([binding.key isEqual:key] && samePixels) {
        CSBubbleTextColorsApply(cell,binding.images.generatedImage ? textColor : nil,binding.callRecord);
        return;
    }
    UIImage *normal=CSTemplate(binding,source,dark,NO);
    id newImage=normal?CSImageForView(bg,normal):nil;
    if (!newImage) {
        CSRestore(binding); binding.key=key;
        // A style enabled after native display may have no observation yet.
        // Request one native display; the cached key prevents per-layout polling.
        if (!source && binding.images.nativeImage) [bg setNeedsDisplay];
        return;
    }
    id newHighlight=nil;
    if (binding.images.nativeHighlightedImage) {
        UIImage *highlightImage=CSTemplate(binding,highlightSource,dark,YES);
        newHighlight=highlightImage?CSImageForView(bg,highlightImage):nil;
        // Native display normally decodes only the active state. A dormant or
        // unsupported pressed image must not block the ready normal background.
    }
    binding.images.generatedImage=newImage; binding.images.generatedHighlightedImage=newHighlight;
    binding.applying=YES;
    [UIView performWithoutAnimation:^{
        ((UIImageView *)bg).image=newImage;
        id targetHighlight=newHighlight?:binding.images.nativeHighlightedImage;
        if (CSCurrentImage(bg,YES)!=targetHighlight) ((UIImageView *)bg).highlightedImage=targetHighlight;
    }];
    // Some YY implementations wrap/copy assigned UIImage objects. Own the stored results,
    // not just the arguments, so disable/reuse still restores the correct native baseline.
    binding.images.generatedImage=CSCurrentImage(bg,NO);
    if (newHighlight) binding.images.generatedHighlightedImage=CSCurrentImage(bg,YES);
    binding.applying=NO; binding.key=key; binding.appliedGeneration=CSStyle.generation; binding.appliedDark=dark;
    CSBubbleTextColorsApply(cell,textColor,binding.callRecord);
}
void CSBubbleStyleNativeChanged(UIView *cell) {
    if (!NSThread.isMainThread) return;
    CSBubbleBinding *binding=objc_getAssociatedObject(cell,&CSBubbleCellKey);
    binding.descriptorValid=NO; binding.key=nil;binding.modelSourceKey=nil;
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
        binding.appliedGeneration==CSStyle.generation && binding.appliedDark==CSBubbleStyleIsDark(binding.cell) &&
        binding.group==CSGroupPosition(binding.model,binding.position)) return generated;
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
    CSRequestMainRefresh(&CSReloadQueued, ^{
        CSBubbleStyleConfiguration *next=[[CSBubbleStyleConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults generation:CSStyle.generation+1];
        if ([next.values isEqual:CSStyle.values]) return;
        BOOL backgroundChanged=![next.backgroundValues isEqual:CSStyle.backgroundValues];
        if (!backgroundChanged) next=[[CSBubbleStyleConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults generation:CSStyle.generation];
        CSStyle=next;CSLoadTextColors();
        if (backgroundChanged) [CSImages removeAllObjects];
        for (UIView *cell in CSCells.allObjects) CSBubbleStyleApply(cell);
    });
}
static void CSSettingsNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    CSReload();
}
void CSBubbleStyleStart(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        CSStyle=[[CSBubbleStyleConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults generation:1];
        CSLoadTextColors();
        CSImages=[NSCache new]; CSImages.countLimit=128; CSImages.totalCostLimit=8*1024*1024;
        CSBodyMetrics=[NSCache new]; CSBodyMetrics.countLimit=128; CSBodyMetrics.totalCostLimit=4*1024*1024;
        CSCells=[NSHashTable weakObjectsHashTable];
        [NSNotificationCenter.defaultCenter addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note) { CSReload(); }];
        [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note) { [CSImages removeAllObjects]; [CSBodyMetrics removeAllObjects]; }];
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,CSSettingsNotification,CFSTR("com.wechat.enhance.bubble_style.settings_changed"),NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
    });
}

// Verified 8.0.78 display-task ABI: UIImage *(CGSize, BOOL (^)(void)). The native
// block does the decoding. We only observe its completion, outside the decoder,
// and retry on main after validating the cell, model, background and image pair.
typedef UIImage *(^CSBubbleDisplayContents)(CGSize, BOOL (^)(void));
void CSBubbleStyleObserveDisplayTask(UIImageView *view, id task) {
    if (!NSThread.isMainThread || !CSStyle.enabled) return;
    CSBubbleBinding *binding=objc_getAssociatedObject(view,&CSBubbleImageKey);
    if (!binding || !binding.supported || binding.applying || !binding.cell ||
        (binding.images.generatedImage && (!binding.images.nativeHighlightedImage || binding.images.generatedHighlightedImage))) return;
    Class taskClass=NSClassFromString(@"YYAsyncLayerDisplayTask");
    if (!taskClass || ![task isKindOfClass:taskClass]) return;
    SEL getter=NSSelectorFromString(@"displayContentsForLayer"),setter=NSSelectorFromString(@"setDisplayContentsForLayer:");
    Method get=class_getInstanceMethod(object_getClass(task),getter),set=class_getInstanceMethod(object_getClass(task),setter);
    if (!get || !set || method_getNumberOfArguments(get)!=2 || method_getNumberOfArguments(set)!=3) return;
    char result[32]={0},argument[32]={0},setterResult[32]={0};
    method_getReturnType(get,result,sizeof(result));method_getArgumentType(set,2,argument,sizeof(argument));
    method_getReturnType(set,setterResult,sizeof(setterResult));
    if (strcmp(result,"@?") || strcmp(argument,"@?") || setterResult[0]!='v') return;
    CSBubbleDisplayContents original=((id(*)(id,SEL))objc_msgSend)(task,getter);
    if (!original) return;
    __weak CSBubbleBinding *expected=binding;
    __weak UIView *cell=binding.cell;
    __weak UIImageView *background=view;
    __weak id model=binding.model;
    id normal=binding.images.nativeImage,highlight=binding.images.nativeHighlightedImage;
    BOOL dark=CSBubbleStyleIsDark(binding.cell);
    NSUInteger generation=CSStyle.generation;
    CSBubbleDisplayContents observed=^UIImage *(CGSize size, BOOL (^cancelled)(void)) {
        CSBubbleDecodeCapture *capture=[CSBubbleDecodeCapture new];capture.normal=normal;capture.highlighted=highlight;
        void *previous=CSActiveDecodeCapture;CSActiveDecodeCapture=(__bridge void *)capture;
        UIImage *image;
        @try { image=original(size,cancelled); }
        @finally { CSActiveDecodeCapture=previous; }
        if (!image || (cancelled && cancelled())) return image;
        if (!capture.normalPixels && !capture.highlightedPixels) return image;
        // No UIKit access or binding mutation on the native decoding thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            CSBubbleBinding *live=expected;UIView *liveCell=cell;UIImageView *liveView=background;
            if (!live || !liveCell || !liveView || !model || !CSStyle.enabled ||
                CSStyle.generation!=generation || CSBubbleStyleIsDark(liveCell)!=dark ||
                objc_getAssociatedObject(liveCell,&CSBubbleCellKey)!=live ||
                objc_getAssociatedObject(liveView,&CSBubbleImageKey)!=live ||
                live.model!=model || CSMessageNativeObject(liveCell,@"viewModel")!=model ||
                live.images.nativeImage!=normal || live.images.nativeHighlightedImage!=highlight) return;
            if (capture.normalPixels) CSPublishDecodedImage(normal,capture.normalPixels,dark);
            if (capture.highlightedPixels) CSPublishDecodedImage(highlight,capture.highlightedPixels,dark);
            CSBubbleStyleApply(liveCell);
        });
        return image;
    };
    ((void(*)(id,SEL,id))objc_msgSend)(task,setter,observed);
}
