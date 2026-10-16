"""Host audit of reachable lifecycle/viewport risks; never accesses real defaults.

Runs existing production-method extractors with isolated fixtures. Publication
counts replace snapshot/UI costs. The production account-reset branch is also
extracted: the shipping lifecycle fixture omits that branch.
"""
from pathlib import Path
import subprocess, tempfile, json, hashlib
repo = Path(__file__).resolve().parents[3]
source = (repo/'Controllers/CSGroupListAdapter.m').read_text()
results = {}
def run(args):
    return subprocess.check_output(args, cwd=repo, text=True)
with tempfile.TemporaryDirectory(prefix='wechat-group-audit-') as temp:
    build = Path(temp)
    run(['python3', 'Tests/extract-group-lifecycle.py', str(build/'GroupLifecycleBodies.h')])
    fixture = (repo/'Tests/GroupLifecycleTests.m').read_text().split('int main(void)', 1)[0]
    fixture = fixture.replace('@property(nonatomic,strong) id nativeHeader;', '@property(nonatomic,strong) id nativeHeader,projection;')
    start = source.index('        NSString *account=CSGroupCurrentAccountID();', source.index('- (void)refresh {'))
    end = source.index('        self.preferences=', start)
    # Preserve the actual branch that clears nativePresentation on account change.
    fixture = fixture.replace('    self.refreshCount++;\n', '    self.refreshCount++;\n' + source[start:end], 1)
    fixture += '''int main(void) { @autoreleasepool {
        Host *host=nil; CSGroupListAdapter *a=List(&host);
        [host viewWillDisappear:NO]; [a beginNativeChange];
        __block NSUInteger executed=0;
        [a performInNativePresentation:^{ executed++; }];
        account=@"account-B"; [a endNativeChange]; RunFor(.02);
        NSUInteger queued=a.nativeActions.count, before=a.refreshCount;
        for (NSUInteger i=0;i<3;i++) { [a requestRefresh]; RunFor(.01); }
        NSDictionary *cross=@{@"queued_after_account_change":@(queued),@"executed_old_account_actions":@(executed),
            @"extra_hidden_publications_for_3_events":@(a.refreshCount-before),@"still_suspended":@(a.presentationSuspended)};
        a=List(&host); before=a.refreshCount;
        for (NSUInteger i=0;i<20;i++) { [a requestRefresh]; RunFor(.004); }
        NSUInteger foreground=a.refreshCount-before;
        a=List(&host); a.publishing=YES;
        [a performInNativePresentation:^{ executed++; }];
        a.publishing=NO; RunFor(.02);
        NSDictionary *reentrant=@{@"queued":@(a.nativeActions.count),@"scheduled":@(a.scheduled),@"dirty":@(a.dirty)};
        NSDictionary *output=@{@"cross_account":cross,@"foreground_publications_for_20_events":@(foreground),@"reentrant_navigation":reentrant};
        NSData *data=[NSJSONSerialization dataWithJSONObject:output options:NSJSONWritingPrettyPrinted error:nil];
        puts([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].UTF8String);
        return 0;
    } }
'''
    (build/'LifecycleAudit.m').write_text(fixture)
    common=['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-unused-function','-Wno-unused-variable','-framework','Foundation','-I'+str(build)]
    run(common+[str(build/'LifecycleAudit.m'),'-o',str(build/'lifecycle')])
    results.update(json.loads(run([str(build/'lifecycle')])))
    run(['python3','Tests/extract-group-viewport.py',str(build/'GroupViewportBodies.h')])
    fixture=(repo/'Tests/GroupViewportTests.m').read_text().split('int main(void)',1)[0]
    fixture+='''int main(void) { @autoreleasepool {
        HostController *host=nil; CSGroupListAdapter *a=List(&host,1600);
        a.pendingScrollToTop=YES; a.groupPanMoving=YES;
        [a applyPendingScrollToTop];
        NSDictionary *output=@{@"top_offset_writes_during_group_pan":@(a.table.offsetWrites),@"pending_after":@(a.pendingScrollToTop)};
        NSData *data=[NSJSONSerialization dataWithJSONObject:output options:NSJSONWritingPrettyPrinted error:nil];
        puts([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].UTF8String); return 0;
    } }
'''
    (build/'ViewportAudit.m').write_text(fixture)
    run(common+['-framework','CoreGraphics',str(build/'ViewportAudit.m'),'-o',str(build/'viewport')])
    results.update(json.loads(run([str(build/'viewport')])))
    fixture=(repo/'docs/performance/session-groups-1.6-32/benchmark.m').read_text().split('int main(void)',1)[0]
    fixture+='''int main(void) { @autoreleasepool {
        MemoryDefaults *defaults=[MemoryDefaults new]; CSGroupPreferences *p=Prefs(defaults);
        p.selectedTabID=@"preset_1"; p.selectedTabID=@"preset_1";
        defaults.writes=0; defaults.syncs=0;
        p.selectedTabID=p.selectedTabID;
        NSDictionary *output=@{@"same_selection_writes":@(defaults.writes),@"same_selection_syncs":@(defaults.syncs)};
        NSData *data=[NSJSONSerialization dataWithJSONObject:output options:NSJSONWritingPrettyPrinted error:nil];
        puts([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].UTF8String); return 0;
    } }
'''
    (build/'PreferencesAudit.m').write_text(fixture)
    run(common+['-Wno-undeclared-selector','-I'+str(repo/'Controllers'),
        str(repo/'Controllers/CSGroupNativeBridge.m'),str(repo/'Controllers/CSGroupProjection.m'),
        str(repo/'Controllers/CSGroupPreferences.m'),str(repo/'Controllers/WESessionTabItem.m'),
        str(build/'PreferencesAudit.m'),'-o',str(build/'preferences')])
    results.update(json.loads(run([str(build/'preferences')])))
results['commit']=run(['git','rev-parse','HEAD']).strip()
results['adapter_sha256']=hashlib.sha256(source.encode()).hexdigest()
results['limits']='Host fixtures with production scheduling/guards/account-reset branch. No UIKit, real host event timing, iPhone FPS, real defaults or accounts.'
print(json.dumps(results,indent=2))
