#import "CSGroupIndexScope.h"
static NSString *const ScopeKey=@"CSGroupIndexScope.stack";
BOOL CSGroupUsesNativeIndices(id table) {
    for (NSArray *entry in [NSThread.currentThread.threadDictionary[ScopeKey] reverseObjectEnumerator])
        if (entry[0]==table) return [entry[1] boolValue];
    return NO;
}
static void WithDomain(id table, BOOL native, void (^block)(void)) {
    NSMutableDictionary *dictionary=NSThread.currentThread.threadDictionary;
    NSMutableArray *stack=dictionary[ScopeKey];
    if (!stack) dictionary[ScopeKey]=stack=[NSMutableArray array];
    [stack addObject:@[table,@(native)]];
    @try { block(); }
    @finally { [stack removeLastObject]; if (!stack.count) [dictionary removeObjectForKey:ScopeKey]; }
}
void CSGroupWithNativeIndices(id table, void (^block)(void)) { WithDomain(table,YES,block); }
void CSGroupWithDisplayIndices(id table, void (^block)(void)) { WithDomain(table,NO,block); }

static NSString *const HeaderScopeKey=@"CSGroupIndexScope.nativeHeaders";
BOOL CSGroupUsesNativeHeader(id table) {
    for (id scopedTable in NSThread.currentThread.threadDictionary[HeaderScopeKey])
        if (scopedTable==table) return YES;
    return NO;
}
void CSGroupWithNativeHeader(id table, void (^block)(void)) {
    NSMutableDictionary *dictionary=NSThread.currentThread.threadDictionary;
    NSMutableArray *stack=dictionary[HeaderScopeKey];
    if (!stack) dictionary[HeaderScopeKey]=stack=[NSMutableArray array];
    [stack addObject:table];
    @try { block(); }
    @finally { [stack removeLastObject]; if (!stack.count) [dictionary removeObjectForKey:HeaderScopeKey]; }
}
