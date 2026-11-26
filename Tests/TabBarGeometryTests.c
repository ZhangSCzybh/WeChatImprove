#include "CSTabBarGeometry.h"
#include <assert.h>
#include <stdio.h>
static int closeTo(double a, double b) { return fabs(a-b)<0.001; }
static void requireRectEqual(CSTabBarRect a, CSTabBarRect b) {
    assert(closeTo(a.x,b.x) && closeTo(a.y,b.y) && closeTo(a.width,b.width) && closeTo(a.height,b.height));
}
static void verifyPointWidthAndQuickStyles(void) {
    CSTabBarRect legacy=CSTabBarFloatingRect(390,83,.6,48,30);
    requireRectEqual(CSTabBarFloatingRectWithWidth(390,83,.6,48,30,0),legacy);
    CSTabBarRect custom=CSTabBarFloatingRectWithWidth(390,83,.6,48,30,300);
    assert(closeTo(custom.width,300) && closeTo(custom.x,45));
    assert(closeTo(custom.y,legacy.y) && closeTo(custom.height,legacy.height));
    assert(closeTo(legacy.width,234)); // Custom width never changes legacy scale semantics.
    requireRectEqual(CSTabBarFloatingRectWithWidth(390,83,1,48,30,300),custom);
    requireRectEqual(CSTabBarFloatingRectWithWidth(390,83,NAN,48,30,300),custom);
    const double invalidWidths[]={0,-1,175.99,1024.01,NAN,INFINITY,-INFINITY};
    for (unsigned index=0;index<sizeof(invalidWidths)/sizeof(invalidWidths[0]);index++)
        requireRectEqual(CSTabBarFloatingRectWithWidth(390,83,.6,48,30,invalidWidths[index]),legacy);
    const double widths[]={176,200,300.5,1024};
    const double scales[]={.6,.75,.9,1};
    for (unsigned host=1;host<=1200;host+=17) for (unsigned width=0;width<4;width++) for (unsigned scale=0;scale<4;scale++) {
        CSTabBarRect rect=CSTabBarFloatingRectWithWidth(host,49,scales[scale],52,20,widths[width]);
        assert(closeTo(rect.width,fmin(host,widths[width])));
        assert(closeTo(rect.x*2+rect.width,host));
        assert(rect.x>=0 && rect.x+rect.width<=host+.001);
        assert(closeTo(rect.y+rect.height,29));
        requireRectEqual(CSTabBarFloatingRectWithWidth(host,49,scales[scale],52,20,0),
            CSTabBarFloatingRect(host,49,scales[scale],52,20));
    }
    assert(CSTabBarFloatingRectWithWidth(0,83,.9,52,0,300).width==0);
    assert(CSTabBarFloatingRectWithWidth(NAN,83,.9,52,0,300).width==0);
    assert(CSTabBarFloatingRectWithWidth(390,INFINITY,.9,52,0,300).width==0);
    const double expectedScales[]={.72,.8,.9}, expectedHeights[]={54,60,62};
    const double oldHeights[]={44,48,52};
    for (unsigned index=0;index<3;index++) {
        CSTabBarQuickStyle style=CSTabBarQuickStyleAtIndex(index);
        assert(closeTo(style.scale,expectedScales[index]) && closeTo(style.contentHeight,expectedHeights[index]));
        assert(CSTabBarQuickStyleIndex(style.scale,style.contentHeight,0)==(int)index);
        assert(CSTabBarQuickStyleIndex(style.scale,style.contentHeight,300)==-1);
        assert(CSTabBarQuickStyleIndex(style.scale,style.contentHeight+1,0)==-1);
        assert(CSTabBarQuickStyleIndex(style.scale,oldHeights[index],0)==-1);
    }
    CSTabBarQuickStyle fallback=CSTabBarQuickStyleAtIndex(~0u);
    assert(closeTo(fallback.scale,.9) && closeTo(fallback.contentHeight,62));
    assert(CSTabBarQuickStyleIndex(.6,52,0)==-1);
    assert(CSTabBarQuickStyleIndex(.9,62,351)==-1); // Matching pixel output still represents a manual width.
    assert(CSTabBarQuickStyleIndex(NAN,52,0)==-1);
    assert(CSTabBarQuickStyleIndex(.9,INFINITY,0)==-1);
    assert(CSTabBarQuickStyleIndex(.9,52,NAN)==-1);
}
static void verifyStructures(void) {
    CSTabBarRect total={19.5,31,351,52};
    CSTabBarLayout classic=CSTabBarLayoutMake(total,0,12,52,1,0,390);
    requireRectEqual(classic.mainRect,total);
    assert(classic.structure==0 && classic.actionRect.width==0);
    for (unsigned index=0;index<4;index++)
        requireRectEqual(CSTabBarLayoutItemRect(classic,index,4,0),CSTabBarItemRect(total,index,4,0));

    CSTabBarLayout separated=CSTabBarLayoutMake(total,1,12,52,1,0,390);
    assert(separated.structure==1 && closeTo(separated.mainRect.width,287));
    assert(closeTo(separated.actionRect.x,318.5) && closeTo(separated.actionRect.width,52));
    assert(closeTo(separated.actionRect.x-separated.mainRect.x-separated.mainRect.width,12));
    CSTabBarLayout separatedRTL=CSTabBarLayoutMake(total,1,12,52,1,1,390);
    assert(closeTo(separatedRTL.actionRect.x,total.x));
    assert(closeTo(separatedRTL.mainRect.x,total.x+64));
    for (int gap=0;gap<=32;gap+=4) for (int rtl=0;rtl<=1;rtl++) {
        CSTabBarLayout layout=CSTabBarLayoutMake(total,1,gap,52,1,rtl,390);
        assert(closeTo(layout.mainRect.width,separated.mainRect.width));
        double left=fmin(layout.mainRect.x,layout.actionRect.x);
        double right=fmax(layout.mainRect.x+layout.mainRect.width,layout.actionRect.x+layout.actionRect.width);
        assert(closeTo((left+right)/2,total.x+total.width/2));
        assert(closeTo(right-left-layout.mainRect.width-layout.actionRect.width,gap));
        assert(left>=0 && right<=390);
    }
    // Full-width hosts cap an expanded gap without shrinking the four-tab bar.
    CSTabBarRect full={0,31,390,52};
    CSTabBarLayout edge=CSTabBarLayoutMake(full,1,32,52,1,0,390);
    assert(closeTo(edge.mainRect.width,326));
    assert(closeTo(edge.actionRect.x-edge.mainRect.x-edge.mainRect.width,12));
    assert(closeTo(edge.mainRect.x,0) && closeTo(edge.actionRect.x+edge.actionRect.width,390));
    // Preview origins include the 12 pt sample margin and share the same host contract.
    CSTabBarRect preview={29.55,31,315.9,52};
    CSTabBarLayout previewLayout=CSTabBarLayoutMake(preview,1,32,52,1,0,375);
    assert(previewLayout.mainRect.x>=0 && previewLayout.actionRect.x+previewLayout.actionRect.width<=375);
    CSTabBarLayout taller=CSTabBarLayoutMake(total,1,32,80,1,0,390);
    assert(closeTo(taller.mainRect.y,17) && closeTo(taller.actionRect.y,3) && closeTo(taller.actionRect.height,80));
    assert(closeTo(taller.actionRect.width,80));
    CSTabBarLayout oversized=CSTabBarLayoutMake(total,1,32,81,1,0,390);
    requireRectEqual(oversized.mainRect,taller.mainRect);
    requireRectEqual(oversized.actionRect,taller.actionRect);
    CSTabBarLayout invalidSize=CSTabBarLayoutMake(total,1,12,NAN,1,0,390);
    requireRectEqual(invalidSize.mainRect,separated.mainRect);
    requireRectEqual(invalidSize.actionRect,separated.actionRect);
    assert(closeTo(taller.actionRect.y+taller.actionRect.height/2,taller.mainRect.y+total.height/2));
    assert(closeTo(fmax(taller.mainRect.y+taller.mainRect.height,taller.actionRect.y+taller.actionRect.height),total.y+total.height));
    for (int lift=0;lift<=100;lift+=10) {
        CSTabBarRect lifted=CSTabBarFloatingRect(390,83,.9,44,lift);
        CSTabBarLayout large=CSTabBarLayoutMake(lifted,1,12,80,1,0,390);
        assert(closeTo(large.actionRect.y+large.actionRect.height,83-lift));
        assert(large.mainRect.y+large.mainRect.height<=83-lift);
    }

    CSTabBarLayout centered=CSTabBarLayoutMake(total,2,12,52,1,0,390);
    assert(centered.structure==2 && closeTo(centered.actionRect.width,70.2));
    assert(closeTo(centered.actionRect.y,total.y) && closeTo(centered.actionRect.height,52));
    assert(closeTo(centered.actionRect.x+centered.actionRect.width/2,total.x+total.width/2));
    CSTabBarRect second=CSTabBarLayoutItemRect(centered,1,4,0);
    CSTabBarRect third=CSTabBarLayoutItemRect(centered,2,4,0);
    assert(closeTo(second.x+second.width,centered.actionRect.x+8));
    assert(closeTo(third.x,centered.actionRect.x+centered.actionRect.width-8));
    assert(closeTo(CSTabBarCenteredOverlap(total.width,centered.actionRect.width),8));
    assert(closeTo(CSTabBarLayoutItemRect(centered,3,4,0).x+third.width,total.x+total.width));
    requireRectEqual(CSTabBarLayoutItemRect(centered,0,4,1),CSTabBarLayoutItemRect(centered,3,4,0));
    assert(closeTo(CSTabBarLayoutMake(total,2,0,44,.75,0,390).actionRect.width,52.65));
    assert(closeTo(CSTabBarLayoutMake(total,2,0,72,1.8,0,390).actionRect.width,126.36));
    assert(closeTo(CSTabBarLayoutMake(total,2,0,72,9,0,390).actionRect.width,126.36));
    assert(closeTo(CSTabBarLayoutMake(total,2,0,72,NAN,0,390).actionRect.width,70.2));
    CSTabBarLayout narrowCenter=CSTabBarLayoutMake((CSTabBarRect){0,31,176,80},2,0,52,1.8,0,176);
    double narrowOverlap=CSTabBarCenteredOverlap(176,narrowCenter.actionRect.width);
    assert(narrowOverlap>=0 && narrowOverlap<8);
    assert(closeTo(narrowCenter.actionRect.height,narrowCenter.actionRect.width));
    assert(closeTo(CSTabBarLayoutMake((CSTabBarRect){0,31,176,44},2,0,52,.75,0,176).actionRect.width,44));
    CSTabBarLayout prominent=CSTabBarLayoutMake(total,2,0,52,1.8,0,390);
    assert(closeTo(prominent.actionRect.height,70.2));
    assert(closeTo(CSTabBarCenteredOverlap(total.width,prominent.actionRect.width),8));
    assert(prominent.actionRect.y<prominent.mainRect.y);
    assert(prominent.actionRect.y+prominent.actionRect.height>prominent.mainRect.y+prominent.mainRect.height);
    assert(closeTo(prominent.actionRect.y+prominent.actionRect.height,total.y+total.height));
    assert(closeTo(prominent.actionRect.y+prominent.actionRect.height/2,prominent.mainRect.y+prominent.mainRect.height/2));
    for (int height=44;height<=80;height+=4) for (int lift=0;lift<=100;lift+=10) {
        CSTabBarRect lifted=CSTabBarFloatingRect(390,83,.9,height,lift);
        CSTabBarLayout large=CSTabBarLayoutMake(lifted,2,12,52,1.8,0,390);
        assert(closeTo(fmax(large.mainRect.y+large.mainRect.height,large.actionRect.y+large.actionRect.height),83-lift));
        assert(large.mainRect.y+large.mainRect.height<=83-lift+.001);
        assert(large.actionRect.height>=44);
    }
    const double centerScales[]={.75,1,1.25,1.8};
    for (unsigned width=176;width<=430;width++) for (unsigned scaleIndex=0;scaleIndex<4;scaleIndex++) {
        CSTabBarRect rect={0,31,width,52};
        CSTabBarLayout layout=CSTabBarLayoutMake(rect,2,12,52,centerScales[scaleIndex],0,width);
        double overlap=CSTabBarCenteredOverlap(width,layout.actionRect.width);
        assert(overlap>=0 && overlap<=8);
        assert(layout.actionRect.width>=44 && layout.actionRect.height>=44);
        assert(layout.actionRect.height<=layout.actionRect.width);
        assert(closeTo(layout.actionRect.x+layout.actionRect.width/2,width/2.0));
        for (unsigned index=0;index<4;index++) {
            CSTabBarRect item=CSTabBarLayoutItemRect(layout,index,4,0);
            double center=item.x+item.width/2;
            assert(center+14<=layout.actionRect.x+.001 || center-14>=layout.actionRect.x+layout.actionRect.width-.001);
            requireRectEqual(item,CSTabBarLayoutItemRect(layout,3-index,4,1));
        }
    }
    CSTabBarLayout invalid=CSTabBarLayoutMake(total,1,NAN,INFINITY,NAN,0,390);
    requireRectEqual(invalid.mainRect,separated.mainRect);
    requireRectEqual(invalid.actionRect,separated.actionRect);
    requireRectEqual(CSTabBarLayoutMake(total,99,12,52,1,0,390).mainRect,total);
    assert(CSTabBarLayoutMake((CSTabBarRect){NAN,0,351,52},2,12,52,1,0,390).mainRect.width==0);
    assert(CSTabBarLayoutMake((CSTabBarRect){0,0,0,52},1,12,52,1,0,390).mainRect.width==0);
    assert(CSTabBarLayoutMake((CSTabBarRect){0,0,351,INFINITY},1,12,52,1,0,390).mainRect.width==0);
    assert(CSTabBarLayoutItemRect(centered,4,4,0).width==0);
    assert(CSTabBarLayoutItemRect(centered,0,0,0).width==0);

    // Sweep narrow widths and both directions: fixed main widths and host-safe
    // group expansion, including native minimum widths and centered overlap.
    for (unsigned width=1;width<=430;width++) for (int structure=0;structure<=2;structure++) {
        for (int rtl=0;rtl<=1;rtl++) {
            CSTabBarRect rect={11,31,width,52};
            double hostWidth=width+22;
            CSTabBarLayout layout=CSTabBarLayoutMake(rect,structure,32,80,1.8,rtl,hostWidth);
            assert(isfinite(layout.mainRect.width) && layout.mainRect.width>0);
            assert(layout.mainRect.x>=0 && layout.mainRect.x+layout.mainRect.width<=hostWidth+.001);
            if (structure==1 && layout.structure==1) {
                assert(layout.mainRect.width>=128);
                assert(layout.actionRect.x>=0 && layout.actionRect.x+layout.actionRect.width<=hostWidth+.001);
                assert(rtl ? layout.actionRect.x+layout.actionRect.width<=layout.mainRect.x :
                    layout.mainRect.x+layout.mainRect.width<=layout.actionRect.x);
                CSTabBarLayout zeroGap=CSTabBarLayoutMake(rect,structure,0,80,1.8,rtl,hostWidth);
                CSTabBarLayout defaultGap=CSTabBarLayoutMake(rect,structure,12,80,1.8,rtl,hostWidth);
                assert(closeTo(layout.mainRect.width,zeroGap.mainRect.width));
                assert(closeTo(layout.mainRect.width,defaultGap.mainRect.width));
            }
            for (unsigned index=0;index<4;index++) {
                CSTabBarRect item=CSTabBarLayoutItemRect(layout,index,4,rtl);
                assert(isfinite(item.x) && isfinite(item.width) && item.width>=0);
                assert(item.x>=layout.mainRect.x-.001 && item.x+item.width<=layout.mainRect.x+layout.mainRect.width+.001);
                if (layout.structure==2 && width>=176) {
                    double center=item.x+item.width/2;
                    assert(center+14<=layout.actionRect.x+.001 || center-14>=layout.actionRect.x+layout.actionRect.width-.001);
                }
            }
        }
    }
}
int main(void) {
    verifyPointWidthAndQuickStyles();
    verifyStructures();
    CSTabBarRect r=CSTabBarFloatingRect(390,83,.9,52,0);
    assert(closeTo(r.width,351) && closeTo(r.x,19.5));
    assert(closeTo(r.y,31) && closeTo(r.height,52));
    CSTabBarRect raised=CSTabBarFloatingRect(390,83,.9,52,30);
    assert(closeTo(raised.y,r.y-30));
    CSTabBarRect plain=CSTabBarFloatingRect(390,49,.9,52,0);
    assert(closeTo(plain.y+plain.height,49));
    assert(closeTo(r.y+r.height,83)); // lift zero means the actual host bottom
    assert(closeTo(raised.y+raised.height,53));
    for (int h=44;h<=80;h++) {
        CSTabBarRect zero=CSTabBarFloatingRect(430,83,.7,h,0);
        assert(closeTo(zero.y+zero.height,83));
        assert(closeTo(zero.height,h));
    }
    CSTabBarRect narrow=CSTabBarFloatingRect(200,49,.6,30,0);
    assert(narrow.width>=176 && narrow.height>=44 && narrow.width<=200);
    CSTabBarRect invalid=CSTabBarFloatingRect(390,83,NAN,INFINITY,NAN);
    assert(isfinite(invalid.x) && isfinite(invalid.y));
    CSTabBarRect a=CSTabBarItemRect(r,0,4,0), b=CSTabBarItemRect(r,0,4,1);
    assert(closeTo(a.x,r.x) && closeTo(b.x,r.x+r.width*.75));
    assert(closeTo(CSTabBarItemRect(r,3,4,0).x+a.width,r.x+r.width));
    assert(CSTabBarItemRect(r,4,4,0).width==0);
    assert(closeTo(CSTabBarRequiredBottomInset(700,680,0,0),28));
    assert(closeTo(CSTabBarRequiredBottomInset(700,680,0,34),0));
    assert(closeTo(CSTabBarRequiredBottomInset(700,680,10,5),23));
    assert(CSTabBarFloatingRect(0,0,.9,52,0).width==0);
    puts("tabbar geometry: PASS");
}
