#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WEContactSelectType) {
    WEContactSelectTypeAll = 0,
    WEContactSelectTypeGroup,
    WEContactSelectTypePrivate,
    WEContactSelectTypeOfficial,
    WEContactSelectTypeTag
};

typedef void (^WEContactSelectCompletion)(NSArray<NSString *> *selectedUserNames);

@interface WEContactSelectViewController : UITableViewController

@property (nonatomic, copy, nullable) WEContactSelectCompletion completion;

- (instancetype)initWithTitle:(NSString *)title
                selectedUserNames:(NSArray<NSString *> *)selectedUserNames
                      selectType:(WEContactSelectType)selectType;

- (instancetype)initWithTitle:(NSString *)title
                selectedUserNames:(NSArray<NSString *> *)selectedUserNames
                      selectType:(WEContactSelectType)selectType
                       tagName:(nullable NSString *)tagName;

@end

NS_ASSUME_NONNULL_END
