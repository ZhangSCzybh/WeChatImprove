# Search input privacy and explicit submission, WeChat 8.0.78

This is bounded, static-only evidence for the 1.8-45 search change. The target is the same arm64 WeChat 8.0.78 executable used by the previous releases. `manifest.json` retains its SHA-256, method addresses, and file hashes. No target process was executed, no real query was submitted, and no user password is included here. `extract.py` and `disassemble.py` reproduce the 33 retained method reads with a read-only mmap and address-bounded `llvm-objdump` calls; no REA session lifecycle was changed.

## Observed entry points

| Class and selector | Normalized ABI | Observation |
| --- | --- | --- |
| `FTSHomeViewController.mmInputBoxTextChanged:text:` | `v@:@@` | Large-input change callback. For confirmed input, trims the query, updates table visibility, and invokes the presenter. Its marked-text branch can log the incoming text; gate before the original if the input must remain private. |
| `FTSHomeViewController.onTextFieldChanged:` | `v@:@` | Legacy callback reads `markedTextRange` and `text`, then calls `mmInputBoxTextChanged:text:`. |
| `FTSHomeViewController.mmInputBoxSearchButtonClick` | `v@:` | Marks non-keyboard submission, then calls `shouldReturnStartSearch`. |
| `FTSHomeViewController.mmInputBoxKeyBoardClick` | `v@:` | Marks keyboard submission, then calls `shouldReturnStartSearch`. |
| `FTSHomeViewController.textFieldShouldReturn:` | `B@:@` | Legacy Return entry; marks keyboard submission, calls `shouldReturnStartSearch`, returns YES. |
| `FTSHomeViewController.shouldReturnStartSearch` | `v@:` | Common submission entry for all three paths above; resigns the input, calls `presenter.onClickSearchButton`, and resets flags. |
| `FTSHomeViewController.doSearch` | `v@:` | Reads `searchBarText` and calls `presenter.doSearch:`. |
| `FTSVoiceSearchBarController.doSearch:` | `v@:@` | Clears cached newest text, cancels existing FTS, then calls `handleTextDidChange:`. This forces a repeated submitted query to be processed. |
| `FTSVoiceSearchBarController.handleTextDidChange:fromNewVoice:` | `v@:@B` | Inserts the input prefix into the intention controller, updates the newest global query, resets data, and schedules both local and Pardus searches. This is the key boundary before prefix use. |
| `FTSVoiceSearchBarController.delaySearchImp:` | `v@:@` | Requires the scheduled query to equal the currently visible `searchBarText`; then reloads and calls `doFTSSearch:`. Logs current query before that comparison. |
| `FTSVoiceSearchBarController.delayPardusSearchImp:` | `v@:@` | Compares current text with the scheduled query, builds suggestion context, and invokes `asyncPardusSearchRequest:`. |
| `FTSVoiceSearchBarController.recordLocalSearchHistory:` | `v@:@` | Sends the provided text to `searchIntentionController.addLocalSearchHistoryFor:`. |

`doWebSearchWithQuery:` occurs in the repository's older header, but is absent from this class's retained 8.0.78 method metadata. Do not rely on that selector as the modern submission boundary. The confirmed replacement is `shouldReturnStartSearch` with the fallback entries above.

## Why hiding results alone is insufficient

`handleTextDidChange:fromNewVoice:` calls `insertSearchTextInputWithPrefix:` before scheduling either local matching or network suggestions. Preventing the final table cells from rendering does not prevent the prefix reaching those pipelines. `cancelFTSSearch` cancels local FTS and clears cached text, but does not cancel both scheduled presenter performs; pending performs must also be canceled before they start.

The presenter has `disableRawQuerySug` (`B@:`) and `setDisableRawQuerySug:` (`v@:B`) stored as a Boolean. This inventory does not establish that it disables every suggestion/matching path. It is not evidence of a complete privacy switch. `fakeSugResultModel` itself reads visible `searchBarText` into suggestion word/docId fields, so no-network operation is not sufficient evidence that no prefix can be displayed.

## Native UI reset without destroying text

`FTSHomeViewController.updateViewHideStates:` takes a Boolean meaning *empty input*. With YES it marks `isSearchBarHasText` false and hides `listAdapter.tableView`; it also updates native guide/check-box state. It does not clear the editor. This is suitable for a held-input state provided the normal nonempty state is restored before a submitted query is processed.

`objectsForListAdapter:` (`@@:@`) calls `presenter.searchResultList`, stores the returned array as `sectionData`, then calls `updateFooterView`. During held input, returning an empty array and retaining empty `sectionData` prevents late data notifications from restoring suggestion rows. Guard `updateFooterView` (`v@:`) as well as `setLoadingStatus` (`v@:`) while held: the footer method reads and logs the visible query and can create a loading indicator even after local cancellation. Clear the existing footer and reload the list after entering that state.

The previous release's empty-input reset remains useful: reset with a safe empty query, then cancel. Do not forward a held prefix to the original presenter handler. Do not call `inputBoxClear` during ordinary editing because it deletes the input; reserve that operation for a fully matched password.

## Submission implications

`onClickSearchButton` is not a universal replacement for a suppressed incremental search. In large-input mode it reads visible text and calls `directJumpToResultPage:isFromNewVoiceInput:`. With the legacy input and no built-up results, it can only log the click. To populate native homepage results after withholding incremental queries, explicitly call native `presenter.doSearch:` for the submitted ordinary query. Whether to additionally preserve the native full-result navigation is a product decision; the ordinary native submission path must run once, not be invoked at each nested callback.

The two delayed callbacks run after the synchronous Return stack has unwound. A thread-local bypass alone cannot authorize them. Tie allowance to the current account, page, submitted query and edit generation, and revoke it immediately on the next edit. This lets submitted ordinary searches complete while stale prefix callbacks remain blocked. Do not pass a full matched password through these submission or history paths.

## Large input, paste, clear, and IME

- `WCSearchBar.inputBoxSetTextOnly:` uses `bar.textView.textView` to `unmarkText`, then writes the wrapper's text. Thus the large editor is a wrapper around a real text view. Check `bar.textView.textView.markedTextRange` in addition to legacy and wrapper properties before attempting password consumption. Repeatedly clearing/restoring the text with this API would end composition, so it is unsuitable for hiding results during typing.
- `inputBoxGetText` supports large-input confirmed text and legacy marked-text handling. Read the visible input only for a deliberate submission, and preserve typed/pasted contents while withholding suggestions.
- `onGetTextInput:isFromVoice:` (`v@:@B`) and `onGetTextInputFromNewVoice:voiceId:` (`v@:@@`) both write through `inputBoxSetText:`. Both log their input at the beginning of the original implementation. Any secret-recognition guard must run before those originals; a retained ordinary query can be written with an explicitly chosen non-query update path.
- Native clear dispatches an empty-input change callback. Allow the empty reset under an explicit reentrancy guard; do not authorize a nonempty callback merely because an outer callback is executing.

## Evidence limits

The keyboard/search-button convergence, data reset, delayed dispatch, history write, native suggestion model, and input-wrapper facts above are observations of the retained instructions. The held-input policy and account/generation authorization are implementation recommendations, not claims of existing native behavior. Runtime behavior on the device, including keyboard composition and native submit navigation, still requires installation acceptance. No complete prefix comparison is derivable from the existing PBKDF2 verifier; an all-input hold until explicit ordinary submission avoids adding weaker prefix verifiers or retaining a plaintext password.
