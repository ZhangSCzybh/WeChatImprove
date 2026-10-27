// Optional initializer keeps the new contract executable against 2.0-23b (red).
@interface CSGroupRow (FoldedSummaryFixture)
- (instancetype)initWithNativePath:(NSIndexPath *)path userName:(NSString *)name
    kind:(CSGroupRowKind)kind category:(CSGroupRowCategory)category top:(BOOL)top
    unreadCount:(NSUInteger)unread redDot:(BOOL)dot nativeSummary:(NSString *)summary sortTime:(NSNumber *)time
    summaryReason:(NSString *)reason nativePrefix:(NSString *)prefix summarySource:(NSString *)source;
@end
static CSGroupRow *SummaryFixtureRow(NSIndexPath *path,NSString *name,NSString *summary,NSNumber *time) {
    if ([CSGroupRow instancesRespondToSelector:@selector(initWithNativePath:userName:kind:category:top:unreadCount:redDot:nativeSummary:sortTime:summaryReason:nativePrefix:summarySource:)])
        return [[CSGroupRow alloc] initWithNativePath:path userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryGroup
            top:NO unreadCount:0 redDot:NO nativeSummary:summary sortTime:time summaryReason:@"ok_cache" nativePrefix:[name stringByAppendingString:@": "] summarySource:@"entry_cache"];
    return [[CSGroupRow alloc] initWithNativePath:path userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryGroup
        top:NO unreadCount:0 redDot:NO nativeSummary:summary sortTime:time];
}
