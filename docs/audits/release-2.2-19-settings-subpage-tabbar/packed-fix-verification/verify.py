#!/usr/bin/env python3
"""Read-only verification of actual release objects and UUID-bound final code."""
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import zipfile

OUT = Path(__file__).resolve().parent
AUDIT = OUT.parent
ROOT = AUDIT.parents[2]
DELIVERY = ROOT / 'packages/2.2-19-settings-subpage-tabbar'
METHODS = {
    'CSSettingsTableViewController': ['CSSettingsTableViewController'],
    'CSAIReplySettingsViewController': ['CSAIConnectionEditor', 'CSAIPresetEditor'],
    'CSScheduledTaskSettingsViewController': ['CSScheduledTaskTextEditor', 'CSScheduledTaskTimeEditor'],
}
commands = []


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def run(command, output=None):
    result = subprocess.run(command, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    commands.append({'command': command, 'exit_code': result.returncode, 'output': output})
    if output:
        (OUT / output).write_text(result.stdout)
    assert result.returncode == 0, (command, result.stdout)
    return result.stdout


def uuid(path):
    return re.findall(r'UUID: ([A-Fa-f0-9-]+)', run(['xcrun', 'dwarfdump', '--uuid', str(path)]))


def slices(path):
    data = Path(path).read_bytes()
    magic, count = struct.unpack_from('>II', data)
    assert magic == 0xcafebabe, 'Expected standard big-endian FAT header'
    result = {}
    for i in range(count):
        cpu, subtype, offset, size, align = struct.unpack_from('>IIIII', data, 8 + 20 * i)
        assert cpu == 0x100000c and (subtype & 0xffffff) in (0, 2)
        key = 'arm64e' if subtype & 0xffffff == 2 else 'arm64'
        result[key] = hashlib.sha256(data[offset:offset + size]).hexdigest()
    return result


def object_method(text, method):
    label = '-[' + method + ' hidesBottomBarWhenPushed]:'
    assert text.count(label) == 1, (method, 'missing or duplicate object method')
    after = text.split(label, 1)[1]
    rows = []
    for line in after.splitlines():
        if re.match(r'^\s*[0-9a-f]+:\s', line):
            rows.append(line)
        elif rows:
            break
    return label + '\n' + '\n'.join(rows) + '\n', rows


def verify_instructions(rows):
    # All five getters are leaf functions: exact BOOL YES, then return.
    assert len(rows) == 2, rows
    assert re.search(r'\bmov\s+w0, #0x1\b', rows[0]), rows
    assert re.search(r'\bret\s*$', rows[1]), rows


def main():
    build_file = AUDIT / 'delivery-build/build-result.json'
    build = json.loads(build_file.read_text())
    inputs = json.loads((AUDIT / 'delivery-build/effective-inputs.json').read_text())['files']
    snapshot = Path(build['frozen_source'])
    assert build['version'] == '2.2-19' and len(build['verified_packages']) == 2
    assert build['inputs_unchanged'] and build['historical_packages_preserved']
    sources = {}
    for source in METHODS:
        rel = 'Controllers/' + source + '.m'
        paths = [ROOT / rel, snapshot / rel,
                 AUDIT / 'tabbar-navigation-validation/green-2.2-19/production' / rel]
        values = [sha(p) for p in paths]
        assert len(set(values + [inputs[rel]])) == 1, (rel, values)
        sources[rel] = {'sha256': values[0], 'current_build_green_snapshots_equal': True}
    symbols_zip = DELIVERY / 'com.wechat.improve_2.2-19_symbols.zip'
    checks = []
    with zipfile.ZipFile(symbols_zip) as archive:
        for package in build['verified_packages']:
            scheme = package['scheme']
            target = snapshot.parent / scheme
            arch = package['Architecture']
            deb = DELIVERY / f'com.wechat.improve_2.2-19_{arch}.deb'
            assert sha(deb) == package['sha256']
            prefix = 'var/jb/' if scheme == 'rootless' else ''
            fat = target / ('verified/' + prefix + 'Library/MobileSubstrate/DynamicLibraries/WeChatImprove.dylib')
            assert sha(fat) == package['dylib_sha256']
            fat_slice_hashes = slices(fat)
            if scheme == 'rootful':
                assert sha(DELIVERY / 'WeChatImprove.dylib') == sha(fat)
            for cpu in package['architectures']:
                thin = target / ('verified-' + cpu + '.dylib')
                assert sha(thin) == fat_slice_hashes[cpu]
                dsym = target / '.theos/obj' / cpu / 'WeChatImprove.dylib.dSYM'
                dwarf = dsym / 'Contents/Resources/DWARF/WeChatImprove.dylib'
                expected_uuid = package['dsym_uuids'][cpu]
                assert uuid(thin) == [expected_uuid] and uuid(dsym) == [expected_uuid]
                zipped = scheme + '/' + cpu + '/WeChatImprove.dylib.dSYM/Contents/Resources/DWARF/WeChatImprove.dylib'
                assert hashlib.sha256(archive.read(zipped)).hexdigest() == sha(dwarf)
                nm = run(['xcrun', 'nm', '-n', str(dwarf)], scheme + '-' + cpu + '-dsym-nm.txt')
                for source, classes in METHODS.items():
                    obj = package['compiled_objects'][cpu][source]
                    assert sha(obj['path']) == obj['sha256']
                    assembly = run(['xcrun', 'llvm-objdump', '--macho', '--disassemble',
                                    '--no-show-raw-insn', '--symbolize-operands', obj['path']])
                    for cls in classes:
                        tag = scheme + '-' + cpu + '-' + cls
                        excerpt, rows = object_method(assembly, cls)
                        verify_instructions(rows)
                        (OUT / (tag + '-object.asm')).write_text(excerpt)
                        symbol = '-[' + cls + ' hidesBottomBarWhenPushed]'
                        matches = re.findall(r'^([0-9a-f]+)\s+[tT]\s+' + re.escape(symbol) + '$', nm, re.M)
                        assert len(matches) == 1, (tag, matches)
                        address = int(matches[0], 16)
                        final = run(['xcrun', 'llvm-objdump', '--disassemble', '--no-show-raw-insn',
                                     '--start-address=' + hex(address), '--stop-address=' + hex(address + 8),
                                     str(thin)], tag + '-final.asm')
                        final_rows = re.findall(r'^\s*[0-9a-f]+:\s+.*$', final, re.M)
                        # Objdump adds an explanatory comment after mov; only the
                        # instruction itself and exact two-address window matter.
                        verify_instructions([line.split(';', 1)[0].rstrip() for line in final_rows])
                        checks.append({'scheme': scheme, 'architecture': cpu, 'method': symbol,
                                       'source': 'Controllers/' + source + '.m',
                                       'source_sha256': sources['Controllers/' + source + '.m']['sha256'],
                                       'object': obj['path'], 'object_sha256': obj['sha256'],
                                       'object_assembly': tag + '-object.asm',
                                       'object_assembly_sha256': sha(OUT / (tag + '-object.asm')),
                                       'final_imp_from_uuid_bound_dsym': hex(address),
                                       'final_code': tag + '-final.asm',
                                       'final_code_sha256': sha(OUT / (tag + '-final.asm')),
                                       'final_thin_sha256': sha(thin),
                                       'final_thin_matches_packaged_fat_slice': True,
                                       'linked_fat_sha256': sha(fat), 'deb_sha256': sha(deb),
                                       'dsym_uuid': expected_uuid, 'dsym_dwarf_sha256': sha(dwarf),
                                       'symbols_zip_entry_byte_match': True,
                                       'returns_BOOL_YES_in_object_and_final': True})
    assert len(checks) == 20
    result = {'passed': True, 'verified_getters': 5, 'schemes': 2, 'architectures': 2,
              'method_checks': 20, 'sources': sources, 'checks': checks,
              'build_result_sha256': sha(build_file), 'symbols_zip_sha256': sha(symbols_zip),
              'delivery_dylib_sha256': sha(DELIVERY / 'WeChatImprove.dylib'),
              'scope': 'Actual compiled objects plus exact code windows in final packaged dylib slices; final method addresses resolved using UUID-matched dSYM method symbols. No selector-string-only claim.',
              'limitations': 'Static packaged-code evidence. Objective-C runtime dispatch, native navigation, live MMTabBar properties and device visual behavior remain unverified.'}
    (OUT / 'commands.json').write_text(json.dumps(commands, ensure_ascii=False, indent=2) + '\n')
    (OUT / 'result.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({k: v for k, v in result.items() if k not in ('sources', 'checks')}, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
