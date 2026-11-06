#import <Foundation/Foundation.h>

// Preserve ICU's decimal-digit and end-anchor semantics; ordinary labels never run a regex.
FOUNDATION_EXPORT BOOL CSCustomTextMatchesTitle(NSString *text, BOOL contacts);
FOUNDATION_EXPORT BOOL CSCustomTextMatchesFriendsCount(NSString *text);
