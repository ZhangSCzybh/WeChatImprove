#import "CSAvatarURLCache.h"
@implementation CSAvatarURLCache {
    NSUserDefaults *_defaults;
    NSString *_key, *_accountKey, *_pendingURL, *_pendingAccount;
    NSUInteger _generation;
    BOOL _queued, _accepting, _clear;
}
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults key:(NSString *)key {
    if ((self=[super init])) {
        _defaults=defaults; _key=[key copy]; _accountKey=[key stringByAppendingString:@".account"];
        _accepting=YES;
    }
    return self;
}
- (NSUInteger)generation { @synchronized(self) { return _generation; } }
- (void)scheduleLocked {
    if (_queued) return;
    _queued=YES;
    dispatch_async(dispatch_get_main_queue(), ^{ [self drain]; });
}
- (void)captureURL:(NSString *)url account:(NSString *)account generation:(NSUInteger)generation {
    if (!url.length || !account.length) return;
    NSString *urlCopy=[url copy], *accountCopy=[account copy];
    @synchronized(self) {
        if (!_accepting || generation!=_generation) return;
        if ([_pendingURL isEqual:urlCopy] && [_pendingAccount isEqual:accountCopy] && !_clear) return;
        _pendingURL=urlCopy; _pendingAccount=accountCopy; _clear=NO;
        [self scheduleLocked];
    }
}
- (void)accountBoundaryAcceptingContacts:(BOOL)accepting {
    @synchronized(self) {
        _generation++; _accepting=accepting; _pendingURL=nil; _pendingAccount=nil; _clear=YES;
        [self scheduleLocked];
    }
}
- (void)drain {
    NSString *url, *account; BOOL clear;
    @synchronized(self) {
        _queued=NO; url=_pendingURL; account=_pendingAccount; clear=_clear;
    }
    // Never hold the capture lock across Defaults or notification delivery.
    // A concurrent account boundary schedules a following drain which clears
    // this write; captures started before that boundary are rejected by epoch.
    if (clear) {
        if ([_defaults objectForKey:_key]) [_defaults removeObjectForKey:_key];
        if ([_defaults objectForKey:_accountKey]) [_defaults removeObjectForKey:_accountKey];
    } else if (url.length) {
        if (![[_defaults stringForKey:_accountKey] isEqual:account]) [_defaults setObject:account forKey:_accountKey];
        if (![[_defaults stringForKey:_key] isEqual:url]) [_defaults setObject:url forKey:_key];
    }
}
@end
