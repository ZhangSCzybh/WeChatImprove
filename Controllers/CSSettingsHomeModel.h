#import <Foundation/Foundation.h>

@class CSSettingSection;

NS_ASSUME_NONNULL_BEGIN

/// A presentation of the current account's already-visible settings, never a second registry.
@interface CSSettingsHomeModel : NSObject
@property(nonatomic) NSUInteger selectedIndex;
@property(nonatomic) BOOL searching;
@property(nonatomic, copy) NSString *query;
@property(nonatomic, copy, readonly) NSArray<CSSettingSection *> *displayedSections;
/// Returns YES when account state changed and transient search/scroll state must be cleared.
- (BOOL)replaceSections:(NSArray<CSSettingSection *> *)sections accountIdentifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
