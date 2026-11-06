#import "CSBackupMutation.h"
#import <stdatomic.h>
static atomic_uint_fast64_t revision;
static atomic_uint writers;
uint64_t CSBackupResourceRevision(void){return atomic_load_explicit(&revision,memory_order_acquire);}
BOOL CSBackupResourceWriteInProgress(void){return atomic_load_explicit(&writers,memory_order_acquire)!=0;}
@implementation CSBackupMutation
- (instancetype)init {if((self=[super init])){atomic_fetch_add_explicit(&writers,1,memory_order_acq_rel);atomic_fetch_add_explicit(&revision,1,memory_order_acq_rel);}return self;}
- (void)dealloc {atomic_fetch_add_explicit(&revision,1,memory_order_acq_rel);atomic_fetch_sub_explicit(&writers,1,memory_order_acq_rel);[NSNotificationCenter.defaultCenter postNotificationName:@"CSBackupResourcesChanged" object:nil];}
@end
