#import "CSMessageActionContext.h"
NS_ASSUME_NONNULL_BEGIN
@interface CSMessageVoiceResource : NSObject
@property(nonatomic, copy, readonly) NSData *data;
// Native m_uiVoiceTime and XML voicelength are milliseconds. Never infer units by magnitude.
@property(nonatomic, readonly) unsigned int durationMilliseconds;
@property(nonatomic, readonly) unsigned int format;
- (instancetype)initWithData:(NSData *)data durationMilliseconds:(unsigned int)duration format:(unsigned int)format;
@end
@interface CSMessageMediaProvider : NSObject
- (instancetype)initWithReader:(NSData * _Nullable (^)(NSString *path))reader;
- (instancetype)init;
// Native getters are snapshotted on main; only immutable bytes/path enter the single serial IO queue.
- (void)prepareVoiceForContext:(CSMessageActionContext *)context operationID:(NSString *)operationID
    completion:(void (^)(CSMessageVoiceResource * _Nullable resource))completion;
- (void)prepareAppDataForContext:(CSMessageActionContext *)context operationID:(NSString *)operationID
    completion:(void (^)(NSData * _Nullable data, NSString * _Nullable path))completion;
- (void)cancelOperationID:(NSString *)operationID;
- (void)downloadCompletedForAccount:(NSString *)account epoch:(NSUInteger)epoch chat:(NSString *)chat
    localID:(unsigned int)localID serverID:(long long)serverID;
@property(nonatomic, copy, nullable) void (^waitingHandler)(NSString *operationID);
@property(nonatomic, copy, nullable) void (^requestDownload)(CSMessageActionContext *context);
@end
NS_ASSUME_NONNULL_END
