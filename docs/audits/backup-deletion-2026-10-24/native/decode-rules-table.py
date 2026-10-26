"""Read-only constant-data reconstruction of WeChat 8.0.78's compiled rule table.
Does not load/execute the target. Symbolically evaluates only its straight-line
integer/vector constant stores, with coverage assertions for all 1046 records.
"""
from pathlib import Path
import re,struct,json,hashlib
base=Path(__file__).parent
ctx={};exec((base/'extract.py').read_text().split('\nimport re,subprocess,hashlib,bisect')[0],ctx)
regs={};memory={};origin={};vectors={}
table=0x120c7b980

def reg(name):
 if name in ('wzr','xzr'):return 0
 return regs['x'+name[1:]] & (0xffffffff if name.startswith('w') else 0xffffffffffffffff)
def put(name,v):regs['x'+name[1:]]=v & (0xffffffff if name.startswith('w') else 0xffffffffffffffff)
def value(s):return int(s.removeprefix('#'),0) if s.startswith('#') or s.startswith('0x') else reg(s)
def address(s):
 assert s.startswith('[') and s.endswith(']'),s
 parts=s[1:-1].split(', ');return reg(parts[0])+(value(parts[1]) if len(parts)>1 else 0)
def width(r):return {'w':4,'x':8,'d':8,'q':16}[r[0]]
def rb(r):return vectors['v'+r[1:]][:width(r)] if r[0] in 'dq' else reg(r).to_bytes(width(r),'little')
def write(addr,bs,pc):
 assert table<=addr and addr+len(bs)<=table+1046*48,(hex(addr),len(bs))
 for j,v in enumerate(bs):memory[addr+j]=v;origin[addr+j]=pc
for line in (base/'rules-table-initializer.asm').read_text().splitlines():
 m=re.match(r'([0-9a-f]+): [0-9a-f]+\s+(\S+)\s*(.*)',line)
 if not m:continue
 pc=int(m[1],16)
 if not 0x1029a27c0<=pc<0x1029aba7c:continue
 op=m[2];args=m[3].split(' ;')[0].split(' <')[0].strip()
 if op=='adrp':r,v=args.split(', ');put(r,int(v,16))
 elif op=='add':r,a,b=args.split(', ');put(r,reg(a)+value(b))
 elif op=='mov':r,v=args.split(', ');put(r,value(v))
 elif op=='movi.2s':r,v=args.split(', ');vectors[r]=int(v[1:],0).to_bytes(4,'little')*2+b'\0'*8
 elif op=='dup.2d':r,v=args.split(', ');vectors[r]=reg(v).to_bytes(8,'little')*2
 elif op=='ldr':
  r,a=args.split(', ',1);p=ctx['pos'](address(a));data=bytes(ctx['b'][p:p+width(r)])
  if r[0] in 'dq':vectors['v'+r[1:]]=data+b'\0'*(16-len(data))
  else:put(r,int.from_bytes(data,'little'))
 elif op=='str':r,a=args.split(', ',1);write(address(a),rb(r),pc)
 elif op=='stp':
  r,s,a=args.split(', ',2);write(address(a),rb(r)+rb(s),pc)
 else:raise ValueError((hex(pc),op,args))
rows=[]
for i in range(1046):
 a=table+i*48; data=bytes(memory.get(a+j,0) for j in range(48))
 # Native struct layout is {q,q,@,q,i,i,i}; final four bytes are padding.
 assert all(a+j in memory for j in range(44)),i
 biz,prefix,obj,store,unknown32,classification,file=struct.unpack('<qqQqiii4x',data)
 p=ctx['pos'](obj);text=ctx['string'](ctx['ptr'](p+16))
 rows.append(dict(index=i,bizType=biz,pathPrefixType=prefix,path=text,storeTimeType=store,unknownIntAt32=unknown32,wechatFileClass=classification,fileTypeInUse=file,pathObject=hex(obj),pathStoreInstruction=hex(origin[a+16]),raw=data.hex()))
(base/'compiled-path-rules.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2)+'\n')
relevant=[x for x in rows if x['pathPrefixType']==1 and (x['path'].startswith('Library') or x['path'] in ['*','.*','**'])]
(base/'library-path-rules.json').write_text(json.dumps(relevant,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'total':len(rows),'library_and_root_wildcard':len(relevant),'prefix_counts':{p:sum(x['pathPrefixType']==p for x in rows) for p in set(x['pathPrefixType'] for x in rows)},'table':hex(table)},ensure_ascii=False))
for x in relevant:print(x['index'],x['path'],f"prefix={x['pathPrefixType']} biz={x['bizType']} time={x['storeTimeType']} class={x['wechatFileClass']} file={x['fileTypeInUse']}")
