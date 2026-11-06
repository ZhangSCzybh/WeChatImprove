#import <Foundation/Foundation.h>
#import "CSGroupPreferences.h"
static NSString *const Profiles=@"com.wechat.enhance.chat_group.account_profiles";
static NSString *const SelectA=@"com.wechat.enhance.chat_group.selection.A";
@interface MemoryDefaults : NSObject
@property(nonatomic,strong) NSMutableDictionary *values;
@property(nonatomic) NSUInteger writes,syncs;
@property(nonatomic) BOOL rejectSelection,throwSelection;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)value forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (BOOL)synchronize;
@end
@implementation MemoryDefaults
- (instancetype)init { if ((self=[super init])) self.values=[NSMutableDictionary new]; return self; }
- (id)objectForKey:(NSString *)key { return self.values[key]; }
- (void)setObject:(id)value forKey:(NSString *)key {
    self.writes++;
    if ([key containsString:@".selection."]) {
        if (self.rejectSelection) return;
        if (self.throwSelection) { self.throwSelection=NO; @throw [NSException exceptionWithName:@"test" reason:nil userInfo:nil]; }
    }
    self.values[key]=[value copy];
}
- (void)removeObjectForKey:(NSString *)key { [self.values removeObjectForKey:key]; }
- (BOOL)synchronize { self.syncs++; return YES; }
@end
static CSGroupPreferences *Prefs(MemoryDefaults *d,NSString *account) { return [[CSGroupPreferences alloc] initWithDefaults:(id)d accountID:account]; }
static NSUInteger checks,failures;
static void Check(BOOL ok,NSString *message) { checks++; if (!ok) { failures++; fprintf(stderr,"FAIL %s\n",message.UTF8String); } }
int main(void) { @autoreleasepool {
    MemoryDefaults *d=[MemoryDefaults new]; CSGroupPreferences *p=Prefs(d,@"A");
    Check([p.selectedTabID isEqual:@"preset_0"] && !d.writes,@"empty config reads without writes");
    p.selectedTabID=@"preset_2";
    Check(d.writes==1 && !d.syncs && !d.values[Profiles],@"selection writes one small key without profile backup/synchronize");
    Check([Prefs(d,@"A").selectedTabID isEqual:@"preset_2"],@"new instance restores selected group");
    d.writes=0; p.selectedTabID=@"preset_2";
    Check(!d.writes,@"identical selection does not write");
    p.selectedTabID=@"missing"; Check(!d.writes && [p.selectedTabID isEqual:@"preset_2"],@"unknown selection cannot be stored");
    CSGroupPreferences *other=Prefs(d,@"B"); other.selectedTabID=@"preset_3";
    Check([Prefs(d,@"A").selectedTabID isEqual:@"preset_2"] && [Prefs(d,@"B").selectedTabID isEqual:@"preset_3"],@"selections are account isolated");
    NSUInteger writes=d.writes; CSGroupPreferences *anonymous=Prefs(d,nil); anonymous.selectedTabID=@"preset_1";
    Check(d.writes==writes,@"unknown account cannot write");
    d.rejectSelection=YES; p.selectedTabID=@"preset_1"; d.rejectSelection=NO;
    Check([p.selectedTabID isEqual:@"preset_2"] && [Prefs(d,@"A").selectedTabID isEqual:@"preset_2"],@"readback failure keeps previous selection");
    d.throwSelection=YES; p.selectedTabID=@"preset_1";
    Check([p.selectedTabID isEqual:@"preset_2"] && [Prefs(d,@"A").selectedTabID isEqual:@"preset_2"],@"exception restores previous selection");
    WESessionTabItem *tab=[WESessionTabItem customTabWithName:@"team" sessionUserNames:@[@"u1",@"u2"]];
    BOOL saved=[p saveCustomTabs:@[tab] presetNames:@{} tabOrder:@[] hiddenPresetTabs:[NSSet set]];
    Check(saved && !d.values[SelectA] && [p.selectedTabID isEqual:@"preset_2"],@"definition save folds selection into compatible profile and clears override");
    Check(d.syncs>0 && d.values[Profiles],@"definition writes retain durable full-profile path");
    p.selectedTabID=tab.tabId;
    CSGroupPreferences *editor=Prefs(d,@"A");
    NSArray *tabs=p.tabs; [p reload]; Check(p.tabs==tabs,@"unchanged definitions reuse normalized tab objects");
    p.selectedTabID=@"preset_3";
    Check([editor saveCustomTabs:editor.customTabs presetNames:@{@"preset_0":@"All"} tabOrder:editor.tabOrder hiddenPresetTabs:editor.hiddenPresetTabs],@"selection-only changes do not conflict with definition editor");
    Check([Prefs(d,@"A").selectedTabID isEqual:@"preset_3"],@"definition editor preserves latest user selection");
    Check(![p saveCustomTabs:p.customTabs presetNames:@{} tabOrder:p.tabOrder hiddenPresetTabs:p.hiddenPresetTabs],@"stale definitions still reject overwrite");
    [p reload]; p.selectedTabID=tab.tabId;
    Check([p saveCustomTabs:@[] presetNames:p.presetNames tabOrder:p.tabOrder hiddenPresetTabs:p.hiddenPresetTabs],@"delete selected custom group succeeds");
    Check(![Prefs(d,@"A").selectedTabID isEqual:tab.tabId],@"deleted group cannot be restored from obsolete override");
    p.selectedTabID=@"preset_2";
    Check([p saveCustomTabs:p.customTabs presetNames:p.presetNames tabOrder:p.tabOrder hiddenPresetTabs:[NSSet setWithObject:@"preset_2"]],@"hide selected preset succeeds");
    Check(![Prefs(d,@"A").selectedTabID isEqual:@"preset_2"],@"hidden group falls back to a visible group");
    d.values[SelectA]=@{@"version":@1,@"tabID":@"deleted"};
    Check(![Prefs(d,@"A").selectedTabID isEqual:@"deleted"],@"invalid old override ignored");
    d.values[SelectA]=@{@"version":@2,@"tabID":@"future"}; writes=d.writes;
    p=Prefs(d,@"A"); p.selectedTabID=@"preset_1";
    Check(d.writes==writes && [d.values[SelectA][@"version"] isEqual:@2],@"future selection schema preserved");
    Check(![p saveCustomTabs:p.customTabs presetNames:p.presetNames tabOrder:p.tabOrder hiddenPresetTabs:p.hiddenPresetTabs] && d.writes==writes,@"definition save also preserves future selection schema");
    d.values[Profiles]=@{@"A":@{@"version":@2}}; writes=d.writes;
    p=Prefs(d,@"A"); p.selectedTabID=@"preset_1";
    Check(d.writes==writes,@"future profile schema never overwritten");
    fprintf(stdout,"Group preferences: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
