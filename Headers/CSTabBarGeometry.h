#ifndef CS_TAB_BAR_GEOMETRY_H
#define CS_TAB_BAR_GEOMETRY_H
#include <math.h>
typedef struct { double x, y, width, height; } CSTabBarRect;
typedef struct { CSTabBarRect mainRect, actionRect; int structure; } CSTabBarLayout;
typedef struct { double scale, contentHeight; } CSTabBarQuickStyle;
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
// A valid point width takes precedence over the retained legacy scale setting.
// Missing/zero/invalid values keep the original layout byte-for-byte.
static inline CSTabBarRect CSTabBarFloatingRectWithWidth(double hostWidth, double hostHeight,
                                                        double scale, double contentHeight, double lift,
                                                        double contentWidth) {
    CSTabBarRect rect=CSTabBarFloatingRect(hostWidth,hostHeight,scale,contentHeight,lift);
    if (rect.width<=0 || !isfinite(contentWidth) || contentWidth<176 || contentWidth>1024) return rect;
    rect.width=fmin(hostWidth,contentWidth);
    rect.x=(hostWidth-rect.width)/2;
    return rect;
}
static inline CSTabBarQuickStyle CSTabBarQuickStyleAtIndex(unsigned index) {
    if (index==0) return (CSTabBarQuickStyle){.72,58};
    if (index==1) return (CSTabBarQuickStyle){.8,60};
    return (CSTabBarQuickStyle){.9,62};
}
static inline int CSTabBarQuickStyleIndex(double scale, double contentHeight, double contentWidth) {
    if (contentWidth!=0 || !isfinite(scale) || !isfinite(contentHeight)) return -1;
    for (unsigned index=0;index<3;index++) {
        CSTabBarQuickStyle style=CSTabBarQuickStyleAtIndex(index);
        if (fabs(scale-style.scale)<.000001 && fabs(contentHeight-style.contentHeight)<.000001) return (int)index;
    }
    return -1;
}
static inline CSTabBarRect CSTabBarItemRect(CSTabBarRect rect, unsigned index, unsigned count, int rtl) {
    if (!count || index>=count) return (CSTabBarRect){0};
    double width=rect.width/count;
    return (CSTabBarRect){rect.x+(rtl ? count-1-index : index)*width,rect.y,width,rect.height};
}
// Eight points of overlap at normal widths; narrow hosts retain enough clear
// space for a full 28 pt icon centered in each adjacent native slot.
static inline double CSTabBarCenteredOverlap(double totalWidth, double actionWidth) {
    return fmin(8,fmax(0,((totalWidth-actionWidth)/8-14)*4/3));
}
// Structure values match CSTabBarStructure without pulling UIKit into geometry tests.
// The separated action can be taller than the main surface; both share a center line.
static inline CSTabBarLayout CSTabBarLayoutMake(CSTabBarRect total, int structure,
                                                double gap, double size, double centerScale, int rtl, double hostWidth) {
    if (!isfinite(total.x) || !isfinite(total.y) || !isfinite(total.width) || !isfinite(total.height) ||
        total.width<=0 || total.height<=0) return (CSTabBarLayout){0};
    CSTabBarLayout layout={total,{0},0};
    if (structure==1) {
        double available=fmax(0,total.width-128);
        double diameter=fmin(CSTabBarClamp(size,44,80,52),available);
        // A width that cannot fit any action uses the intact classic geometry.
        if (diameter<=0) return layout;
        layout.structure=1;
        // The original 12 pt gap defines the four-tab width. Changing only the
        // gap expands/contracts the centered group instead of squeezing tabs.
        double baselineGap=fmin(12,fmax(0,available-diameter));
        layout.mainRect.width=total.width-diameter-baselineGap;
        double center=total.x+total.width/2;
        double host=isfinite(hostWidth) && hostWidth>0 ? hostWidth : total.x+total.width;
        double groupLimit=fmax(0,2*fmin(center,host-center));
        double maxGap=fmax(0,groupLimit-layout.mainRect.width-diameter);
        double spacing=fmin(CSTabBarClamp(gap,0,32,12),maxGap);
        double groupWidth=layout.mainRect.width+diameter+spacing;
        double left=center-groupWidth/2;
        layout.mainRect.x=left+(rtl ? diameter+spacing : 0);
        // Preserve the configured bottom/lift for the entire structure when
        // the independent action is taller than the four-tab surface.
        layout.mainRect.y-=fmax(0,(diameter-total.height)/2);
        layout.actionRect=(CSTabBarRect){rtl ? left : left+groupWidth-diameter,
            layout.mainRect.y+(total.height-diameter)/2,diameter,diameter};
    } else if (structure==2) {
        layout.structure=2;
        double scale=CSTabBarClamp(centerScale,.75,1.8,1);
        double actionWidth=fmin(total.width,fmax(44,total.width/5*scale));
        double actionHeight=fmin(actionWidth,fmax(44,total.height*CSTabBarClamp(scale,.9,1.35,1)));
        layout.mainRect.y-=fmax(0,(actionHeight-total.height)/2);
        layout.actionRect=(CSTabBarRect){total.x+(total.width-actionWidth)/2,
            layout.mainRect.y+(total.height-actionHeight)/2,actionWidth,actionHeight};
    }
    return layout;
}
static inline CSTabBarRect CSTabBarLayoutItemRect(CSTabBarLayout layout, unsigned index, unsigned count, int rtl) {
    if (!count || index>=count) return (CSTabBarRect){0};
    if (layout.structure!=2 || count!=4) return CSTabBarItemRect(layout.mainRect,index,count,rtl);
    unsigned position=rtl ? count-1-index : index;
    double overlap=CSTabBarCenteredOverlap(layout.mainRect.width,layout.actionRect.width);
    double reservedWidth=fmax(0,layout.actionRect.width-overlap*2);
    double width=(layout.mainRect.width-reservedWidth)/count;
    double offset=position*width+(position>=2 ? reservedWidth : 0);
    return (CSTabBarRect){layout.mainRect.x+offset,layout.mainRect.y,width,layout.mainRect.height};
}
// Return the total contentInset.bottom, preserving the host's existing minimum.
static inline double CSTabBarRequiredBottomInset(double viewportBottom, double floatingTop,
                                                 double nativeBottom, double systemAdjustment) {
    double overlap=fmax(0,viewportBottom-floatingTop+8);
    return fmax(nativeBottom,overlap-fmax(0,systemAdjustment));
}
#endif
