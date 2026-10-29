#import "CSBackupScheduler.h"
@interface CSBackupChangeBatch ()
@property(nonatomic) NSLock *lock;
@property(nonatomic) uint64_t generation;
@property(nonatomic) CSBackupChangeKind pending;
@property(nonatomic) NSTimeInterval firstEvent;
@property(nonatomic) NSTimeInterval lastEvent;
@property(nonatomic) BOOL queued;
@end
@implementation CSBackupChangeBatch
- (instancetype)init {if((self=[super init]))_lock=[NSLock new];return self;}
- (uint64_t)generation {[self.lock lock];uint64_t value=_generation;[self.lock unlock];return value;}
- (BOOL)note:(CSBackupChangeKind)kind at:(NSTimeInterval)time {
    [self.lock lock];
    if(!self.pending)self.firstEvent=time;
    self.lastEvent=time;self.pending|=kind;_generation++;
    BOOL enqueue=!self.queued;self.queued=YES;
    [self.lock unlock];return enqueue;
}
- (void)dequeued {[self.lock lock];self.queued=NO;[self.lock unlock];}
- (NSTimeInterval)deadline {
    [self.lock lock];NSTimeInterval deadline=self.pending?MIN(self.lastEvent+0.3,self.firstEvent+2):DBL_MAX;[self.lock unlock];return deadline;
}
- (NSDictionary *)take {
    [self.lock lock];
    NSDictionary *batch=self.pending?@{@"kind":@(self.pending),@"generation":@(_generation),@"first":@(self.firstEvent),@"last":@(self.lastEvent)}:nil;
    self.pending=0;
    [self.lock unlock];return batch;
}
@end

@interface CSBackupScheduler ()
@property(nonatomic) BOOL dirty;
@property(nonatomic) NSTimeInterval firstChange;
@property(nonatomic) NSTimeInterval lastChange;
@property(nonatomic) NSTimeInterval retryAfter;
@end
@implementation CSBackupScheduler
- (instancetype)init {if((self=[super init])){_quietInterval=30;_checkpointInterval=300;}return self;}
- (void)changedAt:(NSTimeInterval)time {if(!self.dirty)self.firstChange=time;self.lastChange=time;self.dirty=YES;}
- (NSTimeInterval)deadline {return self.dirty?MAX(self.retryAfter,MIN(self.lastChange+self.quietInterval,self.firstChange+self.checkpointInterval)):DBL_MAX;}
- (BOOL)shouldRunAt:(NSTimeInterval)time enabled:(BOOL)enabled active:(BOOL)active {return enabled&&active&&self.dirty&&time>=self.deadline;}
- (void)completed:(BOOL)success at:(NSTimeInterval)time {if(success){self.dirty=NO;self.retryAfter=0;}else self.retryAfter=time+60;}
@end
