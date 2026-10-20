"""Bounded disassembly of selected presentation methods; never executes target."""
import hashlib,json,re,subprocess
from pathlib import Path
ROOT=Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
OUT=Path(__file__).parent
ctx={};exec((ROOT/'docs/evidence/close-friends-native-2026-10-20/extract.py').read_text().split('\nimport re,subprocess,hashlib,bisect')[0],ctx)
selected={
 'ContactsDataLogic':['getContactCount','getKeysArray','getAllNormalContact','getAllNormalContactUnfiltered','getContactsArrayWith:','getAllContactsDictionary','getAllContacts','getFilteredContacts','filterContactsViewContacts:'],
 'ContactsViewController':['onFilterContactCandidate:','numberOfSectionsInTableView:','tableView:numberOfRowsInSection:','makeCell:tableCell:section:row:','tableView:didSelectRowAtIndexPath:','mmsectionIndexTitlesForTableView:'],
 'ContactSelectView':['onFilterContactCandidate:'],
 'SessionSelectView':['initData','initRecentForwardView','filterContact:','onFilterContactCandidate:','onContactsDataChange','tableView:numberOfRowsInSection:','contactForRecentChatRowAtIndexPath:','contactIndexForRecentChatRowAtIndexPath:','sessionSelectMessageSearchLogic:shouldIncludeContact:','onFTSContactSearchFinish:'],
 'FTSSingleContactSectionController':['didUpdateWithModel:','onFTSContactSearchFinish:','numberOfSearchItems','dataCellForItemAtIndex:indexPath:','didSelectDataRowAtIndex:indexPath:'],
 'FTSGroupContactSectionController':['didUpdateWithModel:','onFTSContactSearchFinish:','numberOfSearchItems','dataCellForItemAtIndex:indexPath:','didSelectDataRowAtIndex:indexPath:'],
 'FTSTopHitsSectionController':['didUpdateWithModel:','numberOfSearchItems','dataCellForItemAtIndex:indexPath:'],
 'FTSMessageSectionController':['didUpdateWithModel:','numberOfSearchItems','displayedMgrSessionIndexes','displayedSessionUserCount','mgrSessionIndexForDisplayedItemRow:','sessionUsernameForDisplayedItemRow:','sessionMsgItemsForDisplayedItemRow:','didSelectRowAtIndex:'],
 'FTSMsgSearchResultWrap':['getResultCountForDisplay'],
 'ContactTagNewDetailViewController':['reloadDataAndView','sortTagContacts','processContactSectionData:','numberOfSectionsInTableView:','tableView:numberOfRowsInSection:','makeMemberContactCellContent:WithIndexPath:','onClickContactItemCellWithIndexPath:','handleDeleteContactAtIndexPath:','loadHeaderViewSelection'],
 'ContactTagListViewController':['makeContactItemCellContent:withTagData:','makeContactItemCellContent:withTagData:searchText:','tableView:numberOfRowsInSection:'],
 'ContactInfoViewController':['isInMyContactList','onAddToContact'],
 'CBaseContactInfoAssist':['isInMyContactList','onAddToContacts'],
 'WeixinContactInfoAssist':['addMsgActionView','initFooterBtnArea','initFooterStackView','onAddToContacts','doSendVerifyOrAddContact'],
 'WCTimeLineCellView':['initPrivacyButton:','onShowGroup','layoutSubviews','accessibilityLabel'],
 'FTSBaseSectionController':['numberOfItems','numberOfItemsExceptTopTitile'],
 'RecentForwardScrollView':['contactsForRecentForwardMenu','initView','indexForContact:','onItemClick:'],
}
rows=json.loads((OUT/'methods.json').read_text());reports=[]
ivars={int(v['offset_address'],16): cls+'.'+v['name'] for cls,record in json.loads((OUT/'metadata.json').read_text()).items() for v in record['ivars']}
for row in rows:
 if row['selector'] not in selected.get(row['cls'],[]):continue
 start=int(row['address'],16);stop=min(int(row['end'],16),start+16000)
 name=row['cls']+'--'+row['selector'].replace(':','_')+'.asm'
 if (OUT/name).exists():
  reports.append(dict(file=name,start=hex(start),stop=hex(stop),truncated=stop<int(row['end'],16)))
  continue
 raw=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(stop),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
 regs={};lines=[]
 for line in raw.splitlines():
  m=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
  if m:regs[m[1]]=int(m[2],16)
  m=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
  if m and m[1] in regs:
   try:
    value=ctx['string'](ctx['ptr'](ctx['pos'](regs[m[1]]+int(m[2],16))))
    if value and len(value)<180 and all(c.isprintable() and c!='�' for c in value):line+=' ; '+value
   except Exception:pass
  m=re.search(r'ldrsw\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
  if m and m[1] in regs:
   a=regs[m[1]]+int(m[2],16)
   if a in ivars:line+=' ; ivar '+ivars[a]
  lines.append(line.rstrip())
 name=row['cls']+'--'+row['selector'].replace(':','_')+'.asm'
 (OUT/name).write_text('\n'.join(lines)+'\n');reports.append(dict(file=name,start=hex(start),stop=hex(stop),truncated=stop<int(row['end'],16)))
manifest=json.loads((OUT/'manifest.json').read_text());manifest['disassembly']=reports
manifest['files']={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in OUT.iterdir() if p.suffix in ['.py','.asm','.json'] and p.name!='manifest.json'}
(OUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
print(json.dumps({'disassembled':len(reports),'truncated':[r for r in reports if r['truncated']]}))
