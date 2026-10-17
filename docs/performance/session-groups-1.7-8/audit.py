"""Replay current production scheduling using the existing Foundation lifecycle harness.
UI publication is a counted fixture; no device, database, UIKit or power measurement.
"""
from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[3]
with tempfile.TemporaryDirectory(prefix='wechat-group-energy-audit-') as work:
    work = Path(work)
    baseline='45e3ff8521f20821af276cede1da00e878120350'
    def original(path):
        return subprocess.check_output(['git','show',baseline+':'+path],cwd=root,text=True)
    for name,path in [('extract.py','Tests/extract-group-lifecycle.py'),('Adapter.m','Controllers/CSGroupListAdapter.m'),('Hooks.xm','Hooks/SessionGroupHooks.xm')]:
        (work/name).write_text(original(path))
    subprocess.run(['python3',str(work/'extract.py'),str(work/'GroupLifecycleBodies.h'),str(work/'Adapter.m'),str(work/'Hooks.xm')],check=True)
    source=original('Tests/GroupLifecycleTests.m')
    source = source.replace('static BOOL mutateDuringSnapshot;', 'static BOOL mutateDuringSnapshot;\nstatic NSUInteger feedbackUntil;')
    marker = '    [self layout];\n}\n@end'
    assert source.count(marker) == 1
    source = source.replace(marker, '    [self layout];\n    if (feedbackUntil && self.refreshCount < feedbackUntil) [self requestRefresh];\n}\n@end')
    marker = '    fprintf(stdout,"Group lifecycle:'
    assert source.count(marker) == 1
    extra = r'''
    // No incoming work: there is no autonomous publication loop.
    a=List(&host); before=a.refreshCount; RunFor(.25);
    Check(a.refreshCount==before && !a.scheduled,@"idle list does not autonomously refresh");
    fprintf(stdout,"AUDIT idle publications: %lu\n",(unsigned long)(a.refreshCount-before));
    // Separate notifications beyond the fixed merge window each publish.
    before=a.refreshCount;
    for (NSUInteger i=0;i<10;i++) { [a requestCoalescedRefresh]; RunFor(.055); }
    fprintf(stdout,"AUDIT spaced passive events: %lu publications / 10 events\n",(unsigned long)(a.refreshCount-before));
    Check(a.refreshCount==before+10,@"40ms merge does not merge events spaced 55ms apart");
    before=a.refreshCount;
    for (NSUInteger i=0;i<10;i++) { [a requestRefresh]; RunFor(.006); }
    fprintf(stdout,"AUDIT direct events: %lu publications / 10 events\n",(unsigned long)(a.refreshCount-before));
    Check(a.refreshCount==before+10,@"direct requests have no 40ms global rate limit");
    // The production admission/scheduler loops while menu motion persists.
    a.menuState=3; a.menuReads=0; before=a.refreshCount; [a requestRefresh]; RunFor(.27);
    fprintf(stdout,"AUDIT moving menu: %lu state reads, %lu publications, pending=%d after 270ms\n",(unsigned long)a.menuReads,(unsigned long)(a.refreshCount-before),a.scheduled);
    Check(a.menuReads>=6 && a.scheduled && a.refreshCount==before,@"motion retries persist without performing full publication");
    a.menuState=1; RunFor(.07);
    Check(!a.scheduled && a.dirty,@"stationary open menu stops polling");
    a.menuState=0; [a requestRefresh]; RunFor(.02);
    // Model a persistent callback requesting another refresh during publication.
    // This proves scheduler feedback; it does not prove real cell resolution fails.
    before=a.refreshCount; feedbackUntil=before+12; [a requestRefresh]; RunFor(.10);
    fprintf(stdout,"AUDIT injected publication invalidation: %lu chained publications (fixture stops at 12)\n",(unsigned long)(a.refreshCount-before));
    Check(a.refreshCount==before+12,@"publication invalidation can chain immediate refreshes");
    feedbackUntil=0;
'''
    source = source.replace(marker, extra+marker)
    test = work/'Audit.m'; test.write_text(source)
    binary = work/'audit'
    subprocess.run(['xcrun','--sdk','macosx','clang','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-Wno-unused-variable','-framework','Foundation','-I'+str(work),str(test),'-o',str(binary)], check=True)
    subprocess.run([str(binary)], check=True)
