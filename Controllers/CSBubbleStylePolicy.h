#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN
typedef struct { CGFloat red, green, blue, alpha; } CSBubbleRGBA;
typedef struct { CGFloat top, left, bottom, right; } CSBubbleInsets;
typedef struct { CGSize size; CSBubbleInsets caps; } CSBubbleTemplateMetrics;

typedef NS_ENUM(NSUInteger, CSBubbleStyleKind) {
    CSBubbleStyleRounded = 0,
    CSBubbleStyleStacked = 1 // Persisted value retained for the replacement connected-corner style.
};
typedef NS_ENUM(NSUInteger, CSBubbleGroupPosition) {
    CSBubbleGroupSingle = 0, CSBubbleGroupFirst, CSBubbleGroupMiddle, CSBubbleGroupLast
};
FOUNDATION_EXPORT NSString *const CSBubbleStyleKindKey;
FOUNDATION_EXPORT NSString *CSBubbleStyleKindTitle(CSBubbleStyleKind kind);
FOUNDATION_EXPORT CSBubbleGroupPosition CSBubbleGroupPositionForJoins(BOOL previous, BOOL next);
FOUNDATION_EXPORT NSString *CSBubbleTextColorPreferenceKey(NSUInteger palette, NSString *component);

// Immutable snapshot; construction never writes defaults. Colors are component based, not UIKit objects.
@interface CSBubbleStyleConfiguration : NSObject
@property(nonatomic, readonly) BOOL enabled;
@property(nonatomic, readonly) CGFloat radius;
@property(nonatomic, readonly) CSBubbleStyleKind kind;
@property(nonatomic, readonly) NSUInteger generation;
@property(nonatomic, copy, readonly) NSDictionary *values;
@property(nonatomic, copy, readonly) NSDictionary *backgroundValues;
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults generation:(NSUInteger)generation;
- (CSBubbleRGBA)colorForOutgoing:(BOOL)outgoing dark:(BOOL)dark;
// NO means leave native text colors untouched. Text colors are opaque.
- (BOOL)textColorForOutgoing:(BOOL)outgoing dark:(BOOL)dark color:(CSBubbleRGBA * _Nullable)color;
@end
FOUNDATION_EXPORT CGFloat CSBubbleFittedRadius(CGFloat radius, NSUInteger position, CGFloat scale, CSBubbleInsets padding, CGSize targetSize);
FOUNDATION_EXPORT CGFloat CSBubbleReadComponent(NSUserDefaults *defaults, NSString *key, CGFloat fallback);
FOUNDATION_EXPORT BOOL CSBubbleTemplateDescribe(CGFloat radius, NSUInteger position, CGFloat scale,
                                                CSBubbleInsets padding, CSBubbleTemplateMetrics *metrics);
FOUNDATION_EXPORT CGImageRef _Nullable CSBubbleCreateTemplate(CSBubbleRGBA color, CGFloat radius,
    NSUInteger position, CGFloat scale, CSBubbleInsets padding, BOOL highlighted) CF_RETURNS_RETAINED;
FOUNDATION_EXPORT BOOL CSBubbleStyledTemplateDescribe(CGFloat radius, NSUInteger nativePosition, CGFloat scale,
    CSBubbleInsets padding, CSBubbleStyleKind kind, CSBubbleTemplateMetrics *metrics);
// Native segment position belongs to one split message; group position belongs to
// distinct consecutive messages. Keep the two independent to preserve long text.
FOUNDATION_EXPORT CGImageRef _Nullable CSBubbleCreateStyledTemplate(CSBubbleRGBA color, CGFloat radius,
    NSUInteger nativePosition, CGFloat scale, CSBubbleInsets padding, BOOL highlighted,
    CSBubbleStyleKind kind, CSBubbleGroupPosition group, BOOL outgoing) CF_RETURNS_RETAINED;
// Nil means the native image cannot be safely inspected. Insets describe transparent perimeter only.
// Text templates exclude the narrow native arrow when locating the straight body edges.
FOUNDATION_EXPORT BOOL CSBubbleNativeBodyPadding(CGImageRef image, CGFloat scale, CSBubbleInsets *padding);

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
