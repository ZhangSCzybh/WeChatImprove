#import <Foundation/Foundation.h>
#import "CSBackupEngine.h"
int main(void){@autoreleasepool{
 NSString *suite=[@"reset.repro." stringByAppendingString:NSUUID.UUID.UUIDString];
 NSUserDefaults *defaults=[[NSUserDefaults alloc]initWithSuiteName:suite];
 NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
 [defaults setObject:[root URLByAppendingPathComponent:@"missing-tabbar.png"].path forKey:@"com.wechat.enhance.tabbar_style.icon.chat"];
 CSBackupEngine *engine=[[CSBackupEngine alloc]initWithDefaults:@{@"standard":defaults} domains:@{@"standard":suite} store:[[CSBackupStore alloc]initWithRoot:root] resources:root];
 engine.context=^{return @{@"account":@"test",@"installationID":@"isolated-test",@"pluginVersion":@"test"};};
 NSError *error=nil;NSDictionary *snapshot=[engine resetSnapshot:&error];
 printf("1.8-37 reset returned nil: %s\nError: %s\n",snapshot?"NO":"YES",error.localizedDescription.UTF8String);
 [defaults removePersistentDomainForName:suite];[NSFileManager.defaultManager removeItemAtURL:root error:NULL];
 return snapshot==nil&&error!=nil?0:1;
}}
