"""Focused host check: execute production grouping, lookup and toggle methods."""
from pathlib import Path
import re
import subprocess
import tempfile

root = Path(__file__).resolve().parents[3]
source = (root / 'Controllers/CSCloseFriendSettingsViewController.m').read_text()

def method(prefix):
    start = source.index(prefix)
    end = source.find('\n- (', start + 1)
    return source[start:end if end >= 0 else source.index('\n@end', start)]

keys = re.search(r'self.keys=(@\[.*?\]);', source).group(1)
tags = re.findall(r'\btoggle\.tag=(?!=)(.*?);', source)
assert len(tags) == 2 and tags[0] == '100'
for key in ('longPressUnlockDuration', 'unlockSeconds', 'callReplyText'):
    assert f'else if([optionKey isEqual:@"{key}"])' in source
assert source.count('NSString *optionKey=[self optionKeyForIndexPath:indexPath];') == 2
fixture = r'''
#import <Foundation/Foundation.h>
@interface NSIndexPath (Rows)
@property(nonatomic,readonly) NSInteger row,section;
@end
@implementation NSIndexPath (Rows)
- (NSInteger)section {return [self indexAtPosition:0];}
- (NSInteger)row {return [self indexAtPosition:1];}
@end
@interface UITableView : NSObject
- (void)reloadData;
@end
@implementation UITableView
- (void)reloadData {}
@end
@interface UISwitch : NSObject
@property(nonatomic) NSInteger tag;
@property(nonatomic) BOOL on;
@end
@implementation UISwitch
@end
static NSDictionary *profile;
static NSDictionary *CSCloseFriendCurrentProfile(void) {return profile;}
@interface SettingsFixture : NSObject
@property(nonatomic,copy) NSArray *keys,*accountKeys,*protectionKeys;
@property(nonatomic,strong) UITableView *tableView;
@end
@implementation SettingsFixture
- (BOOL)authorized {return YES;}
- (void)save:(NSDictionary *)value {profile=value;}
__METHODS__
- (NSInteger)tagForKey:(NSString *)key {return __TAG__;}
@end
static NSIndexPath *Path(NSUInteger section,NSUInteger row) {NSUInteger indexes[]={section,row};return [NSIndexPath indexPathWithIndexes:indexes length:2];}
int main(void) {@autoreleasepool {
    SettingsFixture *settings=[SettingsFixture new];settings.keys=__KEYS__;
    [settings configureOptionGroups];
    NSArray *expected=@[@"hideSettingsEntry",@"hidePluginEntry",@"biometric",@"shakeToLock",@"longPressUnlockEnabled",@"longPressUnlockDuration",@"unlockSeconds"];
    NSCAssert([settings.accountKeys isEqual:expected],@"All 7 requested rows in screenshot order");
    NSCAssert([settings tableView:nil numberOfRowsInSection:0]==13 && [settings tableView:nil numberOfRowsInSection:1]==15,@"Account and protection row counts");
    for(NSUInteger row=0;row<6;row++) NSCAssert(![settings optionKeyForIndexPath:Path(0,row)],@"Original account actions retain their rows");
    NSMutableSet *seen=[NSMutableSet new];
    for(NSUInteger section=0;section<2;section++) {
        NSUInteger count=[settings tableView:nil numberOfRowsInSection:section];
        for(NSUInteger row=section==0?6:0;row<count;row++) {
            NSString *key=[settings optionKeyForIndexPath:Path(section,row)];
            NSCAssert(key && ![seen containsObject:key],@"Each option appears exactly once");[seen addObject:key];
            if([@[@"longPressUnlockDuration",@"unlockSeconds",@"callReplyText"] containsObject:key]) continue;
            NSMutableDictionary *options=[NSMutableDictionary new];
            for(NSString *other in settings.keys) options[other]=@NO;
            // Existing durations must survive moving and toggling unrelated rows.
            options[@"longPressUnlockDuration"]=@0.5;options[@"unlockSeconds"]=@300;
            profile=@{@"enabled":@YES,@"options":options};
            UISwitch *toggle=[UISwitch new];toggle.tag=[settings tagForKey:key];toggle.on=YES;
            [settings toggle:toggle];
            NSMutableDictionary *expectedOptions=[options mutableCopy];expectedOptions[key]=@YES;
            NSCAssert([profile[@"options"] isEqual:expectedOptions],@"Toggle changes only its mapped option, preserving stored settings");
        }
    }
    NSCAssert(seen.count==22 && [seen isEqual:[NSSet setWithArray:settings.keys]],@"No lost or duplicated options");
    NSCAssert([[settings optionKeyForIndexPath:Path(0,11)] isEqual:@"longPressUnlockDuration"] && [[settings optionKeyForIndexPath:Path(0,12)] isEqual:@"unlockSeconds"],@"Duration editor routes resolve in account section");
    puts("Settings regression: 7 moved rows, 22 unique options, 19 toggle mappings, duration routes and stored values passed");
}return 0;}
'''
fixture = fixture.replace('__METHODS__', '\n'.join(method(prefix) for prefix in (
    '- (void)configureOptionGroups', '- (NSString *)optionKeyForIndexPath:',
    '- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:', '- (void)toggle:')))
fixture = fixture.replace('__TAG__', tags[1]).replace('__KEYS__', keys)
with tempfile.TemporaryDirectory(prefix='wechat-settings-regression-') as tmp:
    path = Path(tmp) / 'settings.m'
    path.write_text(fixture)
    subprocess.run(['xcrun', '--sdk', 'macosx', 'clang', '-fobjc-arc', '-fblocks',
                    '-Wall', '-Wextra', '-Werror', '-Wno-unused-parameter',
                    '-framework', 'Foundation', str(path), '-o', str(Path(tmp)/'settings')], check=True)
    subprocess.run([str(Path(tmp)/'settings')], check=True)
