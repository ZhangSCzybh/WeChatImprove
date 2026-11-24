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
out.write_text('\n'.join(method(source,m) for m in markers) + '\n' +
               method(source, '- (void)refresh {').replace('- (void)refresh {', '- (void)refreshProjection {', 1))
markers=['- (void)showSearchBar:', '- (void)onSearch {','- (void)setSearchBarActive:', '- (void)onFTSSearchEnd {','- (void)cancelSearch {',
         '- (void)viewWillAppear:', '- (void)viewDidAppear:', '- (void)viewWillDisappear:', '- (void)viewDidDisappear:',
         '- (void)viewDidLayoutSubviews {', '- (void)setSearchBarToTableHeaderView {']
bodies=[]
for marker in markers:
 body=method(hooks,marker)
 # Preserve the production hook's ordering while a named fixture callback
 # replays only the corresponding host implementation and its nested calls.
 selector=marker.split(')')[1].strip().split()[0]
 argument=' searchBar:searchBar' if marker=='- (void)showSearchBar:' else ''
 bodies.append(body.replace('%orig',f'[self originalSearchCall:@"{selector}"{argument}]'))
out.with_name('SearchHooks.h').write_text('\n'.join(bodies))
table=hooks[hooks.index('%hook UITableView'):]
out.with_name('SearchTableHooks.h').write_text(
 method(table,'- (UIView *)tableHeaderView').replace('%orig','[super tableHeaderView]')+'\n'+
 method(table,'- (void)setTableHeaderView:').replace('%orig','[super setTableHeaderView:header]'))
