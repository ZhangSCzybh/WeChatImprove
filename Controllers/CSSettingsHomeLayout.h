#import <CoreGraphics/CoreGraphics.h>
#import <math.h>

/// Distances are measured from the natural top, independent of navigation/safe-area insets.
static inline CGFloat CSSettingsHomeRailY(CGFloat profileHeight, CGFloat distance, CGFloat topInset) {
    return topInset+MAX(0,profileHeight-distance);
}
static inline CGFloat CSSettingsHomeMaximumDistance(CGFloat contentHeight, CGFloat viewportHeight,
                                                    CGFloat topInset, CGFloat bottomInset) {
    return MAX(0,contentHeight-viewportHeight+topInset+bottomInset);
}
static inline CGFloat CSSettingsHomeClampedDistance(CGFloat requested, CGFloat maximum) {
    return MIN(MAX(0,requested),MAX(0,maximum));
}
static inline CGFloat CSSettingsHomeAdjustedDistance(CGFloat distance, CGFloat oldHeight, CGFloat newHeight) {
    return distance>=oldHeight && oldHeight>0 ? MAX(0,distance+newHeight-oldHeight) : distance;
}
