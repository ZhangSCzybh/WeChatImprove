"""Extend return-privacy replay with real viewport helpers and card-role policy.

Core source bodies use the unchanged privacy extractor. Decoration hook order is
varied using the actual table hook and actual restore-depth wrapper; post-layout
paint repair is a counted fixture and does not query data-source rows or roles.
"""
from pathlib import Path
import subprocess,sys
root=Path(__file__).resolve().parent.parent
out=Path(sys.argv[1])
subprocess.run([sys.executable,str(root/'Tests/extract-group-return-privacy.py'),str(out),*sys.argv[2:]],check=True)
source=(Path(sys.argv[2]) if len(sys.argv)>2 else root/'Controllers/CSGroupListAdapter.m').read_text()
def method(text,marker):
    start=text.index(marker);brace=text.index('{',start);depth=0
    for end in range(brace,len(text)):
        if text[end]=='{':depth+=1
        elif text[end]=='}':
            depth-=1
            if not depth:return text[start:end+1]
    raise AssertionError(marker)
markers=['- (BOOL)hasScrollableContent','- (BOOL)canRestoreAnchor','- (void)saveAnchor','- (void)restoreAnchor','- (NSNumber *)presentationScrollHeight','- (void)restoreViewportFromTab:','- (void)restoreScrollHeight:']
out.with_name('GroupReturnLayoutViewport.h').write_text('\n\n'.join(method(source,m) for m in markers)+'\n')
out.with_name('GroupReturnLayoutCard.h').write_text(method(source,'BOOL CSGroupCardPosition(')+'\n')
hooks=(root/'Hooks/ListCornerRadiusHooks.xm').read_text().split('%hook MainFrameTableView',1)[1].split('%end',1)[0]
body=method(hooks,'- (void)layoutSubviews {').split('{',1)[1].rsplit('}',1)[0].replace('%orig','original()')
restore=(root/'Controllers/CSListCornerSessionRestore.m').read_text()
out.with_name('GroupReturnLayoutDecorator.h').write_text(method(restore,'void CSListCornerPerformSessionTableLayout(')+'\nstatic void HookDecoratorLayout(id self,void (^original)(void)) {'+body+'}\n')
