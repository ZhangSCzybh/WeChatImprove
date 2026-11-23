#import "CSMomentsCardModel.h"
#import "CSCloseFriendSocialProjection.h"
#include <math.h>

@implementation CSMomentsCardModel
@end

static NSString *Text(id value) {
    if (![value isKindOfClass:NSString.class]) return @"";
    return [value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

static NSString *MiniAppName(id value) {
    NSString *name = Text(value);
    return [name isEqualToString:@"小程序名称"] ? @"" : name;
}

static NSURLComponents *WebLink(id value) {
    NSString *text = Text(value);
    NSURLComponents *url = text.length ? [NSURLComponents componentsWithString:text] : nil;
    NSString *scheme = url.scheme.lowercaseString;
    return url.host.length && ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) ? url : nil;
}

static BOOL Flag(id value) {
    return [value isKindOfClass:NSNumber.class] && isfinite([value doubleValue]) && [value boolValue];
}

static NSTimeInterval Timestamp(id value) {
    if (![value isKindOfClass:NSNumber.class]) return 0;
    NSTimeInterval timestamp = [value doubleValue];
    return isfinite(timestamp) && timestamp >= 0 ? timestamp : 0;
}

static NSUInteger Count(id value, NSArray *fallback) {
    if ([value isKindOfClass:NSNumber.class]) {
        double number = [value doubleValue];
        if (isfinite(number) && number >= 0 && number < (double)NSUIntegerMax)
            return (NSUInteger)number;
    }
    return fallback.count;
}

static NSString *LocationText(id item, id (^read)(id, NSString *)) {
    // 8.0.80.34: WCActionAreaVM gates both label styles with isValidForShow;
    // WCTimeLineCellView -initLocationLabel sends getDisplayCity (0x10a4d4af0).
    // Keep the exact native string, including its whitespace. No field fallback.
    id location = read(item, @"locationInfo");
    if (!location || location == NSNull.null) return @"";
    if (!Flag(read(location, @"isValidForShow"))) return @"";
    id label = read(location, @"getDisplayCity");
    return [label isKindOfClass:NSString.class] ? label : @"";
}

static BOOL HasSharedFields(id share, NSArray<NSString *> *keys, id (^read)(id, NSString *)) {
    if (!share || share == NSNull.null) return NO;
    for (NSString *key in keys) if (Text(read(share, key)).length) return YES;
    return NO;
}

static BOOL HasLiveShare(id share, id (^read)(id, NSString *)) {
    return HasSharedFields(share, @[@"finderLiveID", @"finderObjectID", @"finderUsername", @"coverUrl", @"desc", @"nickname"], read);
}

static BOOL HasThemeLiveShare(id share, id (^read)(id, NSString *)) {
    return HasSharedFields(share, @[@"imgUrl", @"mainTitle", @"subTitle"], read);
}

static NSString *ExplicitMiniAppCover(id info, id (^read)(id, NSString *)) {
    NSString *cover = Text(read(info, @"cover"));
    NSURLComponents *url = cover.length ? [NSURLComponents componentsWithString:cover] : nil;
    NSString *scheme = url.scheme.lowercaseString;
    if (!url.host.length || (![scheme isEqualToString:@"https"] && ![scheme isEqualToString:@"http"])) return @"";
    id rawWidth = read(info, @"width"), rawHeight = read(info, @"height");
    if ((rawWidth && ![rawWidth isKindOfClass:NSNumber.class]) ||
        (rawHeight && ![rawHeight isKindOfClass:NSNumber.class])) return @"";
    double width = [rawWidth doubleValue], height = [rawHeight doubleValue];
    if (!isfinite(width) || !isfinite(height) || width < 0 || height < 0) return @"";
    // Zero is the native default for unpublished dimensions. If dimensions are
    // published, require enough pixels for a card rather than an app icon.
    if ((width > 0 || height > 0) && (fmin(width, height) < 180 || fmax(width, height) < 320)) return @"";
    return cover;
}

CSMomentsContentKind CSMomentsClassifyContent(id item, id (^read)(id, NSString *)) {
    if (!item || !read) return CSMomentsContentText;
    id content = read(item, @"contentObj");
    id rawType = read(content, @"type");
    NSInteger type = [rawType isKindOfClass:NSNumber.class] ? [rawType integerValue] : -1;
    // Live uses its own flat share payload and native template, not Finder's
    // mediaList or the ordinary WCMediaItem photo/video template.
    if (type == 34 || type == 45 || HasLiveShare(read(content, @"finderLiveShareItem"), read) ||
        HasThemeLiveShare(read(content, @"finderThemeLiveShareItem"), read)) return CSMomentsContentFinderLive;
    // A placeholder weappInfo also exists on ordinary shares. Only a published
    // app identity selects MiniApp before the ordinary article/photo dispatch.
    if (Text(read(read(item, @"weappInfo"), @"appUserName")).length) return CSMomentsContentMiniApp;
    // WCTimeLineCellView's verified native template dispatch, 8.0.80.34.
    switch (type) {
        case 28: case 36: case 50: case 59: return CSMomentsContentFinder;
        case 3: return CSMomentsContentArticle;
        case 15: return CSMomentsContentVideo;
        case 1: case 7: case 54: return CSMomentsContentPhotos;
        case 2: return CSMomentsContentText;
        default: break;
    }
    if (Flag(read(item, @"isVideo")) || Flag(read(content, @"isVideoType"))) return CSMomentsContentVideo;
    id media = read(content, @"mediaList");
    if (Flag(read(content, @"isPhotoType")) || ([media isKindOfClass:NSArray.class] && [media count]))
        return CSMomentsContentPhotos;
    if (Text(read(content, @"linkUrl")).length) return CSMomentsContentOtherShare;
    return CSMomentsContentText;
}

static void ProjectSharedContent(CSMomentsCardModel *card, id content, id (^read)(id, NSString *)) {
    card.sourceText = @"";
    card.shareCoverURL = @"";
    if (card.contentKind == CSMomentsContentFinderLive) {
        card.media = nil;
        card.mediaCount = 0;
        card.video = NO;
        card.coverSize = CGSizeMake(1, 1);
        id share = read(content, @"finderLiveShareItem");
        id theme = read(content, @"finderThemeLiveShareItem");
        BOOL themed = !HasLiveShare(share, read) && HasThemeLiveShare(theme, read);
        if (themed) share = theme;
        NSString *title = Text(read(share, themed ? @"mainTitle" : @"desc"));
        if (title.length) card.title = title;
        card.sourceText = Text(read(share, themed ? @"subTitle" : @"nickname"));
        card.shareCoverURL = Text(read(share, themed ? @"imgUrl" : @"coverUrl"));
    } else if (card.contentKind == CSMomentsContentMiniApp) {
        card.video = NO;
        card.mediaCount = card.media ? 1 : 0;
        NSString *title = Text(read(content, @"title"));
        card.sourceText = title.length ? title : card.title;
        NSString *source = MiniAppName(read(card.item, @"sourceNickName"));
        if (!source.length) source = MiniAppName(read(read(card.item, @"appInfo"), @"appName"));
        // The application identity occupies the main title; its shared page
        // title belongs to the information row beside/below the thumbnail.
        // The runtime can replace this fallback with the current local contact.
        card.title = source.length ? source : @"小程序";
        // Keep WCMediaItem on the native thumbnail path. Full-width display
        // requires an explicit published cover, never a guessed thumbnail URL.
        id info = read(content, @"appMsgShareInfo");
        card.shareCoverURL = ExplicitMiniAppCover(info, read);
        if (card.shareCoverURL.length) {
            double width = [read(info, @"width") doubleValue], height = [read(info, @"height") doubleValue];
            card.coverSize = width > 0 && height > 0 ? CGSizeMake(width, height) : CGSizeMake(1, 0.65);
        }
    } else if (card.contentKind == CSMomentsContentFinder) {
        // Finder owns its share media. Do not briefly construct an ordinary
        // WCMedia video/photo cover from content.mediaList before replacing it.
        card.media = nil;
        card.mediaCount = 0;
        // WCContentItemFinderViewModel -getShareItem: uses this exact chain.
        id share = read(content, @"finderShareToMomentsItem");
        if (!share || share == NSNull.null) share = read(read(content, @"finderLongVideoShareItem"), @"converToShareFeedItem");
        NSString *title = Text(read(share, @"desc"));
        if (title.length) card.title = title;
        card.sourceText = Text(read(share, @"nickname"));
        id feedType = read(share, @"feedType");
        // Native VM stores feedType.intValue; isVideoFeed compares it with 4.
        card.video = ([feedType isKindOfClass:NSString.class] || [feedType isKindOfClass:NSNumber.class]) && [feedType intValue] == 4;
        id list = read(share, @"mediaList");
        id first = [list isKindOfClass:NSArray.class] ? [list firstObject] : nil;
        card.shareCoverURL = Text(read(first, @"coverUrl"));
        if (!card.shareCoverURL.length) card.shareCoverURL = Text(read(first, @"thumbUrl"));
        card.coverSize = CGSizeMake(1, 1);
    } else if (card.contentKind == CSMomentsContentArticle) {
        NSString *title = Text(read(content, @"title"));
        if (title.length) card.title = title;
        card.sourceText = Text(read(card.item, @"sourceNickName"));
        NSString *host = WebLink(read(content, @"linkUrl")).host ?: @"";
        if (!card.sourceText.length) card.sourceText = host;
        if (!card.title.length) card.title = host.length ? host : @"网页链接";
        // Declared native field, used only if the native WCMediaItem cover is
        // unavailable. Its priority in native News layout is not established.
        NSString *cover = Text(read(read(content, @"appMsgShareInfo"), @"cover"));
        card.shareCoverURL = WebLink(cover) ? cover : @"";
        card.coverSize = CGSizeMake(1, 0.65);
        card.video = NO;
    }
}

NSArray<CSMomentsCardModel *> *CSMomentsBuildCards(NSArray *source, CSCloseFriendSnapshot *snapshot,
    NSUInteger epoch, BOOL filterAds, id (^read)(id, NSString *), CGSize (^mediaSize)(id)) {
    if (![source isKindOfClass:NSArray.class] || !snapshot || snapshot.blocked || !read) return @[];
    // Keep nil/placeholder reads away from the caller's native dispatch boundary.
    id (^safeRead)(id, NSString *) = ^id(id object, NSString *key) {
        return object && object != NSNull.null ? read(object, key) : nil;
    };
    NSMutableArray<CSMomentsCardModel *> *cards = [NSMutableArray arrayWithCapacity:source.count];
    for (id item in source) {
        if (!item || item == NSNull.null ||
            Flag(safeRead(item, @"isNewDataSeparator")) ||
            Flag(safeRead(item, @"isEarlierContentTipsItem")) ||
            CSCloseFriendSocialObjectHidden(item, snapshot, CSCloseFriendSurfaceTimeline, safeRead) ||
            (filterAds && Flag(safeRead(item, @"isAd")))) continue;

        id content = safeRead(item, @"contentObj");
        NSString *username = Text(safeRead(item, @"username"));
        if (!username.length) username = Text(safeRead(content, @"username"));
        if ([snapshot hidesUserName:username surface:CSCloseFriendSurfaceTimeline]) continue;
        NSString *nickname = Text(safeRead(item, @"nickname"));
        if (!nickname.length) nickname = Text(safeRead(content, @"nickname"));
        if (!nickname.length) nickname = username.length ? username : @"微信用户";

        NSString *title = Text(safeRead(item, @"contentDesc"));
        if (!title.length) title = Text(safeRead(content, @"title"));
        if (!title.length) title = Text(safeRead(content, @"desc"));
        NSString *identifier = Text(safeRead(item, @"itemID"));
        if (!identifier.length) identifier = Text(safeRead(item, @"tid"));

        id rawMedia = safeRead(content, @"mediaList");
        NSArray *media = [rawMedia isKindOfClass:NSArray.class] ? rawMedia : nil;
        id cover = media.firstObject;
        if (cover == NSNull.null) cover = nil;
        CGSize size = cover && mediaSize ? mediaSize(cover) : CGSizeZero;
        if (!isfinite(size.width) || !isfinite(size.height) || size.width <= 0 || size.height <= 0)
            size = CGSizeZero;

        id rawLikes = safeRead(item, @"likeUsers");
        id rawComments = safeRead(item, @"commentUsers");
        NSArray *likes = [rawLikes isKindOfClass:NSArray.class] ? rawLikes : nil;
        NSArray *comments = [rawComments isKindOfClass:NSArray.class] ? rawComments : nil;
        CSMomentsCardModel *card = [CSMomentsCardModel new];
        card.item = item;
        card.media = cover;
        card.identifier = identifier;
        card.title = title;
        card.username = username;
        card.nickname = nickname;
        card.locationText = LocationText(item, safeRead);
        card.coverSize = size;
        card.timestamp = Timestamp(safeRead(item, @"createtime"));
        card.mediaCount = media.count;
        card.contentKind = CSMomentsClassifyContent(item, safeRead);
        card.video = card.contentKind == CSMomentsContentVideo;
        ProjectSharedContent(card, content, safeRead);
        card.liked = Flag(safeRead(item, @"likeFlag")) || Flag(safeRead(item, @"isLikeForMe"));
        card.epoch = epoch;
        card.revision = snapshot.revision;
        if ([snapshot concealsSurface:CSCloseFriendSurfaceInteraction]) {
            card.likes = [[CSCloseFriendSocialProjection alloc] initWithSource:likes snapshot:snapshot
                surface:CSCloseFriendSurfaceInteraction read:safeRead].visible.count;
            card.comments = [[CSCloseFriendSocialProjection alloc] initWithSource:comments snapshot:snapshot
                surface:CSCloseFriendSurfaceInteraction read:safeRead].visible.count;
        } else {
            card.likes = Count(safeRead(item, @"likeCount"), likes);
            card.comments = Count(safeRead(item, @"commentCount"), comments);
        }
        [cards addObject:card];
    }
    return [cards copy];
}
