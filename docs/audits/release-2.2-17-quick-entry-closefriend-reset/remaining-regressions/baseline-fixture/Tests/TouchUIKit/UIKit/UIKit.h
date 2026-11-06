#import "../../TabBarUIKit/UIKit/UIKit.h"
extern NSString *const UIScreenCapturedDidChangeNotification;
typedef NS_ENUM(NSInteger, UIEventType) { UIEventTypeTouches, UIEventTypeMotion };
typedef NS_ENUM(NSInteger, UITouchPhase) { UITouchPhaseBegan, UITouchPhaseMoved, UITouchPhaseStationary, UITouchPhaseEnded, UITouchPhaseCancelled };
@interface UIEvent (TouchTest)
@property(nonatomic) UIEventType type;
@property(nonatomic,strong) NSSet *allTouches;
@end
@interface UITouch : NSObject
@property(nonatomic) UITouchPhase phase;
@property(nonatomic,strong) UIWindow *window;
@property(nonatomic) CGPoint location;
- (CGPoint)locationInView:(UIView *)view;
@end
@interface UIScreen : NSObject
@property(nonatomic) BOOL isCaptured;
+ (instancetype)mainScreen;
@end
@interface UIColor (TouchTest)
+ (instancetype)redColor;
+ (instancetype)whiteColor;
@end
@interface UIView (TouchTest)
+ (void)animateWithDuration:(double)duration animations:(void (^)(void))animations completion:(void (^)(BOOL))completion;
@end
@interface UIApplication (TouchTest)
- (void)sendEvent:(UIEvent *)event;
@end
