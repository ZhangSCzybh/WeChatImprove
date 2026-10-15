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
