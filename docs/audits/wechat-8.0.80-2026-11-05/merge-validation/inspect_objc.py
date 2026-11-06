#!/usr/bin/env python3
"""Read selected Objective-C metadata from the supplied thin arm64 Mach-O, offline."""
import argparse
import hashlib
import json
import mmap
import pathlib
import re
import struct


def inspect(path, names, annotate_directory=None):
    with open(path, "rb") as handle:
        data = mmap.mmap(handle.fileno(), 0, access=mmap.ACCESS_READ)
        u32 = lambda p: struct.unpack_from("<I", data, p)[0]
        u64 = lambda p: struct.unpack_from("<Q", data, p)[0]
        i32 = lambda p: struct.unpack_from("<i", data, p)[0]
        if u32(0) != 0xFEEDFACF:
            raise ValueError("Expected thin little-endian Mach-O 64")
        segments = []
        sections = []
        p = 32
        for _ in range(u32(16)):
            command, size = struct.unpack_from("<II", data, p)
            if command == 0x19:
                # segment_command_64 begins with cmd/cmdsize followed by segname.
                va, length, offset, file_size = struct.unpack_from("<QQQQ", data, p + 24)
                segments.append((va, va + length, offset, file_size))
                s = p + 72
                for _ in range(u32(p + 64)):
                    name = data[s:s+16].split(b"\0")[0].decode()
                    addr, length, offset = struct.unpack_from("<QQI", data, s + 32)
                    sections.append((name, addr, length, offset))
                    s += 80
            p += size

        def off(va):
            for start, end, offset, file_size in segments:
                if start <= va < end and va - start < file_size:
                    return offset + va - start
            raise ValueError(f"Unmapped address {va:#x}")

        def string(va):
            p = off(va)
            return data[p:data.find(b"\0", p)].decode("utf-8", "replace")

        image_base = min(start for start, end, offset, size in segments if size)

        def ptr(p):
            raw = u64(p)
            if not raw:
                return 0
            try:
                off(raw)
                return raw
            except ValueError:
                # DYLD_CHAINED_PTR_64_OFFSET rebases store an image-relative
                # target in 36 bits; the upper bits encode the next fixup.
                target = image_base + (raw & ((1 << 36) - 1))
                off(target)
                return target

        def methods(va):
            if not va:
                return []
            p = off(va)
            flags, count = struct.unpack_from("<II", data, p)
            stride = flags & 0xFFFF
            relative = bool(flags & 0x80000000)
            direct = bool(flags & 0x40000000)
            result = []
            for i in range(count):
                q = p + 8 + stride * i
                entry_va = va + 8 + stride * i
                if relative:
                    selector = entry_va + i32(q)
                    if not direct:
                        selector = ptr(off(selector))
                    types = entry_va + 4 + i32(q + 4)
                    imp = entry_va + 8 + i32(q + 8)
                else:
                    selector, types, imp = struct.unpack_from("<QQQ", data, q)
                result.append({"selector": string(selector), "types": string(types), "imp": hex(imp)})
            return result

        classes = []
        ivar_locations = {}
        for name, addr, length, offset in sections:
            if name != "__objc_classlist":
                continue
            for p in range(offset, offset + length, 8):
                cls = ptr(p)
                ro = ptr(off(cls) + 32) & ~7
                ro_offset = off(ro)
                class_name = string(ptr(ro_offset + 24))
                if class_name not in names:
                    continue
                entries = methods(ptr(ro_offset + 32))
                ivar_va = ptr(ro_offset + 48)
                ivars = []
                if ivar_va:
                    ivar_off = off(ivar_va)
                    stride, count = struct.unpack_from("<II", data, ivar_off)
                    for i in range(count):
                        q = ivar_off + 8 + stride * i
                        location, name_va, types = [ptr(q + k) for k in (0, 8, 16)]
                        ivars.append({"name": string(name_va), "type": string(types), "offset": u32(off(location))})
                        ivar_locations[location] = class_name + "." + string(name_va)
                classes.append({"name": class_name, "address": hex(cls), "methods": entries, "ivars": ivars})
        if annotate_directory:
            selector_ranges = [(addr, addr + length) for name, addr, length, _ in sections if name == "__objc_selrefs"]
            cfstring_ranges = [(addr, addr + length) for name, addr, length, _ in sections if name == "__cfstring"]
            for source in pathlib.Path(annotate_directory).glob("*.asm"):
                if source.stem.endswith("-annotated"):
                    continue
                registers = {}
                lines = []
                for line in source.read_text().splitlines():
                    pieces = line.split("\t")
                    if len(pieces) < 3:
                        lines.append(line)
                        continue
                    op = pieces[-2].strip()
                    operands = pieces[-1]
                    adrp = re.fullmatch(r"(x\d+), (0x[0-9a-f]+).*", operands) if op == "adrp" else None
                    add = re.fullmatch(r"(x\d+), (x\d+), #(0x[0-9a-f]+).*", operands) if op == "add" else None
                    load = re.fullmatch(r"([xwd]\d+), \[(x\d+)(?:, #(0x[0-9a-f]+))?\].*", operands) if op in ["ldr", "ldrsw"] else None
                    destination = re.match(r"([xw]\d+),", operands)
                    if adrp:
                        registers[adrp[1]] = int(adrp[2], 16)
                    elif add and add[2] in registers:
                        registers[add[1]] = registers[add[2]] + int(add[3], 16)
                        address = registers[add[1]]
                        if any(a <= address < b for a, b in cfstring_ranges):
                            try:
                                line += " ; CFString: " + string(ptr(off(address) + 16))
                            except (ValueError, struct.error):
                                pass
                    else:
                        if load and load[2] in registers:
                            address = registers[load[2]] + int(load[3] or "0", 16)
                            try:
                                if any(a <= address < b for a, b in selector_ranges):
                                    line += " ; selector: " + string(ptr(off(address)))
                                elif address in ivar_locations:
                                    line += " ; ivar: " + ivar_locations[address] + " offset=" + str(u32(off(address)))
                                elif load[1].startswith("d"):
                                    line += " ; constant double=" + str(struct.unpack_from("<d", data, off(address))[0])
                            except (ValueError, struct.error):
                                pass
                        if destination:
                            registers.pop("x" + destination[1][1:], None)
                    lines.append(line)
                source.with_name(source.stem + "-annotated.asm").write_text("\n".join(lines) + "\n")
        return {"path": path, "sha256": hashlib.sha256(data).hexdigest(), "classes": classes}


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("path")
    parser.add_argument("classes", nargs="+")
    parser.add_argument("--annotate-directory")
    args = parser.parse_args()
    print(json.dumps(inspect(args.path, set(args.classes), args.annotate_directory), ensure_ascii=False, indent=2))
