"""Bounded, static disassembly of existing WeChat image conversion entry points.
Does not execute or modify the target. Address selection came from ObjC metadata.
"""
import hashlib,json,mmap,re,struct,subprocess
from pathlib import Path
out=Path(__file__).resolve().parent
repo=out.parents[3]
target=Path('/tmp/wechat-8.0.78-inset-analysis/WeChat')
expected='0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e'
with target.open('rb') as stream:
    sha256=hashlib.file_digest(stream,'sha256').hexdigest()
if sha256!=expected:raise SystemExit('Target identity changed; reselect addresses before use')
handle=target.open('rb');data=mmap.mmap(handle.fileno(),0,access=mmap.ACCESS_READ)
u32=lambda offset:struct.unpack_from('<I',data,offset)[0]
u64=lambda offset:struct.unpack_from('<Q',data,offset)[0]
segments=[];offset=32
for _ in range(u32(16)):
    command,size=struct.unpack_from('<II',data,offset)
    if command==0x19:segments.append(struct.unpack_from('<QQQQ',data,offset+24))
    offset+=size

def pos(address):
    for va,virtual_size,file_offset,file_size in segments:
        if va<=address<va+file_size:return file_offset+address-va
    raise ValueError(hex(address))

def pointer(offset):
    value=u64(offset)
    if value>>63:raise ValueError('external bind')
    return 0x100000000+(value&0xfffffffff)

def string(address):
    offset=pos(address);return data[offset:data.find(b'\0',offset)].decode(errors='replace')

classes=json.loads((repo/'docs/evidence/message-actions-native-2026-10-17/classes.json').read_text())
class_names={int(value,16):name for name,value in classes.items()}
selections=[
('CMessageWrap--getJpgPathOfMsgHdOrMiddleImg_',0x104ba84f4,0x104ba8708),
('CMessageWrap--getJpgPathOfMsgMiddleImg_',0x104ba9c70,0x104baa0dc),
('CMessageWrap--getMsgHdOrMiddleImgJpgData_',0x104baaab0,0x104baaac0),
('CMessageWrap--getMsgHdOrMiddleImgData_canUseHeif_',0x104baaad0,0x104baabdc),
('CMessageWrap--getMsgMiddleImgData_canUseHeif_',0x104bab064,0x104bab56c),
('WxamImageManager--getJpgPathByWxam_',0x10a99cc88,0x10a99ce3c),
('WxamImageManager--parseWxamData_',0x10a99c6e4,0x10a99c8c4),
]
reports=[]
for name,start,end in selections:
    raw=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),str(target)],text=True)
    registers={};lines=[]
    for line in raw.splitlines():
        match=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
        if match:registers[match[1]]=int(match[2],16)
        match=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
        if match and match[1] in registers:
            try:
                address=pointer(pos(registers[match[1]]+int(match[2],16)))
                value=class_names.get(address) or string(address)
                if value and len(value)<180 and all(ch.isprintable() and ch!='�' for ch in value):line+=' ; '+value
            except (ValueError,IndexError,struct.error):pass
        lines.append(line.rstrip())
    destination=out/(name+'.asm');destination.write_text('\n'.join(lines)+'\n')
    reports.append({'file':destination.name,'entry':hex(start),'end_exclusive':hex(end),'truncated':False,'sha256':hashlib.sha256(destination.read_bytes()).hexdigest()})
manifest={'target':str(target),'sha256':sha256,'architecture':'arm64','wechat_version':'8.0.78','static_only':True,
'producer':'xcrun llvm-objdump plus read-only Mach-O Objective-C metadata decoding; not REA function Evidence',
'limitations':['No device execution, user message bytes or runtime thread observations.','Reconstructed call chains establish static branches only; no blanket thread-safety guarantee.','REA open_binary established identical target identity; its Ghidra12.1.4 function dossier was stopped during costly import after datatype conflict traces. No decompiler result was obtained.','String/class annotations are pointer-decoding aids; raw instructions remain in each file.'],
'functions':reports}
(out/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
print(json.dumps({'files':len(reports),'assembly_bytes':sum((out/r['file']).stat().st_size for r in reports),'sha256':sha256}))
