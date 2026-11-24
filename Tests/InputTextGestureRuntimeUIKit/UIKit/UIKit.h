#import "../../StyleUIKit/UIKit/UIKit.h"

// Behavioral doubles only: the tests model two failure edges, not UIKit arbitration.
typedef NS_ENUM(NSInteger, UIGestureRecognizerState) {
    UIGestureRecognizerStatePossible, UIGestureRecognizerStateBegan,
    UIGestureRecognizerStateChanged, UIGestureRecognizerStateEnded,
    UIGestureRecognizerStateCancelled, UIGestureRecognizerStateFailed,
    UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded
};
typedef NS_ENUM(NSInteger, UITouchType) { UITouchTypeDirect };
@class UIGestureRecognizer, UINavigationController;
@protocol UIGestureRecognizerDelegate <NSObject>
@optional
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)recognizer shouldReceiveTouch:(UITouch *)touch;
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)recognizer;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)recognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other;
@end
@interface UIGestureRecognizer : NSObject
@property(nonatomic, weak) id<UIGestureRecognizerDelegate> delegate;
@property(nonatomic, weak) UIView *view;
@property(nonatomic) BOOL enabled, cancelsTouchesInView, delaysTouchesBegan, delaysTouchesEnded;
@property(nonatomic) UIGestureRecognizerState state;
@property(nonatomic, copy) NSArray *allowedTouchTypes;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, weak) id testTarget;
@property(nonatomic) SEL testAction;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)reset;
@end
@interface UIPanGestureRecognizer : UIGestureRecognizer @end
@interface UIScreenEdgePanGestureRecognizer : UIPanGestureRecognizer @end
@interface UILongPressGestureRecognizer : UIGestureRecognizer @end
@interface UIView (InputGestureRuntime)
@property(nonatomic, readonly) NSArray<UIGestureRecognizer *> *gestureRecognizers;
- (void)addGestureRecognizer:(UIGestureRecognizer *)recognizer;
- (void)removeGestureRecognizer:(UIGestureRecognizer *)recognizer;
@end
@interface UIWindow (InputGestureRuntime)
@property(nonatomic) BOOL isKeyWindow;
@end
@interface UITouch (InputGestureRuntime)
@property(nonatomic) NSTimeInterval timestamp;
@property(nonatomic, readonly) UIView *view;
@end
@interface UIViewController (InputGestureRuntime)
@property(nonatomic) BOOL isBeingDismissed, isBeingPresented;
@property(nonatomic, strong) id transitionCoordinator;
@property(nonatomic, strong) UIViewController *presentedViewController;
@property(nonatomic, weak) UINavigationController *navigationController;
@end
@interface UINavigationController (InputGestureRuntime)
@property(nonatomic, strong) UIViewController *visibleViewController;
@property(nonatomic, strong) UIGestureRecognizer *interactivePopGestureRecognizer;
@end
@interface UITextView : UIScrollView
@property(nonatomic) BOOL editable, selectable;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) id markedTextRange, selectedTextRange;
@property(nonatomic) NSRange selectedRange;
@property(nonatomic) NSUInteger testDeletes, testPastes;
@property(nonatomic, readonly) id beginningOfDocument, endOfDocument;
- (id)textRangeFromPosition:(id)fromPosition toPosition:(id)toPosition;
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender;
- (void)copy:(id)sender;
- (void)cut:(id)sender;
- (void)paste:(id)sender;
- (void)deleteBackward;
@end
