#import "CSListCornerRenderer.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static char CardRenderStateKey;

@interface CSListCornerRenderState : NSObject
@property (nonatomic, strong) CAShapeLayer *mask;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat radius;
@property (nonatomic) UIRectCorner corners;
@end
@implementation CSListCornerRenderState @end

void CSListApplyCardBackground(UIView *background, CGRect frame, CGFloat radius,
                               BOOL first, BOOL last, UIColor *color) {
    CSListCornerRenderState *state=objc_getAssociatedObject(background,&CardRenderStateKey);
    if (!state) {
        state=[CSListCornerRenderState new];
        state.mask=[CAShapeLayer layer];
        objc_setAssociatedObject(background,&CardRenderStateKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UIRectCorner corners=first && last ? UIRectCornerAllCorners :
        first ? UIRectCornerTopLeft|UIRectCornerTopRight :
        last ? UIRectCornerBottomLeft|UIRectCornerBottomRight : 0;
    CGFloat pathRadius=corners ? radius : 0;
    BOOL shapeChanged=!state.path || !CGSizeEqualToSize(state.size,frame.size) ||
        state.radius!=pathRadius || state.corners!=corners;
    if (shapeChanged) {
        CGRect rect=CGRectMake(0,0,frame.size.width,frame.size.height);
        // Keep UIKit's original path factories and corner-radius behavior.
        if (first && last) state.path=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        else if (corners) state.path=[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius,radius)];
        else state.path=[UIBezierPath bezierPathWithRect:rect];
        state.size=frame.size; state.radius=pathRadius; state.corners=corners;
    }
    CALayer *layer=background.layer;
    CGFloat layerRadius=first && last ? radius : 0;
    CGPathRef path=state.path.CGPath;
    BOOL resetPath=shapeChanged || !state.mask.path ||
        (state.mask.path!=path && !CGPathEqualToPath(state.mask.path,path));
    if (resetPath || layer.mask!=state.mask || layer.cornerRadius!=layerRadius || !layer.masksToBounds) {
        // Reusing a mask must not introduce implicit morph animations when a cell changes groups.
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (resetPath) state.mask.path=path;
        if (layer.mask!=state.mask) layer.mask=state.mask;
        if (layer.cornerRadius!=layerRadius) layer.cornerRadius=layerRadius;
        if (!layer.masksToBounds) layer.masksToBounds=YES;
        [CATransaction commit];
    }
    // Compare actual properties, not just the last request: native reuse may have reset them.
    if (![background.backgroundColor isEqual:color]) background.backgroundColor=color;
    if (!CGRectEqualToRect(background.frame,frame)) background.frame=frame;
}
