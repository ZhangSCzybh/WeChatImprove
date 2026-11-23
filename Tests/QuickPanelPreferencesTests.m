#import <Foundation/Foundation.h>
#import "CSQuickPanelPreferences.h"
#import "CSQuickPanelBackgroundImageStore.h"
#import <ImageIO/ImageIO.h>
#include <math.h>

static NSUserDefaults *CSQuickPanelTestDefaults;
static NSURL *CSQuickPanelTestResourceDirectory;

@interface CSQuickPanelTestImageStore : CSQuickPanelBackgroundImageStore
@end
@implementation CSQuickPanelTestImageStore
+ (NSURL *)resourceDirectoryURL { return CSQuickPanelTestResourceDirectory; }
@end

@interface CSQuickPanelPreferences (TestStorage)
+ (NSUserDefaults *)cs_defaults;
+ (Class)cs_backgroundImageStoreClass;
@end

@interface CSQuickPanelTestPreferences : CSQuickPanelPreferences
@end
@implementation CSQuickPanelTestPreferences
+ (NSUserDefaults *)cs_defaults { return CSQuickPanelTestDefaults; }
+ (Class)cs_backgroundImageStoreClass { return CSQuickPanelTestImageStore.class; }
@end

static void CSRequire(BOOL condition, NSString *message) {
    if (!condition) {
        NSLog(@"FAIL: %@", message);
        exit(1);
    }
}

static void CSDrainNotifications(void) {
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.03]];
}

static NSData *CSLargeImageFixture(void) {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, 3000, 1200, 8, 0, space, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(space);
    CGContextSetRGBFillColor(context, 0.2, 0.4, 0.8, 1);
    CGContextFillRect(context, CGRectMake(0, 0, 3000, 1200));
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    NSMutableData *data = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)data, CFSTR("public.png"), 1, NULL);
    CGImageDestinationAddImage(destination, image, NULL);
    BOOL result = CGImageDestinationFinalize(destination);
    CGImageRelease(image);
    CFRelease(destination);
    return result ? data.copy : nil;
}

static void CSVerifyBackgroundPreferences(NSString *suite) {
    CSRequire([CSQuickPanelTestPreferences.backgroundStyle isEqual:CSQuickPanelBackgroundStyleDefault] &&
              [CSQuickPanelTestPreferences.backgroundColorHex isEqual:@"#F2F2F7"] &&
              CSQuickPanelTestPreferences.backgroundOpacity == 1 && !CSQuickPanelTestPreferences.backgroundImagePath,
              @"background defaults follow system without an image");
    [CSQuickPanelTestPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleColor];
    [CSQuickPanelTestPreferences setBackgroundColorHex:@"#a1b2c3"];
    [CSQuickPanelTestPreferences setBackgroundOpacity:0.35];
    CSRequire([CSQuickPanelTestPreferences.backgroundStyle isEqual:@"color"] &&
              [CSQuickPanelTestPreferences.backgroundColorHex isEqual:@"#A1B2C3"] &&
              CSQuickPanelTestPreferences.backgroundOpacity == 0.35, @"background color and opacity persist independently");
    [CSQuickPanelTestPreferences setBackgroundColorHex:@"#NOTHEX"];
    CSRequire([CSQuickPanelTestPreferences.backgroundColorHex isEqual:@"#A1B2C3"], @"invalid color setter preserves previous color");
    [CSQuickPanelTestPreferences setBackgroundOpacity:-1];
    CSRequire(CSQuickPanelTestPreferences.backgroundOpacity == 0, @"opacity clamps below zero");
    [CSQuickPanelTestPreferences setBackgroundOpacity:2];
    CSRequire(CSQuickPanelTestPreferences.backgroundOpacity == 1, @"opacity clamps above one");
    [CSQuickPanelTestPreferences setBackgroundOpacity:NAN];
    CSRequire(CSQuickPanelTestPreferences.backgroundOpacity == 1, @"non-finite opacity uses safe default");
    [CSQuickPanelTestDefaults setObject:@"broken" forKey:CSQuickPanelBackgroundStyleKey];
    [CSQuickPanelTestDefaults setObject:@"#XX0000" forKey:CSQuickPanelBackgroundColorHexKey];
    [CSQuickPanelTestDefaults setObject:@(-1) forKey:CSQuickPanelBackgroundOpacityKey];
    CSRequire([CSQuickPanelTestPreferences.backgroundStyle isEqual:@"default"] &&
              [CSQuickPanelTestPreferences.backgroundColorHex isEqual:@"#F2F2F7"] &&
              CSQuickPanelTestPreferences.backgroundOpacity == 1, @"malformed persisted background values use safe defaults");

    NSData *source = CSLargeImageFixture();
    NSDictionary *beforeImport = [CSQuickPanelTestDefaults persistentDomainForName:suite];
    NSError *error = nil;
    NSString *first = [CSQuickPanelTestImageStore storeImageData:source error:&error];
    NSString *second = [CSQuickPanelTestImageStore storeImageData:source error:&error];
    CSRequire(first && second && error == nil && ![first isEqual:second], @"identical image imports receive separate owned files");
    CSRequire([[CSQuickPanelTestDefaults persistentDomainForName:suite] isEqual:beforeImport], @"image store never publishes preferences");
    NSData *normalized = [CSQuickPanelTestImageStore imageDataAtPath:first];
    CGImageSourceRef image = CGImageSourceCreateWithData((__bridge CFDataRef)normalized, NULL);
    NSDictionary *properties = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(image, 0, NULL));
    CSRequire(normalized.length > 0 && normalized.length <= 4 * 1024 * 1024 && CGImageSourceGetCount(image) == 1 &&
              [properties[(__bridge NSString *)kCGImagePropertyPixelWidth] integerValue] <= 1536 &&
              [properties[(__bridge NSString *)kCGImagePropertyPixelHeight] integerValue] <= 1536,
              @"import normalizes a large image to the backup image contract");
    CFRelease(image);
    [CSQuickPanelTestPreferences setBackgroundImagePath:first];
    [CSQuickPanelTestPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleImage];
    CSRequire([CSQuickPanelTestPreferences.backgroundImagePath isEqual:first], @"owned image path can be published");
    [CSQuickPanelTestPreferences setBackgroundImagePath:@"/tmp/foreign.png"];
    CSRequire([CSQuickPanelTestPreferences.backgroundImagePath isEqual:first], @"foreign path setter preserves current background");
    [CSQuickPanelTestImageStore removeImageAtPath:second error:&error];
    CSRequire([CSQuickPanelTestImageStore imageDataAtPath:first] && ![NSFileManager.defaultManager fileExistsAtPath:second], @"discarding a stale import preserves the selected image");
    NSString *foreign = [CSQuickPanelTestResourceDirectory URLByAppendingPathComponent:@"other-module.png"].path;
    [source writeToFile:foreign atomically:YES];
    CSRequire(![CSQuickPanelTestImageStore removeImageAtPath:foreign error:&error] && [NSFileManager.defaultManager fileExistsAtPath:foreign], @"cleanup preserves other modules' images");
    CSRequire(![CSQuickPanelTestImageStore storeImageData:[@"invalid" dataUsingEncoding:NSUTF8StringEncoding] error:&error], @"invalid picker content is rejected");
    NSURL *sourceURL = [CSQuickPanelTestResourceDirectory URLByAppendingPathComponent:@"picker-source.png"];
    [source writeToURL:sourceURL atomically:YES];
    NSString *fromURL = [CSQuickPanelTestImageStore storeImageAtURL:sourceURL error:&error];
    CSRequire([CSQuickPanelTestImageStore imageDataAtPath:fromURL] != nil, @"temporary picker URL imports before publication");
    [CSQuickPanelTestImageStore removeImageAtPath:fromURL error:NULL];

    NSString *linkName = [NSString stringWithFormat:@"backup_%@.png", [@"717569636b70616e656c" stringByPaddingToLength:64 withString:@"0" startingAtIndex:0]];
    NSString *linked = [CSQuickPanelTestResourceDirectory URLByAppendingPathComponent:linkName].path;
    CSRequire([CSQuickPanelTestImageStore isManagedImagePath:linked], @"test link uses this module's syntactic filename namespace");
    [NSFileManager.defaultManager createSymbolicLinkAtPath:linked withDestinationPath:foreign error:NULL];
    CSRequire(![CSQuickPanelTestImageStore imageDataAtPath:linked] &&
              ![CSQuickPanelTestImageStore removeImageAtPath:linked error:&error] &&
              [NSFileManager.defaultManager fileExistsAtPath:foreign], @"image reads and cleanup reject a symlink without following it");
    [CSQuickPanelTestPreferences setBackgroundImagePath:linked];
    CSRequire(![CSQuickPanelTestPreferences resetBackgroundWithError:&error] &&
              [CSQuickPanelTestPreferences.backgroundImagePath isEqual:linked], @"failed reset preserves the preference needed to repair its image");
    [NSFileManager.defaultManager removeItemAtPath:linked error:NULL];
    [CSQuickPanelTestPreferences setBackgroundImagePath:first];

    BOOL enabled = CSQuickPanelTestPreferences.enabled;
    CSQuickPanelTriggerLocations locations = CSQuickPanelTestPreferences.triggerLocations;
    NSArray *selected = CSQuickPanelTestPreferences.selectedActionIdentifiers;
    CSRequire([CSQuickPanelTestPreferences resetBackgroundWithError:&error] && error == nil, @"background reset succeeds");
    CSRequire(![NSFileManager.defaultManager fileExistsAtPath:first] && [NSFileManager.defaultManager fileExistsAtPath:foreign], @"reset removes exactly its owned image");
    for (NSString *key in @[CSQuickPanelBackgroundStyleKey, CSQuickPanelBackgroundColorHexKey, CSQuickPanelBackgroundOpacityKey, CSQuickPanelBackgroundImagePathKey]) {
        CSRequire(![CSQuickPanelTestDefaults objectForKey:key], @"reset removes each background key");
    }
    CSRequire(CSQuickPanelTestPreferences.enabled == enabled && CSQuickPanelTestPreferences.triggerLocations == locations &&
              [CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:selected], @"reset preserves enable, trigger locations and action order");
    [CSQuickPanelTestDefaults setObject:foreign forKey:CSQuickPanelBackgroundImagePathKey];
    CSRequire([CSQuickPanelTestPreferences resetBackgroundWithError:&error] && [NSFileManager.defaultManager fileExistsAtPath:foreign], @"reset discards a corrupted foreign path without deleting its target");
}

static void CSVerifyForegroundPreferences(NSString *suite) {
    NSDictionary *legacy = [CSQuickPanelTestDefaults persistentDomainForName:suite];
    CSRequire(!CSQuickPanelTestPreferences.textColorHex && !CSQuickPanelTestPreferences.iconColorHex,
              @"old configurations without foreground overrides use independent automatic defaults");
    CSRequire([[CSQuickPanelTestDefaults persistentDomainForName:suite] isEqual:legacy],
              @"reading automatic defaults never migrates an existing configuration");

    [CSQuickPanelTestPreferences setTextColorHex:@"#a1b2c3"];
    [CSQuickPanelTestPreferences setIconColorHex:@"#d4e5f6"];
    CSRequire([CSQuickPanelTestPreferences.textColorHex isEqual:@"#A1B2C3"] &&
              [CSQuickPanelTestPreferences.iconColorHex isEqual:@"#D4E5F6"], @"foreground colors normalize independently");
    CSRequire([[CSQuickPanelTestDefaults objectForKey:CSQuickPanelTextColorHexKey] isEqual:@"#A1B2C3"] &&
              [[CSQuickPanelTestDefaults objectForKey:CSQuickPanelIconColorHexKey] isEqual:@"#D4E5F6"],
              @"published foreground values use the backup canonical color format");
    for (id invalid in @[@"#ABC", @"#12345678", @"#GG0000", @"1234567", @" #123456", @17, NSNull.null]) {
        [CSQuickPanelTestPreferences setTextColorHex:invalid];
        [CSQuickPanelTestPreferences setIconColorHex:invalid];
        CSRequire([CSQuickPanelTestPreferences.textColorHex isEqual:@"#A1B2C3"] &&
                  [CSQuickPanelTestPreferences.iconColorHex isEqual:@"#D4E5F6"], @"invalid setters preserve both previous foreground colors");
    }
    [CSQuickPanelTestPreferences setTextColorHex:nil];
    CSRequire(!CSQuickPanelTestPreferences.textColorHex && [CSQuickPanelTestPreferences.iconColorHex isEqual:@"#D4E5F6"] &&
              ![CSQuickPanelTestDefaults objectForKey:CSQuickPanelTextColorHexKey], @"default text removes only its override");
    [CSQuickPanelTestPreferences setTextColorHex:@"#010203"];
    [CSQuickPanelTestPreferences setIconColorHex:nil];
    CSRequire(!CSQuickPanelTestPreferences.iconColorHex && [CSQuickPanelTestPreferences.textColorHex isEqual:@"#010203"] &&
              ![CSQuickPanelTestDefaults objectForKey:CSQuickPanelIconColorHexKey], @"default icons remove only their override");
    for (id invalid in @[@"#FFF", @"#QQ0000", @"", @42, @[]]) {
        [CSQuickPanelTestDefaults setObject:invalid forKey:CSQuickPanelTextColorHexKey];
        [CSQuickPanelTestDefaults setObject:invalid forKey:CSQuickPanelIconColorHexKey];
        NSDictionary *beforeRead = [CSQuickPanelTestDefaults persistentDomainForName:suite];
        CSRequire(!CSQuickPanelTestPreferences.textColorHex && !CSQuickPanelTestPreferences.iconColorHex,
                  @"malformed stored foreground colors fall back to automatic modes");
        CSRequire([[CSQuickPanelTestDefaults persistentDomainForName:suite] isEqual:beforeRead],
                  @"malformed foreground reads do not mutate persisted settings");
    }
    [CSQuickPanelTestDefaults setObject:@"#abcdef" forKey:CSQuickPanelTextColorHexKey];
    [CSQuickPanelTestDefaults setObject:@"#FEDcba" forKey:CSQuickPanelIconColorHexKey];
    CSRequire([CSQuickPanelTestPreferences.textColorHex isEqual:@"#ABCDEF"] &&
              [CSQuickPanelTestPreferences.iconColorHex isEqual:@"#FEDCBA"], @"stored mixed case colors read as canonical RGB");
    [CSQuickPanelTestPreferences resetForegroundColors];
    CSDrainNotifications();
    __block NSUInteger notifications = 0;
    __block BOOL onMain = YES;
    id token = [NSNotificationCenter.defaultCenter addObserverForName:CSQuickPanelPreferencesDidChangeNotification object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
        notifications++;
        onMain = onMain && NSThread.isMainThread;
    }];
    [CSQuickPanelTestPreferences setTextColorHex:@"#123456"];
    [CSQuickPanelTestPreferences setIconColorHex:@"#ABCDEF"];
    CSRequire(notifications == 0, @"foreground setters do not synchronously refresh UIKit");
    CSDrainNotifications();
    CSRequire(notifications == 1 && onMain, @"foreground changes coalesce to one main queue notification");
    [CSQuickPanelTestPreferences setTextColorHex:@"#123456"];
    [CSQuickPanelTestPreferences setIconColorHex:@"#abcdef"];
    [CSQuickPanelTestPreferences setTextColorHex:@"invalid"];
    CSDrainNotifications();
    CSRequire(notifications == 1, @"equivalent and invalid foreground writes do not notify");
    [CSQuickPanelTestPreferences resetForegroundColors];
    CSDrainNotifications();
    CSRequire(notifications == 2 && !CSQuickPanelTestPreferences.textColorHex && !CSQuickPanelTestPreferences.iconColorHex,
              @"reset coalesces both overrides into one refresh");
    [CSQuickPanelTestPreferences resetForegroundColors];
    CSDrainNotifications();
    CSRequire(notifications == 2, @"an already default foreground reset is a no-op");
    [NSNotificationCenter.defaultCenter removeObserver:token];

    NSError *error = nil;
    NSString *image = [CSQuickPanelTestImageStore storeImageData:CSLargeImageFixture() error:&error];
    CSRequire(image && !error, @"reset isolation uses an actual owned image");
    [CSQuickPanelTestPreferences setBackgroundImagePath:image];
    [CSQuickPanelTestPreferences setBackgroundStyle:CSQuickPanelBackgroundStyleColor];
    [CSQuickPanelTestPreferences setBackgroundColorHex:@"#ABCDE0"];
    [CSQuickPanelTestPreferences setBackgroundOpacity:0.42];
    [CSQuickPanelTestPreferences setTextColorHex:@"#112233"];
    [CSQuickPanelTestPreferences setIconColorHex:@"#445566"];
    NSMutableDictionary *withoutForeground = [[CSQuickPanelTestDefaults persistentDomainForName:suite] mutableCopy];
    [withoutForeground removeObjectsForKeys:@[CSQuickPanelTextColorHexKey, CSQuickPanelIconColorHexKey]];
    NSData *beforeReset = [CSQuickPanelTestImageStore imageDataAtPath:image];
    [CSQuickPanelTestPreferences resetForegroundColors];
    CSRequire([[CSQuickPanelTestDefaults persistentDomainForName:suite] isEqual:withoutForeground],
              @"foreground reset preserves background, enable, trigger locations and selected order byte-for-byte");
    CSRequire(beforeReset.length && [[CSQuickPanelTestImageStore imageDataAtPath:image] isEqual:beforeReset],
              @"foreground reset does not remove or rewrite the owned background image");
    [CSQuickPanelTestPreferences setTextColorHex:@"#112233"];
    [CSQuickPanelTestPreferences setIconColorHex:@"#445566"];
    CSRequire([CSQuickPanelTestPreferences resetBackgroundWithError:&error] &&
              [CSQuickPanelTestPreferences.textColorHex isEqual:@"#112233"] && [CSQuickPanelTestPreferences.iconColorHex isEqual:@"#445566"],
              @"background reset preserves both foreground overrides");
    [CSQuickPanelTestPreferences resetForegroundColors];
    CSRequire([[CSQuickPanelTestDefaults persistentDomainForName:suite] isEqual:legacy],
              @"after independent appearance resets the existing selection configuration is intact");
}

int main(void) {
    @autoreleasepool {
        NSString *suite = [@"com.wechatimprove.tests.quick-panel." stringByAppendingString:NSUUID.UUID.UUIDString];
        CSQuickPanelTestDefaults = [[NSUserDefaults alloc] initWithSuiteName:suite];
        CSQuickPanelTestResourceDirectory = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]];
        [CSQuickPanelTestDefaults removePersistentDomainForName:suite];
        @try {
            CSRequire(!CSQuickPanelTestPreferences.enabled, @"feature is opt-in");
            CSRequire(CSQuickPanelTestPreferences.triggerLocations == CSQuickPanelTriggerHome, @"default location is home");
            NSArray *expected = @[@"scan", @"wallet", @"moments", @"my_qrcode", @"favorites", @"plugin_home", @"profile", @"panel_settings"];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:expected], @"default entries and order");
            CSRequire([CSQuickPanelTestDefaults persistentDomainForName:suite].count == 0, @"reading defaults does not persist them");

            NSArray *all = CSQuickPanelTestPreferences.allActionIdentifiers;
            NSArray *legacyIdentifiers = @[@"scan", @"wallet", @"moments", @"my_qrcode", @"favorites", @"plugin_home", @"profile", @"create_group", @"add_friend", @"emoji_store", @"panel_settings"];
            NSArray *newIdentifiers = @[@"payment_code", @"channels", @"file_transfer", @"chat_background"];
            CSRequire(all.count == 15 && [NSSet setWithArray:all].count == 15, @"catalog has 15 stable unique identifiers");
            CSRequire([all isEqual:[legacyIdentifiers arrayByAddingObjectsFromArray:newIdentifiers]], @"catalog preserves all existing identifiers and appends new actions");
            NSArray *titles = @[@"扫一扫", @"钱包", @"朋友圈", @"我的二维码", @"收藏", @"插件主页", @"个人资料", @"发起群聊", @"添加朋友", @"表情商店", @"面板设置", @"付款码", @"视频号", @"文件传输助手", @"聊天背景"];
            [all enumerateObjectsUsingBlock:^(NSString *identifier, NSUInteger index, BOOL *stop) {
                (void)stop;
                CSRequire([[CSQuickPanelTestPreferences titleForActionIdentifier:identifier] isEqual:titles[index]], @"catalog Chinese title");
                CSRequire([CSQuickPanelTestPreferences symbolNameForActionIdentifier:identifier].length > 0, @"each action has a symbol");
            }];
            CSRequire([CSQuickPanelTestPreferences titleForActionIdentifier:@"unknown"] == nil, @"unknown action has no title");

            [CSQuickPanelTestDefaults setObject:legacyIdentifiers forKey:CSQuickPanelSelectedActionIdentifiersKey];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:legacyIdentifiers], @"saved 11-action selection does not acquire new actions");
            NSArray *savedOrder = @[@"panel_settings", @"profile", @"scan"];
            [CSQuickPanelTestDefaults setObject:savedOrder forKey:CSQuickPanelSelectedActionIdentifiersKey];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:savedOrder], @"saved custom selection retains its order without new actions");
            CSRequire([[CSQuickPanelTestDefaults objectForKey:CSQuickPanelSelectedActionIdentifiersKey] isEqual:savedOrder], @"reading a saved selection does not migrate its stored value");
            NSArray *savedFourteen = [all subarrayWithRange:NSMakeRange(0, 14)];
            [CSQuickPanelTestDefaults setObject:savedFourteen forKey:CSQuickPanelSelectedActionIdentifiersKey];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:savedFourteen], @"saved 14-action selection does not acquire the fifteenth action");
            [CSQuickPanelTestDefaults setObject:@[@"file_transfer", @"scan", @"payment_code", @"channels"] forKey:CSQuickPanelSelectedActionIdentifiersKey];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:@[@"file_transfer", @"scan", @"payment_code", @"channels"]], @"restored new actions keep their selected order");

            [CSQuickPanelTestDefaults setObject:@"YES" forKey:CSQuickPanelEnabledKey];
            CSRequire(!CSQuickPanelTestPreferences.enabled, @"malformed enable value is rejected");
            [CSQuickPanelTestDefaults setObject:@"home" forKey:CSQuickPanelTriggerLocationsKey];
            CSRequire(CSQuickPanelTestPreferences.triggerLocations == CSQuickPanelTriggerHome, @"malformed locations use safe default");
            [CSQuickPanelTestDefaults setObject:@[@"favorites", @"unknown", @"scan", @"favorites", @17, @"panel_settings"] forKey:CSQuickPanelSelectedActionIdentifiersKey];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:@[@"favorites", @"scan", @"panel_settings"]], @"corrupt restored arrays filter invalid values without changing order");
            [CSQuickPanelTestDefaults setObject:@"scan" forKey:CSQuickPanelSelectedActionIdentifiersKey];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:expected], @"invalid container uses default catalog");

            [CSQuickPanelTestPreferences setSelectedActionIdentifiers:@[]];
            CSRequire(CSQuickPanelTestPreferences.selectedActionIdentifiers.count == 0, @"intentional empty selection stays empty");
            [CSQuickPanelTestPreferences setSelectedActionIdentifiers:@[@"profile", @"profile", @"scan", @"missing"]];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:@[@"profile", @"scan"]], @"setter normalizes duplicates and unknown actions");
            [CSQuickPanelTestPreferences setSelectedActionIdentifiers:@[@"channels", @"payment_code", @"file_transfer", @"channels", @"missing"]];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:@[@"channels", @"payment_code", @"file_transfer"]], @"setter accepts new actions while normalizing duplicates and unknown values");
            [CSQuickPanelTestPreferences setSelectedActionIdentifiers:all];
            CSRequire([CSQuickPanelTestPreferences.selectedActionIdentifiers isEqual:all], @"all 15 actions can be selected without truncation");
            [CSQuickPanelTestPreferences setTriggerLocations:0];
            CSRequire(CSQuickPanelTestPreferences.triggerLocations == CSQuickPanelTriggerHome, @"at least one location survives zero input");
            [CSQuickPanelTestPreferences setTriggerLocations:1 << 7];
            CSRequire(CSQuickPanelTestPreferences.triggerLocations == CSQuickPanelTriggerHome, @"unknown-only location flags use home");
            [CSQuickPanelTestPreferences setTriggerLocations:CSQuickPanelTriggerChat | (1 << 7)];
            CSRequire(CSQuickPanelTestPreferences.triggerLocations == CSQuickPanelTriggerChat, @"unknown flags are stripped");
            CSDrainNotifications();

            __block NSUInteger notifications = 0;
            __block BOOL onMain = YES;
            id token = [NSNotificationCenter.defaultCenter addObserverForName:CSQuickPanelPreferencesDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
                (void)note;
                notifications++;
                onMain = onMain && NSThread.isMainThread;
            }];
            [CSQuickPanelTestPreferences setEnabled:YES];
            [CSQuickPanelTestPreferences setTriggerLocations:CSQuickPanelTriggerHome | CSQuickPanelTriggerChat];
            [CSQuickPanelTestPreferences setSelectedActionIdentifiers:@[]];
            CSRequire(notifications == 0, @"setters do not synchronously notify UI observers");
            CSDrainNotifications();
            CSRequire(notifications == 1 && onMain, @"multiple writes coalesce to one main-queue notification");
            [CSQuickPanelTestPreferences setEnabled:YES];
            [CSQuickPanelTestPreferences setSelectedActionIdentifiers:@[]];
            CSDrainNotifications();
            CSRequire(notifications == 1, @"identical writes do not notify again");
            [NSNotificationCenter.defaultCenter removeObserver:token];
            CSRequire(CSQuickPanelTestPreferences.enabled && CSQuickPanelTestPreferences.triggerLocations == (CSQuickPanelTriggerHome | CSQuickPanelTriggerChat), @"all selected locations remain enabled");
            CSVerifyBackgroundPreferences(suite);
            CSVerifyForegroundPreferences(suite);
            NSLog(@"PASS: quick panel preferences (isolated defaults suite)");
        } @finally {
            [CSQuickPanelTestDefaults removePersistentDomainForName:suite];
            CSQuickPanelTestDefaults = nil;
            [NSFileManager.defaultManager removeItemAtURL:CSQuickPanelTestResourceDirectory error:NULL];
            CSQuickPanelTestResourceDirectory = nil;
        }
    }
    return 0;
}
