#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

// Fits without enlarging small images. Invalid or unrepresentable dimensions return CGSizeZero.
FOUNDATION_EXPORT CGSize CSClownImageSize(CGSize imageSize, CGFloat availableWidth);
// Keeps the original top and incoming left / outgoing right edge. Invalid geometry returns CGRectZero.
FOUNDATION_EXPORT CGRect CSClownResizeFrame(CGRect nativeFrame, CGSize size, BOOL outgoing);
// Preserves the native row's space outside its content, with a finite result of at least one point.
FOUNDATION_EXPORT CGFloat CSClownProjectedRowHeight(CGFloat nativeHeight, CGFloat nativeContentHeight,
                                                  CGFloat replacementContentHeight);
// Strict local-time input; invalid dates, trailing characters and daylight-saving gaps are rejected.
FOUNDATION_EXPORT NSDate * _Nullable CSClownDateFromInput(NSString * _Nullable input);
FOUNDATION_EXPORT NSString * _Nullable CSClownDateInput(NSDate * _Nullable date);
FOUNDATION_EXPORT NSString * _Nullable CSClownDateDisplay(NSDate * _Nullable date);
FOUNDATION_EXPORT NSString * _Nullable CSClownDateDisplayWithDetail(NSDate * _Nullable date, BOOL detail);
// Positive ASCII amounts only: 1–9 integer digits and at most two fractional digits, normalized to cents.
FOUNDATION_EXPORT NSString * _Nullable CSClownAmountFromInput(NSString * _Nullable input);

NS_ASSUME_NONNULL_END
