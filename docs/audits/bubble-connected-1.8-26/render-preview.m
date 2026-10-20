#define main ExistingBubbleTests
#include "../../../Tests/BubbleStyleTests.m"
#undef main
#import <ImageIO/ImageIO.h>
int main(int argc,const char **argv) { @autoreleasepool {
    if (argc!=2) return 2;
    NSString *directory=[NSString stringWithUTF8String:argv[1]];
    for (NSUInteger palette=0;palette<2;palette++) for (NSUInteger outgoing=0;outgoing<2;outgoing++) for (NSUInteger group=0;group<4;group++) {
        CGFloat scale=3;CGSize size=CGSizeMake(group==2?142:(group==3?202:180),38);
        CSBubbleRGBA color=palette ? (outgoing ? (CSBubbleRGBA){.16,.48,.88,1} : (CSBubbleRGBA){.75,.92,.83,1}) : (outgoing ? (CSBubbleRGBA){0,0,0,1} : (CSBubbleRGBA){1,1,1,1});
        CGFloat radius=CSBubbleFittedRadius(18,0,scale,(CSBubbleInsets){0},size);
        CSBubbleTemplateMetrics metrics;CSBubbleStyledTemplateDescribe(radius,0,scale,(CSBubbleInsets){0},CSBubbleStyleStacked,&metrics);
        CGImageRef cg=CSBubbleCreateStyledTemplate(color,radius,0,scale,(CSBubbleInsets){0},NO,CSBubbleStyleStacked,group,outgoing);
        NSData *pixels=Pixels(cg);const unsigned char *source=pixels.bytes;
        size_t w=size.width*scale,h=size.height*scale,sw=CGImageGetWidth(cg),sh=CGImageGetHeight(cg);
        NSMutableData *result=[NSMutableData dataWithLength:w*h*4];unsigned char *destination=result.mutableBytes;
        for (size_t y=0;y<h;y++) for (size_t x=0;x<w;x++) {
            size_t sx=StretchIndex(x,w,sw,metrics.caps.left*scale,metrics.caps.right*scale);
            size_t sy=StretchIndex(y,h,sh,metrics.caps.top*scale,metrics.caps.bottom*scale);
            memcpy(destination+(y*w+x)*4,source+(sy*sw+sx)*4,4);
        }
        CGDataProviderRef provider=CGDataProviderCreateWithCFData((__bridge CFDataRef)result);
        CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
        CGImageRef stretched=CGImageCreate(w,h,8,32,w*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big,provider,NULL,NO,kCGRenderingIntentDefault);
        NSString *path=[directory stringByAppendingPathComponent:[NSString stringWithFormat:@"bubble-%lu-%lu-%lu.png",(unsigned long)palette,(unsigned long)outgoing,(unsigned long)group]];
        CGImageDestinationRef file=CGImageDestinationCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:path],CFSTR("public.png"),1,NULL);
        CGImageDestinationAddImage(file,stretched,NULL);if (!CGImageDestinationFinalize(file)) return 3;
        CFRelease(file);CGImageRelease(stretched);CGColorSpaceRelease(space);CGDataProviderRelease(provider);CGImageRelease(cg);
    }
} return 0; }
