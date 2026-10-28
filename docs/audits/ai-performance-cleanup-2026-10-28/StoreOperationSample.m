#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <sys/resource.h>
#import <sys/stat.h>
#import <unistd.h>
#include <stdio.h>
#include <stdlib.h>

static BOOL collecting;
static NSUInteger encodes, decodes, encodedBytes, decodedBytes, deepCopies;
static NSUInteger fileSyncs, directorySyncs, syncFailures;
#define REQUIRE(condition) do { if (!(condition)) { fprintf(stderr, "FAIL %d: %s\n", __LINE__, #condition); exit(1); } } while (0)

@interface AuditPropertyListSerialization : NSPropertyListSerialization
@end
@implementation AuditPropertyListSerialization
+ (NSData *)dataWithPropertyList:(id)value format:(NSPropertyListFormat)format options:(NSPropertyListWriteOptions)options error:(NSError **)error {
    NSData *data = [super dataWithPropertyList:value format:format options:options error:error];
    if (collecting) { encodes++; encodedBytes += data.length; }
    return data;
}
+ (id)propertyListWithData:(NSData *)data options:(NSPropertyListReadOptions)options format:(NSPropertyListFormat *)format error:(NSError **)error {
    if (collecting) { decodes++; decodedBytes += data.length; }
    return [super propertyListWithData:data options:options format:format error:error];
}
@end

static CFPropertyListRef AuditDeepCopy(CFAllocatorRef allocator, CFPropertyListRef value, CFOptionFlags mutability) {
    if (collecting) deepCopies++;
    return CFPropertyListCreateDeepCopy(allocator, value, mutability);
}
static int AuditFsync(int descriptor) {
    if (collecting) {
        struct stat info;
        REQUIRE(fstat(descriptor, &info) == 0);
        if (S_ISDIR(info.st_mode)) directorySyncs++; else { REQUIRE(S_ISREG(info.st_mode)); fileSyncs++; }
    }
    int result = fsync(descriptor);
    if (collecting && result != 0) syncFailures++;
    return result;
}

// Only count production calls; each wrapper still calls the real implementation.
#define NSPropertyListSerialization AuditPropertyListSerialization
#define CFPropertyListCreateDeepCopy AuditDeepCopy
#define fsync AuditFsync
#import "StoreUnderTest.m"
#undef fsync
#undef CFPropertyListCreateDeepCopy
#undef NSPropertyListSerialization

static void ResetCounts(void) {
    encodes = decodes = encodedBytes = decodedBytes = deepCopies = 0;
    fileSyncs = directorySyncs = syncFailures = 0;
}
static double CPUSeconds(struct timeval value) { return (double)value.tv_sec + (double)value.tv_usec / 1000000.; }
static NSDictionary *Counters(void) {
    return @{@"plist_encodes":@(encodes), @"plist_decodes":@(decodes), @"encoded_bytes":@(encodedBytes),
             @"decoded_bytes":@(decodedBytes), @"cf_deep_copies":@(deepCopies), @"file_fsync_calls":@(fileSyncs),
             @"directory_fsync_calls":@(directorySyncs), @"fsync_failures":@(syncFailures)};
}
static CSAIReplyStore *Seed(NSDictionary *fixture, NSURL *url) {
    collecting = NO;
    NSError *error = nil;
    REQUIRE([CSAIReplyStore replaceState:fixture atURL:url account:fixture[@"account"] error:&error]);
    REQUIRE(error == nil);
    CSAIReplyStore *store = [[CSAIReplyStore alloc] initWithURL:url account:fixture[@"account"]];
    REQUIRE([store load] && store.ready && store.configuration != nil);
    return store;
}
static NSDictionary *Record(NSDictionary *fixture) {
    return @{@"date":fixture[@"history"][0][@"date"], @"conversation":@"audit-room@chatroom",
             @"preset":@"default", @"result":@"submitted", @"detail":@"synthetic audit record"};
}
static NSDictionary *Sample(CSAIReplyStore *store, NSDictionary *fixture, NSURL *url, BOOL claim) {
    NSDictionary *configuration = store.configuration; // Strongly retained across the operation.
    struct rusage before, after;
    ResetCounts();
    REQUIRE(getrusage(RUSAGE_SELF, &before) == 0);
    NSTimeInterval start = NSProcessInfo.processInfo.systemUptime;
    collecting = YES;
    NSError *error = nil;
    BOOL success = claim ? [store claimMessageIDs:@[@"audit-single-claim"] error:&error] : [store appendHistory:Record(fixture) error:&error];
    collecting = NO;
    NSTimeInterval elapsed = NSProcessInfo.processInfo.systemUptime - start;
    REQUIRE(getrusage(RUSAGE_SELF, &after) == 0);
    REQUIRE(success && error == nil && store.ready);
    NSMutableDictionary *result = [Counters() mutableCopy];
    result[@"configuration_pointer_stable"] = configuration == store.configuration ? @YES : @NO;
    REQUIRE([configuration isEqual:store.configuration]);
    result[@"configuration_value_unchanged"] = @YES;
    result[@"user_cpu_seconds"] = @(CPUSeconds(after.ru_utime) - CPUSeconds(before.ru_utime));
    result[@"system_cpu_seconds"] = @(CPUSeconds(after.ru_stime) - CPUSeconds(before.ru_stime));
    result[@"wall_seconds"] = @(elapsed);
    struct stat info;
    REQUIRE(stat(url.fileSystemRepresentation, &info) == 0 && S_ISREG(info.st_mode) && (info.st_mode & 0777) == 0600);
    result[@"persisted_bytes"] = @(info.st_size);
    result[@"persisted_file_mode"] = @"0600";
    NSDictionary *disk = [CSAIReplyStore readStateAtURL:url account:fixture[@"account"] error:&error];
    REQUIRE(disk != nil && error == nil && [disk[@"configuration"] isEqual:configuration]);
    if (claim) REQUIRE(disk[@"handled"][@"audit-single-claim"] != nil);
    else REQUIRE([disk[@"history"] lastObject] && [[disk[@"history"] lastObject] isEqual:Record(fixture)]);
    result[@"disk_readback_verified"] = @YES;
    return result;
}
static NSDictionary *Batch(CSAIReplyStore *store, NSDictionary *fixture, NSUInteger pairs, NSString *prefix) {
    NSDictionary *configuration = store.configuration, *record = Record(fixture);
    NSUInteger stable = 0;
    struct rusage before, after;
    ResetCounts();
    REQUIRE(getrusage(RUSAGE_SELF, &before) == 0);
    NSTimeInterval start = NSProcessInfo.processInfo.systemUptime;
    collecting = YES;
    for (NSUInteger i = 0; i < pairs; i++) {
        @autoreleasepool {
            NSError *error = nil;
            NSString *identity = [NSString stringWithFormat:@"%@-%lu", prefix, (unsigned long)i];
            REQUIRE([store claimMessageIDs:@[identity] error:&error] && error == nil);
            if (configuration == store.configuration) stable++;
            REQUIRE([store appendHistory:record error:&error] && error == nil);
            if (configuration == store.configuration) stable++;
            REQUIRE([configuration isEqual:store.configuration] && store.ready);
        }
    }
    collecting = NO;
    NSTimeInterval elapsed = NSProcessInfo.processInfo.systemUptime - start;
    REQUIRE(getrusage(RUSAGE_SELF, &after) == 0);
    NSMutableDictionary *result = [Counters() mutableCopy];
    result[@"durable_operations"] = @(pairs * 2);
    result[@"configuration_pointer_stable_operations"] = @(stable);
    result[@"user_cpu_seconds"] = @(CPUSeconds(after.ru_utime) - CPUSeconds(before.ru_utime));
    result[@"system_cpu_seconds"] = @(CPUSeconds(after.ru_stime) - CPUSeconds(before.ru_stime));
    result[@"wall_seconds"] = @(elapsed);
    return result;
}
int main(int argc, const char *argv[]) {
    @autoreleasepool {
        REQUIRE(argc == 4);
        NSURL *root = [NSURL fileURLWithPath:@(argv[1]) isDirectory:YES];
        NSDictionary *fixture = [NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfFile:@(argv[2])]
                                                                         options:NSPropertyListImmutable format:NULL error:NULL];
        REQUIRE(CSAIReplyValidateState(fixture, fixture[@"account"], NULL));
        NSURL *url = [root URLByAppendingPathComponent:@"state.plist"];
        CSAIReplyStore *store = Seed(fixture, url);
        NSDictionary *claim = Sample(store, fixture, url, YES);
        NSDictionary *append = Sample(store, fixture, url, NO);
        NSMutableDictionary *output = [@{@"claim":claim, @"append_history":append} mutableCopy];
        NSUInteger pairs = (NSUInteger)strtoul(argv[3], NULL, 10);
        if (pairs) {
            store = Seed(fixture, url);
            (void)Batch(store, fixture, 5, @"warmup");
            NSMutableArray *trials = [NSMutableArray array];
            for (NSUInteger trial = 0; trial < 3; trial++) {
                store = Seed(fixture, url);
                [trials addObject:Batch(store, fixture, pairs, [NSString stringWithFormat:@"trial-%lu", (unsigned long)trial])];
            }
            output[@"batch_trials"] = trials;
            output[@"warmup_pairs_excluded"] = @5;
        }
        NSData *json = [NSJSONSerialization dataWithJSONObject:output options:NSJSONWritingSortedKeys error:NULL];
        REQUIRE(json != nil);
        fwrite(json.bytes, 1, json.length, stdout);
        fputc('\n', stdout);
    }
    return 0;
}
