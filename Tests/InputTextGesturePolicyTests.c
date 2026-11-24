#include "CSInputTextGesturePolicy.h"
#include "CSQuickPanelGesturePolicy.h"
#include <float.h>
#include <stdio.h>
#include <stdlib.h>

static unsigned checks;
static void require(int result, const char *message) {
    checks++;
    if (!result) { fprintf(stderr, "FAIL: %s\n", message); exit(1); }
}
static void expect(double dx, double dy, double elapsed, CSInputTextSwipeDecision expected, const char *message) {
    require(CSInputTextDecideSwipe(dx, dy, elapsed) == expected, message);
}

int main(void) {
    expect(0, 0, 0, CSInputTextSwipeWaiting, "a stationary contact preserves the original tap");
    expect(-0.0, -0.0, 0, CSInputTextSwipeWaiting, "signed zero does not choose a direction");
    expect(nextafter(64.0, 0), 0, .2, CSInputTextSwipeWaiting, "rightward travel below the distance threshold waits");
    expect(-nextafter(64.0, 0), 0, .2, CSInputTextSwipeWaiting, "leftward travel below the distance threshold waits");
    expect(64, 0, .2, CSInputTextSwipeRight, "rightward travel at the threshold chooses right");
    expect(-64, 0, .2, CSInputTextSwipeLeft, "leftward travel at the threshold chooses left");
    expect(64, 32, .2, CSInputTextSwipeRight, "the exact horizontal direction cone is admitted");
    expect(-64, -32, .2, CSInputTextSwipeLeft, "the direction cone remains symmetric for an upward left stroke");
    expect(64, nextafter(32.0, INFINITY), .2, CSInputTextSwipeWaiting, "just outside the horizontal cone keeps waiting");
    expect(0, nextafter(12.0, 0), .2, CSInputTextSwipeWaiting, "vertical jitter below the rejection distance preserves a tap");
    expect(0, 12, .2, CSInputTextSwipeRejected, "downward scrolling is rejected at its threshold");
    expect(0, -12, .2, CSInputTextSwipeRejected, "upward scrolling is rejected at its threshold");
    expect(100, 70, .2, CSInputTextSwipeWaiting, "the exact vertical rejection cone boundary waits");
    expect(100, nextafter(70.0, INFINITY), .2, CSInputTextSwipeRejected, "vertical movement inside the rejection cone fails early");
    expect(64, 64, .2, CSInputTextSwipeRejected, "a diagonal scroll cannot operate the draft");
    expect(64, 0, .65, CSInputTextSwipeRight, "the last valid gesture duration is admitted");
    expect(64, 0, nextafter(.65, INFINITY), CSInputTextSwipeRejected, "a long press cannot become an editing gesture");
    expect(0, 0, .7, CSInputTextSwipeRejected, "a stationary long press is rejected for native selection");
    expect(64, 0, -.01, CSInputTextSwipeRejected, "negative elapsed times fail safely");
    expect(DBL_MAX, 0, .2, CSInputTextSwipeRight, "extreme finite horizontal input returns a defined direction");
    expect(-DBL_MAX, 0, .2, CSInputTextSwipeLeft, "extreme finite input preserves its sign");
    expect(DBL_MIN, -DBL_MIN, .2, CSInputTextSwipeWaiting, "tiny movement never triggers editing");
    const double invalid[] = {NAN, INFINITY, -INFINITY};
    for (unsigned i = 0; i < sizeof(invalid) / sizeof(*invalid); i++) {
        expect(invalid[i], 0, .2, CSInputTextSwipeRejected, "non-finite horizontal coordinates fail safely");
        expect(64, invalid[i], .2, CSInputTextSwipeRejected, "non-finite vertical coordinates fail safely");
        expect(64, 0, invalid[i], CSInputTextSwipeRejected, "non-finite elapsed times fail safely");
    }
    require(CSInputTextDecideSwipe(0, -48, .2) == CSInputTextSwipeRejected &&
            CSQuickPanelDecideSwipe(0, -48) == CSQuickPanelSwipeRecognized,
            "input gestures yield the existing shortcut panel's upward stroke");
    require(CSInputTextDecideSwipe(-64, 0, .2) == CSInputTextSwipeLeft &&
            CSQuickPanelDecideSwipe(-64, 0) == CSQuickPanelSwipeRejected,
            "the existing shortcut panel yields a deliberate left editing stroke");
    require(CSInputTextDecideSwipe(64, 0, .2) == CSInputTextSwipeRight &&
            CSQuickPanelDecideSwipe(64, 0) == CSQuickPanelSwipeRejected,
            "the existing shortcut panel yields a deliberate right editing stroke");
    printf("Input text gesture direction/time boundaries and panel coexistence: %u checks passed\n", checks);
    return 0;
}
