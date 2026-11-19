#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Main-thread adapter for an ordinary, non-ad Moments video. Unsupported native
/// contracts return nil so the caller can retain its static cover fallback.
FOUNDATION_EXPORT UIView * _Nullable CSMomentsCreateVideoCoverView(id _Nullable dataItem, id _Nullable mediaItem);

/// Finds only this module's owned cover, allowing a card to keep its public API.
FOUNDATION_EXPORT UIView * _Nullable CSMomentsVideoCoverViewInView(UIView * _Nullable container);

/// Pure main-thread decision through the current account's WCFacade network and
/// mobile-data setting, plus the native unfinished-composition exclusion.
FOUNDATION_EXPORT BOOL CSMomentsNativeVideoCanAutoPlay(id _Nullable facade, id _Nullable dataItem);

/// Always uses native silent autoplay. Nil, foreign, released and off-main-thread
/// calls return NO. The runtime owns visibility and application-active checks.
FOUNDATION_EXPORT BOOL CSMomentsSetVideoCoverPlaying(UIView * _Nullable cover, BOOL playing);

/// Stops and releases only this module's native owner/player; safe to repeat.
FOUNDATION_EXPORT void CSMomentsReleaseVideoCoverView(UIView * _Nullable cover);

NS_ASSUME_NONNULL_END
