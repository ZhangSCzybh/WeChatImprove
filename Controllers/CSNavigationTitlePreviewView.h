#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// A display-only snapshot of the settings editor; it never loads account data.
@interface CSNavigationTitlePreviewConfiguration : NSObject
@property(nonatomic) BOOL enabled, showSelfAvatar, showOtherAvatar, showNickname, showRemarkName;
@property(nonatomic) CGFloat avatarSize, avatarRadius, separatorSize, avatarSpacing, verticalOffset, nicknameSize;
@property(nonatomic) NSInteger nicknamePosition;
@property(nonatomic, copy) NSString *separatorText;
@property(nonatomic, strong, nullable) UIImage *separatorImage;
@end

@interface CSNavigationTitlePreviewView : UIView
- (void)configureWithSettings:(CSNavigationTitlePreviewConfiguration *)settings;
@end

NS_ASSUME_NONNULL_END
