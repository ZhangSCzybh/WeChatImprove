#import <UIKit/UIKit.h>
#import <objc/message.h>

@implementation UIResponder
- (UIResponder *)nextResponder {return nil;}
@end
@implementation UIColor
+ (instancetype)named:(NSString *)name {UIColor *color=[self new];color.name=name;return color;}
+ (instancetype)labelColor {return [self named:@"label"];}
+ (instancetype)secondaryLabelColor {return [self named:@"secondaryLabel"];}
+ (instancetype)tertiarySystemGroupedBackgroundColor {return [self named:@"tertiaryGrouped"];}
+ (instancetype)secondarySystemGroupedBackgroundColor {return [self named:@"secondaryGrouped"];}
+ (instancetype)systemGrayColor {return [self named:@"gray"];}
+ (instancetype)systemBlueColor {return [self named:@"blue"];}
- (BOOL)isEqual:(id)other {return [other isKindOfClass:UIColor.class] && [self.name isEqual:[other name]];}
- (NSUInteger)hash {return self.name.hash;}
@end
@implementation NSLayoutAnchor
- (NSLayoutConstraint *)constraintEqualToAnchor:(NSLayoutAnchor *)anchor {return [self constraintEqualToAnchor:anchor constant:0];}
- (NSLayoutConstraint *)constraintEqualToAnchor:(NSLayoutAnchor *)anchor constant:(CGFloat)constant {
    NSLayoutConstraint *constraint=[NSLayoutConstraint new];constraint.firstAnchor=self;constraint.secondAnchor=anchor;constraint.constant=constant;return constraint;
}
- (NSLayoutConstraint *)constraintEqualToConstant:(CGFloat)constant {return [self constraintEqualToAnchor:nil constant:constant];}
@end
@implementation NSLayoutConstraint
+ (void)activateConstraints:(NSArray<NSLayoutConstraint *> *)constraints {
    for(NSLayoutConstraint *constraint in constraints) {constraint.active=YES;[constraint.firstAnchor.view.constraints addObject:constraint];}
}
+ (void)deactivateConstraints:(NSArray<NSLayoutConstraint *> *)constraints {
    for(NSLayoutConstraint *constraint in constraints) {constraint.active=NO;[constraint.firstAnchor.view.constraints removeObjectIdenticalTo:constraint];}
}
@end

// This fixture intentionally gives native UITableViewCell control of its built-in
// imageView frame after constraints. It detects dependence on UIKit's private
// layout order, while applying the public anchor equations to owned subviews.
static CGFloat AttributeValue(UIView *view,NSLayoutAttribute attribute) {
    switch(attribute) {
        case NSLayoutAttributeLeading:return CGRectGetMinX(view.bounds);
        case NSLayoutAttributeTrailing:return CGRectGetMaxX(view.bounds);
        case NSLayoutAttributeCenterY:return CGRectGetMidY(view.bounds);
        case NSLayoutAttributeWidth:return CGRectGetWidth(view.bounds);
        case NSLayoutAttributeHeight:return CGRectGetHeight(view.bounds);
    }
}
static void SolveConstraints(UIView *view) {
    CGRect frame=view.frame;
    // Dimensions precede positions so center/trailing constraints are independent
    // of their declaration order. This supports the production anchor vocabulary.
    for(NSUInteger pass=0;pass<2;pass++) for(NSLayoutConstraint *constraint in view.constraints) {
        if(!constraint.active)continue;
        NSLayoutAttribute attribute=constraint.firstAnchor.attribute;
        BOOL dimension=attribute==NSLayoutAttributeWidth || attribute==NSLayoutAttributeHeight;
        if(dimension!=(pass==0))continue;
        CGFloat value=constraint.constant+(constraint.secondAnchor ? AttributeValue(constraint.secondAnchor.view,constraint.secondAnchor.attribute) : 0);
        switch(attribute) {
            case NSLayoutAttributeLeading:frame.origin.x=value;break;
            case NSLayoutAttributeTrailing:frame.origin.x=value-frame.size.width;break;
            case NSLayoutAttributeCenterY:frame.origin.y=value-frame.size.height/2;break;
            case NSLayoutAttributeWidth:frame.size.width=value;break;
            case NSLayoutAttributeHeight:frame.size.height=value;break;
        }
    }
    view.frame=frame;
    for(UIView *child in view.subviews)SolveConstraints(child);
}
@interface UIView ()
@property(nonatomic,strong) NSMutableArray<UIView *> *mutableSubviews;
@end
@implementation UIView
- (instancetype)init {
    if((self=[super init])) {_mutableSubviews=[NSMutableArray array];_constraints=[NSMutableArray array];_translatesAutoresizingMaskIntoConstraints=YES;_userInteractionEnabled=YES;}
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {if((self=[self init]))self.frame=frame;return self;}
- (void)setFrame:(CGRect)frame {_frame=frame;_bounds.size=frame.size;}
- (void)setBounds:(CGRect)bounds {_bounds=bounds;_frame.size=bounds.size;}
- (NSArray<UIView *> *)subviews {return [self.mutableSubviews copy];}
- (void)addSubview:(UIView *)view {[view removeFromSuperview];view.superview=self;[self.mutableSubviews addObject:view];}
- (void)removeFromSuperview {[self.superview.mutableSubviews removeObjectIdenticalTo:self];self.superview=nil;}
- (NSLayoutAnchor *)anchor:(NSLayoutAttribute)attribute {NSLayoutAnchor *anchor=[NSLayoutAnchor new];anchor.view=self;anchor.attribute=attribute;return anchor;}
- (NSLayoutAnchor *)leadingAnchor {return [self anchor:NSLayoutAttributeLeading];}
- (NSLayoutAnchor *)trailingAnchor {return [self anchor:NSLayoutAttributeTrailing];}
- (NSLayoutAnchor *)centerYAnchor {return [self anchor:NSLayoutAttributeCenterY];}
- (NSLayoutAnchor *)widthAnchor {return [self anchor:NSLayoutAttributeWidth];}
- (NSLayoutAnchor *)heightAnchor {return [self anchor:NSLayoutAttributeHeight];}
- (void)setNeedsLayout {}
- (void)layoutIfNeeded {[self layoutSubviews];}
- (void)layoutSubviews {SolveConstraints(self);}
- (UIResponder *)nextResponder {return self.superview;}
@end
@implementation UIImage
+ (instancetype)systemImageNamed:(NSString *)name {if(!name.length || [name isEqual:@"fixture.unsupported"])return nil;UIImage *image=[self new];image.symbolName=name;image.size=CGSizeMake(20,20);return image;}
@end
@implementation UIImageView
- (instancetype)initWithImage:(UIImage *)image {if((self=[super init]))self.image=image;return self;}
@end
@implementation UILabel
- (CGSize)sizeThatFits:(CGSize)size {return CGSizeMake(MIN(size.width,self.text.length*7),MIN(size.height,20));}
@end
@implementation UISwitch
- (instancetype)init {if((self=[super init]))self.frame=CGRectMake(0,0,51,31);return self;}
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events {self.target=target;self.action=action;}
- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events {if(!target || target==self.target) {self.target=nil;self.action=NULL;}}
- (void)sendActionsForControlEvents:(UIControlEvents)events {if(self.target && self.action)((void(*)(id,SEL,id))objc_msgSend)(self.target,self.action,self);}
@end
@implementation UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier {
    if((self=[super init])) {
        self.frame=CGRectMake(0,0,320,44);_contentView=[UIView new];[self addSubview:_contentView];
        _imageView=[UIImageView new];[_contentView addSubview:_imageView];
        _textLabel=[UILabel new];[_contentView addSubview:_textLabel];
        _detailTextLabel=[UILabel new];[_contentView addSubview:_detailTextLabel];
        _shouldIndentWhileEditing=YES;
    }
    return self;
}
- (void)prepareForReuse {}
- (void)layoutSubviews {
    self.contentView.frame=self.bounds;
    [super layoutSubviews];
    _nativeImageLayouts++;
    // UIKit may use the intrinsic image size and a system text baseline. The
    // plugin must not constrain this UIKit-owned view to implement its own icon.
    self.imageView.frame=CGRectMake(19,11,self.imageView.image ? 20 : 0,self.imageView.image ? 20 : 0);
    self.textLabel.frame=CGRectMake(16,(self.bounds.size.height-20)/2,180,20);
    self.detailTextLabel.frame=CGRectMake(200,(self.bounds.size.height-20)/2,100,20);
}
@end
@implementation UITableView
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {}
@end
@implementation UIPasteboard
+ (instancetype)generalPasteboard {static UIPasteboard *pasteboard;static dispatch_once_t once;dispatch_once(&once,^{pasteboard=[self new];});return pasteboard;}
@end
@implementation UIViewController
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion {if(completion)completion();}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {if(completion)completion();}
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style {return [self new];}
@end
