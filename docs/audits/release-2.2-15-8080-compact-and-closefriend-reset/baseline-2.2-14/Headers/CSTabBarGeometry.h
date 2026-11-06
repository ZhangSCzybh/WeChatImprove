#ifndef CS_TAB_BAR_GEOMETRY_H
#define CS_TAB_BAR_GEOMETRY_H
#include <math.h>
typedef struct { double x, y, width, height; } CSTabBarRect;
static inline double CSTabBarClamp(double value, double low, double high, double fallback) {
    return fmin(high, fmax(low, isfinite(value) ? value : fallback));
}
// Coordinates are local to the untouched native tab bar. Negative y is intentional.
static inline CSTabBarRect CSTabBarFloatingRect(double width, double height,
                                                double scale, double contentHeight, double lift) {
    if (!isfinite(width) || !isfinite(height) || width<=0 || height<=0) return (CSTabBarRect){0};
    double w=fmin(width, fmax(176, width*CSTabBarClamp(scale,.6,1,.9)));
    double h=CSTabBarClamp(contentHeight,44,80,52);
    // Lift is measured from the native host's bottom edge, without an implicit safe-area gap.
    double bottom=height-CSTabBarClamp(lift,0,100,0);
    return (CSTabBarRect){(width-w)/2,bottom-h,w,h};
}
static inline CSTabBarRect CSTabBarItemRect(CSTabBarRect rect, unsigned index, unsigned count, int rtl) {
    if (!count || index>=count) return (CSTabBarRect){0};
    double width=rect.width/count;
    return (CSTabBarRect){rect.x+(rtl ? count-1-index : index)*width,rect.y,width,rect.height};
}
// Return the total contentInset.bottom, preserving the host's existing minimum.
static inline double CSTabBarRequiredBottomInset(double viewportBottom, double floatingTop,
                                                 double nativeBottom, double systemAdjustment) {
    double overlap=fmax(0,viewportBottom-floatingTop+8);
    return fmax(nativeBottom,overlap-fmax(0,systemAdjustment));
}
#endif
