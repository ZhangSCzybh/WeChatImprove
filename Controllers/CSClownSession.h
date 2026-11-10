#import <Foundation/Foundation.h>
#import "CSMessageActionContext.h"

NS_ASSUME_NONNULL_BEGIN

// One chat page owns one main-thread session. Replacements never leave memory.
// The page invalidates its session when its conversation/account is left.
@interface CSClownSession : NSObject
@property(nonatomic, copy, readonly) NSString *accountID;
@property(nonatomic, copy, readonly) NSString *conversationID;
@property(nonatomic, readonly) NSUInteger epoch;
@property(nonatomic, readonly) BOOL active;
- (nullable instancetype)initWithAccountID:(NSString *)accountID conversationID:(NSString *)conversationID NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

// Clear operations invalidate previously captured editor/picker epochs as well.
- (void)invalidate;
- (void)clearText;
- (void)clearImages;
- (void)clearTimes;
- (void)clearAmounts;
- (BOOL)acceptsContext:(nullable CSMessageActionContext *)context;
- (nullable NSString *)textForContext:(nullable CSMessageActionContext *)context;
// A nonnil value adds/replaces; nil removes an existing replacement.
- (BOOL)setText:(nullable NSString *)text forContext:(nullable CSMessageActionContext *)context;
- (nullable id)imageForContext:(nullable CSMessageActionContext *)context;
- (BOOL)setImage:(nullable id)image forContext:(nullable CSMessageActionContext *)context;
- (nullable NSString *)amountForContext:(nullable CSMessageActionContext *)context;
// Amount display strings are copied verbatim; input validation belongs to the editor.
- (BOOL)setAmount:(nullable NSString *)amount forContext:(nullable CSMessageActionContext *)context;
- (nullable NSDate *)dateForTimeModel:(nullable id)model;
- (BOOL)setDate:(nullable NSDate *)date forTimeModel:(nullable id)model;
@end

NS_ASSUME_NONNULL_END
