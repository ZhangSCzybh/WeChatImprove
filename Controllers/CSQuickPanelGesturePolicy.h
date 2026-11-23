#ifndef CSQuickPanelGesturePolicy_h
#define CSQuickPanelGesturePolicy_h
#include <math.h>

typedef enum {
    CSQuickPanelSwipeWaiting,
    CSQuickPanelSwipeRejected,
    CSQuickPanelSwipeRecognized
} CSQuickPanelSwipeDecision;

// Discrete recognition leaves taps and short input adjustments untouched.
static inline CSQuickPanelSwipeDecision CSQuickPanelDecideSwipe(double dx, double dy) {
    if (!isfinite(dx) || !isfinite(dy)) return CSQuickPanelSwipeRejected;
    double horizontal=fabs(dx), vertical=fabs(dy);
    if (dy>=12 || (horizontal>=14 && horizontal>vertical*1.15)) return CSQuickPanelSwipeRejected;
    if (-dy>=48 && -dy>=horizontal*1.45) return CSQuickPanelSwipeRecognized;
    return CSQuickPanelSwipeWaiting;
}
#endif
