#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import "CSCloseFriendPolicy.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CSMomentsContentKind) {
    CSMomentsContentText,
    CSMomentsContentPhotos,
    CSMomentsContentVideo,
    CSMomentsContentFinder,
    CSMomentsContentArticle,
    CSMomentsContentOtherShare,
    CSMomentsContentFinderLive,
    CSMomentsContentMiniApp
};

/// Presentation metadata only. Native models and their interaction arrays stay unchanged.
@interface CSMomentsCardModel : NSObject
@property(nonatomic, strong) id item;
@property(nonatomic, strong, nullable) id media;
@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *nickname;
/// Native published location label; empty when absent or not valid for display.
@property(nonatomic, copy) NSString *locationText;
@property(nonatomic) CSMomentsContentKind contentKind;
/// Share metadata row; a mini app uses its shared page title here and its app name in title.
@property(nonatomic, copy) NSString *sourceText;
@property(nonatomic, copy) NSString *shareCoverURL;
@property(nonatomic) CGSize coverSize;
/// Native createtime in Unix seconds; zero denotes an absent or invalid value.
@property(nonatomic) NSTimeInterval timestamp;
@property(nonatomic) NSUInteger mediaCount, likes, comments, epoch, revision;
@property(nonatomic) BOOL video, liked;
@end

#ifdef __cplusplus
extern "C" {
#endif
FOUNDATION_EXPORT NSArray<CSMomentsCardModel *> *CSMomentsBuildCards(NSArray *source,
    CSCloseFriendSnapshot *snapshot, NSUInteger epoch, BOOL filterAds,
    id _Nullable (^read)(id object, NSString *key), CGSize (^mediaSize)(id media));
FOUNDATION_EXPORT CSMomentsContentKind CSMomentsClassifyContent(id item,
    id _Nullable (^read)(id object, NSString *key));
#ifdef __cplusplus
}
#endif

NS_ASSUME_NONNULL_END
