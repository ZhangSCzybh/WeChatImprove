#import "CSBackupScheduler.h"
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
