#include "CSQuickPanelGesturePolicy.h"
#include <float.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

static unsigned long checks;

static void require(int condition, const char *name, double dx, double dy) {
    checks++;
    if (condition) return;
    fprintf(stderr,"FAIL %s (dx=%.17g, dy=%.17g)\n",name,dx,dy);
    exit(1);
}

static void expect(double dx, double dy, CSQuickPanelSwipeDecision expected, const char *name) {
    CSQuickPanelSwipeDecision actual=CSQuickPanelDecideSwipe(dx,dy);
    if (actual!=expected) fprintf(stderr,"decision=%d, expected=%d\n",actual,expected);
    require(actual==expected,name,dx,dy);
}

static void thresholds(void) {
    expect(0,0,CSQuickPanelSwipeWaiting,"stationary contact does not cancel a tap");
    expect(-0.0,-0.0,CSQuickPanelSwipeWaiting,"signed zero stays pending");
    expect(0,nextafter(-48.0,0),CSQuickPanelSwipeWaiting,"upward distance below boundary");
    expect(0,-48,CSQuickPanelSwipeRecognized,"upward distance at boundary");
    expect(0,nextafter(-48.0,-INFINITY),CSQuickPanelSwipeRecognized,"upward distance beyond boundary");
    expect(0,nextafter(12.0,0),CSQuickPanelSwipeWaiting,"downward distance below rejection boundary");
    expect(0,12,CSQuickPanelSwipeRejected,"downward distance at rejection boundary");
    expect(0,500,CSQuickPanelSwipeRejected,"downward swipe never opens panel");
    expect(nextafter(14.0,0),0,CSQuickPanelSwipeWaiting,"horizontal jitter below rejection boundary");
    expect(14,0,CSQuickPanelSwipeRejected,"right swipe yields to tabs");
    expect(-14,0,CSQuickPanelSwipeRejected,"left swipe yields to tabs");
    expect(160,-20,CSQuickPanelSwipeRejected,"long horizontal drag yields to tabs");
    expect(-160,-20,CSQuickPanelSwipeRejected,"mirrored horizontal drag yields to tabs");
    expect(13,-30,CSQuickPanelSwipeWaiting,"small diagonal adjustment stays pending");
    expect(40,-58,CSQuickPanelSwipeRecognized,"upward cone includes boundary");
    expect(-40,-58,CSQuickPanelSwipeRecognized,"upward cone includes mirrored boundary");
    expect(40,nextafter(-58.0,0),CSQuickPanelSwipeWaiting,"outside upward cone stays pending");
    expect(23,-20,CSQuickPanelSwipeWaiting,"horizontal cone excludes exact boundary");
    expect(nextafter(23.0,INFINITY),-20,CSQuickPanelSwipeRejected,"inside horizontal cone yields immediately");
    expect(DBL_MAX,0,CSQuickPanelSwipeRejected,"extreme horizontal value remains safe");
    expect(0,-DBL_MAX,CSQuickPanelSwipeRecognized,"extreme vertical value remains safe");
    expect(DBL_MIN,-DBL_MIN,CSQuickPanelSwipeWaiting,"subnormal-scale movement does not trigger");
}

static void invalidInputs(void) {
    const double invalid[]={NAN,INFINITY,-INFINITY};
    const double ordinary[]={0,14,-48,DBL_MAX,-DBL_MAX};
    for (unsigned i=0;i<sizeof(invalid)/sizeof(*invalid);i++) {
        for (unsigned j=0;j<sizeof(ordinary)/sizeof(*ordinary);j++) {
            expect(invalid[i],ordinary[j],CSQuickPanelSwipeRejected,"non-finite x is rejected");
            expect(ordinary[j],invalid[i],CSQuickPanelSwipeRejected,"non-finite y is rejected");
        }
        for (unsigned j=0;j<sizeof(invalid)/sizeof(*invalid);j++)
            expect(invalid[i],invalid[j],CSQuickPanelSwipeRejected,"non-finite pair is rejected");
    }
}

static void directionalTrajectories(void) {
    for (unsigned step=0;step<=4000;step++) {
        double distance=step*.25;
        expect(0,-distance,distance<48 ? CSQuickPanelSwipeWaiting : CSQuickPanelSwipeRecognized,
            "progressive pure upward swipe opens exactly at threshold");
        expect(distance,0,distance<14 ? CSQuickPanelSwipeWaiting : CSQuickPanelSwipeRejected,
            "progressive pure horizontal swipe never opens");
        expect(0,distance,distance<12 ? CSQuickPanelSwipeWaiting : CSQuickPanelSwipeRejected,
            "progressive pure downward swipe never opens");
    }
}

static uint64_t randomState=UINT64_C(0x5e2531d98f07a6c3);
static uint64_t nextRandom(void) {
    randomState^=randomState<<13;
    randomState^=randomState>>7;
    randomState^=randomState<<17;
    return randomState;
}
static double unitRandom(void) {
    return (double)(nextRandom()>>11)*0x1.0p-53;
}

static void invariants(double dx, double dy) {
    CSQuickPanelSwipeDecision result=CSQuickPanelDecideSwipe(dx,dy);
    require(result==CSQuickPanelSwipeWaiting || result==CSQuickPanelSwipeRejected || result==CSQuickPanelSwipeRecognized,
        "all finite inputs return a defined state",dx,dy);
    require(result==CSQuickPanelDecideSwipe(-dx,dy),"left/right geometry is symmetric",dx,dy);
    if (result==CSQuickPanelSwipeRecognized) {
        require(dy<=-48,"recognized gesture has sufficient upward travel",dx,dy);
        // Division avoids overflowing when randomized finite inputs approach DBL_MAX.
        require(fabs(dx)/(-dy)<=1.0/1.45+1e-12,"recognized gesture remains inside upward cone",dx,dy);
    }
    if (dy>=12) require(result==CSQuickPanelSwipeRejected,"downward movement cannot be admitted",dx,dy);
    if (fabs(dx)>=14 && fabs(dx)/(fabs(dy)+1)>2)
        require(result==CSQuickPanelSwipeRejected,"clearly horizontal movement always yields",dx,dy);
    if (fabs(dx)<14 && dy>-48 && dy<12)
        require(result==CSQuickPanelSwipeWaiting,"small movement preserves the original touch",dx,dy);
    if (dy>=0) require(result!=CSQuickPanelSwipeRecognized,"non-upward gesture never opens",dx,dy);
}

static void randomizedGeometry(void) {
    for (unsigned i=0;i<100000;i++) invariants((unitRandom()*2-1)*2000,(unitRandom()*2-1)*2000);
    for (unsigned i=0;i<100000;i++) {
        double dx=ldexp(unitRandom()*2-1,(int)(nextRandom()%2047)-1023);
        double dy=ldexp(unitRandom()*2-1,(int)(nextRandom()%2047)-1023);
        invariants(dx,dy);
    }
}

int main(void) {
    thresholds();
    invalidInputs();
    directionalTrajectories();
    randomizedGeometry();
    printf("Quick panel gesture policy: %lu checks passed (200000 deterministic randomized input pairs).\n",checks);
    return 0;
}
