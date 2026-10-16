#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN
typedef struct { CGFloat red, green, blue, alpha; } CSBubbleRGBA;
typedef struct { CGFloat top, left, bottom, right; } CSBubbleInsets;
typedef struct { CGSize size; CSBubbleInsets caps; } CSBubbleTemplateMetrics;

// Immutable snapshot; construction never writes defaults. Colors are component based, not UIKit objects.
@interface CSBubbleStyleConfiguration : NSObject
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, readonly) CGFloat radius;
@property(nonatomic, readonly) NSUInteger generation;
@property(nonatomic, copy, readonly) NSDictionary *values;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults generation:(NSUInteger)generation;
- (CSBubbleRGBA)colorForOutgoing:(BOOL)outgoing dark:(BOOL)dark payment:(BOOL)payment;
@end
FOUNDATION_EXPORT CGFloat CSBubbleFittedRadius(CGFloat radius, NSUInteger position, CGFloat scale, CSBubbleInsets padding, CGSize targetSize);
FOUNDATION_EXPORT CGFloat CSBubbleReadComponent(NSUserDefaults *defaults, NSString *key, CGFloat fallback);
FOUNDATION_EXPORT BOOL CSBubbleTemplateDescribe(CGFloat radius, NSUInteger position, CGFloat scale,
                                                CSBubbleInsets padding, CSBubbleTemplateMetrics *metrics);
FOUNDATION_EXPORT CGImageRef _Nullable CSBubbleCreateTemplate(CSBubbleRGBA color, CGFloat radius,
    NSUInteger position, CGFloat scale, CSBubbleInsets padding, BOOL highlighted) CF_RETURNS_RETAINED;
// Nil means the native image cannot be safely inspected. Insets describe transparent perimeter only.
// Text templates exclude the narrow native arrow when locating the straight body edges.
FOUNDATION_EXPORT BOOL CSBubbleNativeBodyPadding(CGImageRef image, CGFloat scale, CSBubbleInsets *padding);
FOUNDATION_EXPORT BOOL CSBubbleNativePadding(CGImageRef image, CGFloat scale, CSBubbleInsets *padding);

// The same ownership protocol is used by the UIKit adapter and the executable macOS regressions.
@interface CSBubbleImageOwnership : NSObject
@property(nonatomic, strong, nullable) id nativeImage;
@property(nonatomic, strong, nullable) id nativeHighlightedImage;
@property(nonatomic, strong, nullable) id generatedImage;
@property(nonatomic, strong, nullable) id generatedHighlightedImage;
- (void)captureImage:(nullable id)image highlighted:(BOOL)highlighted;
- (nullable id)restoredImageForCurrent:(nullable id)current highlighted:(BOOL)highlighted;
@end
NS_ASSUME_NONNULL_END
