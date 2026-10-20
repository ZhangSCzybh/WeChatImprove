#import <Foundation/Foundation.h>
#import "CSBackupScheduler.h"
static int checks;static void Check(BOOL v){checks++;if(!v)exit(1);}
int main(void){@autoreleasepool{CSBackupScheduler *s=[CSBackupScheduler new];Check(![s shouldRunAt:100 enabled:YES active:YES]);[s changedAt:100];Check(s.deadline==130);[s changedAt:120];Check(s.deadline==150);Check(![s shouldRunAt:150 enabled:NO active:YES]);Check(![s shouldRunAt:150 enabled:YES active:NO]);Check([s shouldRunAt:150 enabled:YES active:YES]);for(int t=140;t<430;t+=20)[s changedAt:t];Check(s.deadline==400);[s completed:NO at:401];Check(s.dirty&&s.deadline==461);[s completed:YES at:461];Check(!s.dirty);[s changedAt:500];Check(s.deadline==530);printf("Backup scheduler: %d checks passed\n",checks);}return 0;}
