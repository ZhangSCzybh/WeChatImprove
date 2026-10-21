# Search-password cleanup, WeChat 8.0.78

Static evidence uses the same arm64 binary as 1.8-43. Target SHA-256 and retained method/file hashes are in `manifest.json`; `extract.py` and `disassemble.py` reproduce the bounded reads. No WeChat process was executed.

- `FTSHomeViewController.searchTextField` reads `searchBar.textField`, while `searchBarText` reads `inputBoxGetText`. `customSearchBar` enables large input on `WCWebSearchBar`.
- `WCSearchBar.inputBoxClear` selects the real input implementation: large-input `textView` or legacy `textField`. It clears the text and invokes the native empty-input delegate callback. The previous code only cleared `searchTextField`, leaving the visible large editor intact.
- `FTSVoiceSearchBarController.handleTextDidChange:fromNewVoice:` resets its data source first, then for an empty query cancels search. Reversing this order creates a fresh unfinished data source.
- `FTSHomeViewController.reloadList` only reloads/lays out the list. It does not finish the pending search or clear the loading footer. `updateFooterView` can call `setLoadingStatus` when the native data source remains incomplete.

The fix consumes the matched password before native query/history dispatch, cancels pending presenter performs, uses `inputBoxClear`, cancels search after that native clear path, and removes the old footer. A page-local Boolean prevents late loading callbacks until a new nonempty ordinary query; it stores no query/password. Both input implementations retain IME composition checks. The fallback for versions without `inputBoxClear` clears both exposed editors and delivers an empty presenter input before cancellation.

Focused host tests model a visible editor separate from `searchTextField`, a queued delayed search, cancellation/reset ordering, duplicate callback verification, IME composition, and the next ordinary search. Device behavior still needs confirmation after installing 1.8-44.
