#import <Foundation/Foundation.h>
#import "CSScheduledTaskStore.h"
#include <sys/stat.h>
static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)
static NSDate *D(NSString *s) { NSISO8601DateFormatter *f=[NSISO8601DateFormatter new]; NSDate *d=[f dateFromString:s]; CHECK(d); return d; }
static NSDate *At(NSDate *date, double offset) { return [date dateByAddingTimeInterval:offset]; }
static NSMutableDictionary *Task(NSString *mode, NSDate *anchor) { return [@{@"id":NSUUID.UUID.UUIDString,@"title":@"测试任务",@"target":@"filehelper",@"text":@"你好\n第二行",@"enabled":@YES,@"catchUp":@NO,@"mode":mode,@"interval":@5,@"anchor":anchor,@"hour":@9,@"minute":@30,@"weekdays":@[@2,@4],@"zone":@"Asia/Shanghai"} mutableCopy]; }
static CSScheduledTaskStore *Store(NSURL *url, NSString *account) { CSScheduledTaskStore *s=[[CSScheduledTaskStore alloc] initWithURL:url account:account]; BOOL loaded=[s load];if(!loaded)NSLog(@"load %@: %@",url.path,s.error);CHECK(loaded); return s; }
static void Rules(void) {
    NSDate *base=D(@"2026-10-26T00:00:00Z"); NSMutableDictionary *t=Task(@"minutes",base);
    CHECK(CSScheduledTaskValidate(t,NULL)); CHECK([CSScheduledTaskNext(t,At(base,-1)) isEqual:base]);
    CHECK([CSScheduledTaskNext(t,base) isEqual:At(base,300)]); CHECK([CSScheduledTaskLatest(t,At(base,599)) isEqual:At(base,300)]);
    CHECK([CSScheduledTaskLatest(t,At(base,600)) isEqual:At(base,600)]); CHECK(!CSScheduledTaskLatest(t,At(base,-1)));
    t[@"interval"]=@1; CHECK([CSScheduledTaskNext(t,base) isEqual:At(base,60)]);
    t[@"interval"]=@1440; CHECK(CSScheduledTaskValidate(t,NULL)); t[@"interval"]=@1441; CHECK(!CSScheduledTaskValidate(t,NULL));
    t[@"interval"]=@0; CHECK(!CSScheduledTaskValidate(t,NULL)); t[@"interval"]=@1.5; CHECK(!CSScheduledTaskValidate(t,NULL));
    t[@"mode"]=@"hours"; t[@"interval"]=@2; CHECK([CSScheduledTaskNext(t,At(base,7200)) isEqual:At(base,14400)]);
    t[@"mode"]=@"once"; CHECK([CSScheduledTaskNext(t,At(base,-1)) isEqual:base]); CHECK(!CSScheduledTaskNext(t,base)); CHECK([CSScheduledTaskLatest(t,At(base,100)) isEqual:base]);
    t[@"mode"]=@"daily"; NSDate *daily=D(@"2026-10-26T01:30:00Z"); CHECK([CSScheduledTaskNext(t,base) isEqual:daily]); CHECK([CSScheduledTaskLatest(t,daily) isEqual:daily]); CHECK([CSScheduledTaskNext(t,daily) isEqual:At(daily,86400)]);
    CHECK([CSScheduledTaskNext(t,At(base,-86400)) isEqual:daily]);
    t[@"mode"]=@"weekly"; CHECK([CSScheduledTaskNext(t,daily) isEqual:At(daily,2*86400)]); CHECK([CSScheduledTaskLatest(t,At(daily,86400)) isEqual:daily]);
    t[@"weekdays"]=@[]; CHECK(!CSScheduledTaskValidate(t,NULL)); t[@"weekdays"]=@[@8]; CHECK(!CSScheduledTaskValidate(t,NULL));
    t=Task(@"daily",D(@"2026-03-07T00:00:00Z")); t[@"zone"]=@"America/New_York"; t[@"hour"]=@2; t[@"minute"]=@30;
    // Spring gap: the missing 02:30 runs at the next valid time, 03:00.
    NSDate *gap=D(@"2026-03-08T07:00:00Z"); CHECK([CSScheduledTaskNext(t,D(@"2026-03-08T05:00:00Z")) isEqual:gap]); CHECK([CSScheduledTaskLatest(t,gap) isEqual:gap]);
    // Fall fold: only the first 01:30 is one daily occurrence.
    t[@"hour"]=@1; t[@"minute"]=@30; NSDate *fold=D(@"2026-11-01T05:30:00Z");
    CHECK([CSScheduledTaskNext(t,D(@"2026-11-01T04:00:00Z")) isEqual:fold]);
    CHECK([CSScheduledTaskLatest(t,D(@"2026-11-01T06:45:00Z")) isEqual:fold]);
    CHECK([CSScheduledTaskNext(t,fold) isEqual:D(@"2026-11-02T06:30:00Z")]);
    NSTimeZone *previous=NSTimeZone.defaultTimeZone; NSTimeZone.defaultTimeZone=[NSTimeZone timeZoneWithName:@"Pacific/Auckland"];
    CHECK([CSScheduledTaskLatest(t,D(@"2026-11-01T06:45:00Z")) isEqual:fold]); NSTimeZone.defaultTimeZone=previous;
}
static void Persistence(NSURL *root) {
    NSDate *base=D(@"2026-10-26T00:00:00Z"); NSURL *url=[root URLByAppendingPathComponent:@"account-a.plist"];
    CSScheduledTaskStore *s=Store(url,@"a"); CHECK(!s.enabled && s.ready); NSMutableDictionary *t=Task(@"minutes",At(base,60)); t[@"interval"]=@1;
    CHECK([s saveTask:t now:base]); CHECK(![s claimTask:t[@"id"] now:At(base,60)]); CHECK([s setEnabled:YES now:base]); CHECK(![s claimTask:t[@"id"] now:At(base,59)]);
    NSDictionary *claim=[s claimTask:t[@"id"] now:At(base,60)]; CHECK(claim && [claim[@"account"] isEqual:@"a"]); CHECK(![s claimTask:t[@"id"] now:At(base,60)]);
    CHECK([s.history.firstObject[@"result"] isEqual:@"submitting"]); CHECK([s.tasks.firstObject[@"nextRun"] isEqual:At(base,120)]);
    struct stat st; CHECK(stat(url.fileSystemRepresentation,&st)==0 && (st.st_mode&0777)==0600);
    CSScheduledTaskStore *conflict=[[CSScheduledTaskStore alloc] initWithURL:url account:@"a"]; CHECK(![conflict load] && !conflict.ready); conflict=nil;
    s=nil; s=Store(url,@"a"); CHECK([s.history.firstObject[@"result"] isEqual:@"unknown"]); CHECK(![s claimTask:t[@"id"] now:At(base,60)]);
    claim=[s claimTask:t[@"id"] now:At(base,120)]; CHECK(claim); CHECK([s finishClaim:claim[@"id"] result:@"submitted" detail:@"交给微信"]); CHECK(![s finishClaim:claim[@"id"] result:@"failed" detail:@"重复回调"]);
    CHECK([s setEnabled:NO now:At(base,121)]); CHECK(![s claimTask:t[@"id"] now:At(base,240)]); CHECK([s setEnabled:YES now:At(base,240)]); CHECK([s.tasks.firstObject[@"nextRun"] isEqual:At(base,300)]);
    // Editing while the clock goes backward must retain the persistent high water mark.
    CHECK([s saveTask:t now:At(base,30)]); CHECK([s.tasks.firstObject[@"nextRun"] isEqual:At(base,180)]); CHECK(![s claimTask:t[@"id"] now:At(base,120)]);
    NSMutableDictionary *bad=[t mutableCopy]; bad[@"interval"]=@0; CHECK(![s saveTask:bad now:base] && s.ready); CHECK([s saveTask:t now:At(base,150)]);
    CSScheduledTaskStore *b=Store([root URLByAppendingPathComponent:@"account-b.plist"],@"b"); CHECK(!b.enabled && b.tasks.count==0);
    NSData *before=[NSData dataWithContentsOfURL:url]; s=nil;
    s=[[CSScheduledTaskStore alloc] initWithURL:url account:@"b"]; CHECK(![s load]); CHECK([[NSData dataWithContentsOfURL:url] isEqual:before]); s=nil;
    s=Store(url,@"a"); CHECK([s removeTask:t[@"id"]] && !s.tasks.count);
}
static void MissedAndFailure(NSURL *root) {
    NSDate *base=D(@"2026-10-26T00:00:00Z"); CSScheduledTaskStore *s=Store([root URLByAppendingPathComponent:@"missed.plist"],@"a"); CHECK([s setEnabled:YES now:base]);
    NSMutableDictionary *t=Task(@"minutes",At(base,60)); t[@"interval"]=@5; CHECK([s saveTask:t now:base]);
    CHECK(![s claimTask:t[@"id"] now:At(base,200)]); CHECK([s.history.firstObject[@"result"] isEqual:@"skipped"]); CHECK([s.tasks.firstObject[@"nextRun"] isEqual:At(base,360)]);
    t[@"catchUp"]=@YES; CHECK([s saveTask:t now:At(base,201)]);
    NSDictionary *claim=[s claimTask:t[@"id"] now:At(base,500)]; CHECK(claim && [claim[@"occurrence"] isEqual:At(base,360)]); CHECK(![s claimTask:t[@"id"] now:At(base,500)]);
    claim=[s claimTask:t[@"id"] now:At(base,3600)]; CHECK(claim && [claim[@"occurrence"] isEqual:At(base,3360)]); CHECK(![s claimTask:t[@"id"] now:At(base,3600)]);
    t=Task(@"once",At(base,100)); t[@"catchUp"]=@YES; CHECK([s saveTask:t now:base]); CHECK(![s claimTask:t[@"id"] now:At(base,701)]); CHECK(![s.tasks.lastObject[@"enabled"] boolValue]);
    t=Task(@"once",At(base,800)); CHECK([s saveTask:t now:base]); CHECK([s claimTask:t[@"id"] now:At(base,830)]); CHECK(![s claimTask:t[@"id"] now:At(base,830)]);
    // A filesystem failure cannot authorize native handoff; the file is isolated under mktemp.
    NSURL *url=[root URLByAppendingPathComponent:@"failure/task.plist"]; s=Store(url,@"a"); t=Task(@"once",At(base,60)); CHECK([s setEnabled:YES now:base]); CHECK([s saveTask:t now:base]);
    CHECK([NSFileManager.defaultManager removeItemAtURL:url.URLByDeletingLastPathComponent error:NULL]); CHECK([[@"blocker" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:url.URLByDeletingLastPathComponent atomically:YES]);
    CHECK(![s claimTask:t[@"id"] now:At(base,60)] && !s.ready && s.error);
    NSURL *corrupt=[root URLByAppendingPathComponent:@"corrupt.plist"]; NSData *bytes=[@"truncated plist" dataUsingEncoding:NSUTF8StringEncoding]; CHECK([bytes writeToURL:corrupt atomically:YES]); s=[[CSScheduledTaskStore alloc] initWithURL:corrupt account:@"a"]; CHECK(![s load] && !s.ready); CHECK([[NSData dataWithContentsOfURL:corrupt] isEqual:bytes]);
    NSURL *invalid=[root URLByAppendingPathComponent:@"invalid.plist"]; NSDictionary *bad=@{@"schema":@1,@"account":@"a",@"enabled":@YES,@"tasks":@[Task(@"minutes",base)],@"history":@[]}; CHECK([bad writeToURL:invalid atomically:YES]); s=[[CSScheduledTaskStore alloc] initWithURL:invalid account:@"a"]; CHECK(![s load]);
}
int main(int argc, const char *argv[]) { @autoreleasepool { if (argc!=2) return 2; NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES]; Rules(); Persistence(root); MissedAndFailure(root); printf("PASS: %lu scheduled task checks (isolated store, no native sends)\n",(unsigned long)checks); } return 0; }
