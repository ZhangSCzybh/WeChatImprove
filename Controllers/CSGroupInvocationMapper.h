#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
BOOL CSGroupInvocationIsSupported(SEL selector);
BOOL CSGroupInvocationReturnsPath(SEL selector);
// Validates the entire callback before changing any argument. The invocation retains mapped values.
BOOL CSGroupMapInvocationPaths(NSInvocation *invocation, NSIndexPath * _Nullable (^map)(NSIndexPath *));
NS_ASSUME_NONNULL_END
