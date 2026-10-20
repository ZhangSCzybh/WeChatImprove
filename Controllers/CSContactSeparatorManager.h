#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kContactSeparatorOverridesKey;

@interface CSContactSeparatorConfig : NSObject <NSCopying>

@property (nonatomic, copy, nullable) NSString *separatorText;
@property (nonatomic, copy, nullable) NSString *separatorImagePath;
@property (nonatomic, assign) CGFloat separatorSize;
@property (nonatomic, assign) CGFloat avatarSpacing;
@property (nonatomic, assign) CGFloat verticalOffset;
@property (nonatomic, assign) BOOL enabled;

+ (instancetype)configWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)toDictionary;

@end

@interface CSContactSeparatorManager : NSObject

+ (instancetype)sharedManager;

- (nullable CSContactSeparatorConfig *)configForContactId:(NSString *)contactId;
- (void)setConfig:(nullable CSContactSeparatorConfig *)config forContactId:(NSString *)contactId;
- (void)removeConfigForContactId:(NSString *)contactId;
- (void)resetAllToDefault;

- (NSString *)separatorTextForContactId:(NSString *)contactId;
- (UIImage * _Nullable)separatorImageForContactId:(NSString *)contactId;
- (NSString * _Nullable)separatorImagePathForContactId:(NSString *)contactId;
- (CGFloat)separatorSizeForContactId:(NSString *)contactId;
- (CGFloat)avatarSpacingForContactId:(NSString *)contactId;
- (CGFloat)verticalOffsetForContactId:(NSString *)contactId;
- (BOOL)hasCustomConfigForContactId:(NSString *)contactId;

- (NSArray<NSString *> *)allContactIdsWithCustomConfig;

@end

NS_ASSUME_NONNULL_END
