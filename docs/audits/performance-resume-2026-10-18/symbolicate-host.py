"""Read-only, UUID-gated Objective-C method mapping of the supplied crash.

Uses LC_FUNCTION_STARTS boundaries and Objective-C class method lists. Does not
infer method identity from a nearby unrelated symbol. No device access.
Chained pointer decoding is specific to this verified arm64 WeChat image.
"""
import bisect, hashlib, json, mmap, struct, uuid
from pathlib import Path

out=Path(__file__).parent
crash=Path('/Users/zhangshichao/Downloads/WeChat-2026-10-18-070030.ips')
binary=Path('/tmp/wechat-8.0.78-inset-analysis/WeChat')
report=json.loads(crash.read_text().split('\n',1)[1])
handle=binary.open('rb'); b=mmap.mmap(handle.fileno(),0,access=mmap.ACCESS_READ)
u32=lambda o:struct.unpack_from('<I',b,o)[0]
u64=lambda o:struct.unpack_from('<Q',b,o)[0]
i32=lambda o:struct.unpack_from('<i',b,o)[0]
segs=[];sections={};starts=[];off=32;image_uuid=None
for _ in range(u32(16)):
    cmd,size=struct.unpack_from('<II',b,off)
    if cmd==0x1b: image_uuid=str(uuid.UUID(bytes=b[off+8:off+24]))
    if cmd==0x19:
        name=b[off+8:off+24].split(b'\0')[0].decode()
        va,vs,fo,fs=struct.unpack_from('<QQQQ',b,off+24);segs.append((va,vs,fo,fs))
        for j in range(u32(off+64)):
            so=off+72+80*j;sn=b[so:so+16].split(b'\0')[0].decode()
            sections[(name,sn)]=struct.unpack_from('<QQI',b,so+32)
    if cmd==0x26:
        p,length=struct.unpack_from('<II',b,off+8);end=p+length;address=0x100000000
        while p<end:
            value=shift=0
            while True:
                v=b[p];p+=1;value|=(v&127)<<shift;shift+=7
                if not v&128:break
            if not value:break
            address+=value;starts.append(address)
    off+=size
assert image_uuid==report['usedImages'][0]['uuid'], 'WeChat UUID mismatch'

def pos(address):
    for va,vs,fo,fs in segs:
        if va<=address<va+fs:return fo+address-va
    raise ValueError(hex(address))
def string(address):
    p=pos(address);return b[p:b.find(b'\0',p)].decode(errors='replace')
def ptr(offset):
    v=u64(offset)
    if v>>63:raise ValueError('external binding')
    return 0x100000000+(v&0xfffffffff)

frames=[]
for index in [0,27]:
    for ordinal,frame in enumerate(report['threads'][index]['frames']):
        if frame['imageIndex']!=0:continue
        address=0x100000000+frame['imageOffset']
        k=bisect.bisect_right(starts,address-1)-1
        frames.append(dict(thread=index,frame=ordinal,offset=hex(frame['imageOffset']),
                           address=hex(address),start=hex(starts[k]),end=hex(starts[k+1])))
wanted={int(row['start'],16) for row in frames};found={};skipped=0
for (seg,sec),(addr,size,offset) in sections.items():
    if sec!='__objc_classlist':continue
    for at in range(offset,offset+size,8):
        try:
            cls=ptr(at);rp=pos(ptr(pos(cls)+32)&~7);name=string(ptr(rp+24))
            for kind,cl in [('-',cls),('+',ptr(pos(cls)))]:
                rp=pos(ptr(pos(cl)+32)&~7)
                if not u64(rp+32):continue
                ml=ptr(rp+32);mp=pos(ml);flags,count=struct.unpack_from('<II',b,mp)
                for n in range(count):
                    en=mp+8+n*(flags&0xffff);ev=ml+8+n*(flags&0xffff)
                    imp=ev+8+i32(en+8) if flags&0x80000000 else ptr(en+16)
                    if imp not in wanted:continue
                    if flags&0x80000000:
                        sa=ev+i32(en)
                        if not flags&0x40000000:sa=ptr(pos(sa))
                        selector=string(sa)
                    else:selector=string(ptr(en))
                    found.setdefault(imp,[]).append(f'{kind}[{name} {selector}]')
        except (ValueError,struct.error):skipped+=1
for row in frames:row['methods']=found.get(int(row['start'],16),[])
result=dict(binary=str(binary),uuid=image_uuid,sha256=hashlib.sha256(b).hexdigest(),
            crash_sha256=hashlib.sha256(crash.read_bytes()).hexdigest(),frames=frames,
            skipped_class_metadata=skipped,
            limitations=['Static method boundaries; does not identify a runtime lock owner.',
                         'Class and metaclass method lists only; category-only methods and C/C++ frames may remain unnamed.'])
(out/'wechat-symbolicated-frames.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
for row in frames:print(row['thread'],row['frame'],row['offset'],', '.join(row['methods']) or 'unnamed',row['start'],row['end'])
