#import "CSMessageActionContext.h"
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString * _Nullable CSMessageForwardTargetID(id _Nullable contact);
@interface CSMessageForwardBinding : NSObject
@property(nonatomic, copy) NSString *operationID;
@property(nonatomic, weak) id logic;
@property(nonatomic, strong, nullable) CSMessageActionContext *context;
@property(nonatomic, copy, nullable) NSDictionary<NSString *, id> *targets;
@property(nonatomic) BOOL confirmed;
@property(nonatomic) BOOL cancelled;
@property(nonatomic) BOOL closed;
@property(nonatomic) BOOL enhanced;
@end
@interface CSVoiceForwardAdapter : NSObject
- (BOOL)bindLogic:(id)logic operationID:(NSString *)operationID context:(CSMessageActionContext *)context;
- (nullable CSMessageForwardBinding *)bindingForLogic:(id)logic;
- (BOOL)confirmLogic:(id)logic;
- (void)detachLogic:(id)logic;
- (BOOL)source:(id)source matchesBinding:(CSMessageForwardBinding *)binding;
- (BOOL)source:(id)source matchesContext:(CSMessageActionContext *)context;
@end
NS_ASSUME_NONNULL_END
