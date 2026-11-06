#!/usr/bin/env python3
"""Generate synthetic CMS fixtures and run the unchanged Objective-C parser.

The temporary signing key is synthetic and removed when this script exits.
No installed app, user profile, service, or database is accessed.
"""
from pathlib import Path
import hashlib
import json
import platform
import plistlib
import subprocess
import tempfile
from datetime import datetime

ROOT = Path(__file__).resolve().parent


def run(*args):
    return subprocess.run(args, check=True, text=True, capture_output=True).stdout


with tempfile.TemporaryDirectory(prefix="wechat-signature-legacy-") as scratch:
    scratch = Path(scratch)
    key, cert = scratch / "synthetic-key.pem", scratch / "synthetic-cert.pem"
    run("openssl", "req", "-x509", "-newkey", "rsa:2048", "-nodes",
        "-keyout", str(key), "-out", str(cert), "-days", "1",
        "-subj", "/CN=Synthetic Account Signature Regression Fixture")

    fixtures = []
    for label, team in [("ascii", "Synthetic Test Team"), ("utf8", "合成测试签名团队")]:
        profile = {
            "Name": "Synthetic fixture only",
            "UUID": "00000000-0000-0000-0000-000000000001",
            "TeamName": team,
            "TeamIdentifier": ["SYNTHETIC1"],
            "CreationDate": datetime(2026, 1, 1),
            "ExpirationDate": datetime(2027, 1, 1),
            "ProvisionedDevices": ["0000000000000000000000000000000000000001"],
            "Entitlements": {
                "application-identifier": "SYNTHETIC1.invalid.synthetic.signature-fixture",
                "com.apple.developer.team-identifier": "SYNTHETIC1",
                "get-task-allow": True,
            },
        }
        xml = ROOT / f"{label}.plist"
        xml.write_bytes(plistlib.dumps(profile, fmt=plistlib.FMT_XML, sort_keys=False))
        cms = ROOT / f"{label}.mobileprovision"
        run("openssl", "cms", "-sign", "-binary", "-nodetach", "-in", str(xml),
            "-signer", str(cert), "-inkey", str(key), "-outform", "DER", "-out", str(cms))
        recovered = scratch / f"{label}-verified.plist"
        run("openssl", "cms", "-verify", "-noverify", "-inform", "DER", "-in", str(cms),
            "-out", str(recovered))
        assert recovered.read_bytes() == xml.read_bytes()
        assert plistlib.loads(recovered.read_bytes())["TeamName"] == team
        fixtures.extend([xml, cms])

    # A CMS envelope accepts arbitrary payloads, so this establishes a parser
    # boundary without implying that Apple issues binary-plist profiles.
    binary_xml = ROOT / "utf8-binary.plist"
    binary_xml.write_bytes(plistlib.dumps(profile, fmt=plistlib.FMT_BINARY, sort_keys=False))
    binary_cms = ROOT / "utf8-binary.mobileprovision"
    run("openssl", "cms", "-sign", "-binary", "-nodetach", "-in", str(binary_xml),
        "-signer", str(cert), "-inkey", str(key), "-outform", "DER", "-out", str(binary_cms))
    binary_recovered = scratch / "binary-verified.plist"
    run("openssl", "cms", "-verify", "-noverify", "-inform", "DER", "-in", str(binary_cms),
        "-out", str(binary_recovered))
    assert binary_recovered.read_bytes() == binary_xml.read_bytes()
    fixtures.extend([binary_xml, binary_cms])

    # A 1024-byte eContent has a zero octet in its DER length field before XML.
    # This supplies a valid CMS test of embedded NUL preceding <plist.
    padded_xml = ROOT / "ascii-1024.plist"
    ascii_xml = (ROOT / "ascii.plist").read_bytes()
    padded_xml.write_bytes(ascii_xml + b" " * (1024 - len(ascii_xml)))
    nul_cms = ROOT / "nul-header.mobileprovision"
    run("openssl", "cms", "-sign", "-binary", "-nodetach", "-in", str(padded_xml),
        "-signer", str(cert), "-inkey", str(key), "-outform", "DER", "-out", str(nul_cms))
    padded_recovered = scratch / "padded-verified.plist"
    run("openssl", "cms", "-verify", "-noverify", "-inform", "DER", "-in", str(nul_cms),
        "-out", str(padded_recovered))
    assert padded_recovered.read_bytes() == padded_xml.read_bytes()
    fixtures.extend([padded_xml, nul_cms])

    # Prefix bytes include NUL and every possible high byte. This is deliberately
    # not CMS and records NSString/NSScanner behavior independently of OpenSSL.
    all_bytes = ROOT / "all-byte-prefix-with-xml.bin"
    all_bytes.write_bytes(bytes(range(256)) + (ROOT / "ascii.plist").read_bytes())
    fixtures.append(all_bytes)

    ascii_der = (ROOT / "ascii.mobileprovision").read_bytes()
    xml_close = ascii_der.index(b"</plist>")
    for label, body in [
        ("truncated-mid-xml.mobileprovision", ascii_der[:ascii_der.index(b"<key>ExpirationDate</key>") + 10]),
        ("truncated-before-xml-close.mobileprovision", ascii_der[:xml_close]),
        ("truncated-after-xml-close.mobileprovision", ascii_der[:xml_close + len(b"</plist>")]),
    ]:
        path = ROOT / label
        path.write_bytes(body)
        verify = subprocess.run(
            ["openssl", "cms", "-verify", "-noverify", "-inform", "DER", "-in", str(path)],
            capture_output=True)
        assert verify.returncode != 0
        fixtures.append(path)

    executable = scratch / "legacy-reproduction"
    run("clang", "-fobjc-arc", "-framework", "Foundation", "-Wno-deprecated-declarations",
        str(ROOT / "LegacyProfileReproduction.m"), "-o", str(executable))
    output = run(str(executable), *(str(path) for path in fixtures), str(ROOT / "absent.mobileprovision"))
    rows = {row["fixture"]: row for row in
            (json.loads(line) for line in output.splitlines() if line.startswith("{"))}
    for extension in ("plist", "mobileprovision"):
        assert rows[f"ascii.{extension}"]["legacyTeamName"] == "Synthetic Test Team"
        assert rows[f"utf8.{extension}"]["legacyDictionaryCreated"]
        assert rows[f"utf8.{extension}"]["legacyTeamName"] != "合成测试签名团队"
        assert rows[f"utf8.{extension}"]["legacyTeamIdentifier"] == ["SYNTHETIC1"]
    assert not rows["absent.mobileprovision"]["legacyDictionaryCreated"]
    assert rows["all-byte-prefix-with-xml.bin"]["legacyDictionaryCreated"]
    assert rows["all-byte-prefix-with-xml.bin"]["nulBytesBeforeXMLPlist"] == 1
    assert rows["all-byte-prefix-with-xml.bin"]["nonASCIIBytesBeforeXMLPlist"] == 128
    assert rows["nul-header.mobileprovision"]["nulBytesBeforeXMLPlist"] > 0
    assert rows["nul-header.mobileprovision"]["legacyDictionaryCreated"]
    assert not rows["utf8-binary.plist"]["legacyDictionaryCreated"]
    assert not rows["utf8-binary.mobileprovision"]["legacyDictionaryCreated"]
    assert not rows["truncated-mid-xml.mobileprovision"]["legacyDictionaryCreated"]
    assert rows["truncated-before-xml-close.mobileprovision"]["legacyDictionaryCreated"]
    assert rows["truncated-after-xml-close.mobileprovision"]["legacyDictionaryCreated"]
    (ROOT / "results.txt").write_text(
        f"Host: {platform.platform()}\nOpenSSL: {run('openssl', 'version').strip()}\n"
        "CMS verification: all 4 recovered payloads exactly match source XML/binary plist; synthetic signer, chain trust ignored.\n"
        "All 3 deliberately truncated CMS files fail OpenSSL CMS verification.\n"
        "Assertions: ASCII succeeds; UTF-8 team is corrupted while team ID survives; NUL/high-byte prefix is scanned; binary plist is unsupported; mid-XML truncation fails; missing XML closing plist tag is repaired; complete XML with missing CMS trailer is still parsed; absent profile returns no dictionary. PASS\n"
        + output, encoding="utf-8")
    manifest = {path.name: hashlib.sha256(path.read_bytes()).hexdigest() for path in fixtures}
    (ROOT / "SHA256SUMS.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    print((ROOT / "results.txt").read_text(encoding="utf-8"))
