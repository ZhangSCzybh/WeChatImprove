#!/usr/bin/env python3
"""Compile the actual production Hook bodies on the host, including read-only group role code."""
from pathlib import Path
import re,sys,json
root=Path(__file__).resolve().parent.parent
source=(root/'Hooks/ListCornerRadiusHooks.xm').read_text()
def body(text,start):
    begin=text.index('{',start); depth=1; end=begin+1
    while depth:
        if text[end]=='{':depth+=1
        elif text[end]=='}':depth-=1
        end+=1
    return text[begin+1:end-1]
output=[]
start=source.index('static UIView *CSListCornerSectionView(')
output.append(source[start:source.index('{',start)+1]+body(source,start)+'}')
for page,cls in [('Contacts','ContactsViewController'),('Discover','FindFriendEntryViewController'),('Session','NewMainFrameViewController'),('More','MoreViewController')]:
    start=source.index('%hook '+cls+'\n');end=source.index('%end',start);chunk=source[start:end]
    for role in ['Header','Footer']:
        position=chunk.index(f'- (CGFloat)tableView:(id)arg1 heightFor{role}InSection:')
        code=body(chunk,position)
        assert code.count('%orig')==1
        code=code.replace('%orig','[(UITableView *)arg1 originalHeight]')
        output.append(f'static CGFloat Hook{page}{role}(id self,id arg1,NSInteger arg2) {{'+code+'}')
for cls in ['MMTableViewCell','NewContactsItemCell','MMTableSectionHeaderView']:
    chunk=source[source.index('%hook '+cls+'\n'):];chunk=chunk[:chunk.index('%end')]
    code=body(chunk,chunk.index('- (void)layoutSubviews')).replace('%orig;','(void)self; /* original layout stub */')
    output.append(f'static void Hook{cls}Layout(id self) {{'+code+'}')
for cls in ['NewMainFrameCell','FakeMainFrameCell']:
    chunk=source[source.index('%hook '+cls+'\n'):];chunk=chunk[:chunk.index('%end')]
    code=body(chunk,chunk.index('- (void)layoutSubviews'));assert code.count('%orig')==1
    output.append('static void Hook'+cls+'Layout(id self,void (^original)(void)) {'+code.replace('%orig;', 'original();')+'}')
chunk=source[source.index('%hook ContactsViewController\n'):];chunk=chunk[:chunk.index('%end')]
for method,signature in [('- (void)initCountLabel:', 'HookContactsInitCount(id self,id arg1,void (^original)(void))'), ('- (void)viewDidLayoutSubviews', 'HookContactsCountLayout(id self,void (^original)(void))')]:
    code=body(chunk,chunk.index(method));assert code.count('%orig')==1
    output.append('static void '+signature+' {'+code.replace('%orig;', 'original();')+'}')
chunk=source[source.index('%hook NewMainFrameViewController\n'):];chunk=chunk[:chunk.index('%end')]
# Before the regression fix there is no layout hook: execute native layout alone.
method='- (void)viewDidLayoutSubviews'
code=body(chunk,chunk.index(method)) if method in chunk else '%orig;'
assert code.count('%orig')==1
output.append('static void HookSessionViewportLayout(id self,void (^original)(void)) {'+code.replace('%orig;', 'original();')+'}')
group=(root/'Controllers/CSGroupListAdapter.m').read_text();start=group.index('BOOL CSGroupCardPosition(')
output.append(group[start:group.index('{',start)+1]+body(group,start)+'}')
settings=(root/'Controllers/CSListCornerRadiusSettingsViewController.m').read_text()
start=settings.index('[[CSListCornerConfiguration sharedConfiguration] saveNumber:',settings.index('- (void)resetToDefaultSettings'))
end=settings.index('        self.lightModeBgColor =',start)
code=settings[start:end]
output.append('static void ProductionReset(SettingsFixture *self) {\n'+code+'\n}')
for name,method,variable in [('Radius','showCornerRadiusPicker','radiusValue'),('Left','showLeftMarginPicker','marginValue'),('Right','showRightMarginPicker','marginValue'),('Pinned','showTopSessionTopMarginPicker','marginValue'),('Normal','showNormalSessionTopMarginPicker','marginValue')]:
    start=settings.index('- (void)'+method)
    start=settings.index('CGFloat '+variable+' = [inputText floatValue];',start)
    end=settings.index('self.',start)
    code=settings[start:end].replace('[inputText floatValue]','input')
    output.append('static CGFloat ProductionValidate'+name+'(CGFloat input) {'+code+'return '+variable+';}')
fixture=json.loads((root/'Tests/ListCornerBaseline.json').read_text())
output.append('static NSArray *ProductionKeys(void) { return @['+','.join(f'@[@"{name}",{name}]' for name in fixture['keys'])+']; }')
Path(sys.argv[1]).write_text('\n'.join(output)+'\n')
