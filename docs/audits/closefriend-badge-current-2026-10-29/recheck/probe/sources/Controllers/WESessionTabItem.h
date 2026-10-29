#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WETabType) {
    WETabTypeAll = 0,
    WETabTypeGroup,
    WETabTypePrivate,
    WETabTypeOfficial,
    WETabTypeCustom
};

@interface WESessionTabItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *tabId;
@property (nonatomic, copy) NSString *tabName;
@property (nonatomic, assign) WETabType type;
@property (nonatomic, strong) NSArray<NSString *> *sessionUserNames;
@property (nonatomic, assign) NSInteger sortOrder;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *updateTime;

+ (instancetype)tabWithType:(WETabType)type;
+ (instancetype)customTabWithName:(NSString *)name sessionUserNames:(NSArray<NSString *> *)userNames;

- (NSString *)displayName;
- (BOOL)isPresetTab;

@end
