#!/usr/bin/env python3
"""Execution-free Mach-O ObjC metadata audit; supports this arm64 PTR_64_OFFSET image.

Usage: python3 inspect_objc_metadata.py /absolute/WeChat /absolute/hooks.json output-dir
Reads immutable file bytes. Does not load the target or use the ObjC runtime.
"""
import hashlib
import json
import mmap
import struct
import sys
from pathlib import Path

binary, hooks_path, output_dir = map(Path, sys.argv[1:])
hooks = json.loads(hooks_path.read_text())
output_dir.mkdir(parents=True, exist_ok=True)
source = binary.open('rb')
b = mmap.mmap(source.fileno(), 0, access=mmap.ACCESS_READ)
assert b[:4] == bytes.fromhex('cffaedfe'), 'Expected thin little-endian Mach-O 64'
u32 = lambda p: struct.unpack_from('<I', b, p)[0]
i32 = lambda p: struct.unpack_from('<i', b, p)[0]
u64 = lambda p: struct.unpack_from('<Q', b, p)[0]
segments, sections, encryption, dylibs = [], {}, [], []
imports = []
cursor = 32
for _ in range(u32(16)):
    command, size = struct.unpack_from('<II', b, cursor)
    if command == 0x19:
        name = b[cursor+8:cursor+24].split(b'\0')[0].decode()
        va, vs, fo, fs = struct.unpack_from('<QQQQ', b, cursor+24)
        segments.append(dict(name=name, address=va, size=vs, offset=fo, file_size=fs))
        for j in range(u32(cursor+64)):
            p = cursor+72+j*80
            sn = b[p:p+16].split(b'\0')[0].decode()
            addr, length = struct.unpack_from('<QQ', b, p+32)
            sections[name+','+sn] = dict(address=addr, size=length, offset=u32(p+48))
    elif command == 0x2c:
        encryption.append(dict(zip(['cryptoff', 'cryptsize', 'cryptid'],struct.unpack_from('<III',b,cursor+8))))
    elif command in [0xc, 0x80000018, 0x8000001f]:
        p = cursor+u32(cursor+8)
        dylibs.append(b[p:b.find(b'\0',p)].decode())
    elif command == 0x80000034:
        fixoff = u32(cursor+8)
        starts = fixoff + u32(fixoff+4)
        formats=[]
        for j in range(u32(starts)):
            off=u32(starts+4+j*4)
            if off: formats.append(struct.unpack_from('<H',b,starts+off+6)[0])
        assert set(formats)=={6}, ('Unsupported chained pointer formats', formats)
        imports_offset, symbols_offset, imports_count, imports_format = struct.unpack_from('<4I',b,fixoff+8)
        assert imports_format == 1, ('Unsupported import format', imports_format)
        for j in range(imports_count):
            value=u32(fixoff+imports_offset+j*4)
            p=fixoff+symbols_offset+(value>>9)
            imports.append(b[p:b.find(b'\0',p)].decode())
    cursor += size
base = next(s['address'] for s in segments if s['name']=='__TEXT')

def off(va):
    for s in segments:
        if s['address'] <= va < s['address']+s['file_size']:
            return va-s['address']+s['offset']
    raise ValueError('Address outside file-backed segments: '+hex(va))

def pointer(p):
    raw=u64(p)
    if raw==0: return 0
    if raw>>63: return None  # A chained bind; external symbol resolution not inferred.
    return base+(raw & ((1<<36)-1))

def bound_class(p):
    raw=u64(p)
    if raw>>63:
        name=imports[raw & 0xffffff]
        return name.removeprefix('_OBJC_CLASS_$_')
    return None

def cstr(va):
    p=off(va)
    return b[p:b.find(b'\0',p)].decode('utf-8',errors='replace')

def method_list(va,kind,origin='class'):
    if not va: return []
    p=off(va); flags,count=struct.unpack_from('<II',b,p)
    step=flags & 0xffff
    small=bool(flags & 0x80000000)
    direct=bool(flags & 0x40000000)
    rows=[]
    for j in range(count):
        q=p+8+j*step
        qva=va+8+j*step
        if small:
            np=qva+i32(q)
            if not direct: np=pointer(off(np))
            tp=qva+4+i32(q+4)
            imp=qva+8+i32(q+8)
        else:
            np,tp,imp=[pointer(q+x) for x in (0,8,16)]
        rows.append(dict(kind=kind,selector=cstr(np),encoding=cstr(tp),
                         implementation=hex(imp) if imp else None,
                         metadata_address=hex(qva),origin=origin))
    return rows

classes={}; class_addresses={}; parse_errors=[]
cl=sections['__DATA_CONST,__objc_classlist']
for p in range(cl['offset'],cl['offset']+cl['size'],8):
    va=pointer(p)
    try:
        q=off(va); ro=pointer(q+32)&~7; r=off(ro); name=cstr(pointer(r+24))
        classes[name]=dict(name=name,address=hex(va),superclass_address=pointer(q+8),
                           superclass_external=bound_class(q+8),
                           metaclass_address=pointer(q),ro_address=ro)
        class_addresses[va]=name
    except Exception as e:
        parse_errors.append(dict(address=hex(va or 0),error=str(e)))

targets={h['cls'] for h in hooks}
targets.update(['WCFinderDataItem','BrandTLExptConfig','WAAppTaskSplashADConfig','LocalJSLogicBase'])
# Retain in-image ancestors so inherited declarations can be checked truthfully.
for name in list(targets):
    item=classes.get(name)
    while item and item['superclass_address']:
        ancestor=class_addresses.get(item['superclass_address'])
        if not ancestor or ancestor in targets: break
        targets.add(ancestor)
        item=classes.get(ancestor)
selected={}
for name in sorted(targets):
    if name not in classes: continue
    item=classes[name].copy(); r=off(item['ro_address'])
    item['superclass']=class_addresses.get(item['superclass_address']) or item['superclass_external']
    item['methods']=method_list(pointer(r+32),'-')
    meta=off(item['metaclass_address']); mr=off(pointer(meta+32)&~7)
    item['methods']+=method_list(pointer(mr+32),'+')
    iv=pointer(r+48); item['ivars']=[]
    if iv:
        v=off(iv); size,count=struct.unpack_from('<II',b,v)
        for j in range(count):
            z=v+8+j*size
            op,np,tp=[pointer(z+x) for x in (0,8,16)]
            item['ivars'].append(dict(name=cstr(np),encoding=cstr(tp),
                                      offset=u32(off(op)),metadata_address=hex(iv+8+j*size)))
    pr=pointer(r+64); item['properties']=[]
    if pr:
        v=off(pr); size,count=struct.unpack_from('<II',b,v)
        for j in range(count):
            z=v+8+j*size
            item['properties'].append(dict(name=cstr(pointer(z)),attributes=cstr(pointer(z+8))))
    selected[name]=item

# Categories may provide declared methods absent from the base class method list.
for sk,cat in sections.items():
    if not sk.endswith(',__objc_catlist'): continue
    for p in range(cat['offset'],cat['offset']+cat['size'],8):
        va=pointer(p)
        try:
            q=off(va); clsname=class_addresses.get(pointer(q+8))
            if clsname in selected:
                category=cstr(pointer(q))
                selected[clsname]['methods'] += method_list(pointer(q+16),'-','category:'+category)
                selected[clsname]['methods'] += method_list(pointer(q+24),'+','category:'+category)
        except Exception as e:
            parse_errors.append(dict(category_address=hex(va or 0),error=str(e)))

rows=[]
for h in hooks:
    row=dict(reference_class=h['cls'],kind=h['kind'],selector=h['selector'],
             reference_operation=h['operation'],reference_action=h['action'])
    item=selected.get(h['cls'])
    matches=[m for m in (item or {}).get('methods',[]) if m['kind']==h['kind'] and m['selector']==h['selector']]
    if matches:
        row['status']='declared-on-class'; row['matches']=matches
    elif item:
        parent=selected.get(item['superclass']); inherited=[]; owner=None
        while parent:
            inherited=[m for m in parent['methods'] if m['kind']==h['kind'] and m['selector']==h['selector']]
            if inherited:
                owner=parent['name']; break
            parent=selected.get(parent['superclass'])
        if inherited:
            row['status']='inherited-from-main-image'; row['matches']=inherited; row['declaring_class']=owner
        else:
            row['status']='not-in-declared-methods'; row['superclass']=item['superclass']
    else: row['status']='class-not-in-main-image'
    rows.append(row)

report=dict(binary_sha256=hashlib.file_digest(binary.open('rb'),'sha256').hexdigest(),
            image_base=hex(base),encryption=encryption,dylibs=dylibs,
            class_count=len(classes),parse_errors=parse_errors,
            pointer_format='DYLD_CHAINED_PTR_64_OFFSET (6)',
            limitations=['Metadata proves declared types and static implementation locations, not executed behavior.',
                         'External classes and inherited methods absent from selected metadata remain unresolved.',
                         'Method encodings are preserved verbatim; C declarations require interpreting signedness/width.'],
            classes=selected,hooks=rows)
(output_dir/'objc-metadata.json').write_text(json.dumps(report,ensure_ascii=False,indent=2))
print(json.dumps(dict(classes=len(classes),selected=len(selected),errors=len(parse_errors),
                     status_counts={k:sum(r['status']==k for r in rows) for k in {r['status'] for r in rows}}),indent=2))
