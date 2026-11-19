#import <UIKit/UIKit.h>

// Only WeChat's private objects and the controller presentation boundary are doubles.
// Views, labels, layers, text measurement, table caching and gestures use real UIKit.
@interface ClownPresentationWrap : NSObject
@property(nonatomic, copy) NSString *m_nsFromUsr;
@property(nonatomic, copy) NSString *m_nsToUsr;
@property(nonatomic, copy) NSString *m_nsContent;
@property(nonatomic, copy) NSString *m_nsRealChatUsr;
@property(nonatomic, copy) NSData *m_dtImg;
@property(nonatomic) unsigned int m_uiMessageType, m_uiMesLocalID, m_uiCreateTime;
@property(nonatomic) long long m_n64MesSvrID;
@end

@interface ClownPresentationModel : NSObject
@property(nonatomic, strong) ClownPresentationWrap *messageWrap;
@property(nonatomic) CGSize contentTextSize, thumbImageSize, contentViewSize;
@property(nonatomic, strong) UIFont *contentTextFont;
@property(nonatomic, strong) UIColor *contentTextColor;
@property(nonatomic, copy) NSString *originContentText, *contentText;
@property(nonatomic, copy) NSArray *subViewModels;
@property(nonatomic, copy) NSArray<NSNumber *> *nativeHeights;
@property(nonatomic) BOOL isRecordDetail;
- (id)cellDataForRow:(unsigned long long)row;
- (long long)numberOfRowsInSection;
@end

@interface ClownPresentationSplit : NSObject
@property(nonatomic, weak) ClownPresentationModel *parentModel;
@property(nonatomic) double startHeight;
@end

@interface ClownPresentationTimeModel : NSObject
@property(nonatomic) double showingTime;
@property(nonatomic, copy) NSString *timeText;
@property(nonatomic, copy) NSArray<NSNumber *> *nativeHeights;
@end

@class BaseMsgContentViewController;
@interface ClownPresentationCell : UIView
@property(nonatomic, strong) id viewModel;
@property(nonatomic, weak) BaseMsgContentViewController *testOwner;
@property(nonatomic, strong) UIView *nativeContent;
@property(nonatomic, strong) UIImageView *nativeBubble;
@property(nonatomic, strong) UILabel *nativeText;
- (id)getViewController;
- (id)getCurrentMessageWrap;
- (id)getContentView;
- (id)getBgImageView;
- (id)getRichTextView;
@end

@interface ImageMessageCellView : ClownPresentationCell {
@public UIImageView *m_imageView;
}
@end
@interface WCPayTransferMessageCellView : ClownPresentationCell {
@public UILabel *m_titleLabel;
@public UILabel *m_descLabel;
}
@end
@interface ChatTimeCellView : ClownPresentationCell {
@public UILabel *m_timeLabel;
}
@property(nonatomic, strong) UITapGestureRecognizer *nativeTimeTap;
- (void)installNativeTimeTap;
- (void)renderNativeTime;
- (void)handleNativeTimeTap:(UITapGestureRecognizer *)gesture;
@end

// Native menu object only; production menu selection and captured targets remain unchanged.
@interface MMMenuItem : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) id iconImage;
@property(nonatomic, weak) id target;
@property(nonatomic) SEL action;
@property(nonatomic) unsigned int menuType;
- (instancetype)initWithTitle:(NSString *)title icon:(id)icon target:(id)target action:(SEL)action;
@end

@interface ClownPresentationTableCell : UITableViewCell
@property(nonatomic, strong) UIView *cellView;
@end
@interface ClownPresentationTable : UITableView
@property(nonatomic) NSUInteger testReloadCount;
@end

@interface BaseMsgContentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, copy) NSString *testChat;
@property(nonatomic, copy) NSArray *testNodes;
@property(nonatomic, strong) ClownPresentationTable *testTable;
@property(nonatomic, strong) NSMutableDictionary<NSIndexPath *, ClownPresentationCell *> *testViews;
@property(nonatomic, strong) UIViewController *testPresented;
@property(nonatomic) NSUInteger testPresentationCount;
@property(nonatomic) BOOL timeDetailMode;
@property(nonatomic) NSUInteger nativeTimeToggleCount;
@property(nonatomic) double lastNativeTimeToggleTimestamp;
- (id)getCurrentChatName;
- (id)GetMessageNodeDataArray;
- (id)getTableView;
- (id)getMsgTableView;
- (BOOL)isNeedShowTimeInDetail;
- (void)toggleTimeShowMode:(double)timestamp;
- (void)AsyncSendMessage:(id)text replyingMsg:(id)reply referPartialInfo:(id)partial isPasted:(BOOL)pasted;
@end

@interface MMContext : NSObject
+ (NSString *)currentUserName;
+ (void)setTestAccount:(NSString *)account;
@end

// The system Photos service needs a fully launched app. Its presentation object
// alone is substituted; production picker callbacks and UIKit rendering stay real.
@interface ClownPresentationPhotoController : UIViewController
@property(nonatomic, weak) id delegate;
@end

FOUNDATION_EXPORT void ClownPresentationInstallPresentationBoundary(void);
FOUNDATION_EXPORT BOOL ClownPresentationInvokeAction(UIAlertController *alert, NSUInteger index);
// Uses real UIKit hit-testing, then invokes only the native private-object tap boundary.
FOUNDATION_EXPORT BOOL ClownPresentationTapNativeTime(ChatTimeCellView *cell, CGPoint point);
