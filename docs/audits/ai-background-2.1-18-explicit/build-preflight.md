# 2.1-18 explicit background build preparation

Prepared from the completed 2.1-17 scripts. No build or package verification was run, and no production or test file was modified during preparation.

After implementation, regression checks, version updates and source freeze, run from the established checkout:

```sh
python3 docs/audits/ai-background-2.1-18-explicit/build-packages.py
python3 docs/audits/ai-background-2.1-18-explicit/verify-packages.py
```

The delivery directory is `packages/2.1-18-ai-background-explicit`. Both package schemes build in separate fresh temporary directories. A nonempty delivery directory stops the build. The scripts do not invoke `make clean`, installation or Git staging; preexisting `.theos` and `packages` files are recorded and checked by SHA-256. The symbol archive is validated before exclusive publication and never overwrites an existing archive.

The warning cap is **6 for each scheme**, matching both recorded 2.1-17 results. Each scheme result records the count, cap, baseline version and pass/fail flag. The aggregate result records warning-cap success and causes a nonzero exit if either scheme exceeds the cap, even when both compilers exit successfully. Package verification independently requires both schemes and rechecks the cap.

Retained-symbol checks, arm64/arm64e verification, iOS 15 minimums, filter plist equality, staged/package payload hashes, rootless/rootful installation paths, dSYM UUID matching, symbols ZIP CRC checks, current input hashes and SHA256SUMS generation are retained from 2.1-17. Any new explicit-status symbols can be added after their production names are frozen.

Preparation validation used AST parsing and structural comparisons against 2.1-17 for retained symbols, source and historical-artifact hashing, UUID/plist validation and exclusive archive publication. Neither script's `main` function was executed.
