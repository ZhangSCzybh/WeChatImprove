#import "CSChatDiagnostics.h"
NSString *const CSChatDiagnosticsEnabledKey = @"com.wechat.enhance.chat_diagnostics.enabled";
static NSMutableArray<NSString *> *events;
void CSChatRecordEvent(NSString *feature, NSString *stage) {
    if (![NSUserDefaults.standardUserDefaults boolForKey:CSChatDiagnosticsEnabledKey]) return;
    // Callers supply constant stages or numeric layout metrics, never message/user data.
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

void CSChatRecordMergeMeasurement(double rowHeight, double contentWidth, double contentHeight,
                                  double delta, NSUInteger blockers) {
    if (![NSUserDefaults.standardUserDefaults boolForKey:CSChatDiagnosticsEnabledKey]) return;
    CSChatRecordEvent(@"merge",[NSString stringWithFormat:@"measure row=%.2f content=%.2fx%.2f delta=%.2f blockers=0x%lx",
        rowHeight,contentWidth,contentHeight,delta,(unsigned long)blockers]);
}
void CSChatRecordMergeGeometry(double plannedHeight, double top, double bottom) {
    if (![NSUserDefaults.standardUserDefaults boolForKey:CSChatDiagnosticsEnabledKey]) return;
    CSChatRecordEvent(@"merge",[NSString stringWithFormat:@"geometry-fallback planned=%.2f top=%.2f bottom=%.2f",
        plannedHeight,top,bottom]);
}
void CSChatRecordMergePart(NSUInteger role, double top, double bottom) {
    if (![NSUserDefaults.standardUserDefaults boolForKey:CSChatDiagnosticsEnabledKey]) return;
    CSChatRecordEvent(@"merge",[NSString stringWithFormat:@"geometry-part role=0x%lx top=%.2f bottom=%.2f",
        (unsigned long)role,top,bottom]);
}
