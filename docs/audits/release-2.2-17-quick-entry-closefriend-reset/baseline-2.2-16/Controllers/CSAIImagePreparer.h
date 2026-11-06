#import "CSAIClient.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^CSAIImageCompletion)(NSString * _Nullable dataURL, NSError * _Nullable error);
@protocol CSAIImagePreparing <NSObject>
// The event must contain imageSource and a main-thread imageStillValid block.
// Cancellation suppresses completion and detaches only this operation's downloader delegate.
// Source failures complete with an error while that account/batch lease is valid.
- (id<CSAICancellable>)prepareImageForEvent:(NSDictionary *)event completion:(CSAIImageCompletion)completion;
@end

@interface CSAIImagePreparer : NSObject <CSAIImagePreparing>
// Native seams run on main; file reading and encoding run on one serial queue.
// Defaults use the current native account, image paths and silent image downloader.
@property(nonatomic,copy) NSString * _Nullable (^currentAccount)(void);
@property(nonatomic,copy) NSArray<NSString *> * (^imagePaths)(id source);
@property(nonatomic,copy) id<CSAICancellable> _Nullable (^requestDownload)(NSDictionary *event, BOOL (^valid)(void), void (^result)(id _Nullable wrap, NSError * _Nullable error));
@property(nonatomic,copy) NSData * _Nullable (^reader)(NSString *path, BOOL (^cancelled)(void));
@property(nonatomic,copy) NSString * _Nullable (^encoder)(NSData *data, BOOL (^cancelled)(void), NSError * _Nullable * _Nullable error);
@property(nonatomic) NSTimeInterval downloadTimeout; // Default 20s, bounded to at most 30s.
@end
NS_ASSUME_NONNULL_END
