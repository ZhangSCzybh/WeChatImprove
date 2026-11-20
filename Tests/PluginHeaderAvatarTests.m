#import <Foundation/Foundation.h>

// Foundation-only doubles; this test performs no networking, preferences or disk I/O.
@interface UIImage : NSObject
@property(nonatomic, copy) NSString *name;
+ (instancetype)named:(NSString *)name;
@end
@implementation UIImage
+ (instancetype)named:(NSString *)name { UIImage *image=[self new]; image.name=name; return image; }
@end
@interface UIImageView : NSObject
@property(nonatomic, strong) UIImage *image;
@end
@implementation UIImageView @end
@interface CSPluginHeaderView : NSObject
@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic) NSUInteger resets;
- (void)resetAvatarImage;
@end
@implementation CSPluginHeaderView
- (instancetype)init { if ((self=[super init])) _avatarImageView=[UIImageView new]; return self; }
- (void)resetAvatarImage { self.resets++; self.avatarImageView.image=[UIImage named:@"placeholder"]; }
@end
@interface TraitFixture : NSObject
@property(nonatomic) double displayScale;
@end
@implementation TraitFixture @end

@interface CSNavigationImageRequest : NSObject
@property(nonatomic) BOOL cancelled;
@property(nonatomic, copy) void (^completion)(UIImage *, NSURL *);
@property(nonatomic, strong) NSURL *URL;
@property(nonatomic, copy) NSString *scope;
@property(nonatomic) NSUInteger maxPixelSize;
- (void)cancel;
@end
@implementation CSNavigationImageRequest
- (void)cancel { self.cancelled=YES; }
@end
@interface CSNavigationImageLoader : NSObject
@property(nonatomic, strong) NSMutableArray<CSNavigationImageRequest *> *requests;
+ (instancetype)sharedLoader;
- (CSNavigationImageRequest *)loadURL:(NSURL *)URL fallbackFileURL:(NSURL *)fallback scope:(NSString *)scope
                        maxPixelSize:(NSUInteger)pixels completion:(void (^)(UIImage *, NSURL *))completion;
@end
@implementation CSNavigationImageLoader
+ (instancetype)sharedLoader {
    static CSNavigationImageLoader *loader; static dispatch_once_t once;
    dispatch_once(&once, ^{ loader=[self new]; loader.requests=[NSMutableArray array]; });
    return loader;
}
- (CSNavigationImageRequest *)loadURL:(NSURL *)URL fallbackFileURL:(NSURL *)fallback scope:(NSString *)scope
                        maxPixelSize:(NSUInteger)pixels completion:(void (^)(UIImage *, NSURL *))completion {
    (void)fallback;
    CSNavigationImageRequest *request=[CSNavigationImageRequest new];
    request.URL=URL; request.scope=scope; request.maxPixelSize=pixels; request.completion=completion;
    [self.requests addObject:request];
    return request;
}
@end

static BOOL backupReady=YES, suspended;
static NSUInteger accountEpoch=7;
static NSString *currentAccount=@"account-a", *currentURL=@"https://example.invalid/a.png";
static BOOL CSBackupIsReady(void) { return backupReady; }
static BOOL CSBackupAccountIsSuspended(void) { return suspended; }
static NSUInteger CSBackupAccountEpoch(void) { return accountEpoch; }
@interface CSUserInfoHelper : NSObject
+ (NSString *)getUserWXID;
+ (NSString *)getUserAvatarURL;
@end
@implementation CSUserInfoHelper
+ (NSString *)getUserWXID { return currentAccount; }
+ (NSString *)getUserAvatarURL { return currentURL; }
@end

@interface CSCustomViewController : NSObject
@property(nonatomic, copy) NSArray *avatarIdentity;
@property(nonatomic, strong) CSNavigationImageRequest *avatarRequest;
@property(nonatomic, strong) CSPluginHeaderView *headerView;
@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) TraitFixture *traitCollection;
- (void)loadHeaderAvatarForAccount:(NSString *)account URLString:(NSString *)URLString epoch:(NSUInteger)epoch;
@end
@implementation CSCustomViewController
#include "HeaderAvatarUnderTest.h"
@end

static NSUInteger checks, failures;
static void Check(BOOL result, NSString *message) {
    checks++;
    if (!result) { failures++; fprintf(stderr, "FAIL: %s\n", message.UTF8String); }
}
static CSCustomViewController *Controller(void) {
    backupReady=YES; suspended=NO; accountEpoch=7;
    currentAccount=@"account-a"; currentURL=@"https://example.invalid/a.png";
    CSCustomViewController *controller=[CSCustomViewController new];
    controller.headerView=[CSPluginHeaderView new]; controller.avatarImageView=controller.headerView.avatarImageView;
    controller.traitCollection=[TraitFixture new]; controller.traitCollection.displayScale=3;
    return controller;
}
static void LoadCurrent(CSCustomViewController *controller) {
    [controller loadHeaderAvatarForAccount:currentAccount URLString:currentURL epoch:accountEpoch];
}
static void Finish(CSNavigationImageRequest *request, NSString *name) {
    request.completion(name ? [UIImage named:name] : nil, request.URL);
}
static BOOL IsPlaceholder(CSCustomViewController *controller) {
    return [controller.avatarImageView.image.name isEqual:@"placeholder"];
}

int main(void) { @autoreleasepool {
    CSCustomViewController *controller=Controller();
    NSUInteger before=CSNavigationImageLoader.sharedLoader.requests.count;
    LoadCurrent(controller);
    CSNavigationImageRequest *first=controller.avatarRequest;
    Check(first!=nil && CSNavigationImageLoader.sharedLoader.requests.count==before+1, @"first identity starts one request");
    Check([first.scope isEqual:currentAccount] && [first.URL.absoluteString isEqual:currentURL] && first.maxPixelSize==180,
          @"request retains account scope, URL and display pixel size");
    Check(IsPlaceholder(controller) && controller.headerView.resets==1, @"new identity resets the existing avatar view to placeholder");
    LoadCurrent(controller);
    Check(controller.avatarRequest==first && !first.cancelled && controller.headerView.resets==1 &&
          CSNavigationImageLoader.sharedLoader.requests.count==before+1, @"same identity neither restarts nor cancels an in-flight request");

    currentURL=@"https://example.invalid/new-a.png";
    LoadCurrent(controller);
    CSNavigationImageRequest *second=controller.avatarRequest;
    Check(first.cancelled && second && second!=first && controller.headerView.resets==2, @"URL change cancels old request and resets avatar");
    NSArray *secondIdentity=controller.avatarIdentity;
    Finish(first, @"stale-url");
    Check(controller.avatarRequest==second && IsPlaceholder(controller), @"old URL callback cannot clear the new request or replace placeholder");
    Finish(first, nil);
    Check(controller.avatarRequest==second && [controller.avatarIdentity isEqual:secondIdentity], @"old failure callback cannot invalidate new identity");
    Finish(second, @"new-url");
    Check(controller.avatarRequest==nil && [controller.avatarImageView.image.name isEqual:@"new-url"], @"current successful callback updates image and clears its request");
    Finish(first, @"late-old-success");
    Check([controller.avatarImageView.image.name isEqual:@"new-url"], @"old callback cannot overwrite a newer completed avatar");
    before=CSNavigationImageLoader.sharedLoader.requests.count;
    LoadCurrent(controller);
    Check(CSNavigationImageLoader.sharedLoader.requests.count==before && [controller.avatarImageView.image.name isEqual:@"new-url"],
          @"already loaded identity stays visible without another download");

    currentAccount=@"account-b";
    LoadCurrent(controller);
    CSNavigationImageRequest *accountRequest=controller.avatarRequest;
    Check(accountRequest && IsPlaceholder(controller) && [accountRequest.scope isEqual:@"account-b"], @"account change requests an account-scoped avatar");
    accountEpoch++;
    LoadCurrent(controller);
    CSNavigationImageRequest *epochRequest=controller.avatarRequest;
    Check(accountRequest.cancelled && epochRequest && epochRequest!=accountRequest, @"epoch change cancels old request even when account and URL match");
    Finish(accountRequest, @"stale-account-epoch");
    Check(controller.avatarRequest==epochRequest && IsPlaceholder(controller), @"previous epoch callback cannot clear current request");
    Finish(epochRequest, @"account-b");
    Check([controller.avatarImageView.image.name isEqual:@"account-b"], @"current account and epoch callback updates avatar");

    // Each case changes live state without refreshing the view; the callback must
    // revalidate real account state instead of trusting its captured identity.
    for (NSString *change in @[@"suspended", @"startup", @"epoch", @"account", @"URL"]) {
        controller=Controller(); LoadCurrent(controller);
        CSNavigationImageRequest *pending=controller.avatarRequest;
        if ([change isEqual:@"suspended"]) suspended=YES;
        else if ([change isEqual:@"startup"]) backupReady=NO;
        else if ([change isEqual:@"epoch"]) accountEpoch++;
        else if ([change isEqual:@"account"]) currentAccount=@"different-account";
        else currentURL=@"https://example.invalid/different.png";
        Finish(pending, @"must-be-rejected");
        Check(IsPlaceholder(controller), [NSString stringWithFormat:@"live %@ change rejects stale image completion", change]);
    }

    controller=Controller(); LoadCurrent(controller);
    CSNavigationImageRequest *failed=controller.avatarRequest;
    Finish(failed, nil);
    Check(IsPlaceholder(controller) && !controller.avatarIdentity && !controller.avatarRequest, @"failed download releases identity so a later refresh can retry");
    before=CSNavigationImageLoader.sharedLoader.requests.count;
    LoadCurrent(controller);
    Check(controller.avatarRequest && controller.avatarRequest!=failed && CSNavigationImageLoader.sharedLoader.requests.count==before+1,
          @"same account and URL can retry after a failed request");

    CSNavigationImageRequest *retry=controller.avatarRequest;
    [controller loadHeaderAvatarForAccount:nil URLString:nil epoch:accountEpoch];
    Check(retry.cancelled && !controller.avatarRequest && IsPlaceholder(controller), @"anonymous state cancels pending work and clears old account image");
    Finish(retry, @"late-after-logout");
    Check(IsPlaceholder(controller) && !controller.avatarRequest, @"late logged-out callback cannot restore a prior account avatar");
    for (NSArray *invalid in @[@[@"", @"https://example.invalid/anonymous.png"], @[@"account-a", @""],
                              @[@"account-a", @"file:///tmp/unused.png"], @[@"account-a", @"relative.png"]]) {
        before=CSNavigationImageLoader.sharedLoader.requests.count;
        [controller loadHeaderAvatarForAccount:invalid[0] URLString:invalid[1] epoch:accountEpoch];
        Check(IsPlaceholder(controller) && !controller.avatarRequest && CSNavigationImageLoader.sharedLoader.requests.count==before,
              [NSString stringWithFormat:@"anonymous, empty or non-web identity remains placeholder: %@", invalid]);
    }
    controller=Controller(); controller.traitCollection.displayScale=1; LoadCurrent(controller);
    Check(controller.avatarRequest.maxPixelSize==120, @"low-scale screen still requests the minimum safe avatar resolution");
    CSNavigationImageRequest *oldAccountRequest=controller.avatarRequest;
    currentAccount=@"account-b"; LoadCurrent(controller);
    CSNavigationImageRequest *newAccountRequest=controller.avatarRequest;
    Check(oldAccountRequest.cancelled && newAccountRequest && newAccountRequest!=oldAccountRequest,
          @"account change cancels its pending request even when URL and epoch match");
    Finish(oldAccountRequest, @"old-account");
    Check(controller.avatarRequest==newAccountRequest && IsPlaceholder(controller), @"old account completion cannot clear the new account request");
    fprintf(stdout, "Plugin header avatar: %lu checks, %lu failures\n", (unsigned long)checks, (unsigned long)failures);
    return failures ? 1 : 0;
} }
