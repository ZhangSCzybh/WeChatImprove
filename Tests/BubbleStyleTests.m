#import <Foundation/Foundation.h>
#import "CSBubbleStylePolicy.h"
#include <math.h>
static NSUInteger checks;
#define CHECK(value) do { checks++; if (!(value)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#value); return 1; } } while (0)
static NSData *Pixels(CGImageRef image) {
    size_t width=CGImageGetWidth(image),height=CGImageGetHeight(image);
    NSMutableData *data=[NSMutableData dataWithLength:width*height*4];
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(data.mutableBytes,width,height,8,width*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(space); CGContextDrawImage(context,CGRectMake(0,0,width,height),image); CGContextRelease(context);
    return data;
}
// A native-style first segment is five points wider to include its arrow. The next
// segment has no arrow. Their body edges must coincide after nine-slice resizing.
static CGImageRef NativeSegment(BOOL outgoing, BOOL first, CGFloat scale) {
    size_t w=(first?35:30)*scale,h=40*scale;
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx=CGBitmapContextCreate(NULL,w,h,8,w*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(space);CGContextScaleCTM(ctx,scale,scale);
    CGFloat left=first&&!outgoing?8:3;
    CGContextSetRGBFillColor(ctx,.4,.5,.6,1);CGContextFillRect(ctx,CGRectMake(left,0,24,40));
    if (first) CGContextFillRect(ctx,CGRectMake(outgoing?27:3,16,5,8));
    CGImageRef result=CGBitmapContextCreateImage(ctx);CGContextRelease(ctx);return result;
}
static size_t StretchIndex(size_t target, size_t targetSize, size_t sourceSize, size_t leading, size_t trailing) {
    if (target<leading) return target;
    if (target>=targetSize-trailing) return sourceSize-(targetSize-target);
    return leading+(target-leading)*(sourceSize-leading-trailing)/(targetSize-leading-trailing);
}
static unsigned char StretchedAlpha(NSData *pixels, CGImageRef image, CSBubbleTemplateMetrics metrics,
                                   CGFloat scale, CGSize target, size_t x,size_t y) {
    size_t w=CGImageGetWidth(image),h=CGImageGetHeight(image);
    size_t sx=StretchIndex(x,target.width*scale,w,metrics.caps.left*scale,metrics.caps.right*scale);
    size_t sy=StretchIndex(y,target.height*scale,h,metrics.caps.top*scale,metrics.caps.bottom*scale);
    return ((const unsigned char *)pixels.bytes)[(sy*w+sx)*4+3];
}
int main(void) { @autoreleasepool {
    NSString *suite=[@"CSBubbleTests." stringByAppendingString:NSUUID.UUID.UUIDString];
    NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
    NSDictionary *before=[defaults persistentDomainForName:suite];
    CSBubbleStyleConfiguration *config=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:1];
    CHECK(config.radius==16 && !config.enabled && config.generation==1);
    CHECK(([defaults persistentDomainForName:suite]?:@{}).count==(before?:@{}).count);
    for (NSString *component in @[@"red",@"green",@"blue",@"alpha"]) [defaults setDouble:0 forKey:[@"com.wechat.enhance.bubble_style.sender_light_color." stringByAppendingString:component]];
    config=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:2];
    CSBubbleRGBA transparent=[config colorForOutgoing:YES dark:NO];
    CHECK(transparent.red==0 && transparent.green==0 && transparent.blue==0 && transparent.alpha==0);
    [defaults removeObjectForKey:@"com.wechat.enhance.bubble_style.sender_light_color.alpha"];
    [defaults setDouble:4 forKey:@"com.wechat.enhance.bubble_style.sender_light_color.red"];
    [defaults setDouble:-4 forKey:@"com.wechat.enhance.bubble_style.sender_light_color.green"];
    [defaults setObject:@"bad" forKey:@"com.wechat.enhance.bubble_style.sender_light_color.blue"];
    [defaults setDouble:400 forKey:@"com.wechat.enhance.bubble_style.corner_radius"];
    config=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:3];
    CSBubbleRGBA clamped=[config colorForOutgoing:YES dark:NO];
    CHECK(clamped.red==1 && clamped.green==0 && clamped.blue==.49 && clamped.alpha==1 && config.radius==30);
    [defaults setObject:@"bad" forKey:@"com.wechat.enhance.bubble_style.corner_radius"];
    config=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:4]; CHECK(config.radius==16);
    [defaults removePersistentDomainForName:suite];
    config=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:5];
    // Retired payment-color preferences cannot invalidate or alter the ordinary palette.
    NSDictionary *ordinaryValues=config.values;
    [defaults setDouble:.123 forKey:@"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.red"];
    config=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:6];
    CHECK([ordinaryValues isEqual:config.values]);
    CHECK([defaults doubleForKey:@"com.wechat.enhance.bubble_style.redenvelop_sender_light_color.red"]==.123);
    CHECK(config.kind==CSBubbleStyleRounded);
    [defaults setInteger:CSBubbleStyleStacked forKey:CSBubbleStyleKindKey];
    CSBubbleStyleConfiguration *stacked=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:7];
    CHECK(stacked.kind==CSBubbleStyleStacked && stacked.radius==config.radius);
    CHECK(![stacked.values isEqual:config.values]);
    CHECK([stacked.values[@"sender_light_color"] isEqual:config.values[@"sender_light_color"]]);
    [defaults setObject:@"1" forKey:CSBubbleStyleKindKey];
    CHECK([[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:8].kind==CSBubbleStyleRounded);
    CHECK(CSBubbleGroupPositionForJoins(NO,NO)==CSBubbleGroupSingle);
    CHECK(CSBubbleGroupPositionForJoins(NO,YES)==CSBubbleGroupFirst);
    CHECK(CSBubbleGroupPositionForJoins(YES,YES)==CSBubbleGroupMiddle);
    CHECK(CSBubbleGroupPositionForJoins(YES,NO)==CSBubbleGroupLast);
    CHECK([CSBubbleStyleKindTitle(stacked.kind) isEqualToString:@"连续圆角"]);
    // Text defaults preserve native colors. All four direction/theme palettes
    // are independent, and font-only edits cannot invalidate background templates.
    NSDictionary *backgroundValues=stacked.backgroundValues;
    [defaults setInteger:CSBubbleStyleStacked forKey:CSBubbleStyleKindKey];
    for (NSUInteger palette=0;palette<4;palette++) {
        CSBubbleStyleConfiguration *native=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:8];
        CHECK(![native textColorForOutgoing:palette%2==0 dark:palette>=2 color:NULL]);
        for (NSString *component in @[@"red",@"green",@"blue"])
            [defaults setDouble:palette*.2 forKey:CSBubbleTextColorPreferenceKey(palette,component)];
        CSBubbleStyleConfiguration *custom=[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:9];
        CSBubbleRGBA font;CHECK([custom textColorForOutgoing:palette%2==0 dark:palette>=2 color:&font]);
        CHECK(font.red==palette*.2 && font.green==palette*.2 && font.blue==palette*.2 && font.alpha==1);
        CHECK([custom.backgroundValues isEqual:backgroundValues]);CHECK(![custom.values isEqual:native.values]);
        [defaults setObject:@"bad" forKey:CSBubbleTextColorPreferenceKey(palette,@"red")];
        CHECK(![[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:10] textColorForOutgoing:palette%2==0 dark:palette>=2 color:NULL]);
        [defaults setDouble:2 forKey:CSBubbleTextColorPreferenceKey(palette,@"red")];
        CHECK([[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:11] textColorForOutgoing:palette%2==0 dark:palette>=2 color:&font] && font.red==1);
        [defaults removeObjectForKey:CSBubbleTextColorPreferenceKey(palette,@"blue")];
        CHECK(![[[CSBubbleStyleConfiguration alloc] initWithDefaults:defaults generation:12] textColorForOutgoing:palette%2==0 dark:palette>=2 color:NULL]);
    }
    [defaults removePersistentDomainForName:suite];
    // Expected corner masks in TL/TR/BL/BR order. These enumerate the requested
    // incoming/outgoing single, first, middle and last silhouettes explicitly.
    const NSUInteger squareCorners[2][4]={{0,4,5,1},{0,8,10,2}};
    for (NSNumber *radiusValue in @[@1,@2,@4,@16,@30])
    for (NSUInteger scale=1;scale<=3;scale++) for (NSUInteger outgoing=0;outgoing<2;outgoing++)
    for (NSUInteger group=0;group<=3;group++) for (NSUInteger palette=0;palette<2;palette++)
    for (NSUInteger highlighted=0;highlighted<2;highlighted++) {
        CGFloat radius=radiusValue.doubleValue;
        CSBubbleRGBA c=palette ? (CSBubbleRGBA){.1,.6,.8,.5} : (CSBubbleRGBA){.9,.7,.2,1};
        CSBubbleInsets padding={2,3,4,5};CSBubbleTemplateMetrics metrics,baseMetrics;
        CHECK(CSBubbleStyledTemplateDescribe(radius,0,scale,padding,CSBubbleStyleStacked,&metrics));
        CHECK(CSBubbleTemplateDescribe(radius,0,scale,padding,&baseMetrics));
        CHECK(CGSizeEqualToSize(metrics.size,baseMetrics.size));
        CHECK(metrics.caps.left==baseMetrics.caps.left && metrics.caps.right==baseMetrics.caps.right);
        CGImageRef cg=CSBubbleCreateStyledTemplate(c,radius,0,scale,padding,highlighted,CSBubbleStyleStacked,group,outgoing);
        CGImageRef base=CSBubbleCreateTemplate(c,radius,0,scale,padding,highlighted);
        CHECK(cg && base);
        NSData *data=Pixels(cg),*original=Pixels(base);
        const unsigned char *bytes=data.bytes,*rounded=original.bytes;
        size_t w=CGImageGetWidth(cg),h=CGImageGetHeight(cg);
        CGFloat factor=highlighted?.84:1;
        BOOL uniform=YES;
        for (NSUInteger i=0;i<data.length;i+=4) {
            CGFloat alpha=bytes[i+3];
            if (alpha>ceil(c.alpha*255) || fabs(bytes[i]-c.red*factor*alpha)>2 ||
                fabs(bytes[i+1]-c.green*factor*alpha)>2 || fabs(bytes[i+2]-c.blue*factor*alpha)>2) uniform=NO;
        }
        CHECK(uniform); // No backing/stripe colors and no doubled opacity anywhere.
        CHECK(bytes[3]==0); // Native transparent padding is preserved.
        CHECK(abs(bytes[((h/2)*w+w/2)*4+3]-(int)round(c.alpha*255))<=1);
        CGSize target=CGSizeMake(220,100);
        for (NSUInteger corner=0;corner<4;corner++) {
            BOOL right=corner&1,bottom=corner&2;
            size_t x=right ? w-(size_t)(padding.right*scale)-1 : padding.left*scale;
            size_t y=bottom ? h-(size_t)(padding.bottom*scale)-1 : padding.top*scale;
            NSUInteger at=(y*w+x)*4+3;
            BOOL square=squareCorners[outgoing][group]&(1<<corner);
            if (square && abs(bytes[at]-(int)round(c.alpha*255))>1)
                fprintf(stderr,"Corner mismatch: radius=%g scale=%lu outgoing=%lu group=%lu corner=%lu alpha=%u expected=%g\n",
                    radius,(unsigned long)scale,(unsigned long)outgoing,(unsigned long)group,(unsigned long)corner,bytes[at],round(c.alpha*255));
            if (square) CHECK(abs(bytes[at]-(int)round(c.alpha*255))<=1);
            else { CHECK(abs(bytes[at]-rounded[at])<=1);CHECK(bytes[at]<c.alpha*255-1); }
            size_t tx=right ? (target.width-padding.right)*scale-1 : padding.left*scale;
            size_t ty=bottom ? (target.height-padding.bottom)*scale-1 : padding.top*scale;
            CHECK(StretchedAlpha(data,cg,metrics,scale,target,tx,ty)==bytes[at]);
        }
        if (group==CSBubbleGroupSingle) CHECK([data isEqual:original]);
        else CHECK(![data isEqual:original]);
        CGImageRelease(cg);CGImageRelease(base);
    }
    // Native split rows retain their existing seams for every group and direction.
    for (NSUInteger segment=1;segment<=3;segment++) for (NSUInteger group=0;group<=3;group++)
    for (NSUInteger outgoing=0;outgoing<2;outgoing++) {
        CGImageRef cg=CSBubbleCreateStyledTemplate((CSBubbleRGBA){.4,.6,.2,1},16,segment,2,(CSBubbleInsets){0},NO,CSBubbleStyleStacked,group,outgoing);
        CGImageRef base=CSBubbleCreateTemplate((CSBubbleRGBA){.4,.6,.2,1},16,segment,2,(CSBubbleInsets){0},NO);
        CHECK([Pixels(cg) isEqual:Pixels(base)]);CGImageRelease(cg);CGImageRelease(base);
    }
    for (NSUInteger group=0;group<=3;group++) {
        CGImageRef cg=CSBubbleCreateStyledTemplate((CSBubbleRGBA){0,0,0,0},16,0,2,(CSBubbleInsets){0},YES,CSBubbleStyleStacked,group,YES);
        NSData *data=Pixels(cg);const unsigned char *bytes=data.bytes;
        for (NSUInteger i=3;i<data.length;i+=4) CHECK(bytes[i]==0);
        CGImageRelease(cg);
    }
    // Real pixels, every theme/direction/segment/highlight combination, three scales.
    for (NSUInteger position=0;position<4;position++) for (NSUInteger scale=1;scale<=3;scale++)
    for (NSUInteger bits=0;bits<8;bits++) {
        BOOL outgoing=bits&1,dark=bits&2,highlighted=bits&4;
        CSBubbleRGBA color=[config colorForOutgoing:outgoing dark:dark];
        CSBubbleInsets padding={2,3,4,5};
        CSBubbleTemplateMetrics metrics;
        CHECK(CSBubbleTemplateDescribe(config.radius,position,scale,padding,&metrics));
        CHECK(fabs(metrics.size.width-metrics.caps.left-metrics.caps.right-1.0/scale)<.0001);
        CHECK(fabs(metrics.size.height-metrics.caps.top-metrics.caps.bottom-1.0/scale)<.0001);
        CGImageRef image=CSBubbleCreateTemplate(color,config.radius,position,scale,padding,highlighted); CHECK(image);
        CHECK(CGImageGetWidth(image)<=512 && CGImageGetHeight(image)<=512);
        NSData *data=Pixels(image); const unsigned char *bytes=data.bytes;
        size_t w=CGImageGetWidth(image),h=CGImageGetHeight(image),center=(((size_t)(padding.top*scale)+(h-(size_t)((padding.top+padding.bottom)*scale))/2)*w+w/2)*4;
        CHECK(bytes[3]==0 && bytes[center+3]==255);
        CHECK(abs((int)bytes[center]-(int)round(color.red*(highlighted?.84:1)*255))<=1);
        CHECK(abs((int)bytes[center+1]-(int)round(color.green*(highlighted?.84:1)*255))<=1);
        CHECK(abs((int)bytes[center+2]-(int)round(color.blue*(highlighted?.84:1)*255))<=1);
        CSBubbleInsets found; CHECK(CSBubbleNativeBodyPadding(image,scale,&found));
        CHECK(fabs(found.left-padding.left)<.0001 && fabs(found.right-padding.right)<.0001);
        CHECK(fabs(found.top-padding.top)<.0001 && fabs(found.bottom-padding.bottom)<.0001);
        // Native segment semantics: top corners round only for 0/1, bottom only for 0/3.
        size_t x=(size_t)(padding.left*scale),y=(size_t)(padding.top*scale);
        CHECK((bytes[(y*w+x)*4+3]==0)==(position==0 || position==1));
        y=h-(size_t)(padding.bottom*scale)-1;
        CHECK((bytes[(y*w+x)*4+3]==0)==(position==0 || position==3));
        CGImageRelease(image);
    }
    CSBubbleTemplateMetrics metrics;
    CHECK(!CSBubbleTemplateDescribe(NAN,0,2,(CSBubbleInsets){0},&metrics));
    CHECK(!CSBubbleTemplateDescribe(16,8,2,(CSBubbleInsets){0},&metrics));
    CHECK(!CSBubbleTemplateDescribe(16,0,8,(CSBubbleInsets){0},&metrics));
    CHECK(!CSBubbleTemplateDescribe(16,0,2,(CSBubbleInsets){17,0,0,0},&metrics));
    CHECK(CSBubbleTemplateDescribe(30,0,4,(CSBubbleInsets){16,16,16,16},&metrics));
    CGImageRef image=CSBubbleCreateTemplate(transparent,16,0,2,(CSBubbleInsets){0},NO);CHECK(image);
    NSData *data=Pixels(image); const unsigned char *bytes=data.bytes;
    for (NSUInteger i=3;i<data.length;i+=4) CHECK(bytes[i]==0);
    CGImageRelease(image);
    // Pixel seams for both directions at 1x/2x/3x, including a short bottom row.
    for (NSUInteger scale=1;scale<=3;scale++) for (NSUInteger outgoing=0;outgoing<2;outgoing++) {
        CGImageRef firstNative=NativeSegment(outgoing,YES,scale),lastNative=NativeSegment(outgoing,NO,scale);
        CSBubbleInsets firstPadding,lastPadding;
        CHECK(CSBubbleNativeBodyPadding(firstNative,scale,&firstPadding));
        CHECK(CSBubbleNativeBodyPadding(lastNative,scale,&lastPadding));
        CHECK(firstPadding.left==(outgoing?3:8) && firstPadding.right==(outgoing?8:3));
        CHECK(lastPadding.left==3 && lastPadding.right==3);
        CGSize firstSize=CGSizeMake(175,80),lastSize=CGSizeMake(170,24);
        CGFloat radius=CSBubbleFittedRadius(30,3,scale,lastPadding,lastSize);
        CSBubbleTemplateMetrics firstMetrics,lastMetrics;
        CHECK(CSBubbleTemplateDescribe(30,1,scale,firstPadding,&firstMetrics));
        CHECK(CSBubbleTemplateDescribe(radius,3,scale,lastPadding,&lastMetrics));
        CHECK(lastMetrics.caps.top+lastMetrics.caps.bottom<lastSize.height);
        CGImageRef first=CSBubbleCreateTemplate((CSBubbleRGBA){.4,.5,.6,1},30,1,scale,firstPadding,NO);
        CGImageRef last=CSBubbleCreateTemplate((CSBubbleRGBA){.4,.5,.6,1},radius,3,scale,lastPadding,NO);
        NSData *firstPixels=Pixels(first),*lastPixels=Pixels(last);
        size_t offset=outgoing?0:5*scale;
        for (size_t x=0;x<175*scale;x++) {
            unsigned char top=StretchedAlpha(firstPixels,first,firstMetrics,scale,firstSize,x,80*scale-1);
            unsigned char bottom=x>=offset && x<offset+170*scale ?
                StretchedAlpha(lastPixels,last,lastMetrics,scale,lastSize,x-offset,0):0;
            CHECK(top==bottom); // No side step or transparent seam at the join.
        }
        CGImageRelease(first);CGImageRelease(last);CGImageRelease(firstNative);CGImageRelease(lastNative);
    }
    CGFloat fitted=CSBubbleFittedRadius(30,0,3,(CSBubbleInsets){0},CGSizeMake(80,38));
    CHECK(CSBubbleTemplateDescribe(fitted,0,3,(CSBubbleInsets){0},&metrics));
    CHECK(metrics.caps.top+metrics.caps.bottom<38);
    // Own only generated assignments. Native replacement during reuse/disable must survive.
    CSBubbleImageOwnership *ownership=[CSBubbleImageOwnership new];
    NSObject *native=[NSObject new],*generated=[NSObject new],*replacement=[NSObject new],*highlight=[NSObject new];
    [ownership captureImage:native highlighted:NO]; ownership.generatedImage=generated;
    [ownership captureImage:generated highlighted:NO]; CHECK(ownership.nativeImage==native);
    CHECK([ownership restoredImageForCurrent:generated highlighted:NO]==native);
    CHECK([ownership restoredImageForCurrent:replacement highlighted:NO]==replacement);
    [ownership captureImage:replacement highlighted:NO]; CHECK([ownership restoredImageForCurrent:generated highlighted:NO]==replacement);
    [ownership captureImage:highlight highlighted:YES]; ownership.generatedHighlightedImage=[NSObject new];
    CHECK([ownership restoredImageForCurrent:ownership.generatedHighlightedImage highlighted:YES]==highlight);
    [ownership captureImage:nil highlighted:YES]; CHECK([ownership restoredImageForCurrent:ownership.generatedHighlightedImage highlighted:YES]==nil);
    CHECK(ownership.nativeImage==replacement);
    fprintf(stdout,"Bubble policy/renderer/ownership: %lu checks passed\n",(unsigned long)checks);
} return 0; }
