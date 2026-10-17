#import "CSMessageActionDiagnostics.h"
#include <stdatomic.h>
#if TARGET_OS_IOS
#import "CSSettingTableViewCell.h"
#import "CSUserInfoHelper.h"
#else
#define kPluginVersionString @"host-test"
#endif
static atomic_bool CSDiagnosticsEnabled=false;
static NSMutableArray<NSDictionary *> *CSDiagnosticEvents;
static NSUInteger CSDiagnosticSequence;
@implementation CSMessageActionDiagnostics
+ (BOOL)isEnabled { return atomic_load_explicit(&CSDiagnosticsEnabled,memory_order_relaxed); }
+ (void)setEnabled:(BOOL)enabled {
    @synchronized(self) {
        if (enabled) { CSDiagnosticEvents=[NSMutableArray array]; CSDiagnosticSequence=0; }
        atomic_store_explicit(&CSDiagnosticsEnabled,enabled,memory_order_relaxed);
    }
}
+ (void)record:(NSString *)stage fields:(NSDictionary<NSString *,id> *)fields {
    if (![self isEnabled]) return;
    // A fixed schema prevents callers from accidentally exporting message data.
    static NSSet *numbers,*strings; static dispatch_once_t once;
    dispatch_once(&once,^{
        numbers=[NSSet setWithArray:@[@"type",@"count",@"repeat",@"forward",@"repeatEnabled",@"voiceEnabled",@"context",@"valid",@"account",@"fromSelf",@"toSelf",@"hasFrom",@"hasTo",@"senderKnown",@"outgoing",@"hasLocalID",@"hasServerID",@"duration",@"format",@"bytes",@"expectedBytes",@"status",@"recording",@"complete",@"terminal",@"cancelled",@"measured",@"formatKnown",@"stable",@"accepted",@"constructor",@"insert",@"uploader",@"actionMatches",@"targetPresent",@"menuType",@"typeSet"]];
        strings=[NSSet setWithArray:@[@"cell",@"model",@"wrap",@"controller",@"nativeController",@"reason",@"item"]];
    });
    NSMutableDictionary *event=[NSMutableDictionary dictionaryWithObject:stage forKey:@"stage"];
    for (NSString *key in fields) {
        id value=fields[key];
        if (([numbers containsObject:key] && [value isKindOfClass:NSNumber.class]) ||
            ([strings containsObject:key] && [value isKindOfClass:NSString.class] && [value length]<=160)) event[key]=value;
    }
    @synchronized(self) {
        if (![self isEnabled]) return;
        event[@"sequence"]=@(++CSDiagnosticSequence); [CSDiagnosticEvents addObject:event];
        if (CSDiagnosticEvents.count>160) [CSDiagnosticEvents removeObjectAtIndex:0];
    }
}
+ (NSString *)report {
    NSArray *events; @synchronized(self) { events=[CSDiagnosticEvents copy] ?: @[]; }
    NSDictionary *report=@{@"schema":@1,@"plugin":kPluginVersionString,
        @"wechat": [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"] ?: @"unknown",
        @"wechatBuild": [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"] ?: @"unknown",
        @"events":events};
    NSData *data=[NSJSONSerialization dataWithJSONObject:report options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ?: @"{}";
}
#if TARGET_OS_IOS
+ (CSSettingSection *)settingsSectionForController:(UITableViewController *)controller {
    CSSettingItem *toggle=[CSSettingItem switchItemWithTitle:@"记录消息操作诊断" iconName:@"stethoscope" iconColor:UIColor.systemOrangeColor switchValue:self.isEnabled valueChangedBlock:^(BOOL on){ [self setEnabled:on]; }];
    CSSettingItem *copy=[CSSettingItem actionItemWithTitle:@"复制诊断信息" iconName:@"doc.on.doc" iconColor:UIColor.systemBlueColor];
    __weak UITableViewController *weakController=controller; __weak CSSettingItem *weakToggle=toggle;
    copy.actionBlock=^{
        [self setEnabled:NO]; weakToggle.switchValue=NO;
        [UIPasteboard.generalPasteboard setItems:@[@{@"public.utf8-plain-text":[self report]}] options:@{UIPasteboardOptionLocalOnly:@YES}];
        [weakController.tableView reloadData];
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"诊断信息已复制" message:@"记录已停止，可将诊断信息粘贴用于排查。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
        [weakController presentViewController:alert animated:YES completion:nil];
    };
    CSSettingItem *help=[CSSettingItem itemWithTitle:@"使用方法" iconName:@"info.circle" iconColor:UIColor.secondaryLabelColor detail:@"开启后重现问题，再返回复制；不记录消息内容或联系人"];
    return [CSSettingSection sectionWithHeader:@"问题排查" items:@[toggle,copy,help]];
}
#endif
@end
