#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSDictionary *_Nullable CSAutomationEventFromWrap(id wrap,NSString *account,NSString *session);
FOUNDATION_EXPORT NSDictionary *_Nullable CSAutomationEventFromPat(id pat,NSString *account,NSString *conversation);
// Read-only normalization of the raw 10002 sysmsg path, before native pat aggregation.
FOUNDATION_EXPORT NSDictionary *_Nullable CSAutomationPatFromXMLMessage(id wrap,NSString *session);
FOUNDATION_EXPORT NSArray<NSString *> *CSAutomationMessageIdentifiers(id wrap,NSString *account,NSString *conversation);
FOUNDATION_EXPORT void CSAutomationMarkOwnedSend(id wrap);
FOUNDATION_EXPORT BOOL CSAutomationIsOwnedSend(id wrap);
// Retains the stable identity after native submission/synchronization rebuilds wrappers.
FOUNDATION_EXPORT void CSAutomationRememberOwnedSend(id wrap,NSString *account,NSString *conversation);
NS_ASSUME_NONNULL_END
