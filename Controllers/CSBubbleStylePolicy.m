#import "CSBubbleStylePolicy.h"
#include <math.h>

static NSString *const CSPrefix = @"com.wechat.enhance.bubble_style.";
CGFloat CSBubbleReadComponent(NSUserDefaults *defaults, NSString *key, CGFloat fallback) {
    id value = [defaults objectForKey:key];
    if (![value isKindOfClass:NSNumber.class]) return fallback;
    double number = [value doubleValue];
    return isfinite(number) ? MAX(0, MIN(1, number)) : fallback;
}
@implementation CSBubbleStyleConfiguration {
    CSBubbleRGBA _colors[8];
}
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults generation:(NSUInteger)generation {
    if (!(self = [super init])) return nil;
    _generation = generation;
    _enabled = [defaults boolForKey:[CSPrefix stringByAppendingString:@"enabled"]];
    id rawRadius = [defaults objectForKey:[CSPrefix stringByAppendingString:@"corner_radius"]];
    CGFloat radius = [rawRadius isKindOfClass:NSNumber.class] ? [rawRadius doubleValue] : 16;
    _radius = isfinite(radius) ? MAX(1, MIN(30, radius)) : 16;
    NSArray *names = @[@"sender_light_color", @"receiver_light_color", @"sender_dark_color", @"receiver_dark_color",
        @"redenvelop_sender_light_color", @"redenvelop_receiver_light_color", @"redenvelop_sender_dark_color", @"redenvelop_receiver_dark_color"];
    CSBubbleRGBA fallbacks[] = {{.27,.78,.49,1}, {.95,.95,.95,1}, {.20,.60,.98,1}, {.18,.18,.18,1},
        {.91,.30,.24,1}, {.91,.30,.24,1}, {.86,.22,.10,1}, {.86,.22,.10,1}};
    NSMutableDictionary *values = [NSMutableDictionary dictionaryWithDictionary:@{@"enabled":@(_enabled), @"radius":@(_radius)}];
    for (NSUInteger i = 0; i < names.count; i++) {
        NSString *prefix = [[CSPrefix stringByAppendingString:names[i]] stringByAppendingString:@"."];
        _colors[i] = (CSBubbleRGBA){CSBubbleReadComponent(defaults,[prefix stringByAppendingString:@"red"],fallbacks[i].red),
            CSBubbleReadComponent(defaults,[prefix stringByAppendingString:@"green"],fallbacks[i].green),
            CSBubbleReadComponent(defaults,[prefix stringByAppendingString:@"blue"],fallbacks[i].blue),
            CSBubbleReadComponent(defaults,[prefix stringByAppendingString:@"alpha"],fallbacks[i].alpha)};
        values[names[i]] = @[@(_colors[i].red),@(_colors[i].green),@(_colors[i].blue),@(_colors[i].alpha)];
    }
    _values = [values copy];
    return self;
}
- (CSBubbleRGBA)colorForOutgoing:(BOOL)outgoing dark:(BOOL)dark payment:(BOOL)payment {
    return _colors[(payment ? 4 : 0) + (dark ? 2 : 0) + (outgoing ? 0 : 1)];
}
@end

CGFloat CSBubbleFittedRadius(CGFloat radius, NSUInteger position, CGFloat scale, CSBubbleInsets padding, CGSize targetSize) {
    if (!isfinite(scale) || scale<1 || scale>4 || position>3) return 0;
    if (targetSize.width<=0 || targetSize.height<=0) return radius; // Before native layout.
    if (!isfinite(targetSize.width) || !isfinite(targetSize.height)) return 0;
    CGFloat center=1/scale;
    CGFloat edge=(targetSize.width-padding.left-padding.right-center)/2;
    NSUInteger corners=position==0?2:(position==2?0:1);
    if (corners) edge=MIN(edge,(targetSize.height-padding.top-padding.bottom-center)/corners);
    else if (targetSize.height-padding.top-padding.bottom<center) return 0;
    return MIN(radius,floor(edge*scale)/scale-1);
}
BOOL CSBubbleTemplateDescribe(CGFloat radius, NSUInteger position, CGFloat scale, CSBubbleInsets padding, CSBubbleTemplateMetrics *metrics) {
    if (!isfinite(radius) || radius < 1 || radius > 30 || position > 3 || !isfinite(scale) || scale < 1 || scale > 4) return NO;
    CGFloat sides[] = {padding.top,padding.left,padding.bottom,padding.right};
    for (NSUInteger i=0;i<4;i++) if (!isfinite(sides[i]) || sides[i]<0 || sides[i]>16) return NO;
    CGFloat center = 1 / scale;
    // A full radius + antialiasing pixel is fixed on each side; exactly one stretchable center pixel.
    CGFloat edge = ceil((radius + 1) * scale) / scale;
    CSBubbleTemplateMetrics value;
    CGFloat topEdge=(position==0 || position==1)?edge:0;
    CGFloat bottomEdge=(position==0 || position==3)?edge:0;
    value.size = CGSizeMake(padding.left + edge*2 + center + padding.right,
                            padding.top + topEdge + bottomEdge + center + padding.bottom);
    value.caps = (CSBubbleInsets){padding.top+topEdge,padding.left+edge,padding.bottom+bottomEdge,padding.right+edge};
    if (ceil(value.size.width*scale)>512 || ceil(value.size.height*scale)>512) return NO;
    if (metrics) *metrics=value;
    return YES;
}
CGImageRef CSBubbleCreateTemplate(CSBubbleRGBA color, CGFloat radius, NSUInteger position, CGFloat scale, CSBubbleInsets padding, BOOL highlighted) {
    CSBubbleTemplateMetrics metrics;
    if (!CSBubbleTemplateDescribe(radius,position,scale,padding,&metrics)) return NULL;
    CGFloat components[]={color.red,color.green,color.blue,color.alpha};
    for (NSUInteger i=0;i<4;i++) if (!isfinite(components[i]) || components[i]<0 || components[i]>1) return NULL;
    size_t width=(size_t)ceil(metrics.size.width*scale), height=(size_t)ceil(metrics.size.height*scale);
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(NULL,width,height,8,width*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(space);
    if (!context) return NULL;
    CGContextScaleCTM(context,scale,scale);
    // Work in top-left coordinates, matching UIKit segment position semantics.
    CGContextTranslateCTM(context,0,metrics.size.height);
    CGContextScaleCTM(context,1,-1);
    CGFloat left=padding.left, top=padding.top, right=metrics.size.width-padding.right, bottom=metrics.size.height-padding.bottom;
    CGFloat tr=(position==0 || position==1)?radius:0, br=(position==0 || position==3)?radius:0;
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,left+tr,top);
    CGPathAddLineToPoint(path,NULL,right-tr,top);
    if (tr) CGPathAddArcToPoint(path,NULL,right,top,right,top+tr,tr);
    CGPathAddLineToPoint(path,NULL,right,bottom-br);
    if (br) CGPathAddArcToPoint(path,NULL,right,bottom,right-br,bottom,br);
    CGPathAddLineToPoint(path,NULL,left+br,bottom);
    if (br) CGPathAddArcToPoint(path,NULL,left,bottom,left,bottom-br,br);
    CGPathAddLineToPoint(path,NULL,left,top+tr);
    if (tr) CGPathAddArcToPoint(path,NULL,left,top,left+tr,top,tr);
    CGPathCloseSubpath(path);
    CGFloat factor=highlighted?.84:1;
    CGContextSetRGBFillColor(context,color.red*factor,color.green*factor,color.blue*factor,color.alpha);
    CGContextAddPath(context,path); CGContextFillPath(context);
    CGImageRef image=CGBitmapContextCreateImage(context);
    CGPathRelease(path); CGContextRelease(context);
    return image;
}
static BOOL CSNativePadding(CGImageRef image, CGFloat scale, CSBubbleInsets *padding, BOOL bodyOnly) {
    if (!image || !isfinite(scale) || scale<1 || scale>4) return NO;
    size_t w=CGImageGetWidth(image),h=CGImageGetHeight(image);
    if (!w || !h || w>512 || h>512) return NO;
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(NULL,w,h,8,w*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(space); if (!context) return NO;
    CGContextDrawImage(context,CGRectMake(0,0,w,h),image);
    const unsigned char *data=CGBitmapContextGetData(context);
    size_t minX=w,minY=h,maxX=0,maxY=0;
    size_t leftCounts[512]={0},rightCounts[512]={0},opaqueRows=0;
    for (size_t y=0;y<h;y++) {
        size_t left=w,right=0;
        for (size_t x=0;x<w;x++) if (data[(y*w+x)*4+3]>0) {
            minX=MIN(minX,x);minY=MIN(minY,y);maxX=MAX(maxX,x);maxY=MAX(maxY,y);
            left=MIN(left,x);right=MAX(right,x);
        }
        if (left<w) { leftCounts[left]++;rightCounts[right]++;opaqueRows++; }
    }
    CGContextRelease(context);
    if (minX==w) return NO;
    if (bodyOnly) {
        // The straight body edge repeats across rows; a narrow arrow and rounded corners
        // do not. Ties keep the outer edge, so uncertain shapes are never cropped inward.
        size_t left=minX,right=maxX;
        for (size_t x=minX;x<=maxX;x++) {
            if (leftCounts[x]>leftCounts[left]) left=x;
            if (rightCounts[x]>=rightCounts[right]) right=x;
        }
        size_t minimum=MAX((size_t)2,opaqueRows/4);
        if (leftCounts[left]>=minimum && rightCounts[right]>=minimum && left<right &&
            left/scale<=16 && (w-right-1)/scale<=16) { minX=left;maxX=right; }
    }
    CSBubbleInsets result={(CGFloat)minY/scale,(CGFloat)minX/scale,(CGFloat)(h-maxY-1)/scale,(CGFloat)(w-maxX-1)/scale};
    CGFloat sides[]={result.top,result.left,result.bottom,result.right};
    for (NSUInteger i=0;i<4;i++) if (sides[i]>16) return NO;
    if (padding) *padding=result;
    return YES;
}
BOOL CSBubbleNativePadding(CGImageRef image, CGFloat scale, CSBubbleInsets *padding) {
    return CSNativePadding(image,scale,padding,NO);
}
BOOL CSBubbleNativeBodyPadding(CGImageRef image, CGFloat scale, CSBubbleInsets *padding) {
    return CSNativePadding(image,scale,padding,YES);
}
@implementation CSBubbleImageOwnership
- (void)captureImage:(id)image highlighted:(BOOL)highlighted {
    id generated=highlighted?self.generatedHighlightedImage:self.generatedImage;
    if (generated && image==generated) return;
    if (highlighted) self.nativeHighlightedImage=image; else self.nativeImage=image;
}
- (id)restoredImageForCurrent:(id)current highlighted:(BOOL)highlighted {
    id generated=highlighted?self.generatedHighlightedImage:self.generatedImage;
    return generated && current==generated ? (highlighted?self.nativeHighlightedImage:self.nativeImage) : current;
}
@end
