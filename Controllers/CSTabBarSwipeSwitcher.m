#import "CSTabBarSwipeSwitcher.h"

// The native images, labels and badges stay beneath this transparent input
// control. It owns the complete sequence, so the starting button cannot send a
// late Up action that undoes a cross-slot selection.
@interface CSTabBarTouchControl : UIControl
@property(nonatomic, weak) MMTabBar *bar;
@end

@implementation CSTabBarTouchControl
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        self.backgroundColor=UIColor.clearColor;
        self.isAccessibilityElement=NO;
        [self addTarget:self action:@selector(touchDown:forEvent:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchDrag:forEvent:) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDragOutside];
        [self addTarget:self action:@selector(touchUp:forEvent:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(touchCancel:forEvent:) forControlEvents:UIControlEventTouchCancel];
    }
    return self;
}
- (CGPoint)pointForEvent:(UIEvent *)event {
    UITouch *touch=event.allTouches.anyObject;
    return touch ? [touch locationInView:self.bar] : [self convertPoint:CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds)) toView:self.bar];
}
- (void)touchDown:(UIControl *)sender forEvent:(UIEvent *)event {
    CSTabBarTouchBegin(self.bar,[self pointForEvent:event]);
}
- (void)touchDrag:(UIControl *)sender forEvent:(UIEvent *)event {
    CSTabBarTouchMove(self.bar,[self pointForEvent:event]);
}
- (void)touchUp:(UIControl *)sender forEvent:(UIEvent *)event {
    CSTabBarTouchEnd(self.bar,[self pointForEvent:event]);
}
- (void)touchCancel:(UIControl *)sender forEvent:(UIEvent *)event {
    CSTabBarTouchCancel(self.bar);
}
@end

UIControl *CSTabBarCreateTouchControl(MMTabBar *bar) {
    CSTabBarTouchControl *control=[[CSTabBarTouchControl alloc] initWithFrame:CGRectZero];
    control.bar=bar;
    return control;
}

// The adapter synchronizes input frames and owns the lifecycle observers.
void CSTabBarSwipeRefresh(MMTabBar *bar) { (void)bar; }
void CSTabBarSwipeInstallObservers(void) {}
