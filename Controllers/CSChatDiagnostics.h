#import <Foundation/Foundation.h>
FOUNDATION_EXPORT NSString *const CSChatDiagnosticsEnabledKey;
FOUNDATION_EXPORT void CSChatRecordEvent(NSString *feature, NSString *stage);
FOUNDATION_EXPORT NSString *CSChatDiagnosticReport(void);

// Numeric layout metrics only; no messages, account IDs or object descriptions.
FOUNDATION_EXPORT void CSChatRecordMergeMeasurement(double rowHeight, double contentWidth,
    double contentHeight, double delta, NSUInteger blockers);
FOUNDATION_EXPORT void CSChatRecordMergeGeometry(double plannedHeight, double top, double bottom);
FOUNDATION_EXPORT void CSChatRecordMergePart(NSUInteger role, double top, double bottom);
