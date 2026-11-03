#import "CSCloseFriendSignatures.h"
static NSString *CSType(const char *type) {
    if(!type)return @"";
    while(*type && strchr("rnNoORV",*type))type++;
    // Object class/protocol annotations do not alter ABI. Blocks remain distinct from objects.
    if(type[0]=='@' && type[1]=='"')return @"@";
    return [NSString stringWithUTF8String:type]?:@"";
}
BOOL CSCloseFriendMethodMatches(Method method, const char *encoding) {
    if(!method || !encoding)return NO;
    @try {
        NSMethodSignature *actual=[NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
        NSMethodSignature *expected=[NSMethodSignature signatureWithObjCTypes:encoding];
        if(!actual || !expected || actual.numberOfArguments!=expected.numberOfArguments || ![CSType(actual.methodReturnType) isEqual:CSType(expected.methodReturnType)])return NO;
        for(NSUInteger i=0;i<actual.numberOfArguments;i++)if(![CSType([actual getArgumentTypeAtIndex:i]) isEqual:CSType([expected getArgumentTypeAtIndex:i])])return NO;
        return YES;
    } @catch(__unused NSException *exception) { return NO; }
}
