#import <Foundation/Foundation.h>
#import <objc/runtime.h>
static id DynamicGet(id self,SEL cmd){return @"installed";}
@interface DynamicFixture:NSObject @end
@implementation DynamicFixture
+ (BOOL)resolveInstanceMethod:(SEL)sel {if(sel==NSSelectorFromString(@"pbField")){puts("resolver called");return class_addMethod(self,sel,(IMP)DynamicGet,"@16@0:8");}return [super resolveInstanceMethod:sel];}
@end
int main(){@autoreleasepool{id x=[DynamicFixture new];Method m=class_getInstanceMethod(object_getClass(x),NSSelectorFromString(@"pbField"));printf("class_getInstanceMethod found=%d\n",m!=NULL);}}
