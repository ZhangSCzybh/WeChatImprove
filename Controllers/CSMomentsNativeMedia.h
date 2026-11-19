#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Native media views use WeChat's existing cache and download subscriptions.
/// Creation and sizing run on the main thread; unavailable contracts return nil/zero.
FOUNDATION_EXPORT UIView * _Nullable CSMomentsCreateCoverView(id _Nullable dataItem, id _Nullable mediaItem);
/// Size initializes both the native imageSize and the view frame.
FOUNDATION_EXPORT UIView * _Nullable CSMomentsCreateAvatarView(NSString * _Nullable username, CGSize size);
FOUNDATION_EXPORT CGSize CSMomentsNativeMediaSize(id _Nullable mediaItem);

/// Read-only observations after native completion / full-screen display.
/// Display accepts verified native viewer state and its current image. The old
/// scroll path carries WCMediaImageViewModel_WCMediaItem; the full-screen
/// container path carries its original WCMediaItem. Deferred checks revalidate
/// the current native state, visibility and session before recording a view.
/// Only media actually displayed in this account session can be promoted;
/// earlier app sessions require opening the native viewer again.
FOUNDATION_EXPORT void CSMomentsNativeMediaDidDownload(id _Nullable mediaItem);
/// Main-thread observation of a path returned by WeChat's own getter. Quality
/// is its native tier (4 UHD / 3 HD / 2 data); unknown or unviewed media is ignored.
/// The card never calls those getters to initialize or discover native paths.
FOUNDATION_EXPORT void CSMomentsNativeMediaDidResolveLocalPath(id _Nullable mediaItem,
    NSUInteger quality, NSString * _Nullable path);
FOUNDATION_EXPORT void CSMomentsNativeMediaDidDisplay(UIView * _Nullable nativeView,
    id _Nullable viewModelOrMedia, UIImage * _Nullable image);
/// Suspend local decoding while inactive; resume only registered, viewed covers.
FOUNDATION_EXPORT void CSMomentsNativeMediaSetActive(BOOL active);
/// Account/epoch boundary: forget registrations, images and pending work.
FOUNDATION_EXPORT void CSMomentsResetCachedMedia(void);

/// End this card's native download observation before removing or reusing its cover.
FOUNDATION_EXPORT void CSMomentsReleaseCoverView(UIView * _Nullable view);

NS_ASSUME_NONNULL_END
