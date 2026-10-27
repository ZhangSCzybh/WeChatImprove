"""Diagnostic replay of the unmodified production proxy on macOS Foundation.

This is a host lifetime probe, not an iOS/UIKit animation reproduction.
Production files and user preferences are never modified.
"""
from pathlib import Path
import json
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
source = (HERE / 'before/Controllers/CSGroupListAdapter.m').read_text()
start = source.index('@interface CSGroupTableProxy : NSObject')
end = source.index('\n@end', source.index('@implementation CSGroupTableProxy', start)) + len('\n@end')
proxy = source[start:end]
prefix = r'''
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "CSGroupInvocationMapper.h"
@class UITableView, UITableViewCell;
static BOOL CSGroupUsesNativeIndices(id table) { (void)table; return NO; }
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) id table;
@property(nonatomic) BOOL isActive;
@property(nonatomic) NSUInteger forwards;
- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target;
- (void)forwardInvocation:(NSInvocation *)inv target:(id)target;
@end
@implementation CSGroupListAdapter
- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target { (void)path; (void)target; return nil; }
- (void)forwardInvocation:(NSInvocation *)inv target:(id)target {
    self.forwards++;
    NSUInteger length=inv.methodSignature.methodReturnLength;
    if (length) { void *zero=calloc(1,length); [inv setReturnValue:zero]; free(zero); }
    if (target) [inv invokeWithTarget:target];
}
@end
@interface HeaderDelegate : NSObject
- (double)tableView:(id)table heightForHeaderInSection:(NSInteger)section;
@end
@implementation HeaderDelegate
- (double)tableView:(id)table heightForHeaderInSection:(NSInteger)section { (void)table; (void)section; return 23.0; }
@end
'''
suffix = r'''
static NSMutableDictionary *Query(CSGroupTableProxy *proxy, CSGroupListAdapter *adapter, NSString *scenario) {
    SEL selector=@selector(tableView:heightForHeaderInSection:);
    NSMutableDictionary *result=[@{@"scenario":scenario, @"responds":@([proxy respondsToSelector:selector]),
        @"hasSignature":@([proxy methodSignatureForSelector:selector]!=nil), @"targetIsNil":@(proxy.target==nil)} mutableCopy];
    NSUInteger before=adapter.forwards;
    @try {
        double value=((double(*)(id,SEL,id,NSInteger))objc_msgSend)(proxy,selector,nil,0);
        result[@"value"]=@(value); result[@"threw"]=@NO;
    } @catch (NSException *exception) {
        result[@"threw"]=@YES; result[@"exception"]=exception.name; result[@"reason"]=exception.reason;
    }
    result[@"enteredAdapterForwarding"]=@(adapter.forwards!=before);
    return result;
}
int main(void) { @autoreleasepool {
    CSGroupListAdapter *adapter=[CSGroupListAdapter new]; adapter.isActive=YES;
    CSGroupTableProxy *proxy=[CSGroupTableProxy new]; proxy.adapter=adapter;
    NSMutableArray *results=[NSMutableArray array];
    @autoreleasepool {
        HeaderDelegate *target=[HeaderDelegate new]; proxy.target=target;
        [results addObject:Query(proxy,adapter,@"live_target")];
    }
    [results addObject:Query(proxy,adapter,@"weak_target_released_before_delayed_callback")];
    NSObject *replacement=[NSObject new]; proxy.target=replacement;
    [results addObject:Query(proxy,adapter,@"same_proxy_retargeted_without_header_method")];
    HeaderDelegate *restored=[HeaderDelegate new]; proxy.target=restored;
    [results addObject:Query(proxy,adapter,@"live_target_restored")];
    NSData *data=[NSJSONSerialization dataWithJSONObject:results options:NSJSONWritingPrettyPrinted error:NULL];
    puts([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].UTF8String);
    return !(![results[0][@"threw"] boolValue] && [results[1][@"threw"] boolValue] &&
        [results[2][@"threw"] boolValue] && ![results[3][@"threw"] boolValue]);
} }
'''
with tempfile.TemporaryDirectory(prefix='wechat-proxy-lifetime-probe-') as directory:
    work = Path(directory)
    probe = work / 'probe.m'
    probe.write_text(prefix + proxy + suffix)
    command = ['xcrun', '--sdk', 'macosx', 'clang', '-fobjc-arc', '-fblocks', '-Wall', '-Wextra', '-Werror',
               '-framework', 'Foundation', '-I' + str(ROOT / 'Controllers'), str(probe),
               str(ROOT / 'Controllers/CSGroupInvocationMapper.m'), '-o', str(work / 'probe')]
    subprocess.run(command, check=True)
    completed = subprocess.run([str(work / 'probe')], check=True, capture_output=True, text=True)
    result = {'scope': 'macOS Foundation diagnostic; actual production proxy and invocation support list; adapter forwarding stub; no UIKit',
              'cases': json.loads(completed.stdout)}
    (HERE / 'proxy-reproduction.json').write_text(json.dumps(result, indent=2, ensure_ascii=False) + '\n')
    print(json.dumps(result, indent=2, ensure_ascii=False))
