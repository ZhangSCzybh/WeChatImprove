#import "CSAdPurificationFilters.h"

static BOOL ContainsAny(NSString *text, NSArray<NSString *> *parts) {
    for (NSString *part in parts) if ([text containsString:part]) return YES;
    return NO;
}
BOOL CSAdPurificationTextIsAd(id text) {
    if (![text isKindOfClass:NSString.class] || [text length] > 4 * 1024 * 1024 || [text hasPrefix:@"this.__wxLibrary"]) return NO;
    static NSArray *parts; static dispatch_once_t once;
    dispatch_once(&once, ^{ parts = @[@"getadvert", @"getAdPreloadData", @"_ads_", @"/ads_", @"advert_group", @"advertisement_", @"ad_posid", @"custom_event_wxAdDelayReport"]; });
    return ContainsAny(text, parts) || [text isEqualToString:@"adDataReport"] || [text isEqualToString:@"shouldShowSplashAd"];
}
id CSAdPurificationURLString(id text, CSAdPurificationScope scopes) {
    if (!scopes || ![text isKindOfClass:NSString.class] || [text length] > 1024 * 1024) return text;
    if ((scopes & CSAdPurificationArticles) && [text containsString:@"mp.weixin.qq.com/mp/getappmsgad"]) return @"/t";
    if ((scopes & CSAdPurificationMoments) && ContainsAny(text, @[@"wxsnsdy.wxs.qq.com", @"wxsnsdy.tc.qq.com", @"wxsnsdy.video.qq.com", @"wxsnsdythumb.wxs.qq.com"])) return @"/t";
    if ((scopes & CSAdPurificationMiniPrograms) && ContainsAny(text, @[@"/wxfile://usr/ad/", @"/ad.wx.com", @"lib/WASplashadWorker.js", @"lib/WAAppAd.js"])) return @"/t";
    // The sample's unscoped `ad_data` rule can affect unrelated products and
    // disabled ranges. Named endpoints above provide a scope we can establish.
    return text;
}
BOOL CSAdPurificationArticleEventIsAd(id parameters) {
    if (![parameters isKindOfClass:NSDictionary.class]) return NO;
    id url = parameters[@"reqUrl"], msg = parameters[@"msg"];
    return ([url isKindOfClass:NSString.class] && ContainsAny(url, @[@"mp/getappmsgad", @"mp/appmsgreport", @"mp/wapcommreport"])) ||
        ([msg isKindOfClass:NSString.class] && ContainsAny(msg, @[@"ad_slot_data", @"adData:", @"advertisement", @"/mp/getappmsgad"]));
}
BOOL CSAdPurificationDisallowedBridgeFunction(id name) {
    if (![name isKindOfClass:NSString.class]) return NO;
    static NSSet *names; static dispatch_once_t once;
    dispatch_once(&once, ^{ names = [NSSet setWithArray:@[@"getAdIdInfo", @"adDataReport", @"openADCanvas", @"handleAdAction", @"writeLog"]]; });
    return [names containsObject:name];
}

typedef struct { NSUInteger nodes; BOOL valid; BOOL changed; } CSTraversal;
static BOOL Visit(CSTraversal *walk, NSUInteger depth) {
    if (!walk->valid || depth > 32 || ++walk->nodes > 20000) { walk->valid = NO; return NO; }
    return YES;
}
static id ProcessNode(id value, NSUInteger depth, CSTraversal *walk) {
    if (!Visit(walk, depth)) return value;
    if ([value isKindOfClass:NSString.class]) {
        if ([value length] > 1024 * 1024) { walk->valid = NO; return value; }
        if ([value hasPrefix:@"this.__wxLibrary"]) return value;
        static NSRegularExpression *pattern; static dispatch_once_t once;
        dispatch_once(&once, ^{ pattern = [NSRegularExpression regularExpressionWithPattern:@"advert_group|getadvert|getAdPreloadData|ad_posid|_ads_|/ads_|advertisement_" options:NSRegularExpressionCaseInsensitive error:NULL]; });
        NSString *output = [pattern stringByReplacingMatchesInString:value options:0 range:NSMakeRange(0, [value length]) withTemplate:@"orz"];
        if (![output isEqual:value]) { walk->changed = YES; return output; }
        return value;
    }
    if ([value isKindOfClass:NSArray.class]) {
        NSMutableArray *output = [NSMutableArray arrayWithCapacity:[value count]]; BOOL changed = NO;
        for (id child in value) { id next = ProcessNode(child, depth + 1, walk); if (next != child) changed = YES; [output addObject:next]; if (!walk->valid) return value; }
        return changed ? [output copy] : value;
    }
    if ([value isKindOfClass:NSDictionary.class]) {
        NSMutableDictionary *output = [NSMutableDictionary dictionaryWithCapacity:[value count]]; BOOL changed = NO;
        for (id key in value) {
            id child = value[key]; id next = ProcessNode(child, depth + 1, walk); if (next != child) changed = YES; output[key] = next;
            if (!walk->valid) return value;
        }
        return changed ? [output copy] : value;
    }
    return value;
}
id CSAdPurificationProcessObject(id object) {
    if (!object) return object;
    @try { CSTraversal walk = {0, YES, NO}; id output = ProcessNode(object, 0, &walk); return walk.valid && walk.changed ? output : object; }
    @catch (__unused NSException *exception) { return object; }
}

static BOOL HasPayload(id value) {
    if (!value || value == NSNull.null) return NO;
    if ([value isKindOfClass:NSNumber.class]) return [value doubleValue] != 0;
    if ([value isKindOfClass:NSString.class]) return [value length] > 0 && ![value isEqualToString:@"0"];
    if ([value isKindOfClass:NSArray.class] || [value isKindOfClass:NSDictionary.class]) return [value count] > 0;
    return NO;
}
static BOOL SearchItemIsAd(id item) {
    if (![item isKindOfClass:NSDictionary.class]) return NO;
    // Classify records by named metadata, never by arbitrary title/snippet text.
    static NSArray *markers; static dispatch_once_t once;
    dispatch_once(&once, ^{ markers = @[@"isAd", @"is_ad", @"is_advertisement", @"ad_posid", @"advert_group", @"advertisement", @"adData", @"ad_info", @"adInfo", @"ad_slot_data"]; });
    for (NSString *key in markers) if (HasPayload(item[key])) return YES;
    return NO;
}
static id FilterSearchNode(id value, NSUInteger depth, CSTraversal *walk) {
    if (!Visit(walk, depth)) return value;
    if ([value isKindOfClass:NSArray.class]) {
        NSMutableArray *output = [NSMutableArray arrayWithCapacity:[value count]]; BOOL changed = NO;
        for (id child in value) {
            if (SearchItemIsAd(child)) { walk->changed = YES; changed = YES; continue; }
            id next = FilterSearchNode(child, depth + 1, walk); if (next != child) changed = YES;
            [output addObject:next]; if (!walk->valid) return value;
        }
        return changed ? [output copy] : value;
    }
    if ([value isKindOfClass:NSDictionary.class]) {
        NSMutableDictionary *output = [NSMutableDictionary dictionaryWithCapacity:[value count]]; BOOL changed = NO;
        for (id key in value) {
            id child = value[key], next = FilterSearchNode(child, depth + 1, walk);
            if (next != child) changed = YES; output[key] = next; if (!walk->valid) return value;
        }
        return changed ? [output copy] : value;
    }
    return value;
}
id CSAdPurificationSearchResult(id event, id handler, id result) {
    BOOL guide = [event isKindOfClass:NSString.class] && [event isEqualToString:@"onSearchWebQueryReady"];
    BOOL search = [event isKindOfClass:NSString.class] && [event isEqualToString:@"onSearchDataReady"];
    if ((!guide && !search) || ![handler isKindOfClass:NSString.class] || [handler length] > 65536 ||
        ![handler containsString:guide ? @"querySearchWeb" : @"getSearchData"] || ![result isKindOfClass:NSDictionary.class]) return result;
    @try {
        id text = result[@"json"];
        if (![text isKindOfClass:NSString.class] || [text length] > 4 * 1024 * 1024) return result;
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        id json = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] : nil;
        if (![json isKindOfClass:NSDictionary.class] || (guide && ![json[@"cgiName"] isEqual:@"SearchGuide"])) return result;
        id records = json[@"data"];
        if (![records isKindOfClass:NSArray.class] && ![records isKindOfClass:NSDictionary.class]) return result;
        CSTraversal walk = {0, YES, NO}; id filtered = FilterSearchNode(records, 0, &walk);
        if (!walk.valid || !walk.changed) return result;
        NSMutableDictionary *outputJSON = [json mutableCopy]; outputJSON[@"data"] = filtered;
        NSData *encoded = [NSJSONSerialization dataWithJSONObject:outputJSON options:0 error:NULL];
        NSString *outputText = encoded ? [[NSString alloc] initWithData:encoded encoding:NSUTF8StringEncoding] : nil;
        if (!outputText) return result;
        NSMutableDictionary *output = [result mutableCopy]; output[@"json"] = outputText; return output;
    } @catch (__unused NSException *exception) { return result; }
}
