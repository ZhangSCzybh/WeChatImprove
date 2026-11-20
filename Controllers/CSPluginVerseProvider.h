#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Returns the verse body, or nil for an empty, malformed or error response.
FOUNDATION_EXPORT NSString * _Nullable CSPluginVerseTextFromResponse(NSString * _Nullable response);
/// The second source also serves short quotations without classical verse punctuation.
FOUNDATION_EXPORT NSString * _Nullable CSPluginQuoteTextFromResponse(NSString * _Nullable response);

/// Public, account-independent content. Cache files are disposable and excluded from settings backups.
@interface CSPluginVerseProvider : NSObject
+ (instancetype)sharedProvider;
- (NSString *)currentVerse;
/// Every call starts a refresh, alternating HTTPS sources and trying the other source on failure or a repeated body.
/// Delivers cached content first when available, then the final result, always asynchronously on main.
/// A newer call cancels and invalidates the previous call, including already queued callbacks.
- (void)refreshWithCompletion:(void (^)(NSString *verse))completion;
@end

NS_ASSUME_NONNULL_END
