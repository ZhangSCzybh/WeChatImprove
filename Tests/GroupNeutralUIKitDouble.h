// Rendering-state double only. No real Core Animation or hit-testing is executed.
@interface GroupNeutralHeader : NSObject
@property(nonatomic) CGRect frame;
@end
@implementation GroupNeutralHeader @end
@interface GroupNeutralView : NSObject
+ (void)performWithoutAnimation:(void (^)(void))changes;
@end
@implementation GroupNeutralView
+ (void)performWithoutAnimation:(void (^)(void))changes { if(changes)changes(); }
@end
#define UIView GroupNeutralView
@interface GroupNeutralGesture : NSObject
@property(nonatomic) BOOL enabled;
@end
@implementation GroupNeutralGesture @end
@interface GroupNeutralLayer : NSObject
@property(nonatomic,strong) GroupNeutralLayer *mask;
@property(nonatomic) CGRect bounds;
+ (instancetype)layer;
@end
@implementation GroupNeutralLayer
+ (instancetype)layer { return [self new]; }
@end
@interface GroupNeutralTransaction : NSObject
+ (void)begin;
+ (void)commit;
+ (void)setDisableActions:(BOOL)disable;
@end
@implementation GroupNeutralTransaction
+ (void)begin {}
+ (void)commit {}
+ (void)setDisableActions:(BOOL)disable { (void)disable; }
@end
#define CALayer GroupNeutralLayer
#define CATransaction GroupNeutralTransaction
