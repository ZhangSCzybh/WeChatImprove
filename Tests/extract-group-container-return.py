"""Real proxy + complete refresh + existing real privacy/layout/card replay.

The external entry deliberately queries the UI proxy while a native owner scope
is active, before table.layoutSubviews. This is a host-controlled input boundary;
it does not assert that a phone miniapp return uses that sequence.
"""
from pathlib import Path
import subprocess,sys
root=Path(__file__).resolve().parent.parent
out=Path(sys.argv[1]);source_path=Path(sys.argv[2]) if len(sys.argv)>2 else root/'Controllers/CSGroupListAdapter.m'
hooks_path=Path(sys.argv[3]) if len(sys.argv)>3 else root/'Hooks/SessionGroupHooks.xm'
subprocess.run([sys.executable,str(root/'Tests/extract-group-return-layout.py'),str(out),str(source_path),str(hooks_path),*sys.argv[4:]],check=True)
source=source_path.read_text()
def method(text,marker):
 start=text.index(marker);brace=text.index('{',start);depth=0
 for end in range(brace,len(text)):
  if text[end]=='{':depth+=1
  elif text[end]=='}':
   depth-=1
   if not depth:return text[start:end+1]
 raise AssertionError(marker)
completion='- (void)finishNeutralPublication:(BOOL)publicationCompleted {'
fallback='- (void)finishNeutralPublication:(BOOL)publicationCompleted { (void)publicationCompleted; }'
if completion in source:
 out.write_text(out.read_text().replace(fallback,method(source,completion),1))
out.with_name('GroupContainerRefresh.h').write_text(method(source,'- (void)refresh {')+'\n')
start=source.index('@interface CSGroupTableProxy : NSObject');end=source.index('\n@end',source.index('@implementation CSGroupTableProxy',start))+len('\n@end')
out.with_name('GroupContainerProxy.h').write_text(source[start:end]+'\n')
