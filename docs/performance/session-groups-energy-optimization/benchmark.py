"""Compare cold projection and validated cached paths; synthetic host, no UIKit."""
from pathlib import Path
import subprocess,tempfile
root=Path(__file__).resolve().parents[3]
source=(root/'docs/performance/session-groups-1.6-32/benchmark.m').read_text()
marker='        NSDictionary *core=Measure(^{'
extra='''        CSGroupProjection *cached=Project(sections,prefs);
        NSDictionary *cachedSame=Measure(^{
            CSGroupProjection *p=[[CSGroupProjection alloc] initWithSections:sections tabs:prefs.tabs selectedTabID:prefs.selectedTabID filterDuplicates:NO accountID:@"synthetic-account" previousProjection:cached];
            NSCAssert(p==cached,@"unchanged result was not reused");
        });
        NSMutableArray *updatedRows=[sections[0] mutableCopy];
        CSGroupRow *first=updatedRows[0];
        updatedRows[0]=[[CSGroupRow alloc] initWithNativePath:first.nativePath userName:first.userName kind:first.kind category:first.category top:first.top unreadCount:first.unreadCount+1 redDot:first.redDot];
        NSArray *updatedSections=@[updatedRows];
        NSDictionary *cachedUnread=Measure(^{
            CSGroupProjection *p=[[CSGroupProjection alloc] initWithSections:updatedSections tabs:prefs.tabs selectedTabID:prefs.selectedTabID filterDuplicates:NO accountID:@"synthetic-account" previousProjection:cached];
            NSCAssert(p.valid,@"unread projection failed");
        });
        NSDictionary *cachedSwitch=Measure(^{
            CSGroupProjection *p=[[CSGroupProjection alloc] initWithSections:sections tabs:prefs.tabs selectedTabID:@"preset_2" filterDuplicates:NO accountID:@"synthetic-account" previousProjection:cached];
            NSCAssert(p.valid,@"selection projection failed");
        });
'''
assert source.count(marker)==1
source=source.replace(marker,extra+marker)
source=source.replace('@"projection_only":projection,','@"projection_only":projection,@"cached_unchanged":cachedSame,@"cached_unread":cachedUnread,@"cached_switch":cachedSwitch,')
with tempfile.TemporaryDirectory(prefix='wechat-group-cache-benchmark-') as d:
    d=Path(d);(d/'benchmark.m').write_text(source)
    args=['xcrun','--sdk','macosx','clang','-O2','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-undeclared-selector','-framework','Foundation','-I'+str(root/'Controllers')]
    args += [str(root/'Controllers'/p) for p in ['CSGroupNativeBridge.m','CSGroupProjection.m','CSGroupPreferences.m','WESessionTabItem.m']]
    subprocess.run(args+[str(d/'benchmark.m'),'-o',str(d/'bench')],check=True)
    subprocess.run([str(d/'bench')],check=True)
