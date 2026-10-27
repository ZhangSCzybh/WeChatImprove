// Research contract only; not included in the tweak build.
// Recovered from WeChat 8.0.78 Objective-C metadata. See methods.json for IMPs.
@interface CMessageWrap : NSObject
- (NSString *)GetChatName; // @16@0:8
- (void)ChangeForDisplay; // v16@0:8; invoke only on a verified independent copy
@end
@interface MainFrameCellData : NSObject
@property(nonatomic,strong) id m_sessionInfo;
@property(nonatomic,copy) NSString *m_textForMessageLabel;
@property(nonatomic,copy) NSString *m_prefixTextForQuoteMessage;
- (void)makeTextForQuoteMessage; // v16@0:8
+ (NSString *)digestForMsg:(CMessageWrap *)message withSender:(NSString *)sender; // @32@0:8@16@24
@end
@interface MainFrameItemView : UIView
- (void)quoteMessageLable:(UILabel *)messageLabel prefixText:(NSString *)prefix; // v32@0:8@16@24
- (void)removeQuoteMessageLabel; // v16@0:8
@end
