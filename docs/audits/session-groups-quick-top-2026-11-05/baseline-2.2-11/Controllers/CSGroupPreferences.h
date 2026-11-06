#import <Foundation/Foundation.h>
#import "WESessionTabItem.h"
NS_ASSUME_NONNULL_BEGIN
/// Account-owned group data. An unknown account presents defaults and cannot write/import.
@interface CSGroupPreferences : NSObject
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults accountID:(nullable NSString *)accountID;
@property (nonatomic, copy, readonly, nullable) NSString *accountID;
@property (nonatomic, copy, readonly) NSArray<WESessionTabItem *> *tabs;
@property (nonatomic, copy, readonly) NSArray<WESessionTabItem *> *customTabs;
@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *presetNames;
@property (nonatomic, copy, readonly) NSArray<NSString *> *tabOrder;
@property (nonatomic, copy, readonly) NSSet<NSString *> *hiddenPresetTabs;
@property (nonatomic, copy) NSString *selectedTabID;
@property (nonatomic) BOOL filterDuplicates;
@property (nonatomic, readonly) BOOL hasLegacyData;
- (void)reload;
/// Returns YES only after the property-list write has been read back successfully.
- (BOOL)saveCustomTabs:(NSArray<WESessionTabItem *> *)customTabs
          presetNames:(NSDictionary<NSString *, NSString *> *)presetNames
             tabOrder:(NSArray<NSString *> *)tabOrder
     hiddenPresetTabs:(NSSet<NSString *> *)hiddenPresetTabs;
/// Explicitly merge legacy IDs; existing account groups/names win. Legacy bytes remain intact.
- (BOOL)importLegacy;
@end
NS_ASSUME_NONNULL_END
