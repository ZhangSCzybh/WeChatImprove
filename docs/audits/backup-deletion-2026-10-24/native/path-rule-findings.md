# WeChat 8.0.78 compiled path-rule evidence

Target: `/tmp/wechat-8.0.78-inset-analysis/WeChat`; SHA-256 recorded by the parent investigation: `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`. Static evidence only; no iPhone execution or observed deletion.

## Complete compiled table reconstruction

`loadPathMatchRulesWithOtherUser:` at `0x10299e608` calls `0x1029a274c` at `0x10299e8f4`. The latter returns table `0x120c7b980` and writes count `0x416` (1046) at `0x1029a2784`. Its constant initialization is the straight-line region `0x1029a27c0` to `0x1029aba7c` (exclusive), in `rules-table-initializer.asm`.

`decode-rules-table.py` symbolically evaluates only those constant loads/stores into a Python byte map; it does not run the executable. It asserts every non-padding byte in all 1046 records was written, and rejects unsupported instructions and writes outside the table. The emitted `compiled-path-rules.json` includes each rule's raw bytes, CFString object address, and instruction that writes its path pointer. `library-path-rules.json` is a convenience subset. Fields were cross-checked against setters in `rules-addPathComponent_withRule_toRootNode_supportModify_.asm` and `rules-p_validateStoreTimeType_.asm`:

- `+0`: int64 bizType (`0x10299f4f0` -> `setM_bizType:`).
- `+8`: int64 pathPrefixType (`0x10299f4c8` -> `setM_pathPrefixType:`).
- `+16`: NSString relative path.
- `+24`: int64 storeTimeType (`0x10299fe78`, validated 1..9).
- `+32`: int32 of unresolved semantics, explicitly labeled `unknownIntAt32`.
- `+36`: int32 wechatFileClass (`0x10299f510` -> `setM_wechatFileClass:`).
- `+40`: int32 fileTypeInUse (`0x10299f500` -> `setM_fileTypeInUse:`).

The NSString format at `0x11e66dc48` is `bizType=%ld, pathPrefixType=%ld, relativePath=%@, storeTimeType=%ld`, corroborating the first four fields. Prefix 1 attaches to the app root (`0x10299ebd8`); prefix 2 attaches under Documents/current-user hash (`0x10299eb10`), prefix 3 under Library/WechatPrivate/current-user hash (`0x10299ebb4`). Counts: 276 / 393 / 377 respectively.

## Library/Application Support has no ancestor rule for this plugin

Exactly three prefix-1 rules begin with `Library/Application Support/`:

| Index | Path | bizType | storeTimeType | wechatFileClass | Path-pointer store |
|---|---|---:|---:|---:|---|
|108|Library/Application Support/DefaultWxaCacheManager.json|100|7|4|0x1029a3cf0|
|252|Library/Application Support/com.apple.watchconnectivity|100|2|4|0x1029a44d4|
|253|Library/Application Support/libCachedImageData.db|27|1|4|0x1029a44f8|

There is no compiled rule at `Library`, `Library/Application Support`, `Library/Application Support/WeChatImprove`, or BackupV2, and no regex child under Application Support that matches WeChatImprove. Prefix-1 root entries include `<reg>.*WeChat.*` (index 2), but it matches only the current path component, so it does not match `Library` and cannot protect WeChatImprove deeper under Library. It is not an ancestor wildcard for this path.

Tree-building assigns business fields only at the final component of each rule (`0x10299f4d8` -> `0x10299f4ec` gates `0x10299f4f0` onward). Therefore the intermediate Library and Application Support tree nodes do not become marked file nodes merely because known descendants exist. `MMBizFileMatchNode.init` initializes bizType=0, storeTimeType=9 and unmarked class/type fields (`rules-node-init.asm`). `isMarkBizFileNode` at `0x10299d500` requires positive bizType and class, and a non-placeholder file type.

`matchBizWithChildFolder:parentFolder:` obtains child `lastPathComponent` at `0x1029a0200` and matches that name against the parent's immediate rule children at `0x1029a0284` / `0x1029a02b4`. Thus WeChatImprove matches none of Application Support's three concrete children. `MMBizFileMatchNode.isMatchWithName:` uses exact string equality for normal nodes (`0x10299d67c`) and full-name regex matching for `<reg>` nodes (`0x10299d6e0` onward). It does not search descendants by a root regex.

On an unmatched child with no inherited marked-folder classification, `matchBizWithChildFolder` writes bizType=2 at `0x1029a0460`, storeTimeType=9 at `0x1029a0474`, fileType=0x7fffffff at `0x1029a0488`, class=1 at `0x1029a049c`. This differs from the separate `fileMatchedBizType:inFolder:` default return struct (the parent investigation observed `{2,9,0x7ffffffe,0}`); do not conflate these two output layouts.

The compiled table does contain a distinct `Library/Preferences` rule (index 112): bizType=33, storeTimeType=1, class=4. That establishes a difference from Application Support, but this report does not claim it proves a new storage destination is immune to every host cleanup mechanism.

## Limits and conditions

This demonstrates that the compiled 8.0.78 path rules do not protect BackupV2 by an ancestor rule, and explains how its subtree reaches unknown classification absent a runtime rule patch or other inherited marked-folder override. The initializer has a hot-patch function pointer branch (`0x1029a2750` / `0x1029a2758`), and `patchAppendBizRule:` exists. A device can therefore differ from this static table; no device runtime overrides were inspected.

Classification alone is not observed deletion. The scan/delete gates, age thresholds, scan root, runtime switches, and actual device log must be combined with the parent's deletion-chain evidence. Nothing here establishes that the user's actual binary is this exact sample or that its settings permitted deletion at 8 AM.
