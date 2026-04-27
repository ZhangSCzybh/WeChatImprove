//
// CSChatRoomSelectViewController.h
// 群聊选择器界面
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CSChatRoomSelectCompletion)(NSArray<NSString *> *selectedUserNames);

@interface CSChatRoomSelectViewController : UITableViewController

@property (nonatomic, copy, nullable) CSChatRoomSelectCompletion completion;

- (instancetype)initWithTitle:(NSString *)title selectedUserNames:(NSArray<NSString *> *)selectedUserNames;

@end

NS_ASSUME_NONNULL_END
