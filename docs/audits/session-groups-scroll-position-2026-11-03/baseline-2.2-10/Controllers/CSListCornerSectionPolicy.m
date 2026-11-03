#import "CSListCornerSectionPolicy.h"
BOOL CSListCornerHidesSection(CSListCornerPage page, NSInteger section) {
    return page==CSListCornerPageContacts && section>=0 && section<=3;
}
double CSListCornerSectionGap(CSListCornerPage page, NSInteger section, double pinnedGap, double normalGap) {
    if (page==CSListCornerPageSession) return section==0 ? pinnedGap : (section==1 || section==2 ? normalGap : 0);
    return CSListCornerHidesSection(page,section) ? 0 : 10;
}
double CSListCornerHeaderHeight(CSListCornerPage page, BOOL enabled, double originalHeight, NSInteger section, double pinnedGap, double normalGap) {
    if (!enabled) return originalHeight;
    if (CSListCornerHidesSection(page,section)) return 0;
    return originalHeight+CSListCornerSectionGap(page,section,pinnedGap,normalGap);
}
double CSListCornerFooterHeight(CSListCornerPage page, BOOL enabled, double originalHeight) {
    return enabled ? (page==CSListCornerPageContacts ? 0 : 0.01) : originalHeight;
}
