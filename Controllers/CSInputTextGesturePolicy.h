#ifndef CSInputTextGesturePolicy_h
#define CSInputTextGesturePolicy_h
#include <math.h>

typedef enum {
    CSInputTextSwipeWaiting, CSInputTextSwipeRejected,
    CSInputTextSwipeLeft, CSInputTextSwipeRight
} CSInputTextSwipeDecision;

// A deliberate short, one-finger horizontal stroke. Vertical scrolling and long
// presses get an early failure; execution waits for the finger to leave the view.
static inline CSInputTextSwipeDecision CSInputTextDecideSwipe(double dx, double dy, double elapsed) {
    if (!isfinite(dx) || !isfinite(dy) || !isfinite(elapsed) || elapsed < 0 || elapsed > .65)
        return CSInputTextSwipeRejected;
    double horizontal = fabs(dx), vertical = fabs(dy);
    if (vertical >= 12 && vertical > horizontal * .7) return CSInputTextSwipeRejected;
    if (horizontal >= 64 && horizontal >= vertical * 2)
        return dx < 0 ? CSInputTextSwipeLeft : CSInputTextSwipeRight;
    return CSInputTextSwipeWaiting;
}
#endif
