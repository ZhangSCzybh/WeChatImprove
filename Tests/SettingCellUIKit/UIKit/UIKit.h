// Host-only UIKit doubles for executing the production setting-cell methods.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <dispatch/dispatch.h>

// macOS Foundation loads CoreAutoLayout. Keep fixture classes separate from its
// real NSLayoutAnchor/NSLayoutConstraint Objective-C runtime class names.
#define NSLayoutAnchor CSSettingTestLayoutAnchor
#define NSLayoutConstraint CSSettingTestLayoutConstraint

typedef NS_ENUM(NSInteger, UIViewContentMode) { UIViewContentModeScaleToFill, UIViewContentModeScaleAspectFit, UIViewContentModeCenter };
typedef NS_ENUM(NSInteger, UITableViewCellStyle) { UITableViewCellStyleDefault, UITableViewCellStyleValue1 };
typedef NS_ENUM(NSInteger, UITableViewCellAccessoryType) { UITableViewCellAccessoryNone, UITableViewCellAccessoryDisclosureIndicator };
typedef NS_ENUM(NSInteger, UITableViewCellSelectionStyle) { UITableViewCellSelectionStyleNone, UITableViewCellSelectionStyleDefault };
typedef NS_ENUM(NSInteger, NSTextAlignment) { NSTextAlignmentLeft, NSTextAlignmentCenter, NSTextAlignmentRight };
typedef NS_ENUM(NSInteger, UIKeyboardType) { UIKeyboardTypeDefault };
typedef NS_ENUM(NSInteger, UIAlertControllerStyle) { UIAlertControllerStyleAlert };
typedef NS_ENUM(NSInteger, NSLayoutAttribute) { NSLayoutAttributeLeading, NSLayoutAttributeTrailing, NSLayoutAttributeCenterY, NSLayoutAttributeWidth, NSLayoutAttributeHeight };
typedef NSUInteger UIControlEvents;
static const UIControlEvents UIControlEventValueChanged=1;

@class UIView, NSLayoutConstraint;
@interface UIResponder : NSObject
- (UIResponder *)nextResponder;
@end
@interface UIColor : NSObject
@property(nonatomic,copy) NSString *name;
+ (instancetype)labelColor;
+ (instancetype)secondaryLabelColor;
+ (instancetype)tertiarySystemGroupedBackgroundColor;
+ (instancetype)secondarySystemGroupedBackgroundColor;
+ (instancetype)systemGrayColor;
+ (instancetype)systemBlueColor;
@end
@interface NSLayoutAnchor : NSObject
@property(nonatomic,weak) UIView *view;
@property(nonatomic) NSLayoutAttribute attribute;
- (NSLayoutConstraint *)constraintEqualToAnchor:(NSLayoutAnchor *)anchor;
- (NSLayoutConstraint *)constraintEqualToAnchor:(NSLayoutAnchor *)anchor constant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintEqualToConstant:(CGFloat)constant;
@end
@interface NSLayoutConstraint : NSObject
@property(nonatomic,strong) NSLayoutAnchor *firstAnchor,*secondAnchor;
@property(nonatomic) CGFloat constant;
@property(nonatomic,getter=isActive) BOOL active;
+ (void)activateConstraints:(NSArray<NSLayoutConstraint *> *)constraints;
+ (void)deactivateConstraints:(NSArray<NSLayoutConstraint *> *)constraints;
@end
@interface UIView : UIResponder
@property(nonatomic) CGRect frame,bounds;
@property(nonatomic) BOOL hidden,translatesAutoresizingMaskIntoConstraints,userInteractionEnabled;
@property(nonatomic) BOOL isAccessibilityElement;
@property(nonatomic) UIViewContentMode contentMode;
@property(nonatomic,strong) UIColor *backgroundColor,*tintColor;
@property(nonatomic,weak) UIView *superview;
@property(nonatomic,readonly) NSArray<UIView *> *subviews;
@property(nonatomic,strong) NSMutableArray<NSLayoutConstraint *> *constraints;
@property(nonatomic,readonly) NSLayoutAnchor *leadingAnchor,*trailingAnchor,*centerYAnchor,*widthAnchor,*heightAnchor;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)addSubview:(UIView *)view;
- (void)removeFromSuperview;
- (void)setNeedsLayout;
- (void)layoutIfNeeded;
- (void)layoutSubviews;
@end
@interface UIImage : NSObject
@property(nonatomic,copy) NSString *symbolName;
@property(nonatomic) CGSize size;
+ (instancetype)systemImageNamed:(NSString *)name;
@end
@interface UIImageView : UIView
@property(nonatomic,strong) UIImage *image;
- (instancetype)initWithImage:(UIImage *)image;
@end
@interface UILabel : UIView
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic) NSTextAlignment textAlignment;
- (CGSize)sizeThatFits:(CGSize)size;
@end
@interface UISwitch : UIView
@property(nonatomic,getter=isOn) BOOL on;
@property(nonatomic,weak) id target;
@property(nonatomic) SEL action;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events;
- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events;
- (void)sendActionsForControlEvents:(UIControlEvents)events;
@end
@interface UITableViewCell : UIView
@property(nonatomic,strong) UIView *contentView,*selectedBackgroundView,*accessoryView;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *textLabel,*detailTextLabel;
@property(nonatomic) UITableViewCellAccessoryType accessoryType;
@property(nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property(nonatomic,getter=isEditing) BOOL editing;
@property(nonatomic) BOOL shouldIndentWhileEditing,showsReorderControl;
@property(nonatomic,readonly) NSUInteger nativeImageLayouts;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier;
- (void)prepareForReuse;
@end
@interface UITableView : UIView
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
@end
@interface UIPasteboard : NSObject
@property(nonatomic,copy) NSString *string;
+ (instancetype)generalPasteboard;
@end
@interface UIViewController : UIResponder
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
@end
@interface UIAlertController : UIViewController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;
@end
