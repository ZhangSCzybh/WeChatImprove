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
static NSMutableDictionary *Window(NSDate *anchor, NSInteger start, NSInteger end, NSInteger interval, NSString *unit, NSArray *days) {
    NSMutableDictionary *task=Task(@"window",anchor);task[@"windowStart"]=@(start);task[@"windowEnd"]=@(end);task[@"interval"]=@(interval);task[@"windowUnit"]=unit;task[@"weekdays"]=days;return task;
}
static void WindowRules(void) {
    NSDate *base=D(@"2026-10-26T00:00:00Z"),*start=At(base,3600),*end=At(base,36000);
    NSArray *all=@[@1,@2,@3,@4,@5,@6,@7];NSMutableDictionary *task=Window(base,540,1080,30,@"minutes",all);
    CHECK(CSScheduledTaskValidate(task,NULL));CHECK([CSScheduledTaskNext(task,base) isEqual:start]);CHECK(!CSScheduledTaskLatest(task,At(start,-1)));
    CHECK([CSScheduledTaskNext(task,start) isEqual:At(start,1800)]);CHECK([CSScheduledTaskLatest(task,start) isEqual:start]);
    CHECK([CSScheduledTaskLatest(task,At(end,-1)) isEqual:At(end,-1800)]);CHECK([CSScheduledTaskLatest(task,end) isEqual:At(end,-1800)]);
    CHECK([CSScheduledTaskNext(task,At(end,-1)) isEqual:At(start,86400)]);CHECK([CSScheduledTaskNext(task,end) isEqual:At(start,86400)]);
    CHECK(CSScheduledTaskAllowsExecution(task,start,start));CHECK(!CSScheduledTaskAllowsExecution(task,start,At(start,-1)));
    CHECK(CSScheduledTaskAllowsExecution(task,At(end,-1800),At(end,-1)));CHECK(!CSScheduledTaskAllowsExecution(task,At(end,-1800),end));
    CHECK(!CSScheduledTaskAllowsExecution(task,At(end,-1800),At(start,86400)));CHECK(!CSScheduledTaskAllowsExecution(task,end,end));
    CHECK([CSScheduledTaskRuleDescription(task) containsString:@"每天 09:00–18:00"]);CHECK([CSScheduledTaskRuleDescription(task) containsString:@"每 30 分钟"]);
    // The effective date clips slots; it does not shift a day's interval grid.
    task[@"anchor"]=At(start,1020);CHECK([CSScheduledTaskNext(task,base) isEqual:At(start,1800)]);CHECK(!CSScheduledTaskLatest(task,At(start,1200)));
    CHECK(!CSScheduledTaskAllowsExecution(task,start,At(start,1200)));task[@"anchor"]=At(start,1800);
    CHECK([CSScheduledTaskNext(task,base) isEqual:At(start,1800)]);CHECK([CSScheduledTaskNext(task,At(start,1800)) isEqual:At(start,3600)]);
    // Intervals longer than a window still execute once at each selected start.
    task=Window(base,540,600,168,@"hours",all);CHECK(CSScheduledTaskValidate(task,NULL));CHECK([CSScheduledTaskNext(task,start) isEqual:At(start,86400)]);
    CHECK([CSScheduledTaskLatest(task,At(start,3599)) isEqual:start]);CHECK([CSScheduledTaskRuleDescription(task) containsString:@"每 168 小时"]);
    // Friday's overnight window includes Saturday's early hours, not Saturday night.
    NSDate *friday=D(@"2026-10-30T14:00:00Z"),*saturdayEnd=At(friday,14400);task=Window(base,1320,120,30,@"minutes",@[@6]);
    CHECK([CSScheduledTaskNext(task,base) isEqual:friday]);CHECK([CSScheduledTaskNext(task,At(friday,9000)) isEqual:At(friday,10800)]);
    CHECK([CSScheduledTaskLatest(task,At(friday,12600)) isEqual:At(friday,12600)]);CHECK(CSScheduledTaskAllowsExecution(task,At(friday,12600),At(saturdayEnd,-1)));
    CHECK(!CSScheduledTaskAllowsExecution(task,At(friday,12600),saturdayEnd));CHECK([CSScheduledTaskNext(task,At(saturdayEnd,-1)) isEqual:At(friday,7*86400)]);
    CHECK(!CSScheduledTaskAllowsExecution(task,At(friday,86400),At(friday,86400)));CHECK([CSScheduledTaskRuleDescription(task) containsString:@"次日 02:00"]);
    CHECK([CSScheduledTaskLatest(task,At(friday,2*86400)) isEqual:At(saturdayEnd,-1800)]);
    // Selected weekdays and late effective dates cannot expose earlier occurrences.
    task[@"anchor"]=At(friday,9000);CHECK([CSScheduledTaskNext(task,base) isEqual:At(friday,9000)]);CHECK(!CSScheduledTaskLatest(task,At(friday,8999)));
    // Validate boundaries and types independently; existing modes need no window keys.
    task=Window(base,0,1439,1440,@"minutes",all);CHECK(CSScheduledTaskValidate(task,NULL));
    for (NSString *key in @[@"windowStart",@"windowEnd",@"windowUnit",@"interval",@"weekdays"]) {NSMutableDictionary *bad=[task mutableCopy];[bad removeObjectForKey:key];CHECK(!CSScheduledTaskValidate(bad,NULL));}
    for (id value in @[@(-1),@1440,@0.5,@"09:00",NSNull.null]) {NSMutableDictionary *bad=[task mutableCopy];bad[@"windowStart"]=value;CHECK(!CSScheduledTaskValidate(bad,NULL));}
    for (id value in @[@(-1),@1440,@0.5,@"18:00",NSNull.null]) {NSMutableDictionary *bad=[task mutableCopy];bad[@"windowEnd"]=value;CHECK(!CSScheduledTaskValidate(bad,NULL));}
    for (id value in @[@0,@1441,@1.5,@"30",NSNull.null]) {NSMutableDictionary *bad=[task mutableCopy];bad[@"interval"]=value;CHECK(!CSScheduledTaskValidate(bad,NULL));}
    for (id value in @[@[],@[@0],@[@8],@[@1.5],@"每天",NSNull.null]) {NSMutableDictionary *bad=[task mutableCopy];bad[@"weekdays"]=value;CHECK(!CSScheduledTaskValidate(bad,NULL));}
    task[@"windowEnd"]=task[@"windowStart"];CHECK(!CSScheduledTaskValidate(task,NULL));task[@"windowEnd"]=@1;task[@"windowUnit"]=@"days";CHECK(!CSScheduledTaskValidate(task,NULL));
    task[@"windowUnit"]=@"hours";task[@"interval"]=@169;CHECK(!CSScheduledTaskValidate(task,NULL));task[@"interval"]=@168;CHECK(CSScheduledTaskValidate(task,NULL));
    CHECK(!CSScheduledTaskAllowsExecution(task,[NSDate dateWithTimeIntervalSince1970:NAN],base));
    for (NSString *mode in @[@"once",@"minutes",@"hours",@"daily",@"weekly"]) CHECK(CSScheduledTaskAllowsExecution(Task(mode,base),start,At(start,-1)));
    // A series of actual slots must agree in both directions, including midnight.
    task=Window(base,1320,120,37,@"minutes",all);NSDate *cursor=base;
    for (NSUInteger i=0;i<40;i++) {NSDate *next=CSScheduledTaskNext(task,cursor);CHECK(next && [next compare:cursor]==NSOrderedDescending);CHECK([CSScheduledTaskLatest(task,next) isEqual:next]);CHECK(CSScheduledTaskAllowsExecution(task,next,next));cursor=next;}
}
static void WindowDST(void) {
    NSArray *all=@[@1,@2,@3,@4,@5,@6,@7];NSMutableDictionary *task=Window(D(@"2026-03-01T00:00:00Z"),150,240,30,@"minutes",all);task[@"zone"]=@"America/New_York";
    NSDate *gap=D(@"2026-03-08T07:00:00Z");CHECK([CSScheduledTaskNext(task,At(gap,-1)) isEqual:gap]);CHECK([CSScheduledTaskLatest(task,gap) isEqual:gap]);
    CHECK([CSScheduledTaskNext(task,gap) isEqual:At(gap,1800)]);CHECK([CSScheduledTaskNext(task,At(gap,1800)) isEqual:D(@"2026-03-09T06:30:00Z")]);
    CHECK(CSScheduledTaskAllowsExecution(task,At(gap,1800),At(gap,3599)));CHECK(!CSScheduledTaskAllowsExecution(task,At(gap,1800),At(gap,3600)));
    task[@"windowStart"]=@135;task[@"windowEnd"]=@165;CHECK([CSScheduledTaskNext(task,At(gap,-1)) isEqual:D(@"2026-03-09T06:15:00Z")]);CHECK(!CSScheduledTaskAllowsExecution(task,gap,gap));
    // A collapsed Sunday must not terminate a weekly rule or strand an overdue claim.
    task[@"weekdays"]=@[@1];NSDate *afterGapWeek=D(@"2026-03-15T06:15:00Z"),*beforeGapWeek=D(@"2026-03-01T07:15:00Z");
    CHECK([CSScheduledTaskNext(task,D(@"2026-03-01T08:00:00Z")) isEqual:afterGapWeek]);
    CHECK([CSScheduledTaskNext(task,D(@"2026-03-02T08:00:00Z")) isEqual:afterGapWeek]);
    CHECK([CSScheduledTaskLatest(task,D(@"2026-03-14T08:00:00Z")) isEqual:beforeGapWeek]);
    CHECK([CSScheduledTaskLatest(task,D(@"2026-03-15T06:00:00Z")) isEqual:beforeGapWeek]);
    CHECK([CSScheduledTaskLatest(task,afterGapWeek) isEqual:afterGapWeek]);
    // During a fall fold, actual one-hour slots may share a displayed local hour.
    task=Window(D(@"2026-10-01T00:00:00Z"),60,180,1,@"hours",all);task[@"zone"]=@"America/New_York";NSDate *fold=D(@"2026-11-01T05:00:00Z");
    CHECK([CSScheduledTaskNext(task,At(fold,-1)) isEqual:fold]);CHECK([CSScheduledTaskNext(task,fold) isEqual:At(fold,3600)]);
    CHECK([CSScheduledTaskLatest(task,At(fold,3600)) isEqual:At(fold,3600)]);CHECK([CSScheduledTaskNext(task,At(fold,3600)) isEqual:At(fold,7200)]);
    CHECK([CSScheduledTaskLatest(task,At(fold,10800)) isEqual:At(fold,7200)]);CHECK(!CSScheduledTaskAllowsExecution(task,At(fold,7200),At(fold,10800)));
    CHECK([CSScheduledTaskNext(task,At(fold,7200)) isEqual:D(@"2026-11-02T06:00:00Z")]);
    NSTimeZone *previous=NSTimeZone.defaultTimeZone;NSTimeZone.defaultTimeZone=[NSTimeZone timeZoneWithName:@"Pacific/Auckland"];
    CHECK([CSScheduledTaskLatest(task,At(fold,3600)) isEqual:At(fold,3600)]);NSTimeZone.defaultTimeZone=previous;
    // Overnight bounds use calendar days, including the shorter spring night.
    task=Window(D(@"2026-03-01T00:00:00Z"),1320,240,1,@"hours",@[@7]);task[@"zone"]=@"America/New_York";
    NSDate *night=D(@"2026-03-08T03:00:00Z");CHECK([CSScheduledTaskNext(task,At(night,-1)) isEqual:night]);
    CHECK([CSScheduledTaskLatest(task,D(@"2026-03-08T08:00:00Z")) isEqual:D(@"2026-03-08T07:00:00Z")]);
    CHECK(!CSScheduledTaskAllowsExecution(task,D(@"2026-03-08T07:00:00Z"),D(@"2026-03-08T08:00:00Z")));
}
static void WindowPersistence(NSURL *root) {
    NSDate *base=D(@"2026-10-26T00:00:00Z"),*start=At(base,3600);NSArray *all=@[@1,@2,@3,@4,@5,@6,@7];
    NSURL *url=[root URLByAppendingPathComponent:@"window.plist"];CSScheduledTaskStore *store=Store(url,@"window-account");
    NSMutableDictionary *task=Window(base,540,550,2,@"minutes",all);CHECK([store setEnabled:YES now:base]);CHECK([store saveTask:task now:base]);
    NSDictionary *claim=[store claimTask:task[@"id"] now:start];CHECK(claim && [claim[@"occurrence"] isEqual:start]);CHECK(![store claimTask:task[@"id"] now:start]);
    store=nil;store=Store(url,@"window-account");CHECK([store.history.firstObject[@"result"] isEqual:@"unknown"]);CHECK(![store claimTask:task[@"id"] now:start]);
    claim=[store claimTask:task[@"id"] now:At(start,120)];CHECK(claim);CHECK([store finishClaim:claim[@"id"] result:@"submitted" detail:@"isolated test"]);
    CHECK([store saveTask:task now:At(start,-60)]);CHECK([store.tasks.firstObject[@"lastOccurrence"] isEqual:At(start,120)]);CHECK([store.tasks.firstObject[@"nextRun"] isEqual:At(start,240)]);
    CHECK(![store claimTask:task[@"id"] now:At(start,120)]);CHECK(![store claimTask:task[@"id"] now:At(start,300)]);CHECK([store.history.firstObject[@"result"] isEqual:@"skipped"]);
    task[@"catchUp"]=@YES;CHECK([store saveTask:task now:At(start,301)]);claim=[store claimTask:task[@"id"] now:At(start,590)];
    CHECK(claim && [claim[@"occurrence"] isEqual:At(start,480)]);CHECK([store finishClaim:claim[@"id"] result:@"submitted" detail:@"latest only"]);
    // A recent occurrence cannot escape its window via the ten-minute allowance.
    CHECK([store saveTask:task now:At(start,86400-60)]);CHECK(![store claimTask:task[@"id"] now:At(start,86400+600)]);
    CHECK([store.history.firstObject[@"result"] isEqual:@"skipped"]);CHECK([store.tasks.firstObject[@"nextRun"] isEqual:At(start,2*86400)]);
    // Without catch-up, out-of-window claims also advance to the next window.
    task[@"windowEnd"]=@549;task[@"catchUp"]=@NO;CHECK([store saveTask:task now:At(start,2*86400-60)]);
    CHECK(![store claimTask:task[@"id"] now:At(start,2*86400+540)]);CHECK([store.history.firstObject[@"result"] isEqual:@"skipped"]);
    CHECK([store.tasks.firstObject[@"nextRun"] isEqual:At(start,3*86400)]);
    // Explicit re-enabling discards all disabled-period slots, including today.
    CHECK([store setEnabled:NO now:At(start,3*86400-60)]);CHECK([store setEnabled:YES now:At(start,3*86400+250)]);
    CHECK([store.tasks.firstObject[@"nextRun"] isEqual:At(start,3*86400+360)]);CHECK(![store claimTask:task[@"id"] now:At(start,3*86400+250)]);
    NSDictionary *state=[CSScheduledTaskStore readStateAtURL:url account:@"window-account" error:NULL];CHECK(state);
    NSDictionary *portable=CSScheduledTaskBackupConfiguration(state);CHECK(CSScheduledTaskBackupValueValidate(portable,@"window-account",NULL));
    NSDictionary *definition=portable[@"tasks"][0];CHECK([definition[@"windowStart"] isEqual:@540] && [definition[@"windowEnd"] isEqual:@549] && [definition[@"windowUnit"] isEqual:@"minutes"]);
    CHECK(!definition[@"nextRun"] && !definition[@"lastOccurrence"] && !portable[@"history"]);CHECK([definition[@"weekdays"] isEqual:all]);
    NSMutableDictionary *bad=[definition mutableCopy];bad[@"windowEnd"]=@540;NSMutableDictionary *badState=[portable mutableCopy];badState[@"tasks"]=@[bad];CHECK(!CSScheduledTaskBackupValueValidate(badState,@"window-account",NULL));
    // A stale runtime nextRun before the effective date must not remain overdue.
    NSURL *staleURL=[root URLByAppendingPathComponent:@"window-stale.plist"];NSMutableDictionary *stale=Window(At(base,2*86400),540,1080,30,@"minutes",all);stale[@"nextRun"]=base;
    NSDictionary *staleState=@{@"schema":@1,@"account":@"window-account",@"enabled":@YES,@"tasks":@[stale],@"history":@[]};CHECK([staleState writeToURL:staleURL atomically:YES]);
    CSScheduledTaskStore *recovered=Store(staleURL,@"window-account");CHECK(![recovered claimTask:stale[@"id"] now:start]);
    CHECK(recovered.ready && [recovered.tasks.firstObject[@"enabled"] boolValue]);CHECK([recovered.tasks.firstObject[@"nextRun"] isEqual:At(start,2*86400)]);
    CHECK(!recovered.tasks.firstObject[@"lastOccurrence"] && [recovered.history.firstObject[@"result"] isEqual:@"skipped"]);
    CHECK(![recovered claimTask:stale[@"id"] now:start]);CHECK(recovered.history.count==1);
}
int main(int argc, const char *argv[]) { @autoreleasepool { if (argc!=2) return 2; NSURL *root=[NSURL fileURLWithPath:@(argv[1]) isDirectory:YES]; Rules(); Persistence(root); MissedAndFailure(root); WindowRules(); WindowDST(); WindowPersistence(root); printf("PASS: %lu scheduled task checks (isolated store, no native sends)\n",(unsigned long)checks); } return 0; }
