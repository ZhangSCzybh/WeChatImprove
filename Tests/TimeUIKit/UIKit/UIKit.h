#import "../../MessageUIKit/UIKit/UIKit.h"
@class UIGestureRecognizer, UITouch;
@protocol UIGestureRecognizerDelegate <NSObject>
@optional
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)other;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)other;
@end
@interface CSTestLayer : NSObject
@property(nonatomic) CGFloat cornerRadius;
@end
@interface UIColor : NSObject
+ (instancetype)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (instancetype)clearColor;
@end
@interface UIFont : NSObject
+ (instancetype)systemFontOfSize:(CGFloat)size;
+ (instancetype)boldSystemFontOfSize:(CGFloat)size;
@end
extern NSUInteger CSTimeFontCreations;
@interface UIView (TimeUI)
@property(nonatomic,readonly) CSTestLayer *layer;
@property(nonatomic) BOOL userInteractionEnabled;
@property(nonatomic,readonly) UIView *superview;
@property(nonatomic,readonly) NSArray *gestureRecognizers;
- (void)addSubview:(UIView *)view;
- (void)bringSubviewToFront:(UIView *)view;
- (BOOL)isDescendantOfView:(UIView *)view;
- (void)addGestureRecognizer:(id)gesture;
@end
typedef NS_ENUM(NSInteger,NSTextAlignment) { NSTextAlignmentCenter };
@interface UILabel : UIView
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong) UIColor *backgroundColor;
@property(nonatomic,copy) NSString *text;
@property(nonatomic) NSInteger numberOfLines;
@property(nonatomic) BOOL adjustsFontSizeToFitWidth;
@property(nonatomic) BOOL clipsToBounds;
@property(nonatomic) NSTextAlignment textAlignment;
@end
@interface UIControl : UIView @end
@interface UITouch : NSObject
@property(nonatomic,weak) UIView *view;
@property(nonatomic) CGPoint testLocation;
- (CGPoint)locationInView:(UIView *)view;
@end
@class UIPanGestureRecognizer;
@interface UIGestureRecognizer : NSObject
@property(nonatomic,weak) id<UIGestureRecognizerDelegate> delegate;
@property(nonatomic,weak) UIView *view;
@property(nonatomic) NSInteger state;
@property(nonatomic) BOOL enabled,delaysTouchesBegan,delaysTouchesEnded,cancelsTouchesInView;
- (CGPoint)locationInView:(UIView *)view;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
@end
@interface UITapGestureRecognizer : UIGestureRecognizer
@property(nonatomic) NSUInteger numberOfTapsRequired;
@property(nonatomic) CGPoint testLocation;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (CGPoint)locationInView:(UIView *)view;
@end
extern NSString *const NSFontAttributeName;
enum { NSStringDrawingUsesLineFragmentOrigin=1 };
@interface NSString (TimeDrawing)
- (CGRect)boundingRectWithSize:(CGSize)size options:(NSUInteger)options attributes:(NSDictionary *)attributes context:(id)context;
@end
