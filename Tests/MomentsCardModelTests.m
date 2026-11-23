#import <Foundation/Foundation.h>
#import "CSMomentsCardModel.h"
#include <math.h>

static NSUInteger Assertions, Reads;
#define CHECK(condition) do { Assertions++; if (!(condition)) { NSLog(@"Moments model FAIL %d: %s", __LINE__, #condition); exit(1); } } while (0)

// Native models may have expensive or unsafe equality/hash implementations.
// Building a presentation must retain their identity without invoking either.
@interface CSMomentsNativeFixture : NSObject
@property(nonatomic, strong) NSDictionary *values;
@end
@implementation CSMomentsNativeFixture
- (NSUInteger)hash { @throw [NSException exceptionWithName:@"NativeHash" reason:nil userInfo:nil]; }
- (BOOL)isEqual:(id)object {
    (void)object;
    @throw [NSException exceptionWithName:@"NativeEquality" reason:nil userInfo:nil];
}
@end

static id Read(id object, NSString *key) {
    Reads++;
    if ([object isKindOfClass:NSDictionary.class]) return object[key];
    if ([object isKindOfClass:CSMomentsNativeFixture.class]) return [object values][key];
    return nil;
}

static CGSize MediaSize(id media) {
    return CGSizeMake([Read(media, @"width") doubleValue], [Read(media, @"height") doubleValue]);
}

static CSCloseFriendSnapshot *Snapshot(BOOL enabled, BOOL revealed, BOOL blocked, NSDictionary *options) {
    NSDictionary *profile = @{@"enabled":@(enabled), @"friends":@[@"secret"], @"groups":@[], @"options":options ?: @{}};
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:@"current-user" profile:profile
        revealed:revealed revision:17 blocked:blocked];
}

static NSArray<CSMomentsCardModel *> *Build(NSArray *source, CSCloseFriendSnapshot *snapshot, BOOL ads) {
    return CSMomentsBuildCards(source, snapshot, 23, ads,
        ^id(id object, NSString *key) { return Read(object, key); },
        ^CGSize(id media) { return MediaSize(media); });
}

static void TestSharedContent(CSCloseFriendSnapshot *snapshot) {
    CHECK(CSMomentsContentText == 0 && CSMomentsContentPhotos == 1 && CSMomentsContentVideo == 2);
    CHECK(CSMomentsContentFinder == 3 && CSMomentsContentArticle == 4 && CSMomentsContentOtherShare == 5);
    CHECK(CSMomentsContentFinderLive == 6 && CSMomentsContentMiniApp == 7);
    NSDictionary *thumb = @{@"width":@120, @"height":@90, @"thumbUrl":@"https://cdn.example/thumb"};
    NSDictionary *second = @{@"width":@900, @"height":@1200};
    NSMutableArray *media = [@[thumb, second] mutableCopy];
    NSMutableDictionary *live = [@{@"finderLiveID":@"live-id", @"coverUrl":@" https://cdn.example/live ",
        @"bareCoverUrl":@"https://cdn.example/bare", @"desc":@"  直播标题 ", @"nickname":@" 主播 "} mutableCopy];
    NSMutableDictionary *content = [@{@"type":@34, @"finderLiveShareItem":live,
        @"mediaList":media, @"isVideoType":@YES} mutableCopy];
    NSMutableDictionary *post = [@{@"contentObj":content, @"contentDesc":@"朋友圈文案", @"isVideo":@YES,
        @"weappInfo":@{@"appUserName":@"mini-app"}} mutableCopy];
    NSData *original = [NSJSONSerialization dataWithJSONObject:post options:NSJSONWritingSortedKeys error:NULL];
    for (NSNumber *type in @[@34, @45]) {
        content[@"type"] = type;
        CSMomentsCardModel *card = Build(@[post], snapshot, NO)[0];
        CHECK(card.contentKind == CSMomentsContentFinderLive && card.item == post);
        CHECK(card.media == nil && card.mediaCount == 0 && !card.video);
        CHECK(CGSizeEqualToSize(card.coverSize, CGSizeMake(1, 1)));
        CHECK([card.shareCoverURL isEqual:@"https://cdn.example/live"]);
        CHECK([card.title isEqual:@"直播标题"] && [card.sourceText isEqual:@"主播"]);
    }
    content[@"type"] = @34;
    for (NSUInteger pass = 0; pass < 5; pass++) Build(@[post], snapshot, NO);
    CHECK([original isEqual:[NSJSONSerialization dataWithJSONObject:post options:NSJSONWritingSortedKeys error:NULL]]);
    CHECK(post[@"contentObj"] == content && content[@"finderLiveShareItem"] == live);
    CHECK(content[@"mediaList"] == media && media.count == 2 && media[0] == thumb);
    CHECK([live[@"coverUrl"] isEqual:@" https://cdn.example/live "]);
    CSMomentsNativeFixture *native = [CSMomentsNativeFixture new];
    native.values = post;
    CHECK(Build(@[native], snapshot, NO)[0].item == native);
    CHECK([original isEqual:[NSJSONSerialization dataWithJSONObject:post options:NSJSONWritingSortedKeys error:NULL]]);

    // A valid live payload selects live even without a known type. Unknown
    // objects, empty strings and NSNull must not change an ordinary share.
    CSMomentsCardModel *card = Build(@[@{@"contentObj":@{@"type":@3, @"finderLiveShareItem":live}}], snapshot, NO)[0];
    CHECK(card.contentKind == CSMomentsContentFinderLive && [card.shareCoverURL isEqual:@"https://cdn.example/live"]);
    card = Build(@[@{@"contentObj":@{@"finderLiveShareItem":@{@"finderLiveID":@"id"}}}], snapshot, NO)[0];
    CHECK(card.contentKind == CSMomentsContentFinderLive && card.shareCoverURL.length == 0 && !card.video);
    for (id invalid in @[NSNull.null, @42, @[], @"wrong", @{},
        @{@"finderLiveID":NSNull.null, @"coverUrl":@42, @"desc":@[], @"nickname":@" \n"}]) {
        card = Build(@[@{@"contentObj":@{@"type":@3, @"finderLiveShareItem":invalid}}], snapshot, NO)[0];
        CHECK(card.contentKind == CSMomentsContentArticle);
        card = Build(@[@{@"contentDesc":@"保留文案", @"contentObj":@{@"type":@45,
            @"finderLiveShareItem":invalid, @"mediaList":media}}], snapshot, NO)[0];
        CHECK(card.contentKind == CSMomentsContentFinderLive && !card.video && card.media == nil && card.mediaCount == 0);
        CHECK(card.shareCoverURL.length == 0 && card.sourceText.length == 0 && [card.title isEqual:@"保留文案"]);
    }
    card = Build(@[@{@"contentObj":@{@"type":@34}}], snapshot, NO)[0];
    CHECK(card.contentKind == CSMomentsContentFinderLive && card.shareCoverURL.length == 0 && card.media == nil);
    NSDictionary *theme = @{@"mainTitle":@"  主题直播 ", @"subTitle":@" 主题来源 ", @"imgUrl":@" https://cdn.example/theme "};
    card = Build(@[@{@"contentObj":@{@"finderThemeLiveShareItem":theme, @"mediaList":media}}], snapshot, NO)[0];
    CHECK(card.contentKind == CSMomentsContentFinderLive && [card.title isEqual:@"主题直播"]);
    CHECK([card.sourceText isEqual:@"主题来源"] && [card.shareCoverURL isEqual:@"https://cdn.example/theme"]);
    CHECK(!card.video && card.media == nil && card.mediaCount == 0 && CGSizeEqualToSize(card.coverSize, CGSizeMake(1, 1)));
    card = Build(@[@{@"contentObj":@{@"finderThemeLiveShareItem":theme, @"finderLiveShareItem":live}}], snapshot, NO)[0];
    CHECK([card.title isEqual:@"直播标题"] && [card.shareCoverURL isEqual:@"https://cdn.example/live"]);
    for (id invalid in @[NSNull.null, @42, @[], @{}, @{@"imgUrl":@42, @"mainTitle":@[], @"subTitle":@" "}])
        CHECK(Build(@[@{@"contentObj":@{@"type":@2, @"finderThemeLiveShareItem":invalid}}], snapshot, NO)[0].contentKind == CSMomentsContentText);

    NSMutableDictionary *miniContent = [@{@"type":@3, @"title":@"小程序标题", @"mediaList":media,
        @"isVideoType":@YES, @"linkUrl":@"https://example.com/path"} mutableCopy];
    NSMutableDictionary *mini = [@{@"contentObj":miniContent, @"weappInfo":@{@"appUserName":@" app-id "},
        @"contentDesc":@"发布附言", @"sourceNickName":@" 原生来源 ",
        @"appInfo":@{@"appName":@"备用来源"}, @"isVideo":@YES} mutableCopy];
    NSData *miniOriginal = [NSJSONSerialization dataWithJSONObject:mini options:NSJSONWritingSortedKeys error:NULL];
    card = Build(@[mini], snapshot, NO)[0];
    CHECK(card.contentKind == CSMomentsContentMiniApp && card.item == mini && card.media == thumb);
    CHECK(card.mediaCount == 1 && !card.video && card.shareCoverURL.length == 0);
    CHECK(CGSizeEqualToSize(card.coverSize, CGSizeMake(120, 90)));
    CHECK([card.title isEqual:@"原生来源"] && [card.sourceText isEqual:@"小程序标题"]);
    CHECK([miniOriginal isEqual:[NSJSONSerialization dataWithJSONObject:mini options:NSJSONWritingSortedKeys error:NULL]]);
    CHECK(miniContent[@"mediaList"] == media && media.count == 2 && [mini[@"weappInfo"][@"appUserName"] isEqual:@" app-id "]);
    miniContent[@"title"] = @" \n";
    CHECK([Build(@[mini], snapshot, NO)[0].sourceText isEqual:@"发布附言"]);
    miniContent[@"title"] = @42;
    CHECK([Build(@[mini], snapshot, NO)[0].sourceText isEqual:@"发布附言"]);
    miniContent[@"title"] = @"小程序标题";
    miniContent[@"type"] = @1;
    CHECK(Build(@[mini], snapshot, NO)[0].contentKind == CSMomentsContentMiniApp);
    mini[@"sourceNickName"] = @" 小程序名称 \n";
    card = Build(@[mini], snapshot, NO)[0];
    CHECK([card.title isEqual:@"备用来源"] && [card.sourceText isEqual:@"小程序标题"]);
    [mini removeObjectForKey:@"sourceNickName"];
    CHECK([Build(@[mini], snapshot, NO)[0].title isEqual:@"备用来源"]);
    mini[@"appInfo"] = NSNull.null;
    card = Build(@[mini], snapshot, NO)[0];
    CHECK([card.title isEqual:@"小程序"] && [card.sourceText isEqual:@"小程序标题"]);
    for (id invalidName in @[NSNull.null, @42, @[], @" \n", @"小程序名称"]) {
        mini[@"sourceNickName"] = invalidName;
        mini[@"appInfo"] = @{@"appName":invalidName};
        card = Build(@[mini], snapshot, NO)[0];
        CHECK([card.title isEqual:@"小程序"] && [card.sourceText isEqual:@"小程序标题"]);
    }
    miniContent[@"appMsgShareInfo"] = @{@"cover":@" https://cdn.example/explicit-large "};
    card = Build(@[mini], snapshot, NO)[0];
    CHECK([card.shareCoverURL isEqual:@"https://cdn.example/explicit-large"] && card.media == thumb);
    CHECK(CGSizeEqualToSize(card.coverSize, CGSizeMake(1, 0.65)) && card.mediaCount == 1);
    for (id invalidCover in @[NSNull.null, @42, @[], @" \n", @"not a URL", @"file:///tmp/cover", @"//cdn.example/cover"]) {
        miniContent[@"appMsgShareInfo"] = @{@"cover":invalidCover};
        CHECK(Build(@[mini], snapshot, NO)[0].shareCoverURL.length == 0);
    }
    for (NSDictionary *dimensions in @[@{@"width":@64, @"height":@64}, @{@"width":@120, @"height":@90},
        @{@"width":@640, @"height":@0}, @{@"width":@(-1), @"height":@480},
        @{@"width":@(NAN), @"height":@480}, @{@"width":@"640", @"height":@480}]) {
        NSMutableDictionary *info = [dimensions mutableCopy];
        info[@"cover"] = @"https://cdn.example/icon";
        miniContent[@"appMsgShareInfo"] = info;
        card = Build(@[mini], snapshot, NO)[0];
        CHECK(card.shareCoverURL.length == 0);
        CHECK(CGSizeEqualToSize(card.coverSize, CGSizeMake(120, 90)));
    }
    for (NSDictionary *dimensions in @[@{@"width":@0, @"height":@0}, @{@"width":@320, @"height":@180},
        @{@"width":@180, @"height":@320}, @{@"width":@320, @"height":@320}]) {
        NSMutableDictionary *info = [dimensions mutableCopy];
        info[@"cover"] = @"https://cdn.example/explicit-large";
        miniContent[@"appMsgShareInfo"] = info;
        card = Build(@[mini], snapshot, NO)[0];
        CHECK([card.shareCoverURL isEqual:@"https://cdn.example/explicit-large"]);
        CGSize expected = [dimensions[@"width"] doubleValue] > 0
            ? CGSizeMake([dimensions[@"width"] doubleValue], [dimensions[@"height"] doubleValue]) : CGSizeMake(1, 0.65);
        CHECK(CGSizeEqualToSize(card.coverSize, expected));
    }
    miniContent[@"appMsgShareInfo"] = NSNull.null;
    [miniContent removeObjectForKey:@"mediaList"];
    card = Build(@[mini], snapshot, NO)[0];
    CHECK(card.contentKind == CSMomentsContentMiniApp && card.media == nil && card.mediaCount == 0 && !card.video);
    CHECK(card.shareCoverURL.length == 0 && CGSizeEqualToSize(card.coverSize, CGSizeZero));
    miniContent[@"appMsgShareInfo"] = @{@"cover":@"https://cdn.example/cover-without-thumb"};
    CHECK([Build(@[mini], snapshot, NO)[0].shareCoverURL isEqual:@"https://cdn.example/cover-without-thumb"]);
    for (id invalidInfo in @[NSNull.null, @42, @[], @{}, @{@"appUserName":NSNull.null},
        @{@"appUserName":@42}, @{@"appUserName":@[]}, @{@"appUserName":@" \n"}]) {
        card = Build(@[@{@"weappInfo":invalidInfo, @"contentObj":@{@"type":@3}}], snapshot, NO)[0];
        CHECK(card.contentKind == CSMomentsContentArticle);
    }

    // Existing Finder, long-video conversion, Article and ordinary-media
    // projection retain their established payload/URL priorities.
    NSDictionary *feed = @{@"desc":@"视频号标题", @"nickname":@"视频号作者", @"feedType":@"4",
        @"mediaList":@[@{@"coverUrl":@"https://cdn.example/feed", @"thumbUrl":@"https://cdn.example/feed-thumb"}]};
    for (NSNumber *type in @[@28, @36, @50, @59]) {
        card = Build(@[@{@"weappInfo":NSNull.null, @"contentObj":@{@"type":type,
            @"mediaList":media, @"finderShareToMomentsItem":feed}}], snapshot, NO)[0];
        CHECK(card.contentKind == CSMomentsContentFinder && card.media == nil && card.mediaCount == 0 && card.video);
        CHECK([card.title isEqual:@"视频号标题"] && [card.sourceText isEqual:@"视频号作者"]);
        CHECK([card.shareCoverURL isEqual:@"https://cdn.example/feed"] && CGSizeEqualToSize(card.coverSize, CGSizeMake(1, 1)));
    }
    card = Build(@[@{@"contentObj":@{@"type":@36, @"finderShareToMomentsItem":NSNull.null,
        @"finderLongVideoShareItem":@{@"converToShareFeedItem":feed}}}], snapshot, NO)[0];
    CHECK(card.contentKind == CSMomentsContentFinder && card.video && [card.shareCoverURL isEqual:@"https://cdn.example/feed"]);
    NSDictionary *photoFeed = @{@"feedType":@2, @"mediaList":@[@{@"thumbUrl":@"https://cdn.example/finder-photo"}]};
    card = Build(@[@{@"contentObj":@{@"type":@28, @"finderShareToMomentsItem":photoFeed}}], snapshot, NO)[0];
    CHECK(!card.video && [card.shareCoverURL isEqual:@"https://cdn.example/finder-photo"]);
    card = Build(@[@{@"sourceNickName":@"文章来源", @"contentObj":@{@"type":@3, @"title":@"文章标题",
        @"mediaList":media, @"appMsgShareInfo":@{@"cover":@"https://cdn.example/article"}}}], snapshot, NO)[0];
    CHECK(card.contentKind == CSMomentsContentArticle && card.media == thumb && card.mediaCount == 2 && !card.video);
    CHECK([card.title isEqual:@"文章标题"] && [card.sourceText isEqual:@"文章来源"]);
    CHECK([card.shareCoverURL isEqual:@"https://cdn.example/article"] && CGSizeEqualToSize(card.coverSize, CGSizeMake(1, 0.65)));
    NSString *longURL = @"https://h5.aihujing.com/#/video?hjType=1&content_title=%E6%9C%AF%E5%89%8D&token=original";
    NSMutableDictionary *webContent = [@{@"type":@3, @"title":@"探马", @"linkUrl":longURL,
        @"appMsgShareInfo":@{@"cover":@" https://cdn.example/h5-cover "}} mutableCopy];
    NSMutableDictionary *webPost = [@{@"contentObj":webContent} mutableCopy];
    NSData *originalWeb = [NSJSONSerialization dataWithJSONObject:webPost options:NSJSONWritingSortedKeys error:NULL];
    card = Build(@[webPost], snapshot, NO)[0];
    CHECK([card.title isEqual:@"探马"] && [card.sourceText isEqual:@"h5.aihujing.com"]);
    CHECK([card.shareCoverURL isEqual:@"https://cdn.example/h5-cover"]);
    CHECK([originalWeb isEqual:[NSJSONSerialization dataWithJSONObject:webPost options:NSJSONWritingSortedKeys error:NULL]]);
    CHECK([webContent[@"linkUrl"] isEqual:longURL]);
    for (id invalidCover in @[NSNull.null, @42, @[], @" \n", @"http://[", @"not a URL", @"file:///tmp/cover", @"//cdn.example/cover"]) {
        webContent[@"appMsgShareInfo"] = @{@"cover":invalidCover};
        CHECK(Build(@[webPost], snapshot, NO)[0].shareCoverURL.length == 0);
    }
    webContent[@"title"] = @" \n";
    CHECK([Build(@[webPost], snapshot, NO)[0].title isEqual:@"h5.aihujing.com"]);
    webPost[@"contentDesc"] = @"保留发布文案";
    CHECK([Build(@[webPost], snapshot, NO)[0].title isEqual:@"保留发布文案"]);
    webPost[@"sourceNickName"] = @"原始分享来源";
    CHECK([Build(@[webPost], snapshot, NO)[0].sourceText isEqual:@"原始分享来源"]);
    [webPost removeObjectForKey:@"contentDesc"];
    [webPost removeObjectForKey:@"sourceNickName"];
    for (id invalidLink in @[NSNull.null, @42, @[], @" \n", @"http://[", @"file:///tmp/page", @"//h5.example/page"]) {
        webContent[@"linkUrl"] = invalidLink;
        card = Build(@[webPost], snapshot, NO)[0];
        CHECK([card.title isEqual:@"网页链接"] && card.sourceText.length == 0);
    }
    CHECK(Build(@[@{@"contentObj":@{@"type":@15, @"mediaList":media}}], snapshot, NO)[0].contentKind == CSMomentsContentVideo);
    CHECK(Build(@[@{@"contentObj":@{@"type":@1, @"mediaList":media}}], snapshot, NO)[0].contentKind == CSMomentsContentPhotos);
}

int main(void) { @autoreleasepool {
    CSCloseFriendSnapshot *locked = Snapshot(YES, NO, NO, nil);
    CSCloseFriendSnapshot *revealed = Snapshot(YES, YES, NO, nil);
    CSCloseFriendSnapshot *disabled = Snapshot(NO, NO, NO, nil);
    CSCloseFriendSnapshot *blocked = Snapshot(YES, NO, YES, nil);
    TestSharedContent(locked);
    NSDictionary *ordinaryUser = @{@"username":@"alice"};
    NSDictionary *secretUser = @{@"username":@"secret"};
    NSDictionary *reply = @{@"username":@"bob", @"refUserName":@"secret"};
    NSDictionary *nested = @{@"username":@"carol", @"comment":secretUser};
    NSMutableArray *likes = [@[ordinaryUser, secretUser] mutableCopy];
    NSMutableArray *comments = [@[ordinaryUser, secretUser, reply, nested] mutableCopy];
    NSDictionary *portrait = @{@"width":@600, @"height":@900};
    NSDictionary *landscape = @{@"width":@1200, @"height":@800};
    NSMutableArray *media = [@[portrait, landscape] mutableCopy];
    NSMutableDictionary *content = [@{@"title":@"Shared title", @"desc":@"Shared description", @"mediaList":media} mutableCopy];
    NSMutableDictionary *post = [@{@"username":@"alice", @"nickname":@"Alice", @"itemID":@"native-id",
        @"tid":@"fallback-id", @"contentDesc":@"  Today’s photos\n", @"contentObj":content,
        @"likeCount":@91, @"commentCount":@62, @"likeUsers":likes, @"commentUsers":comments,
        @"isLikeForMe":@YES, @"createtime":@1794976496} mutableCopy];
    NSDictionary *hidden = @{@"username":@"secret", @"itemID":@"hidden"};
    NSDictionary *ad = @{@"username":@"brand", @"isAd":@YES};
    NSDictionary *separator = @{@"isNewDataSeparator":@YES};
    NSDictionary *tips = @{@"isEarlierContentTipsItem":@YES};
    NSMutableArray *source = [@[post, hidden, ad, separator, tips] mutableCopy];

    NSArray<CSMomentsCardModel *> *cards = Build(source, locked, NO);
    CHECK(cards.count == 2 && cards[0].item == post && cards[1].item == ad);
    CSMomentsCardModel *card = cards[0];
    CHECK([card.identifier isEqualToString:@"native-id"]);
    CHECK([card.title isEqualToString:@"Today’s photos"]);
    CHECK([card.username isEqualToString:@"alice"] && [card.nickname isEqualToString:@"Alice"]);
    CHECK(card.media == portrait && card.mediaCount == 2);
    CHECK(card.coverSize.width == 600 && card.coverSize.height == 900);
    CHECK(card.timestamp == 1794976496);
    CHECK([card.locationText isEqualToString:@""]);
    CHECK(card.likes == 1 && card.comments == 1 && card.liked && !card.video);
    CHECK(card.epoch == 23 && card.revision == 17);
    CHECK(Build(@[@{@"likeFlag":@YES}], locked, NO)[0].liked);
    CHECK(!Build(@[@{@"likeFlag":@NO, @"isLikeForMe":@NO}], locked, NO)[0].liked);
    CHECK(Build(source, locked, YES).count == 1);
    CHECK(Build(source, revealed, NO).count == 3);
    CHECK(Build(source, revealed, YES).count == 2);
    CHECK(Build(source, disabled, NO).count == 3);
    CHECK(Build(source, disabled, YES).count == 2);
    CHECK(Build(@[post], revealed, NO)[0].likes == 91);
    CHECK(Build(@[post], revealed, NO)[0].comments == 62);

    NSUInteger before = Reads;
    CHECK(Build(source, blocked, NO).count == 0 && Reads == before);
    CHECK(Build(@[], locked, NO).count == 0);
    CSCloseFriendSnapshot *interactionOnly = Snapshot(YES, NO, NO, @{@"hideTimeline":@NO});
    CHECK(Build(source, interactionOnly, NO).count == 3);
    CHECK(Build(@[post], interactionOnly, NO)[0].comments == 1);

    // Repeated projection leaves every original array and native field intact.
    for (NSUInteger pass = 0; pass < 10; pass++) Build(source, locked, pass % 2);
    CHECK(source.count == 5 && source[0] == post && source[1] == hidden);
    CHECK(post[@"likeUsers"] == likes && post[@"commentUsers"] == comments);
    CHECK(post[@"contentObj"] == content && content[@"mediaList"] == media);
    CHECK(likes.count == 2 && comments.count == 4 && media.count == 2);
    CHECK([post[@"likeCount"] isEqual:@91] && [post[@"commentCount"] isEqual:@62]);
    CHECK([post[@"createtime"] isEqual:@1794976496]);

    // WCDataItem declares unsigned-int createtime, not createTime. Preserve Unix
    // seconds without signed overflow or guessing a millisecond conversion.
    CHECK(Build(@[@{@"createtime":@(4294967295U)}], locked, NO)[0].timestamp == 4294967295.0);
    CHECK(Build(@[@{@"createtime":@1794976496.25}], locked, NO)[0].timestamp == 1794976496.25);
    CHECK(Build(@[@{@"createtime":@0}], locked, NO)[0].timestamp == 0);
    CHECK(Build(@[@{}], locked, NO)[0].timestamp == 0);
    CHECK(Build(@[@{@"createTime":@1794976496}], locked, NO)[0].timestamp == 0);
    for (id invalidTimestamp in @[@(-1), @(NAN), @(INFINITY), @(-INFINITY),
        @"1794976496", NSNull.null, @[]]) {
        CHECK(Build(@[@{@"createtime":invalidTimestamp}], locked, NO)[0].timestamp == 0);
    }

    // Preserve the native isValidForShow/getDisplayCity result verbatim. Other
    // address fields and GPS coordinates are not native label fallbacks.
    NSMutableDictionary *location = [@{@"isValidForShow":@YES,
        @"getDisplayCity":@"  上海 · 西岸美术馆\n",
        @"getDisplayPOIAddress":@"Other address", @"displayPoiAddressName":@"Other display",
        @"poiName":@"Other POI", @"city":@"Other city"} mutableCopy];
    NSMutableDictionary *locatedPost = [@{@"locationInfo":location} mutableCopy];
    card = Build(@[locatedPost], locked, NO)[0];
    CHECK([card.locationText isEqualToString:@"  上海 · 西岸美术馆\n"]);
    CHECK(locatedPost[@"locationInfo"] == location && [location[@"getDisplayCity"] isEqual:@"  上海 · 西岸美术馆\n"]);
    location[@"getDisplayCity"] = @" \n";
    CHECK([Build(@[locatedPost], locked, NO)[0].locationText isEqual:@" \n"]);
    [location removeObjectForKey:@"getDisplayCity"];
    CHECK(Build(@[locatedPost], locked, NO)[0].locationText.length == 0);
    location[@"getDisplayCity"] = @"  苏州 ";
    CHECK([Build(@[locatedPost], locked, NO)[0].locationText isEqual:@"  苏州 "]);
    location[@"getDisplayCity"] = @42;
    CHECK(Build(@[locatedPost], locked, NO)[0].locationText.length == 0);
    location[@"getDisplayCity"] = @"Valid city";
    location[@"isValidForShow"] = @NO;
    CHECK(Build(@[locatedPost], locked, NO)[0].locationText.length == 0);
    for (id invalidLocation in @[NSNull.null, @42, @[], @" "]) {
        CHECK(Build(@[@{@"locationInfo":invalidLocation}], locked, NO)[0].locationText.length == 0);
    }
    CHECK(Build(@[@{@"locationInfo":@{@"locationLatitude":@31.2, @"locationLongitude":@121.5}}], locked, NO)[0].locationText.length == 0);
    CHECK(Build(@[@{@"contentObj":@{@"locationInfo":@{@"poiName":@"Unpublished"}}}], locked, NO)[0].locationText.length == 0);
    CHECK([Build(@[@{@"locationInfo":@{@"isValidForShow":@YES, @"getDisplayCity":@"  北京📍 "}}], locked, NO)[0].locationText isEqual:@"  北京📍 "]);

    NSDictionary *unknownInteractions = @{@"username":@"alice", @"likeCount":@100, @"commentCount":@200};
    card = Build(@[unknownInteractions], locked, NO)[0];
    CHECK(card.likes == 0 && card.comments == 0);
    card = Build(@[unknownInteractions], revealed, NO)[0];
    CHECK(card.likes == 100 && card.comments == 200);
    NSDictionary *arrayCounts = @{@"username":@"alice", @"likeCount":@(-2), @"commentCount":@"wrong",
        @"likeUsers":likes, @"commentUsers":comments};
    card = Build(@[arrayCounts], revealed, NO)[0];
    CHECK(card.likes == 2 && card.comments == 4);
    NSDictionary *emptyCounts = @{@"likeCount":@(-1), @"commentCount":@(NAN)};
    card = Build(@[emptyCounts], revealed, NO)[0];
    CHECK(card.likes == 0 && card.comments == 0);

    NSDictionary *text = @{@"contentDesc":@"Just a text post", @"username":@"writer", @"tid":@"text-id"};
    card = Build(@[text], locked, NO)[0];
    CHECK(card.media == nil && card.mediaCount == 0 && CGSizeEqualToSize(card.coverSize, CGSizeZero));
    CHECK([card.title isEqualToString:@"Just a text post"] && [card.identifier isEqualToString:@"text-id"]);
    CHECK([card.nickname isEqualToString:@"writer"]);
    NSDictionary *video = @{@"isVideo":@YES, @"contentObj":@{@"mediaList":@[portrait]}};
    card = Build(@[video], locked, NO)[0];
    CHECK(card.video && card.mediaCount == 1 && card.media == portrait);
    CHECK(card.title.length == 0 && [card.nickname isEqualToString:@"微信用户"]);
    NSDictionary *shared = @{@"contentDesc":@"  \n", @"contentObj":@{@"title":@"Link title", @"desc":@"Description",
        @"username":@"author", @"nickname":@"Author", @"isVideoType":@YES}};
    card = Build(@[shared], locked, NO)[0];
    CHECK([card.title isEqualToString:@"Link title"] && [card.username isEqualToString:@"author"]);
    CHECK([card.nickname isEqualToString:@"Author"] && card.video);
    CHECK([Build(@[@{@"contentObj":@{@"desc":@"Description only"}}], locked, NO)[0].title isEqualToString:@"Description only"]);
    CHECK(Build(@[@{@"contentObj":@{@"username":@"secret"}}], locked, NO).count == 0);

    // Keep complete Unicode sequences and native bracket codes for WeChat's
    // renderer. Trimming must never split a surrogate pair, modifier or ZWJ.
    NSArray<NSString *> *emojiTitles = @[@"今天😀很好", @"👍🏽", @"👩🏽‍💻一起工作", @"👨‍👩‍👧‍👦",
        @"🇨🇳旗帜", @"1️⃣键帽", @"❤️红心", @"☀︎与☀️", @"[微笑][旺柴]😀[unknown]", @"🫶🏿\n🏳️‍🌈"];
    for (NSString *emojiTitle in emojiTitles) {
        NSDictionary *emojiPost = @{@"contentDesc":[NSString stringWithFormat:@" \n%@\n ", emojiTitle]};
        card = Build(@[emojiPost], locked, NO)[0];
        CHECK([card.title isEqualToString:emojiTitle]);
        CHECK([card.title dataUsingEncoding:NSUTF8StringEncoding] && [card.title dataUsingEncoding:NSUTF16StringEncoding]);
        CHECK([Build(@[@{@"contentObj":@{@"title":emojiTitle}}], locked, NO)[0].title isEqualToString:emojiTitle]);
        CHECK([Build(@[@{@"contentObj":@{@"desc":emojiTitle}}], locked, NO)[0].title isEqualToString:emojiTitle]);
    }

    for (NSDictionary *invalidSize in @[@{@"width":@0, @"height":@900}, @{@"width":@600, @"height":@(-1)},
        @{@"width":@(INFINITY), @"height":@900}, @{@"width":@600, @"height":@(NAN)}]) {
        card = Build(@[@{@"contentObj":@{@"mediaList":@[invalidSize]}}], locked, NO)[0];
        CHECK(card.media == invalidSize && CGSizeEqualToSize(card.coverSize, CGSizeZero));
    }
    card = Build(@[@{@"contentObj":@{@"mediaList":@[NSNull.null]}}], locked, NO)[0];
    CHECK(card.media == nil && CGSizeEqualToSize(card.coverSize, CGSizeZero));
    CHECK(Build(@[NSNull.null], locked, NO).count == 0);

    CSMomentsNativeFixture *native = [CSMomentsNativeFixture new];
    native.values = post;
    card = Build(@[native], locked, NO)[0];
    CHECK(card.item == native && card.media == portrait && card.likes == 1 && card.comments == 1);
    NSLog(@"Moments card model: %lu assertions passed", (unsigned long)Assertions);
} return 0; }
