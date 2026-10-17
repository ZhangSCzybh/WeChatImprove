#import <Foundation/Foundation.h>
#import <TargetConditionals.h>
NS_ASSUME_NONNULL_BEGIN
@class CSSettingSection, UITableViewController;
// Explicitly enabled, bounded in-memory observations. Never retain native objects,
// message text, account/chat/message IDs, file paths, hashes or media bytes.
@interface CSMessageActionDiagnostics : NSObject
+ (BOOL)isEnabled;
+ (void)setEnabled:(BOOL)enabled;
+ (void)record:(NSString *)stage fields:(NSDictionary<NSString *, id> *)fields;
+ (NSString *)report;
#if TARGET_OS_IOS
+ (CSSettingSection *)settingsSectionForController:(UITableViewController *)controller;
#endif
@end
NS_ASSUME_NONNULL_END
