"""Replay the production header methods and search hooks with a host UIKit fixture."""
from pathlib import Path
import sys
root=Path(__file__).resolve().parent.parent
source=(root/'Controllers/CSGroupListAdapter.m').read_text()
hooks=(root/'Hooks/SessionGroupHooks.xm').read_text()
out=Path(sys.argv[1])
def method(text,marker):
 start=text.index(marker); brace=text.index('{',start); depth=0
 for end in range(brace,len(text)):
  if text[end]=='{': depth+=1
  elif text[end]=='}':
   depth-=1
   if not depth: return text[start:end+1]
 raise AssertionError(marker)
markers=['- (UIView *)nativeTableHeaderView','- (void)setNativeTableHeaderView:', '- (void)prepareForNativeSearch', '- (BOOL)keepsGroupHeaderDuringSearch', '- (void)publishHeader:', '- (void)layout {']
out.write_text('\n'.join(method(source,m) for m in markers))
markers=['- (void)onSearch {','- (void)setSearchBarActive:', '- (void)onFTSSearchEnd {','- (void)cancelSearch {']
out.with_name('SearchHooks.h').write_text('\n'.join(method(hooks,m).replace('%orig','[self originalSearchCall]') for m in markers))
