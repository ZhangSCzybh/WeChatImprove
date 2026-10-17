### Spec Compliance

- ✅ Spec compliant for the task-scoped source correction reviewed over d88dfcdb..f94d7cb3. No blocking omission or unsolicited behavior was found. Type42 admission and independent builders are covered at Controllers/CSMessageActionCoordinator.m:131 and Hooks/RepeatHooks.xm:80; text resolves the native owning delegate at Controllers/CSMessageSendAdapter.m:63; normal handoffs retain Unknown while avoiding the misleading popup at Controllers/CSMessageActionCoordinator.m:231 and :250; voice readiness/download handling and scoped native success suppression are implemented at Controllers/CSMessageMediaProvider.m:83, :100, :147, :189 and Hooks/VoiceForwardHooks.xm:21.
- ⚠️ This is not post-fix device acceptance. The exact installed image, runtime menu class/model population, actual audio contents, recipient playback, and success-UI timing cannot be certified by static 8.0.78.34 evidence or host doubles. The user's reported version is 8.0.78. These limits are explicit in docs/evidence/message-actions-1.8-2/fix-report.md:7 and :65.
- ⚠️ The native helper duration units are evidenced, but the universal applicability of the 20 ms agreement threshold is a conservative product assumption, not a recovered native acceptance rule. The latest implementation applies it even when declared byte length matches (Controllers/CSMessageMediaProvider.m:100). This can visibly refuse otherwise usable audio if its metadata differs more; it does not authorize destructive download or replay. The assumption and unperformed real-codec/device acceptance are disclosed at docs/evidence/message-actions-1.8-2/native-voice-report.md:44 and fix-report.md:65.

### Strengths

- Controllers/CSMessageActionMenuAdapter.m:79 assigns positive, distinct numeric IDs while scanning existing items for collisions. This addresses the actual native numeric dedup contract without bypassing restricted menus or disturbing host-item order. Tests/MessageActionExecutionTests.m:386 reproduces the dedup/filter pipeline using extracted production hooks and a weak menu target.
- Controllers/CSMessageSendAdapter.m:63 gates m_delegate resolution on native page and logic ancestry and retains exact selector/ABI validation and conversation restriction. Tests/MessageActionExecutionTests.m:251 exercises a page that has no synthetic sender route, Unicode payloads, wrong delegates, and normal-return versus exception feedback.
- Controllers/CSMessageMediaProvider.m:83 handles completion/play bits and outgoing finalization separately; :100 validates immutable bytes off-main; :147 prevents repair downloads on completed/outgoing sources; :189 validates the persisted candidate's source identity without replacing the captured context. Terminal callbacks do not bypass length/duration checks.
- Hooks/VoiceForwardHooks.xm:21 suppresses both native success branches only through the bound enhancement marker. Controllers/CSMessageActionCoordinator.m:281 and Controllers/CSVoiceForwardAdapter.m:53 preserve that marker through cleanup and clear closed bindings on unrelated reuse. Tests/MessageActionExecutionTests.m:474 checks pre/post-cleanup getters, unbound logic, and reuse.
- Controllers/CSMessageSendAdapter.m:92 sets nativeHandoffReturned only after the concrete uploader returns, preserving ambiguous insertion/exception outcomes and avoiding any invented delivery acknowledgment.

### Issues

#### Critical (Must Fix)

- None found.

#### Important (Should Fix)

- None found. No concrete source-review blocker.

#### Minor (Nice to Have)

- Tests/MessageActionExecutionTests.m:501 and :523: the new codec fixture only implements format0, and the declared-length cases do not isolate a matching byte length with a mismatching measured duration. Existing tests reject a wrong length, invalid format, or incomplete bytes; they would not specifically catch reintroducing a declared-length shortcut around the new duration check. Add a focused case with length700/data700 and a source duration more than20 ms from the helper's1000 ms result, plus threshold boundary cases. Small SILK/OPUS helper doubles with valid and invalid headers would exercise the new normalization branches; label those as branch tests, never real-codec validation. This is coverage hardening, not evidence of a demonstrated production defect.

### Assessment

**Task quality:** Approved

**Reasoning:** The changes follow the demonstrated native menu, receiver, status, and success-UI contracts and preserve conservative source/account/target ownership. Approval covers the source correction; the documented runtime and real-codec assumptions remain acceptance limits, and do not establish phone delivery/playability.

**Review checks:** Read the supplied task diff, brief, requirements, implementation report, retained native reports/manifests and mutation results; recovered a tool-truncated test hunk from the same supplied diff. No changed source file was reread, no source/git/service/package mutation was performed, and no test suite was rerun. Named unchanged-code integration checks were (1) card source resolution through inherited viewModel.messageWrap, checked in Controllers/CSMessageActionContext.m:59; (2) scalar/menu-ID conversion and trusted service-proxy dispatch, checked in Controllers/CSMessageNativeActionAdapter.m:108 and :133; (3) native duration units and format0 arithmetic, checked in docs/evidence/message-actions-native-2026-10-17/ordinary-repeat-contracts.md:92. Reported final host/syntax runs are identified by docs/evidence/message-actions-1.8-2/host-validation-reported.json:1; it expressly contains implementer-reported transcript references, not retained raw stdout/stderr. The corrected initial missing-framework-path invocation is disclosed, and no final test-output warning was reported.
