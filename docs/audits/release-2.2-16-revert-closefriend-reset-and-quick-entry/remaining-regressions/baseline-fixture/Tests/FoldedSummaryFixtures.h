static CSGroupRow *SummaryFixtureRow(NSIndexPath *path,NSString *name,NSString *summary,NSNumber *time) {
    return [[CSGroupRow alloc] initWithNativePath:path userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryGroup
        top:NO unreadCount:0 redDot:NO nativeSummary:summary sortTime:time nativePrefix:[name stringByAppendingString:@": "]];
}
