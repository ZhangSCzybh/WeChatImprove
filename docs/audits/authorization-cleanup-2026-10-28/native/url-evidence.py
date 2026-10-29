"""Read-only string/CFString references and bounded ARM64 ADRP+ADD xrefs.

This is a bounded static search, not an execution or scheme-success check.
"""
import bisect, json, struct
import extract as e
from disassemble import starts

needles = ['weixin://profile/', 'weixin://profile/%@',
           'weixin://findfriend/verifycontact',
           'weixin://findfriend/verifycontact/([^/]*)']
hits = []
for (segment, section), (addr, size, off) in e.sections.items():
    if section != '__cstring':
        continue
    p = off
    while p < off + size:
        end = e.b.find(b'\0', p)
        if end < 0:
            break
        value = e.b[p:end].decode(errors='replace')
        if value in needles:
            hits.append(dict(section=section, address=hex(addr+p-off), file_offset=hex(p), value=value))
        p = end + 1
strings = {int(row['address'], 16): row['value'] for row in hits}
constants = dict(strings)
for (_, section), (addr, size, off) in e.sections.items():
    if section != '__cfstring':
        continue
    for p in range(off, off + size, 32):
        try:
            target = e.ptr(p + 16)
        except ValueError:
            continue
        if target in strings:
            constants[addr+p-off] = strings[target]
pages = {v & ~4095 for v in constants}
xrefs = []
for (_, section), (addr, size, off) in e.sections.items():
    if section != '__text':
        continue
    for delta in range(0, size, 4):
        instruction = e.u32(off + delta)
        if instruction & 0x9f000000 != 0x90000000:
            continue
        immediate = ((instruction >> 29) & 3) | (((instruction >> 5) & 0x7ffff) << 2)
        if immediate & (1 << 20):
            immediate -= 1 << 21
        pc = addr + delta
        page = (pc & ~4095) + immediate * 4096
        if page not in pages:
            continue
        register = instruction & 31
        for distance in range(4, 25, 4):
            other = e.u32(off + delta + distance)
            # ADD Xd, Xn, #imm12, no shift. Stop at unconditional call/branch.
            if other & 0x7c000000 == 0x14000000:
                break
            if other & 0xffc00000 != 0x91000000 or ((other >> 5) & 31) != register:
                continue
            target = page + ((other >> 10) & 4095)
            if target not in constants:
                continue
            index = bisect.bisect_right(starts, pc)
            xrefs.append(dict(adrp=hex(pc), add=hex(pc+distance), constant=hex(target), value=constants[target], function_start=hex(starts[index-1]), function_end_exclusive=hex(starts[index])))
result = dict(search_boundary='__cstring exact strings; __cfstring direct pointers; __text ADRP+ADD within six instructions before a direct branch/call; other reference forms are not covered', strings=hits, constants=[dict(address=hex(k),value=v) for k,v in constants.items()], xrefs=xrefs)
(e.out / 'url-evidence.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps({'strings':len(hits),'constants':len(constants),'xrefs':xrefs},indent=2))
