#import <Foundation/Foundation.h>
FOUNDATION_EXPORT NSString *const CSChatDiagnosticsEnabledKey;
FOUNDATION_EXPORT void CSChatRecordEvent(NSString *feature, NSString *stage);
FOUNDATION_EXPORT NSString *CSChatDiagnosticReport(void);
FOUNDATION_EXPORT void CSChatClearDiagnostics(void);
