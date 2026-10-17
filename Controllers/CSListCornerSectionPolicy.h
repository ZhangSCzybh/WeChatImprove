#import <Foundation/Foundation.h>
// Foundation-only values; never introduce UIKit, views, delegates or blocks here.
typedef NS_ENUM(NSInteger, CSListCornerPage) {
    CSListCornerPageSession, CSListCornerPageContacts, CSListCornerPageDiscover, CSListCornerPageMore
};
FOUNDATION_EXPORT double CSListCornerHeaderHeight(CSListCornerPage page, BOOL enabled, double originalHeight, NSInteger section, double pinnedGap, double normalGap);
FOUNDATION_EXPORT double CSListCornerFooterHeight(CSListCornerPage page, BOOL enabled, double originalHeight);
FOUNDATION_EXPORT BOOL CSListCornerHidesSection(CSListCornerPage page, NSInteger section);
FOUNDATION_EXPORT double CSListCornerSectionGap(CSListCornerPage page, NSInteger section, double pinnedGap, double normalGap);
