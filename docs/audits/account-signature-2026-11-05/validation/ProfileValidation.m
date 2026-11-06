#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import "CSProvisioningProfile.h"

// Reuse the unchanged baseline implementation recorded by the independent
// reproduction. Its CLI main is renamed; the parser itself is not rewritten.
#define main CSUnusedLegacyReproductionMain
#include "../legacy-reproduction/LegacyProfileReproduction.m"
#undef main

// These models retain the strings produced by the production controller. They
// deliberately provide no UIKit rendering, lifecycle, or WeChat runtime.
@interface UIColor : NSObject
+ (id)systemBlueColor; + (id)systemGreenColor; + (id)systemOrangeColor;
+ (id)systemIndigoColor; + (id)systemTealColor; + (id)systemPurpleColor;
+ (id)systemCyanColor; + (id)systemRedColor;
@end
@implementation UIColor
+ (id)systemBlueColor { return nil; } + (id)systemGreenColor { return nil; }
+ (id)systemOrangeColor { return nil; } + (id)systemIndigoColor { return nil; }
+ (id)systemTealColor { return nil; } + (id)systemPurpleColor { return nil; }
+ (id)systemCyanColor { return nil; } + (id)systemRedColor { return nil; }
@end
@interface UITableView : NSObject @end
@implementation UITableView @end

@interface CSSettingItem : NSObject
@property (copy) NSString *title;
@property (copy) NSString *detail;
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)name iconColor:(id)color detail:(NSString *)detail;
@end
@implementation CSSettingItem
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)name iconColor:(id)color detail:(NSString *)detail {
    CSSettingItem *item = [self new]; item.title = title; item.detail = detail; return item;
}
@end
@interface CSSettingSection : NSObject
@property (copy) NSString *header;
@property (copy) NSArray<CSSettingItem *> *items;
+ (instancetype)sectionWithHeader:(NSString *)header items:(NSArray *)items;
@end
@implementation CSSettingSection
+ (instancetype)sectionWithHeader:(NSString *)header items:(NSArray *)items {
    CSSettingSection *section = [self new]; section.header = header; section.items = items; return section;
}
@end
@interface CSUserInfoHelper : NSObject
+ (NSString *)getUserNickname; + (NSString *)getUserAliasName; + (NSString *)getUserWXID;
@end
@implementation CSUserInfoHelper
+ (NSString *)getUserNickname { return @"Synthetic nickname"; }
+ (NSString *)getUserAliasName { return @"synthetic-alias"; }
+ (NSString *)getUserWXID { return @"wxid_synthetic"; }
@end
@interface CSAccountDetailViewController : NSObject
@property (strong) NSArray<CSSettingSection *> *sections;
@property (strong) NSArray<CSSettingItem *> *userItems;
@property (strong) NSArray<CSSettingItem *> *appItems;
@property (strong) NSArray<CSSettingItem *> *certItems;
@property (copy) NSString *profileReadMessage;
- (NSString *)determineProfileType:(NSDictionary *)profileDict;
- (NSDictionary *)readProvisioningProfile;
- (NSString *)getDeviceModelIdentifier;
- (void)setupData;
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
@end

// Generated verbatim from the current production controller before compilation.
// The runner also records source and extracted-method SHA-256 values.
#include "ControllerMethods.inc"

static NSMutableArray *checks;
static NSMutableDictionary *observations;
static NSUInteger failed;

static void Check(BOOL passed, NSString *name) {
    [checks addObject:@{@"name": name, @"passed": @(passed)}];
    printf("%s %s\n", passed ? "PASS" : "FAIL", name.UTF8String);
    if (!passed) failed++;
}

static NSData *XML(NSString *body) { return [body dataUsingEncoding:NSUTF8StringEncoding]; }
static NSData *Load(NSString *directory, NSString *name) {
    return [NSData dataWithContentsOfFile:[directory stringByAppendingPathComponent:name]];
}
static NSDictionary *PlainPlist(NSData *data) {
    return [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
}
static NSArray *Rows(CSAccountDetailViewController *controller) {
    NSMutableArray *rows = [NSMutableArray new];
    for (CSSettingItem *item in controller.certItems) {
        [rows addObject:@{@"title": item.title ?: @"", @"detail": item.detail ?: @""}];
    }
    return rows;
}
static BOOL FooterOnlyOnSignature(CSAccountDetailViewController *controller, NSString *expected) {
    return [controller tableView:nil titleForFooterInSection:0] == nil &&
           [controller tableView:nil titleForFooterInSection:1] == nil &&
           [[controller tableView:nil titleForFooterInSection:2] isEqualToString:expected];
}
static BOOL AllRowsMissing(CSAccountDetailViewController *controller) {
    if (controller.certItems.count != 7) return NO;
    for (CSSettingItem *item in controller.certItems) {
        if (![item.detail isEqualToString:@"未读取到证书信息"]) return NO;
    }
    return YES;
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        if (argc != 4) { fputs("usage: profile-validation FIXTURES SCRATCH RESULT_JSON\n", stderr); return 2; }
        checks = [NSMutableArray new]; observations = [NSMutableDictionary new];
        NSString *fixtures = [NSString stringWithUTF8String:argv[1]];
        NSString *scratch = [NSString stringWithUTF8String:argv[2]];
        NSString *resultPath = [NSString stringWithUTF8String:argv[3]];
        printf("Foundation OS: %s\n", NSProcessInfo.processInfo.operatingSystemVersionString.UTF8String);
        observations[@"foundationOS"] = NSProcessInfo.processInfo.operatingSystemVersionString;

        // All expected values come from the source XML used by the sibling's
        // actual, independently verified CMS fixture; no installed profile is used.
        NSDictionary *expectedASCII = PlainPlist(Load(fixtures, @"ascii.plist"));
        NSDictionary *expectedUTF8 = PlainPlist(Load(fixtures, @"utf8.plist"));
        Check(expectedASCII != nil && expectedUTF8 != nil, @"source XML dictionaries are readable");
        for (NSString *label in @[@"ascii", @"utf8"]) {
            NSDictionary *expected = [label isEqualToString:@"ascii"] ? expectedASCII : expectedUTF8;
            for (NSString *extension in @[@"plist", @"mobileprovision"]) {
                NSString *name = [label stringByAppendingPathExtension:extension];
                NSDictionary *actual = CSProvisioningProfileDictionaryFromData(Load(fixtures, name));
                Check([actual isEqual:expected], [@"production parser preserves complete dictionary: " stringByAppendingString:name]);
            }
        }
        NSDictionary *actualUTF8 = CSProvisioningProfileDictionaryFromData(Load(fixtures, @"utf8.mobileprovision"));
        for (NSString *key in @[@"TeamName", @"TeamIdentifier", @"CreationDate", @"ExpirationDate", @"ProvisionedDevices", @"Entitlements"]) {
            Check([actualUTF8[key] isEqual:expectedUTF8[key]], [@"UTF-8 CMS preserves source field: " stringByAppendingString:key]);
        }
        Check([actualUTF8[@"TeamName"] isEqual:@"合成测试签名团队"], @"UTF-8 team retains original Chinese text");
        Check([actualUTF8[@"CreationDate"] isKindOfClass:NSDate.class] &&
              [actualUTF8[@"ExpirationDate"] isKindOfClass:NSDate.class], @"profile dates remain NSDate values");
        Check([actualUTF8[@"Entitlements"][@"get-task-allow"] isKindOfClass:NSNumber.class], @"entitlement Boolean remains a property-list Boolean");

        NSDictionary *legacyASCII = LegacyReadProfile(Load(fixtures, @"ascii.mobileprovision"));
        NSDictionary *legacyUTF8 = LegacyReadProfile(Load(fixtures, @"utf8.mobileprovision"));
        Check([legacyASCII isEqual:expectedASCII], @"unchanged legacy parser baseline reads ASCII CMS");
        Check(legacyUTF8 != nil && ![legacyUTF8[@"TeamName"] isEqual:expectedUTF8[@"TeamName"]], @"regression witness: unchanged legacy parser corrupts UTF-8 team");
        Check([legacyUTF8[@"TeamIdentifier"] isEqual:expectedUTF8[@"TeamIdentifier"]], @"legacy regression does not imply every field disappeared");
        observations[@"legacyUTF8Team"] = legacyUTF8[@"TeamName"] ?: NSNull.null;
        observations[@"fixedUTF8Team"] = actualUTF8[@"TeamName"] ?: NSNull.null;

        Check(CSProvisioningProfileDictionaryFromData(nil) == nil, @"nil input returns nil");
        Check(CSProvisioningProfileDictionaryFromData(NSData.data) == nil, @"empty input returns nil");
        const uint8_t nonPlist[] = {0, 1, 0xff, 0xfe, 0x80, 'b', 'a', 'd'};
        Check(CSProvisioningProfileDictionaryFromData([NSData dataWithBytes:nonPlist length:sizeof nonPlist]) == nil, @"binary input without XML plist returns nil");
        Check(CSProvisioningProfileDictionaryFromData(XML(@"<plist version=\"1.0\"><dict><key>x</key><string>value</string></dict>")) == nil, @"missing closing plist marker returns nil");
        Check(CSProvisioningProfileDictionaryFromData(XML(@"</plist><plist version=\"1.0\"><dict/>")) == nil, @"closing marker before opening marker cannot satisfy parser");
        NSData *arrayXML = XML(@"<plist version=\"1.0\"><array><string>valid XML but wrong root</string></array></plist>");
        id directArray = [NSPropertyListSerialization propertyListWithData:arrayXML options:0 format:NULL error:NULL];
        Check([directArray isKindOfClass:NSArray.class] && CSProvisioningProfileDictionaryFromData(arrayXML) == nil, @"valid array plist is rejected by dictionary root guard");
        NSData *malformed = XML(@"<plist version=\"1.0\"><dict><key>x</key><string>unclosed</dict></plist>");
        NSError *malformedError = nil;
        id directMalformed = [NSPropertyListSerialization propertyListWithData:malformed options:0 format:NULL error:&malformedError];
        observations[@"malformedDirectFoundation"] = @{@"returnedValue": @(directMalformed != nil), @"errorCode": @(malformedError.code), @"error": malformedError.localizedDescription ?: @""};
        Check(directMalformed == nil && CSProvisioningProfileDictionaryFromData(malformed) == nil, @"observed unbalanced XML is rejected by Foundation and production parser");

        NSMutableData *wrapped = [NSMutableData new];
        uint8_t everyByte[256]; for (NSUInteger i = 0; i < sizeof everyByte; i++) everyByte[i] = (uint8_t)i;
        [wrapped appendBytes:everyByte length:sizeof everyByte];
        [wrapped appendData:Load(fixtures, @"utf8.mobileprovision")];
        [wrapped appendBytes:everyByte length:sizeof everyByte];
        Check([CSProvisioningProfileDictionaryFromData(wrapped) isEqual:expectedUTF8], @"every binary byte before and after real UTF-8 CMS leaves dictionary unchanged");
        Check([CSProvisioningProfileDictionaryFromData(Load(fixtures, @"all-byte-prefix-with-xml.bin")) isEqual:expectedASCII], @"existing NUL and high-byte prefix fixture preserves complete ASCII dictionary");
        Check(CSProvisioningProfileDictionaryFromData(Load(fixtures, @"truncated-before-xml-close.mobileprovision")) == nil, @"existing CMS truncated before closing XML marker is rejected");
        // A complete embedded XML span is sufficient by design; this helper is
        // metadata extraction and intentionally does not verify CMS signatures.
        Check([CSProvisioningProfileDictionaryFromData(Load(fixtures, @"truncated-after-xml-close.mobileprovision")) isEqual:expectedASCII], @"documented boundary: complete XML parses without CMS trailer");
        Check(CSProvisioningProfileDictionaryFromData(Load(fixtures, @"utf8-binary.mobileprovision")) == nil, @"documented boundary: CMS with binary-plist payload is unsupported");

        // Prevent the exact bundle-reading method from writing to an unintended
        // directory. The runner places this executable in its private scratch.
        BOOL safeBundle = [NSBundle.mainBundle.bundlePath.stringByStandardizingPath isEqual:scratch.stringByStandardizingPath];
        Check(safeBundle, @"test executable main bundle is the isolated temporary directory");
        if (!safeBundle) return 3;
        NSString *embedded = [scratch stringByAppendingPathComponent:@"embedded.mobileprovision"];
        NSFileManager *fm = NSFileManager.defaultManager;
        [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        CSAccountDetailViewController *controller = [CSAccountDetailViewController new];
        Check([Load(fixtures, @"utf8.mobileprovision") writeToFile:embedded atomically:YES], @"synthetic CMS written only to isolated bundle");
        [controller setupData];
        NSArray *expectedTitles = @[@"允许设备", @"证书类型", @"签名团队", @"团队ID", @"注册时间", @"过期时间", @"授权设备 UDID"];
        NSArray *expectedDetails = @[@"1 台设备", @"个人证书", @"合成测试签名团队", @"SYNTHETIC1", @"2026-01-01 08:00:00", @"2027-01-01 08:00:00", @"0000000000000000000000000000000000000001"];
        Check(controller.sections.count == 3 && controller.userItems.count == 3 && controller.appItems.count == 4, @"production setupData retains three sections and existing account/application rows");
        Check([[controller.certItems valueForKey:@"title"] isEqual:expectedTitles] &&
              [[controller.certItems valueForKey:@"detail"] isEqual:expectedDetails], @"production bundle reader and setupData produce all seven expected signature rows");
        Check(controller.profileReadMessage == nil && [controller tableView:nil titleForFooterInSection:0] == nil &&
              [controller tableView:nil titleForFooterInSection:1] == nil && [controller tableView:nil titleForFooterInSection:2] == nil, @"valid profile has no diagnostic footer in any section");
        observations[@"validSignatureRows"] = Rows(controller);

        Check([fm removeItemAtPath:embedded error:NULL], @"remove only synthetic profile to exercise missing-file path");
        [controller setupData];
        NSString *missingMessage = @"当前安装包未包含签名描述文件，无法显示签名信息。重签时请保留 embedded.mobileprovision。";
        Check(AllRowsMissing(controller), @"missing profile retains seven truthful missing-value rows");
        Check(FooterOnlyOnSignature(controller, missingMessage), @"missing-file explanation appears only below signature section");
        observations[@"missingFooter"] = controller.profileReadMessage ?: NSNull.null;

        Check([malformed writeToFile:embedded atomically:YES], @"malformed synthetic profile written to isolated bundle");
        [controller setupData];
        NSString *malformedMessage = @"当前安装包的签名描述文件无法解析，请检查重签时使用的描述文件。";
        Check(AllRowsMissing(controller) && FooterOnlyOnSignature(controller, malformedMessage), @"malformed profile shows seven missing rows and signature-only parse explanation");
        observations[@"malformedFooter"] = controller.profileReadMessage ?: NSNull.null;

        [fm removeItemAtPath:embedded error:NULL];
        Check([fm createDirectoryAtPath:embedded withIntermediateDirectories:NO attributes:nil error:NULL], @"non-file synthetic path created only inside isolated bundle");
        [controller setupData];
        Check(AllRowsMissing(controller) && FooterOnlyOnSignature(controller, @"暂时无法读取当前安装包的签名描述文件。"), @"non-file read error shows signature-only read explanation");
        observations[@"readErrorFooter"] = controller.profileReadMessage ?: NSNull.null;
        [fm removeItemAtPath:embedded error:NULL];

        // Reuse the same instance to verify diagnostics clear after recovery.
        [Load(fixtures, @"ascii.mobileprovision") writeToFile:embedded atomically:YES];
        [controller setupData];
        Check(controller.profileReadMessage == nil && controller.certItems.count == 7 &&
              [controller.certItems[2].detail isEqual:@"Synthetic Test Team"] &&
              [controller tableView:nil titleForFooterInSection:2] == nil, @"subsequent valid profile clears earlier error message and restores rows");
        Check([[controller determineProfileType:@{@"ProvisionsAllDevices": @YES}] isEqual:@"企业证书"] &&
              [[controller determineProfileType:@{@"ProvisionsAllDevices": @NO}] isEqual:@"App Store"] &&
              [[controller determineProfileType:@{@"ProvisionsAllDevices": @[@YES]}] isEqual:@"App Store"] &&
              [[controller determineProfileType:@{@"ProvisionedDevices": @"not an array"}] isEqual:@"App Store"], @"production certificate classifier checks NSNumber and NSArray before interpreting malformed values");
        [fm removeItemAtPath:embedded error:NULL];

        NSDictionary *result = @{@"passed": @(failed == 0), @"checks": checks, @"checkCount": @(checks.count), @"failureCount": @(failed), @"observations": observations};
        NSData *json = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted | NSJSONWritingSortedKeys error:NULL];
        if (![json writeToFile:resultPath atomically:YES]) return 4;
        printf("Checks: %lu; failures: %lu\n", (unsigned long)checks.count, (unsigned long)failed);
        return failed == 0 ? 0 : 1;
    }
}
