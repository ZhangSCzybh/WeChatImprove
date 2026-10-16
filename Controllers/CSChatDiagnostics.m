#import "CSChatDiagnostics.h"
NSString *const CSChatDiagnosticsEnabledKey = @"com.wechat.enhance.chat_diagnostics.enabled";
static NSMutableArray<NSString *> *events;
void CSChatRecordEvent(NSString *feature, NSString *stage) {
    if (![NSUserDefaults.standardUserDefaults boolForKey:CSChatDiagnosticsEnabledKey]) return;
    // Callers supply constant stages, never message/user data.
    @synchronized (CSChatDiagnosticsEnabledKey) {
        if (!events) events=[NSMutableArray array];
        if (events.count==128) [events removeObjectAtIndex:0];
        [events addObject:[NSString stringWithFormat:@"%.3f %@: %@",NSDate.timeIntervalSinceReferenceDate,feature,stage]];
    }
}
NSString *CSChatDiagnosticReport(void) {
    @synchronized (CSChatDiagnosticsEnabledKey) { return events.count ? [events componentsJoinedByString:@"\n"] : @"暂无记录。请开启兼容性诊断，返回聊天并复现问题后，再查看或复制。"; }
}
void CSChatClearDiagnostics(void) {
    @synchronized (CSChatDiagnosticsEnabledKey) { [events removeAllObjects]; }
}
