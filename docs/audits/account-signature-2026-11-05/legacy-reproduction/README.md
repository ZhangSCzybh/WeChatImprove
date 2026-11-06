# Legacy account-signature parser reproduction

This directory records the behavior of the existing Objective-C parser before
the account-signature repair. All names, team IDs, device IDs, app IDs and signing
material are synthetic. The script never accesses an installed app or user data.
Its temporary self-signed private key is removed after fixture creation.

Run from the repository root:

```sh
python3 docs/audits/account-signature-2026-11-05/legacy-reproduction/reproduce.py
```

Requirements: macOS Foundation, `clang`, Python 3 and OpenSSL with `cms`.
The script creates four real DER CMS SignedData envelopes using
`openssl cms -sign -binary -nodetach`. It verifies each signature with
`openssl cms -verify -noverify` and checks that the extracted content exactly
matches its XML source. `-noverify` skips chain trust for the synthetic signer;
it does not skip the CMS content signature check.

`LegacyProfileReproduction.m` copies the old parser's NSString/NSScanner/plist
operations unchanged. Its caller supplies fixture NSData in place of reading
`NSBundle.mainBundle.bundlePath/embedded.mobileprovision`. Missing data is guarded
before parsing, matching the original implementation. JSON output records whether
the file, ASCII NSString and parsed dictionary exist, plus the actual team value.

## Observed behavior

The captured run is in `results.txt`; `SHA256SUMS.json` identifies its fixture
bytes. On macOS 27.0 (26A428) Objective-C Foundation:

| Input | Old parser result |
| --- | --- |
| Plain ASCII XML plist | Correct dictionary and team name |
| Actual DER CMS with ASCII XML payload | Correct dictionary and team name |
| Plain UTF-8 XML with `合成测试签名团队` | Dictionary exists, team name becomes mojibake |
| Actual DER CMS with the same UTF-8 XML payload | Dictionary exists, team name becomes mojibake |
| Valid DER CMS with NUL before `<plist>` in a length field | Correct dictionary; embedded NUL does not stop scanning |
| Prefix containing every byte 0...255 followed by XML (deliberately not CMS) | Correct dictionary; NUL and 128 high bytes do not stop scanning |
| Plain binary plist and valid CMS containing binary plist | No dictionary; the legacy parser only searches for XML |
| CMS truncated in the middle of XML | No dictionary |
| CMS truncated immediately before `</plist>` | Dictionary exists: the old code appends the missing closing tag |
| CMS truncated immediately after `</plist>` | Dictionary exists despite incomplete/invalid CMS |
| Missing `embedded.mobileprovision` | No dictionary, leading to all seven legacy missing-value rows |

The old NSString ASCII conversion does **not** return nil for these DER fixtures.
It decodes the byte values in a way that corrupts the embedded UTF-8 text before
the parser encodes that corrupted text back to UTF-8. A Swift
`String(data:encoding:.ascii)` probe returns nil for high bytes on this host, but
that is not the behavior of the Objective-C implementation and must not be used
as evidence that every CMS file causes every field to disappear.

These tests establish a real Unicode decoding defect and the missing-file
behavior. They do not establish which installed host/build changed the user's
all-fields symptom. No real device provisioning profile was available to this
investigation. Behavior on the user's actual iOS/Foundation version still needs
device confirmation.

All three deliberately truncated envelopes fail OpenSSL CMS verification. The old
parser accepts two of them because it never validates the CMS envelope or the
signature. A replacement that only extracts complete XML also does not validate
CMS or certificate trust. Passing profile data to a metadata parser must not be
described as a successful code-signature or certificate validity check.

## Offline SDK evidence and format boundary

The locally installed iPhoneOS 27.2 SDK documents the following in Foundation:

- `NSString.h:86–87`: `NSASCIIStringEncoding` is "Strict 7-bit ASCII encoding
  within 8-bit chars; ASCII values 0…127 only."
- `NSString.h:984–990`: `initWithData:encoding:` expects bytes in the specified
  encoding and its default plain-text format; initialization can return nil.
- `NSScanner.h:200–212`: `scanUpToString:intoString:` scans an NSString, reports
  whether it consumed characters, and scans to end if no terminator is found.
  It does not document NUL-terminated C-string behavior.

SDK base path:
`/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS27.2.sdk/System/Library/Frameworks/Foundation.framework/Headers/`.
These declarations show that supplying an entire binary CMS envelope to an ASCII
text decoder uses the wrong input encoding. They do not prove that any particular
iOS version became stricter, or that this explains the user's all-fields symptom.
No such version-change evidence was available in the local SDK or repository.

The normal provisioning-profile representation is CMS SignedData containing an
XML property list. CMS itself can encapsulate arbitrary octets, including binary
plist data; the binary fixture proves that generic capability only. No Apple
issued profile in binary-plist format was available here, so this fixture must
not be cited as evidence that a WeChat or iOS release changed provisioning
profiles to binary plist. Both the old scanner and a replacement that searches
only for `<plist` / `</plist>` will return no dictionary for that binary fixture.

## History and environment boundary

`Controllers/CSAccountDetailViewController.m` was introduced by commit
`96d3f5d3` (`v1.5.3`, 2026-04-27). The tracked production file at baseline HEAD
`25081b45` (`2.2-11`) is identical to that initial file:

```sh
git diff 96d3f5d3 25081b45 -- Controllers/CSAccountDetailViewController.m
```

The working checkout's preexisting `2.2-12` changes also did not modify that file
when this investigation began. There is no account-parser source revision here
that establishes a later plugin-version regression boundary. The existing code
only reads the host app bundle's `embedded.mobileprovision`; it does not read
entitlements, the code signature, a certificate API, or plugin package metadata.
The investigated Hooks contain no bundle-path hook or provisioning-file removal.

The repository builds a Theos `.deb`, injected into the user's installed WeChat.
An App Store host or some other install/signing arrangements may have no embedded
provisioning profile. The plugin cannot recover missing profile-only values such
as provisioning creation/expiration dates or an allowed-device list from that
file when it is absent. Team ID may be available separately in actual signing
entitlements, but that does not supply the other profile fields and does not prove
an App Store distribution type. A no-profile path must retain truthful missing
values instead of fabricating a team, certificate type, dates or device list.

The legacy UDID row takes `ProvisionedDevices.firstObject`. In a profile with
multiple devices this is not evidence of the current device's UDID.
