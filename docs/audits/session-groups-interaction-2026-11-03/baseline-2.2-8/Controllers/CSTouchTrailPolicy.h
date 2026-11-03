#import <Foundation/Foundation.h>
#include <math.h>
static const NSUInteger CSTouchTrailMaximumDots=48;
static inline BOOL CSTouchTrailShouldDisplay(BOOL enabled, BOOL recordingOnly, BOOL captured, BOOL active) {
    return enabled && active && (!recordingOnly || captured);
}
static inline double CSTouchTrailSampleInterval(double density) {
    if (!isfinite(density) || density<1) density=50;
    return MAX(1.0/30.0,0.21-MIN(100.0,density)/500.0);
}
static inline BOOL CSTouchTrailShouldSample(double now, double last, double dx, double dy) {
    return now-last>=1.0/60.0 && dx*dx+dy*dy>=1.0;
}
