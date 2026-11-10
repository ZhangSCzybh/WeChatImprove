#import "CSMessageActionCoordinator.h"
#import "CSMessageSendAdapter.h"
#import "CSFavoriteVoiceMediaProvider.h"

NS_ASSUME_NONNULL_BEGIN
// Owns only standalone voice favorites. Native chat forwarding remains separately bound.
@interface CSFavoriteVoiceForwardAdapter : NSObject
+ (instancetype)sharedAdapter;
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment
    preferences:(CSMessageActionPreferences *)preferences accountCoordinator:(CSMessageActionCoordinator *)accounts
    mediaProvider:(CSFavoriteVoiceMediaProvider *)media sendAdapter:(CSMessageSendAdapter *)sender;
- (BOOL)canForwardItem:(id)item;
- (void)forwardItem:(id)item fromController:(id)controller;
- (void)withDetailMenuForController:(id)controller perform:(void (^)(void))perform;
- (long long)menuEnableType:(long long)enabled delegate:(id)delegate;
- (void)bindLogic:(id)logic source:(id)source;
- (void)confirmLogic:(id)logic;
- (BOOL)handleLogic:(id)logic source:(id)source target:(id)target;
- (void)finishLogic:(id)logic cancelled:(BOOL)cancelled;
- (BOOL)suppressesNativeSuccessForLogic:(id)logic;
- (void)downloadFinishedForItem:(id)item error:(int)error;
- (void)cancelOperationID:(NSString *)operationID;
- (void)cancelAll;
// Injectable native presenter and feedback for execution tests. The default uses ForwardMessageMgr.
@property(nonatomic, copy, nullable) BOOL (^presentVoiceWrap)(id wrap, id controller);
@property(nonatomic, copy, nullable) void (^feedbackHandler)(NSString *message);
@end
NS_ASSUME_NONNULL_END
