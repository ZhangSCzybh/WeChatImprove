#import <Foundation/Foundation.h>

// Captures contain immutable strings only; persistence never runs in a native getter.
@interface CSAvatarURLCache : NSObject
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults key:(NSString *)key;
- (NSUInteger)generation;
- (void)captureURL:(NSString *)url account:(NSString *)account generation:(NSUInteger)generation;
- (void)accountBoundaryAcceptingContacts:(BOOL)accepting;
@end
