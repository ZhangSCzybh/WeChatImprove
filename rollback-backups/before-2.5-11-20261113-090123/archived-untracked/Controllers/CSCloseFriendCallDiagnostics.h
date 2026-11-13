#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#ifdef __cplusplus
extern "C" {
#endif

/// Manual, bounded, process-local recording. No notification or account payload is accepted.
FOUNDATION_EXPORT void CSCFCallDiagnosticsStartRecording(NSUInteger epoch);
FOUNDATION_EXPORT void CSCFCallDiagnosticsRecord(NSString *event, NSUInteger epoch);
FOUNDATION_EXPORT void CSCFCallDiagnosticsStopRecording(void);
FOUNDATION_EXPORT BOOL CSCFCallDiagnosticsIsRecording(void);
/// Read the actual notification delegate and observe an existing, ABI-verified callback.
/// Implemented by the notification hooks; never replaces the system delegate.
FOUNDATION_EXPORT void CSCFCallDiagnosticsInspectNotificationDelegate(void);
/// An account boundary clears the recording before export; epoch is never included in the report.
FOUNDATION_EXPORT NSString *CSCFCallDiagnosticsReport(NSString *pluginVersion, NSDictionary *capabilities, NSUInteger epoch);

#ifdef __cplusplus
}
#endif
NS_ASSUME_NONNULL_END
