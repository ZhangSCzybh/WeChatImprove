#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Main-thread snapshot of one independent voice favorite. Native objects are retained read-only.
@interface CSFavoriteVoiceContext : NSObject
@property(nonatomic, copy, readonly) NSString *accountID;
@property(nonatomic, readonly) NSUInteger accountEpoch;
@property(nonatomic, readonly) unsigned int localID;
@property(nonatomic, readonly) unsigned int favoriteID;
@property(nonatomic, copy, readonly) NSString *dataID;
@property(nonatomic, copy, readonly) NSString *dataMD5;
@property(nonatomic, copy, readonly) NSString *stableIdentity;
@property(nonatomic, readonly) unsigned int durationMilliseconds;
@property(nonatomic, readonly) unsigned int format;
@property(nonatomic, readonly) BOOL formatKnown;
@property(nonatomic, readonly) unsigned int expectedBytes;
@property(nonatomic, strong, readonly) id sourceItem;
@property(nonatomic, strong, readonly) id dataItem;
+ (nullable id)standaloneItemForListObject:(id)object;
+ (nullable instancetype)contextWithItem:(id)item accountID:(NSString *)accountID accountEpoch:(NSUInteger)epoch;
- (BOOL)matchesItem:(id)item;
- (nullable id)dataItemInItem:(id)item;
@end
NS_ASSUME_NONNULL_END
