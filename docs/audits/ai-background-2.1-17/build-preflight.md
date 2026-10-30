# 2.1-17 build preflight

Prepared from the completed 2.1-16 build and package-verification scripts. Preparation did not run `make`, package verification, an installer, or any process using a WeChat account/database. No version files, README, or production AI source files were changed by this task.

After implementation, testing, version updates, and source freeze, run from the existing checkout:

```sh
python3 docs/audits/ai-background-2.1-17/build-packages.py
python3 docs/audits/ai-background-2.1-17/verify-packages.py
```

The build script requires all three existing version locations to say `2.1-17`. It creates fresh temporary output directories for rootless and rootful, builds them in parallel, writes new packages to `packages/2.1-17-ai-background`, checks production input hashes before/after, and compares every preexisting file under the checkout's `.theos` and `packages` trees. An existing nonempty delivery directory stops the build before it changes build outputs.

The verifier requires a successful preserved-input build and additionally checks current production inputs against its recorded hashes. It checks package metadata, arm64/arm64e payloads, iOS 15 minimums, source filter plist, staging/package equality, retained feature symbols, absence of the removed silence bridge, and matching dSYM UUIDs. It produces the symbols ZIP and SHA256SUMS. The ZIP is built as a temporary sibling and published without overwriting an existing delivery, after validation and its CRC check; a failed validation removes the draft ZIP.

Do not invoke `make clean`: the repository's clean target removes the checkout's entire `.theos` and `packages` directories. The prepared scripts never invoke it. Do not change production inputs between build and verification. If a build fails, preserve/rename its audit logs and output first; the scripts intentionally refuse to overwrite a nonempty delivery directory or an existing symbols archive. Temporary build directories are retained for inspection and dSYM verification.

The retained-symbol list carries forward the 2.1-16 checks and includes the final 2.1-17 observer installation/request entry points and observer/context Objective-C classes. Preparation validation consisted of Python AST parsing and review; no build was started during preparation. The completed build and package results are recorded separately in `build-result.json` and `package-verification.json`.
