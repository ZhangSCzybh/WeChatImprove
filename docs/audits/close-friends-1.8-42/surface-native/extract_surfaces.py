"""Offline 8.0.78 metadata; writes only sibling evidence files."""
import bisect, hashlib, json, struct
from pathlib import Path

ROOT = Path('/Users/zhangshichao/Documents/Workspace/WeChatImprove')
OUT = Path(__file__).parent
ctx = {}
exec((ROOT / 'docs/evidence/close-friends-native-2026-10-20/extract.py').read_text().split('\nimport re,subprocess,hashlib,bisect')[0], ctx)
b, u32, u64, i32, ptr, pos, string = (ctx[k] for k in ['b','u32','u64','i32','ptr','pos','string'])
classes = json.loads((ROOT / 'docs/evidence/message-actions-native-2026-10-17/classes.json').read_text())
reverse = {int(v,16): k for k,v in classes.items()}
selected = ['ContactsViewController','ContactsDataLogic','ContactSelectView','SessionSelectView','SessionSelectController','FTSSearchContactSectionController','FTSSingleContactSectionController','FTSGroupContactSectionController','FTSMsgSearchResultWrap','FTSMsgSearchResultHandler','FTSMultiContactResultWrap','FTSMsgSearchResultHandlerWrapper','FTSMsgSearchTask','FTSContactSearchTask','FTSIntelligentMsgSearchResultWrap','FTSIntelligentMsgSearchResultHandler','ContactTagListViewController','ContactTagData','ContactTagNewDetailViewController','ContactInfoViewController','CBaseContactInfoAssist','WeixinContactInfoAssist','WCTimeLineCellView','FTSMsgSessionResultItem','FTSBaseSectionController','FTSMessageSectionController','FTSTopHitsSectionController','FTSIntelligentMsgSessionResultItem']
selected += ['SessionSelectMessageSearchLogic','FTSTopHitItem','FTSTopHitValue','FTSTopHitGroupMember','_TtC6WeChat14FTSSectionData','_TtC6WeChat20FTSNormalSectionData','ContactTagItem','RecentForwardScrollView','FTSMessageMgr']
starts=[]; off=32
for _ in range(u32(16)):
    cmd,sz=struct.unpack_from('<II',b,off)
    if cmd==0x26:
        p,size=struct.unpack_from('<II',b,off+8); end=p+size; addr=0x100000000
        while p<end:
            value=shift=0
            while True:
                v=b[p];p+=1;value|=(v&127)<<shift;shift+=7
                if not v&128:break
            if not value:break
            addr+=value;starts.append(addr)
    off+=sz
methods=[]; metadata={}; missing=[]
for name in selected:
    if name not in classes:missing.append(name);continue
    ca=int(classes[name],16); record={'address':hex(ca),'ivars':[],'properties':[]}
    try: record['superclass']=reverse.get(ptr(pos(ca)+8),hex(ptr(pos(ca)+8)))
    except ValueError: record['superclass']='external bind (not decoded)'
    metadata[name]=record
    rp=pos(ptr(pos(ca)+32)&~7)
    if u64(rp+48):
        ip=pos(ptr(rp+48));iz,ic=struct.unpack_from('<II',b,ip)
        for k in range(ic):
            en=ip+8+k*iz;oa=ptr(en)
            record['ivars'].append({'offset_address':hex(oa),'offset':u32(pos(oa)),'name':string(ptr(en+8)),'type':string(ptr(en+16))})
    if u64(rp+64):
        pp=pos(ptr(rp+64));sz,count=struct.unpack_from('<II',b,pp)
        for k in range(count):
            en=pp+8+k*sz
            record['properties'].append({'name':string(ptr(en)),'attributes':string(ptr(en+8))})
    for kind,cl in [('instance',ca),('class',ptr(pos(ca)))]:
        rp=pos(ptr(pos(cl)+32)&~7)
        if not u64(rp+32):continue
        ml=ptr(rp+32);mp=pos(ml);flags,count=struct.unpack_from('<II',b,mp)
        for n in range(count):
            en=mp+8+n*(flags&0xffff);ev=ml+8+n*(flags&0xffff)
            if flags&0x80000000:
                sa=ev+i32(en)
                if not flags&0x40000000:sa=ptr(pos(sa))
                sel=string(sa);imp=ev+8+i32(en+8);typ=string(ev+4+i32(en+4))
            else:sel=string(ptr(en));imp=ptr(en+16);typ=string(ptr(en+8))
            idx=bisect.bisect_right(starts,imp);end=starts[idx] if idx<len(starts) else imp
            methods.append(dict(cls=name,kind=kind,selector=sel,address=hex(imp),end=hex(end),types=typ))
OUT.mkdir(parents=True,exist_ok=True)
(OUT/'methods.json').write_text(json.dumps(methods,indent=2)+'\n')
(OUT/'metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')
sha=hashlib.sha256()
with open(ctx['f'].name,'rb') as handle:
    for block in iter(lambda:handle.read(1024*1024),b''):sha.update(block)
manifest={'target':str(ctx['f'].name),'sha256':sha.hexdigest(),'static_only':True,'missing_classes':missing,'classes':selected,'method_count':len(methods)}
(OUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
print(json.dumps({'methods':len(methods),'classes':len(metadata),'missing':missing,'sha256':manifest['sha256']}))
