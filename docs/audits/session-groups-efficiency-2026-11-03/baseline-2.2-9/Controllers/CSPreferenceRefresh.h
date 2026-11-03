#import <Foundation/Foundation.h>
#import <stdatomic.h>

// NotificationCenter delivers queue:nil observers on the posting thread. Only
// enqueue here: a native service may still own a lock needed by the main thread.
static inline void CSRequestMainRefresh(atomic_bool *pending, dispatch_block_t work) {
    if (atomic_exchange(pending, true)) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        atomic_store(pending, false);
        work();
    });
}
