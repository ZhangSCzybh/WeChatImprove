#import <Foundation/Foundation.h>
#import "CSAdPurificationFilters.h"

static NSUInteger Assertions;
#define CHECK(condition) do { Assertions++; if (!(condition)) { NSLog(@"AdPurification filters FAIL %d: %s", __LINE__, #condition); exit(1); } } while (0)

static NSDictionary *ResultWithJSON(id json) {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:&error];
    CHECK(data != nil && error == nil);
    return @{@"json": [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], @"callback": @"keep-callback", @"status": @0};
}
static NSDictionary *DecodedResult(id result) {
    CHECK([result isKindOfClass:NSDictionary.class]);
    CHECK([result[@"json"] isKindOfClass:NSString.class]);
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:[result[@"json"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    CHECK([json isKindOfClass:NSDictionary.class] && error == nil);
    return json;
}

static void CheckURLScopes(void) {
    const CSAdPurificationScope all = CSAdPurificationArticles | CSAdPurificationSubscriptions |
        CSAdPurificationMoments | CSAdPurificationFinder | CSAdPurificationMiniPrograms |
        CSAdPurificationSearch | CSAdPurificationRecommendations;
    NSArray *cases = @[
        @[@"https://mp.weixin.qq.com/mp/getappmsgad?action=get", @(CSAdPurificationArticles)],
        @[@"https://wxsnsdy.wxs.qq.com/123", @(CSAdPurificationMoments)],
        @[@"https://wxsnsdy.tc.qq.com/123", @(CSAdPurificationMoments)],
        @[@"https://wxsnsdy.video.qq.com/123", @(CSAdPurificationMoments)],
        @[@"https://wxsnsdythumb.wxs.qq.com/123", @(CSAdPurificationMoments)],
        @[@"https://mini.test/wxfile://usr/ad/content", @(CSAdPurificationMiniPrograms)],
        @[@"https://ad.wx.com/resource", @(CSAdPurificationMiniPrograms)],
        @[@"https://mini.test/lib/WASplashadWorker.js", @(CSAdPurificationMiniPrograms)],
        @[@"https://mini.test/lib/WAAppAd.js", @(CSAdPurificationMiniPrograms)]
    ];
    for (NSArray *row in cases) {
        id input = [row[0] mutableCopy];
        CSAdPurificationScope matching = [row[1] unsignedLongLongValue];
        CHECK(CSAdPurificationURLString(input, 0) == input);
        CHECK([CSAdPurificationURLString(input, matching) isEqual:@"/t"]);
        CHECK([CSAdPurificationURLString(input, all) isEqual:@"/t"]);
        CHECK(CSAdPurificationURLString(input, all & ~matching) == input);
        for (NSUInteger bit = 0; bit < 7; bit++) {
            CSAdPurificationScope scope = (CSAdPurificationScope)(1ULL << bit);
            if (scope != matching) CHECK(CSAdPurificationURLString(input, scope) == input);
        }
    }
    for (NSString *ordinary in @[@"https://example.test/ad_data/analytics", @"https://mp.weixin.qq.com/s/article", @"https://example.test/image.png"]) {
        id input = [ordinary mutableCopy];
        CHECK(CSAdPurificationURLString(input, all) == input);
    }
    id input = [@"https://wxsnsdy.wxs.qq.com/video" mutableCopy];
    CHECK(CSAdPurificationURLString(input, (CSAdPurificationScope)(1ULL << 40)) == input);
}

static void CheckTextAndArticleBridges(void) {
    for (NSString *text in @[@"call getadvert now", @"getAdPreloadData", @"abc_ads_test", @"/ads_path", @"advert_group", @"advertisement_slot", @"ad_posid", @"custom_event_wxAdDelayReport", @"adDataReport", @"shouldShowSplashAd"])
        CHECK(CSAdPurificationTextIsAd(text));
    CHECK(!CSAdPurificationTextIsAd(@"this.__wxLibrary getadvert ad_posid"));
    CHECK(!CSAdPurificationTextIsAd(@"学习广告原理：什么是商业推广"));
    CHECK(!CSAdPurificationTextIsAd(@"adDataReportDocumentation"));
    CHECK(!CSAdPurificationTextIsAd(@"shouldShowSplashAdSettings"));
    for (NSString *name in @[@"getAdIdInfo", @"adDataReport", @"openADCanvas", @"handleAdAction", @"writeLog"])
        CHECK(CSAdPurificationDisallowedBridgeFunction(name));
    for (NSString *name in @[@"getAdIdInfoDescription", @"log", @"getSearchData", @"openDocument"])
        CHECK(!CSAdPurificationDisallowedBridgeFunction(name));
    for (NSString *url in @[@"https://mp.weixin.qq.com/mp/getappmsgad", @"/mp/appmsgreport", @"/mp/wapcommreport"])
        CHECK(CSAdPurificationArticleEventIsAd(@{@"reqUrl": url}));
    for (NSString *msg in @[@"ad_slot_data", @"adData:yes", @"advertisement", @"/mp/getappmsgad"])
        CHECK(CSAdPurificationArticleEventIsAd(@{@"msg": msg}));
    CHECK(!CSAdPurificationArticleEventIsAd(@{@"reqUrl": @"/mp/readarticle", @"msg": @"normal event"}));
    CHECK(!CSAdPurificationArticleEventIsAd(@{@"reqUrl": @17, @"msg": @[@"ad_slot_data"]}));
}

static void CheckRecursiveCopyAndBounds(void) {
    id normalString = [@"ordinary content" mutableCopy];
    id normal = @{@"title": normalString, @"children": @[@1, NSNull.null]};
    CHECK(CSAdPurificationProcessObject(normal) == normal);
    CHECK(CSAdPurificationProcessObject(normalString) == normalString);
    id library = [@"this.__wxLibrary getadvert ad_posid advertisement_x" mutableCopy];
    CHECK(CSAdPurificationProcessObject(library) == library);

    NSDictionary *input = @{@"getadvert": @"getadvert ad_posid GETADPRELOADDATA advertisement_x",
                            @"children": @[@"/ads_image _ads_banner advert_group", normal, library], @"number": @17};
    NSDictionary *output = CSAdPurificationProcessObject(input);
    CHECK(output != input);
    CHECK(output[@"getadvert"] != nil && output[@"orz"] == nil);
    CHECK([output[@"getadvert"] isEqual:@"orz orz orz orzx"]);
    CHECK([output[@"children"][0] isEqual:@"orzimage orzbanner orz"]);
    CHECK(output[@"children"][1] == normal && output[@"children"][2] == library);
    CHECK([output[@"number"] isEqual:@17]);
    CHECK([input[@"getadvert"] isEqual:@"getadvert ad_posid GETADPRELOADDATA advertisement_x"]);
    CHECK([input[@"children"][0] isEqual:@"/ads_image _ads_banner advert_group"]);

    // A failed traversal must roll back earlier rewrites and pass through the
    // complete root, including when the first child already matched.
    id deep = @"leaf";
    for (NSUInteger level = 0; level < 64; level++) deep = @[deep];
    id deepRoot = @[@"getadvert", deep];
    CHECK(CSAdPurificationProcessObject(deepRoot) == deepRoot);

    NSMutableArray *cycle = [NSMutableArray arrayWithObject:@"getadvert"];
    NSMutableDictionary *backlink = [NSMutableDictionary dictionaryWithObject:cycle forKey:@"loop"];
    [cycle addObject:backlink];
    CHECK(CSAdPurificationProcessObject(cycle) == cycle);
    [backlink removeAllObjects];

    NSMutableArray *wide = [NSMutableArray arrayWithObject:@"getadvert"];
    for (NSUInteger index = 0; index < 25000; index++) [wide addObject:@17];
    CHECK(CSAdPurificationProcessObject(wide) == wide);
}

static void CheckGuideFiltering(void) {
    NSArray *ordinary = @[@{@"id": @1, @"title": @"广告投放科普"}, @{@"id": @2}, @{@"id": @3}, @{@"id": @4}];
    id unchanged = ResultWithJSON(@{@"cgiName": @"SearchGuide", @"data": @{@"data": @[@{@"items": ordinary}]}});
    CHECK(CSAdPurificationSearchResult(@"onSearchWebQueryReady", @"handler querySearchWeb", unchanged) == unchanged);

    NSArray *items = @[@{@"id": @1, @"title": @"getadvert 与 ad_posid 参数科普"},
                       @{@"id": @2}, @{@"id": @3}, @{@"id": @"sponsor", @"isAd": @YES}, @{@"id": @4}];
    id input = ResultWithJSON(@{@"cgiName": @"SearchGuide", @"trace": @"preserve", @"data": @{@"data": @[@{@"items": items}]}});
    id output = CSAdPurificationSearchResult(@"onSearchWebQueryReady", @"querySearchWeb", input);
    CHECK(output != input);
    NSDictionary *json = DecodedResult(output);
    NSArray *expected = @[items[0], items[1], items[2], items[4]];
    CHECK([json[@"data"][@"data"][0][@"items"] isEqual:expected]);
    CHECK([json[@"trace"] isEqual:@"preserve"]);
    CHECK([output[@"callback"] isEqual:@"keep-callback"] && [output[@"status"] isEqual:@0]);
    CHECK([DecodedResult(input)[@"data"][@"data"][0][@"items"] isEqual:items]);
}

static void CheckSearchMetadataAndNestedOrder(void) {
    NSArray *metadata = @[@{@"isAd": @YES}, @{@"is_ad": @1}, @{@"is_advertisement": @YES},
                         @{@"ad_posid": @"slot-1"}, @{@"advert_group": @"group-1"},
                         @{@"advertisement": @{@"id": @1}}, @{@"adData": @{@"id": @1}},
                         @{@"ad_info": @{@"id": @1}}, @{@"adInfo": @{@"id": @1}},
                         @{@"ad_slot_data": @[@1]}];
    NSDictionary *first = @{@"id": @1, @"title": @"getadvert /ads_ advertisement_ 介绍"};
    NSDictionary *last = @{@"id": @2, @"isAd": @NO, @"is_ad": @0, @"adInfo": @{}, @"adData": NSNull.null};
    for (NSDictionary *ad in metadata) {
        id input = ResultWithJSON(@{@"data": @[first, ad, last]});
        id output = CSAdPurificationSearchResult(@"onSearchDataReady", @"getSearchData", input);
        CHECK(output != input);
        CHECK(([DecodedResult(output)[@"data"] isEqual:@[first, last]]));
    }

    NSDictionary *keepA = @{@"id": @"A"}, *keepB = @{@"id": @"B"}, *keepC = @{@"id": @"C"};
    NSDictionary *group = @{@"title": @"advert_group 术语说明", @"items": @[keepB, @{@"ad_posid": @"s1"}, keepC], @"nonList": @42};
    id input = ResultWithJSON(@{@"data": @[keepA, group, @"getadvert topic", @{@"adData": @{@"slot": @1}}, last]});
    id output = CSAdPurificationSearchResult(@"onSearchDataReady", @"getSearchData-handler", input);
    NSArray *expected = @[keepA, @{@"title": group[@"title"], @"items": @[keepB, keepC], @"nonList": @42}, @"getadvert topic", last];
    CHECK([DecodedResult(output)[@"data"] isEqual:expected]);
}

static void CheckSearchPassThroughAndBadTypes(void) {
    id input = ResultWithJSON(@{@"cgiName": @"SearchGuide", @"data": @[@{@"isAd": @YES}]});
    CHECK(CSAdPurificationSearchResult(@"unrelated", @"getSearchData", input) == input);
    CHECK(CSAdPurificationSearchResult(@"onSearchDataReady", @"querySearchWeb", input) == input);
    CHECK(CSAdPurificationSearchResult(@"onSearchWebQueryReady", @"getSearchData", input) == input);
    CHECK(CSAdPurificationSearchResult(@"onSearchDataReady", @17, input) == input);
    CHECK(CSAdPurificationSearchResult(@17, @"getSearchData", input) == input);
    id wrongCGI = ResultWithJSON(@{@"cgiName": @"OtherSearch", @"data": @[@{@"isAd": @YES}]});
    CHECK(CSAdPurificationSearchResult(@"onSearchWebQueryReady", @"querySearchWeb", wrongCGI) == wrongCGI);
    for (id malformed in @[@{@"json": @"{not JSON"}, @{@"json": @42}, @{}, @{@"json": @"null"}, @{@"json": @"[]"}, @{@"json": @"{\"data\":17}"}])
        CHECK(CSAdPurificationSearchResult(@"onSearchDataReady", @"getSearchData", malformed) == malformed);

    id deep = @{@"title": @"leaf"};
    for (NSUInteger level = 0; level < 64; level++) deep = @[deep];
    id deepResult = ResultWithJSON(@{@"data": @[@{@"isAd": @YES}, deep]});
    CHECK(CSAdPurificationSearchResult(@"onSearchDataReady", @"getSearchData", deepResult) == deepResult);

    for (id nonString in @[@17, NSNull.null, @[], @{}]) {
        CHECK(!CSAdPurificationTextIsAd(nonString));
        CHECK(!CSAdPurificationArticleEventIsAd(nonString));
        CHECK(!CSAdPurificationDisallowedBridgeFunction(nonString));
        CHECK(CSAdPurificationURLString(nonString, CSAdPurificationArticles) == nonString);
        CHECK(CSAdPurificationSearchResult(@"onSearchDataReady", @"getSearchData", nonString) == nonString);
        CHECK(CSAdPurificationProcessObject(nonString) == nonString);
    }
    CHECK(!CSAdPurificationTextIsAd(nil));
    CHECK(!CSAdPurificationArticleEventIsAd(nil));
    CHECK(!CSAdPurificationDisallowedBridgeFunction(nil));
    CHECK(CSAdPurificationURLString(nil, CSAdPurificationArticles) == nil);
    CHECK(CSAdPurificationProcessObject(nil) == nil);
    CHECK(CSAdPurificationSearchResult(nil, nil, nil) == nil);
}

int main(void) { @autoreleasepool {
    CheckURLScopes();
    CheckTextAndArticleBridges();
    CheckRecursiveCopyAndBounds();
    CheckGuideFiltering();
    CheckSearchMetadataAndNestedOrder();
    CheckSearchPassThroughAndBadTypes();
    NSLog(@"AdPurification filters passed (%lu assertions)", (unsigned long)Assertions);
    return 0;
} }
