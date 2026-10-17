exec(open('/tmp/service-entry-extract.py').read().split("selected={'MMContext'")[0])
classes={};raw={};found=[]
for (seg,sec),(addr,size,offset) in sections.items():
 if sec!='__objc_classlist':continue
 for off in range(offset,offset+size,8):
  try:
   cls=ptr(off);rp=pos(ptr(pos(cls)+32)&~7);name=string(ptr(rp+24));classes[cls]=name
   try:parent=ptr(pos(cls)+8)
   except ValueError:parent='external-bind'
   raw[name]={'address':hex(cls),'superclass':parent}
   for kind in ['instance','class']:
    mr=rp if kind=='instance' else pos(ptr(pos(ptr(pos(cls)))+32)&~7)
    if not u64(mr+32):continue
    ml=ptr(mr+32);mp=pos(ml);flags,count=struct.unpack_from('<II',b,mp)
    for n in range(count):
     entry=mp+8+n*(flags&0xffff)
     if flags&0x80000000:
      ev=ml+8+n*(flags&0xffff);seladdr=ev+i32(entry)
      if not flags&0x40000000:seladdr=ptr(pos(seladdr))
      sel=string(seladdr);imp=ev+8+i32(entry+8);types=string(ev+4+i32(entry+4))
     else:sel=string(ptr(entry));imp=ptr(entry+16);types=string(ptr(entry+8))
     if sel in ['returnAsRawService','defaultCenter','fastCurrentContext']:
      found.append({'class':name,'kind':kind,'selector':sel,'address':hex(imp),'types':types})
  except (ValueError,struct.error):continue
for n in ['CContactMgr','MMServiceCenter','MMServiceWrapper','MMBaseService']:
 print(n,raw.get(n), 'parent',classes.get(raw.get(n,{}).get('superclass')))
print(json.dumps(found,indent=2))
root.joinpath('service-entry-related-methods.json').write_text(json.dumps(found,indent=2))
for x in found:
 if x['selector']=='returnAsRawService':
  start=int(x['address'],16)
  text=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(start+16),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
  root.joinpath('service-entry-'+x['class']+'-'+x['kind']+'-returnAsRawService.asm').write_text(text)
print('MMUserService',raw.get('MMUserService'), 'parent',classes.get(raw.get('MMUserService',{}).get('superclass')))
catfound=[]
for (seg,sec),(addr,size,offset) in sections.items():
 if sec not in ['__objc_catlist','__objc_nlcatlist']:continue
 for o in range(offset,offset+size,8):
  try:
   cp=pos(ptr(o));name=string(ptr(cp))
   try:owner=classes.get(ptr(cp+8),hex(ptr(cp+8)))
   except ValueError:owner='external-bind'
   for kind,moff in [('instance',16),('class',24)]:
    if not u64(cp+moff):continue
    ml=ptr(cp+moff);mp=pos(ml);flags,count=struct.unpack_from('<II',b,mp)
    for n in range(count):
     entry=mp+8+n*(flags&0xffff)
     if flags&0x80000000:
      ev=ml+8+n*(flags&0xffff);seladdr=ev+i32(entry)
      if not flags&0x40000000:seladdr=ptr(pos(seladdr))
      sel=string(seladdr);imp=ev+8+i32(entry+8);types=string(ev+4+i32(entry+4))
     else:sel=string(ptr(entry));imp=ptr(entry+16);types=string(ptr(entry+8))
     if sel in ['returnAsRawService','defaultCenter','fastCurrentContext']:
      catfound.append({'class':owner,'category':name,'kind':kind,'selector':sel,'address':hex(imp),'types':types})
  except (ValueError,struct.error):continue
print(json.dumps(catfound,indent=2))
root.joinpath('service-entry-category-methods.json').write_text(json.dumps(catfound,indent=2))
for x in catfound:
 start=int(x['address'],16)
 text=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(start+0x80),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
 root.joinpath('service-entry-'+x['class']+'-'+x['category']+'-'+x['selector']+'.asm').write_text(text)
