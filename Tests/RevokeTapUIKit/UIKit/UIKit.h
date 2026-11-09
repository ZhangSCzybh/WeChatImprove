#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@class UIGestureRecognizer,UITouch,UIWindow;
typedef NS_ENUM(NSInteger,UIGestureRecognizerState) {
    UIGestureRecognizerStatePossible,UIGestureRecognizerStateBegan,UIGestureRecognizerStateChanged,
    UIGestureRecognizerStateEnded,UIGestureRecognizerStateCancelled,UIGestureRecognizerStateFailed
};
@protocol UIGestureRecognizerDelegate <NSObject>
@optional
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch;
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other;
@end
@interface UIView : NSObject
@property(nonatomic) CGRect frame;
@property(nonatomic,getter=isHidden) BOOL hidden;
@property(nonatomic) CGFloat alpha;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,weak) UIWindow *window;
@property(nonatomic,strong) NSMutableArray<UIGestureRecognizer *> *gestureRecognizers;
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture;
@end
@interface UIWindow : UIView @end
@interface UIScrollView : UIView
@property(nonatomic,getter=isDragging) BOOL dragging;
@property(nonatomic,getter=isDecelerating) BOOL decelerating;
@end
@interface UITableView : UIScrollView @end
@interface UIGestureRecognizer : NSObject
@property(nonatomic) BOOL enabled;
@property(nonatomic) BOOL cancelsTouchesInView;
@property(nonatomic) BOOL delaysTouchesEnded;
@property(nonatomic) UIGestureRecognizerState state;
@property(nonatomic,weak) id<UIGestureRecognizerDelegate> delegate;
@property(nonatomic) CGPoint testPoint;
@property(nonatomic,weak) id testTarget;
@property(nonatomic) SEL testAction;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (CGPoint)locationInView:(UIView *)view;
- (void)testFire;
@end
@interface UITapGestureRecognizer : UIGestureRecognizer @end
@interface UITouch : NSObject
@property(nonatomic) CGPoint testPoint;
- (CGPoint)locationInView:(UIView *)view;
@end
