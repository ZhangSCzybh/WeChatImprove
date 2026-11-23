// Narrow UI boundary doubles for the production shared-cover adapter. These
// exercise view ownership and geometry; they do not simulate UIKit rendering.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSInteger, UIViewContentMode) {
    UIViewContentModeScaleToFill,
    UIViewContentModeScaleAspectFit,
    UIViewContentModeScaleAspectFill
};
typedef NS_ENUM(NSInteger, NSLineBreakMode) { NSLineBreakByTruncatingTail = 4 };
typedef NS_ENUM(NSInteger, NSTextAlignment) { NSTextAlignmentLeft, NSTextAlignmentCenter };

@class UIView, UITapGestureRecognizer;
@interface UIFont : NSObject @end
@interface UITraitCollection : NSObject @end
@interface UIColor : NSObject
+ (instancetype)secondaryLabelColor;
+ (instancetype)tertiarySystemFillColor;
+ (instancetype)secondarySystemGroupedBackgroundColor;
@end

@interface UIView : NSObject
@property(nonatomic) CGRect frame, bounds;
@property(nonatomic) CGPoint center;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic, getter=isHidden) BOOL hidden;
@property(nonatomic) BOOL clipsToBounds, userInteractionEnabled;
@property(nonatomic) UIViewContentMode contentMode;
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, weak) UIView *superview;
@property(nonatomic, strong) NSMutableArray<UIView *> *subviews;
@property(nonatomic, strong) NSMutableArray<UITapGestureRecognizer *> *gestureRecognizers;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
- (void)willMoveToSuperview:(UIView *)superview;
- (void)didMoveToSuperview;
- (void)layoutSubviews;
- (void)addGestureRecognizer:(UITapGestureRecognizer *)recognizer;
- (void)removeGestureRecognizer:(UITapGestureRecognizer *)recognizer;
@end

@interface UILabel : UIView
@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) UIFont *font;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic) NSInteger numberOfLines;
@property(nonatomic) NSLineBreakMode lineBreakMode;
@property(nonatomic) NSTextAlignment textAlignment;
@end

@interface UIImage : NSObject
+ (instancetype)systemImageNamed:(NSString *)name;
@end
@interface UIImageView : UIView
@property(nonatomic, strong) UIImage *image;
- (instancetype)initWithImage:(UIImage *)image;
@end

@interface UIViewController : NSObject
@property(nonatomic, strong) id navigationController;
@property(nonatomic, strong) UITraitCollection *traitCollection;
@end

@interface UITapGestureRecognizer : NSObject
@property(nonatomic, weak) UIView *view;
@property(nonatomic, weak) id target;
@property(nonatomic) SEL action;
- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (void)fire;
@end
