"""Extract dispatch/publication decisions, plus UIKit selection restoration hooks."""
from pathlib import Path
import sys
root=Path(__file__).resolve().parent.parent
source=(Path(sys.argv[2]) if len(sys.argv)>2 else root/'Controllers/CSGroupListAdapter.m').read_text()
def method(text,marker):
    start=text.index(marker); brace=text.index('{',start);depth=0
    for end in range(brace,len(text)):
        if text[end]=='{':depth+=1
        elif text[end]=='}':
            depth-=1
            if depth==0:return text[start:end+1]
    raise AssertionError(marker)
markers=['- (void)forwardInvocation:(NSInvocation *)inv target:(id)target {']
# The old adapter has no stable snapshot helper; callback regressions can still run against it.
helper='- (CSGroupProjection *)projectionForSections:'
if helper in source: markers.append(helper)
out=Path(sys.argv[1]);out.mkdir(exist_ok=True)
(out/'GroupProxySupport.h').write_text(method(source,'- (BOOL)respondsToSelector:'))
(out/'GroupSelectionBodies.h').write_text('\n'.join(method(source,m) for m in markers))
(out/'GroupSelectionFlags.h').write_text('#define HAS_STABLE_SNAPSHOT '+str(int(helper in source))+'\n')
hooks=(root/'Hooks/SessionGroupHooks.xm').read_text().split('%hook UITableView',1)[1].split('%end',1)[0]
selected=method(hooks,'- (void)selectRowAtIndexPath:')
selected=selected.replace('%orig;', '[self originalSelect:path animated:animated scrollPosition:position];').replace('%orig(display, animated, position);','[self originalSelect:display animated:animated scrollPosition:position];')
scroll=method(hooks,'- (void)scrollToRowAtIndexPath:')
scroll=scroll.replace('%orig;', '[self originalScroll:path atScrollPosition:position animated:animated];').replace('%orig(display, position, animated);','[self originalScroll:display atScrollPosition:position animated:animated];')
(out/'GroupSelectionHooks.h').write_text(selected+'\n'+scroll+'\n')
