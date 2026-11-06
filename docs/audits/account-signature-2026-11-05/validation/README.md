# Account signature metadata validation

Run from the repository root on macOS with Xcode Command Line Tools, Python 3,
and OpenSSL with CMS support:

```sh
python3 docs/audits/account-signature-2026-11-05/validation/run-validation.py
```

The captured run on macOS 27.0 (26A428) passed **43 checks with zero failures**.
`validation.log` records commands, CMS verification, compiler output, and every
check. `result.json` records machine-readable checks and the actual generated
signature rows/error messages. `manifest.json` identifies the production sources,
extracted methods, test program, baseline, and every reused fixture by SHA-256.

The runner compiles the actual `Controllers/CSProvisioningProfile.m` alongside
`ProfileValidation.m`; the helper is not duplicated or translated. Its expected
dictionary is read directly from the sibling `legacy-reproduction` source plist.
Before running, OpenSSL verifies each of that directory's three existing DER CMS
SignedData fixtures and byte-compares the recovered payload with its source
XML/binary plist. No signing material is generated here. `-noverify` skips
certificate chain trust for the synthetic signer while still checking the CMS
content signature.

The test includes the sibling's unchanged baseline parser and renames only its
CLI `main`. This demonstrates the old parser's actual Objective-C behavior on
this host: ASCII CMS succeeds; a Chinese UTF-8 team name becomes mojibake while
the team ID survives. The repaired helper preserves the entire ASCII and UTF-8
dictionaries, with explicit checks for team, team ID, creation/expiration dates,
device list, and entitlements. **This establishes a Unicode defect; it does not
establish that the user's missing seven fields have that same cause.**

Boundary checks cover nil, empty/no-plist bytes, a missing closing XML marker,
a closing marker before the opening marker, a valid array root, and unbalanced
XML. The malformed input is also passed directly to Foundation: the captured
run returns nil with error 3840. This test does not assume all superficially
invalid XML is rejected by `NSPropertyListSerialization`. Wrapping the real
UTF-8 CMS in every byte from 0 through 255 on both sides leaves its dictionary
unchanged. Existing binary-prefix and truncated-profile fixtures are reused.

For controller integration, the runner extracts the production constants and
five complete methods verbatim into `ControllerMethods.inc` immediately before
compilation: profile-type classification, bundle reading, device identifier,
`setupData`, and the footer delegate. Minimal Foundation models retain the row
titles/details; the color stubs provide no behavior. The executable first checks
that `NSBundle.mainBundle.bundlePath` is its own temporary directory. Only that
directory receives synthetic `embedded.mobileprovision` bytes. This exercises
the actual bundle path, file-read errors, parser call, and row creation together.

The controller checks verify seven expected signature fields, three existing
sections, the existing account/application row counts, no footer on success,
separate missing-file/parse/read explanations only in the signature section,
truthful missing values, and clearing a prior explanation on recovery. A directory
at the temporary file path exercises a real non-file read error without changing
filesystem permissions. NSNumber/NSArray guards are also exercised.

The evidence has these limits:

- The source fixtures, names, team/device IDs, and dates are synthetic. No actual
  profile from the user's re-signed WeChat 8.0.78 was available to these tests.
- Foundation is macOS Foundation. No iOS device, live WeChat process, UIKit layout,
  real signing/entitlements, or full injected plugin lifecycle is tested here.
- The UI explicitly labels the first provisioned device as `授权设备 UDID`.
  This test verifies that label and the unchanged first-device value. The first
  authorized device is still not guaranteed to be the current phone when the
  profile lists several devices.
- The helper extracts a complete XML plist span; it does not parse ASN.1, verify
  CMS integrity/trust, or establish signing identity. A complete XML span in a
  truncated CMS trailer still parses, explicitly checked as an extraction boundary.
- A CMS payload encoded as a binary plist returns nil. That synthetic boundary
  fixture demonstrates an unsupported encoding; it is not evidence that Apple's
  real profiles or the user's re-signer produce that encoding.
- Metadata that is absent from the installed bundle cannot be recovered by this
  helper. Passing these tests does not confirm the user's installed environment
  has changed or that all-fields loss has been resolved on their device.
- No root `Tests` files were restored or edited. No installed app, user data,
  database, shared service, or device was accessed or restarted.
