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

int main(void) { @autoreleasepool {
    CSCloseFriendSnapshot *locked = Snapshot(YES, NO, NO, nil);
    CSCloseFriendSnapshot *revealed = Snapshot(YES, YES, NO, nil);
    CSCloseFriendSnapshot *disabled = Snapshot(NO, NO, NO, nil);
    CSCloseFriendSnapshot *blocked = Snapshot(YES, NO, YES, nil);
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
