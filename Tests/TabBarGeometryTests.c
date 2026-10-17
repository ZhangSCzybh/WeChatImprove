#include "CSTabBarGeometry.h"
#include <assert.h>
#include <stdio.h>
static int closeTo(double a, double b) { return fabs(a-b)<0.001; }
int main(void) {
    CSTabBarRect r=CSTabBarFloatingRect(390,83,34,.9,52,0);
    assert(closeTo(r.width,351) && closeTo(r.x,19.5));
    assert(closeTo(r.y,-11) && closeTo(r.height,52));
    CSTabBarRect raised=CSTabBarFloatingRect(390,83,34,.9,52,30);
    assert(closeTo(raised.y,r.y-30));
    CSTabBarRect plain=CSTabBarFloatingRect(390,49,0,.9,52,0);
    assert(closeTo(plain.y,r.y)); // home indicator must not inflate the content
    CSTabBarRect narrow=CSTabBarFloatingRect(200,49,0,.6,30,0);
    assert(narrow.width>=176 && narrow.height>=44 && narrow.width<=200);
    CSTabBarRect invalid=CSTabBarFloatingRect(390,83,34,NAN,INFINITY,NAN);
    assert(isfinite(invalid.x) && isfinite(invalid.y));
    CSTabBarRect a=CSTabBarItemRect(r,0,4,0), b=CSTabBarItemRect(r,0,4,1);
    assert(closeTo(a.x,r.x) && closeTo(b.x,r.x+r.width*.75));
    assert(closeTo(CSTabBarItemRect(r,3,4,0).x+a.width,r.x+r.width));
    assert(CSTabBarItemRect(r,4,4,0).width==0);
    assert(closeTo(CSTabBarRequiredBottomInset(700,680,0,0),28));
    assert(closeTo(CSTabBarRequiredBottomInset(700,680,0,34),0));
    assert(closeTo(CSTabBarRequiredBottomInset(700,680,10,5),23));
    assert(CSTabBarFloatingRect(0,0,0,.9,52,0).width==0);
    puts("tabbar geometry: PASS");
}
