#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <objc/runtime.h>
#import "CSNavigationImageLoader.h"
static NSUInteger checks,decoded,mainDecodes,networkStarts,networkStops;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); exit(1); } } while (0)
NSString *const UIApplicationDidReceiveMemoryWarningNotification=@"NavigationMemoryWarning";
@implementation UIImage { CGImageRef _image; }
+ (instancetype)imageWithCGImage:(CGImageRef)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation {
    (void)scale;(void)orientation;
    @synchronized(self) { decoded++;if (NSThread.isMainThread) mainDecodes++; }
    UIImage *value=[self new];value->_image=CGImageRetain(image);return value;
}
+ (instancetype)imageNamed:(NSString *)name { (void)name;static UIImage *placeholder;static dispatch_once_t once;dispatch_once(&once,^{placeholder=[self new];});return placeholder; }
- (CGImageRef)CGImage { return _image; }
- (void)dealloc { if (_image) CGImageRelease(_image); }
@end
@implementation UIImageView @end
@implementation UIScreen
+ (instancetype)mainScreen { static UIScreen *screen;static dispatch_once_t once;dispatch_once(&once,^{screen=[self new];});return screen; }
- (CGFloat)scale { return 2; }
@end
static NSData *PNG(CGFloat red) {
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(NULL,400,200,8,1600,space,(CGBitmapInfo)kCGImageAlphaPremultipliedLast);CGColorSpaceRelease(space);
    CGContextSetRGBFillColor(context,red,.3,.7,1);CGContextFillRect(context,CGRectMake(0,0,400,200));
    CGImageRef image=CGBitmapContextCreateImage(context);CGContextRelease(context);
    NSMutableData *data=[NSMutableData data];
    CGImageDestinationRef dest=CGImageDestinationCreateWithData((__bridge CFMutableDataRef)data,CFSTR("public.png"),1,NULL);
    CGImageDestinationAddImage(dest,image,NULL);CGImageDestinationFinalize(dest);CFRelease(dest);CGImageRelease(image);
    return data;
}
static NSData *fixture;
@interface ImageProtocol : NSURLProtocol
@property(atomic) BOOL stopped;
@end
@implementation ImageProtocol
+ (BOOL)canInitWithRequest:(NSURLRequest *)request { return [request.URL.host isEqual:@"images.invalid"]; }
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request { return request; }
- (void)startLoading {
    @synchronized(ImageProtocol.class) { networkStarts++; }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(.05*NSEC_PER_SEC)),dispatch_get_global_queue(QOS_CLASS_DEFAULT,0), ^{
        if (self.stopped) return;
        NSInteger status=[self.request.URL.path containsString:@"error"] ? 500 : 200;
        NSHTTPURLResponse *response=[[NSHTTPURLResponse alloc] initWithURL:self.request.URL statusCode:status HTTPVersion:@"HTTP/1.1" headerFields:@{@"Content-Type":@"image/png"}];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:fixture];[self.client URLProtocolDidFinishLoading:self];
    });
}
- (void)stopLoading { self.stopped=YES;@synchronized(ImageProtocol.class) { networkStops++; } }
@end
static void Run(double seconds) { [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:seconds]]; }
static void WaitAt(BOOL (^done)(void),int line) { NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:3];while (!done() && deadline.timeIntervalSinceNow>0) Run(.005);if (!done()) fprintf(stderr,"Timeout at %d: starts=%lu decoded=%lu stops=%lu\n",line,(unsigned long)networkStarts,(unsigned long)decoded,(unsigned long)networkStops);CHECK(done()); }
#define Wait(done) WaitAt((done),__LINE__)
static NSURL *URL(NSString *path) { return [NSURL URLWithString:[@"https://images.invalid/" stringByAppendingString:path]]; }
static UIImage *Load(CSNavigationImageLoader *loader,NSURL *url,NSURL *fallback,NSString *account,NSUInteger pixels) {
    __block BOOL done=NO;__block UIImage *result=nil;
    CSNavigationImageRequest *request=[loader loadURL:url fallbackFileURL:fallback scope:account maxPixelSize:pixels completion:^(UIImage *image,NSURL *resolved) {
        (void)resolved;CHECK(NSThread.isMainThread);result=image;done=YES;
    }];
    Wait(^BOOL{return done;});[request cancel];return result;
}

// Compile the actual avatar-binding methods with a small UI fixture.
static NSString *currentAccount=@"A";
static CSNavigationImageLoader *fixtureLoader;
static id SharedFixture(__unused id cls,__unused SEL selector) { return fixtureLoader; }
static NSString *CSMessageCurrentAccount(void) { return currentAccount; }
@interface CSAvatarTitleView : NSObject
@property(nonatomic) CGFloat avatarSize;
@property(nonatomic,strong) UIImageView *otherAvatarImageView,*selfAvatarImageView;
@property(nonatomic,copy) NSString *otherAvatarUrl,*selfAvatarUrl;
@property(nonatomic,copy) NSArray *otherAvatarRequestKey,*selfAvatarRequestKey;
@property(nonatomic,strong) CSNavigationImageRequest *otherAvatarRequest,*selfAvatarRequest;
@property(nonatomic) BOOL otherAvatarLoaded,selfAvatarLoaded;
- (void)updateOtherAvatarWithUrl:(NSString *)url;
- (void)updateSelfAvatarWithUrl:(NSString *)url;
- (void)updateAvatarWithURL:(NSString *)url other:(BOOL)other;
@end
@implementation CSAvatarTitleView
#include "NavigationAvatarBodies.h"
@end
// Actual popover/settings binding and lifecycle methods, with visible-target fixtures.
@interface UIView : UIImageView @end
@implementation UIView @end
@interface UITableViewCell : UIView @end
@implementation UITableViewCell @end
@interface UITableView : NSObject
@property(nonatomic,strong) UITableViewCell *displayed;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)path;
@end
@implementation UITableView
- (UITableViewCell *)cellForRowAtIndexPath:(__unused NSIndexPath *)path { return self.displayed; }
@end
@interface NSIndexPath (NavigationFixture)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;
@end
@implementation NSIndexPath (NavigationFixture)
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section { NSUInteger indexes[]={(NSUInteger)section,(NSUInteger)row};return [self indexPathWithIndexes:indexes length:2]; }
@end
@interface CContact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName,*m_nsHeadImgUrl;
@end
@implementation CContact @end
@interface CSSettingItem : NSObject @end
@implementation CSSettingItem @end
@interface AvatarControllerFixture : NSObject
@property(nonatomic,strong) UIView *viewIfLoaded;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
@end
@implementation AvatarControllerFixture
- (void)viewDidAppear:(__unused BOOL)animated {}
- (void)viewWillDisappear:(__unused BOOL)animated {}
@end
@interface CSUserInfoPopoverController : AvatarControllerFixture {
@public
    UITableView *_tableView;
    CContact *_contact;
    NSString *_avatarAccount;
    CSNavigationImageBinding *_avatarBinding;
    __weak UITableViewCell *_avatarCell;
    __weak UIImageView *_avatarView;
    CSSettingItem *_avatarItem;
    BOOL _avatarActive;
}
- (void)loadPopoverAvatar;
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@implementation CSUserInfoPopoverController
#include "NavigationPopoverBodies.h"
@end
@interface CSContactSeparatorSettingsViewController : AvatarControllerFixture
@property(nonatomic,strong) CSNavigationImageBinding *avatarBinding;
@property(nonatomic,copy) NSString *avatarURL,*avatarAccount,*contactId;
@property(nonatomic,weak) UIImageView *avatarImageView;
@property(nonatomic,strong) UIImage *contactAvatar;
@property(nonatomic) BOOL avatarActive;
- (void)configureContactAvatarURL:(NSString *)url account:(NSString *)account;
- (void)loadContactAvatar;
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
@end
@implementation CSContactSeparatorSettingsViewController
#include "NavigationSettingsAvatarBodies.h"
@end
static CSUserInfoPopoverController *Popover(NSString *path,UIImageView *target,UITableViewCell *cell) {
    CSUserInfoPopoverController *owner=[CSUserInfoPopoverController new];
    owner.viewIfLoaded=[UIView new];owner.viewIfLoaded.window=@YES;target.window=@YES;
    owner->_tableView=[UITableView new];owner->_tableView.displayed=cell;
    owner->_avatarCell=cell;owner->_avatarView=target;owner->_avatarAccount=@"A";
    owner->_contact=[CContact new];owner->_contact.m_nsUsrName=@"friend";owner->_contact.m_nsHeadImgUrl=URL(path).absoluteString;
    owner->_avatarItem=[CSSettingItem new];objc_setAssociatedObject(owner->_avatarItem,"contactHeadImgUrl",owner->_contact.m_nsHeadImgUrl,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return owner;
}
static void PopoverChecks(void) {
    currentAccount=@"A";
    UIImageView *first=[UIImageView new],*second=[UIImageView new];UITableViewCell *cell=[UITableViewCell new],*cell2=[UITableViewCell new];
    CSUserInfoPopoverController *a=Popover(@"popover-shared",first,cell),*b=Popover(@"popover-shared",second,cell2);
    NSUInteger starts=networkStarts;
    [a viewDidAppear:NO];[b viewDidAppear:NO];
    CHECK(first.image==[UIImage imageNamed:@"DefaultProfileHead_phone"] && second.image==first.image);
    Wait(^BOOL { return first.image.CGImage && second.image.CGImage; });
    CHECK(networkStarts==starts+1);CHECK(CGImageGetWidth(first.image.CGImage)==160);CHECK(first.image==second.image);
    starts=networkStarts;for (int i=0;i<100;i++) [a loadPopoverAvatar];Run(.01);CHECK(networkStarts==starts);
    currentAccount=@"B";[a loadPopoverAvatar];CHECK(!first.image.CGImage);
    currentAccount=@"A";[a loadPopoverAvatar];Wait(^BOOL { return first.image.CGImage!=NULL; });
    CSUserInfoPopoverController *invalidPending=Popover(@"popover-pending-invalid",second,cell2);
    starts=networkStarts;[invalidPending viewDidAppear:NO];Wait(^BOOL {return networkStarts>starts;});
    NSUInteger stops=networkStops;currentAccount=@"B";[invalidPending loadPopoverAvatar];
    Wait(^BOOL {return networkStops>stops;});Run(.07);CHECK(!second.image.CGImage);currentAccount=@"A";
    // Exercise actual caller guards independently: account, contact, URL and current cell.
    for (NSUInteger guard=0;guard<4;guard++) {
        NSString *path=[NSString stringWithFormat:@"popover-guard-%lu",(unsigned long)guard];
        CSUserInfoPopoverController *owner=Popover(path,first,cell);[owner viewDidAppear:NO];
        if (guard==0) currentAccount=@"B";
        if (guard==1) owner->_contact.m_nsUsrName=@"changed";
        if (guard==2) owner->_contact.m_nsHeadImgUrl=URL(@"changed-url").absoluteString;
        if (guard==3) owner->_tableView.displayed=cell2;
        Run(.09);CHECK(first.image==[UIImage imageNamed:@"DefaultProfileHead_phone"]);currentAccount=@"A";
    }
    CSUserInfoPopoverController *leaving=Popover(@"popover-leave",first,cell);[leaving viewDidAppear:NO];
    [leaving viewWillDisappear:NO];Run(.09);CHECK(first.image==[UIImage imageNamed:@"DefaultProfileHead_phone"]);
    [leaving viewDidAppear:NO];Wait(^BOOL { return first.image.CGImage!=NULL; });
    CSUserInfoPopoverController *reused=Popover(@"popover-reuse",second,cell2);[reused viewDidAppear:NO];
    [reused tableView:reused->_tableView didEndDisplayingCell:cell2 forRowAtIndexPath:nil];Run(.09);
    CHECK(second.image==[UIImage imageNamed:@"DefaultProfileHead_phone"] && !reused->_avatarCell);
    // Settings are constructed immediately with a placeholder; loading starts only for its visible header.
    CSContactSeparatorSettingsViewController *settings=[CSContactSeparatorSettingsViewController new];
    settings.contactId=@"friend";settings.viewIfLoaded=[UIView new];settings.viewIfLoaded.window=@YES;
    first=[UIImageView new];first.window=@YES;settings.avatarImageView=first;
    [settings configureContactAvatarURL:URL(@"settings-slow").absoluteString account:@"A"];
    CHECK(first.image==[UIImage imageNamed:@"DefaultProfileHead_phone"]);
    [settings viewDidAppear:NO];CHECK(!first.image.CGImage);
    Wait(^BOOL { return first.image.CGImage!=NULL; });CHECK(CGImageGetWidth(first.image.CGImage)==80);
    for (NSUInteger guard=0;guard<4;guard++) {
        settings.contactId=@"friend";settings.avatarImageView=first;settings.avatarAccount=@"A";
        [settings configureContactAvatarURL:URL([NSString stringWithFormat:@"settings-guard-%lu",(unsigned long)guard]).absoluteString account:@"A"];
        if (guard==0) currentAccount=@"B";
        if (guard==1) settings.contactId=@"changed";
        if (guard==2) settings.avatarURL=URL(@"new-settings-url").absoluteString;
        if (guard==3) settings.avatarImageView=second;
        Run(.09);CHECK(!first.image.CGImage);currentAccount=@"A";
    }
    settings.contactId=@"friend";settings.avatarImageView=first;
    [settings configureContactAvatarURL:URL(@"settings-dismiss").absoluteString account:@"A"];
    [settings viewWillDisappear:NO];Run(.09);CHECK(!first.image.CGImage);
    [settings viewDidAppear:NO];Wait(^BOOL { return first.image.CGImage!=NULL; });
    [settings configureContactAvatarURL:nil account:@"A"];CHECK(!first.image.CGImage);
    UIView *header=[UIView new];first.superview=header;
    [settings configureContactAvatarURL:URL(@"settings-reused-header").absoluteString account:@"A"];
    [settings tableView:nil didEndDisplayingHeaderView:header forSection:0];Run(.09);CHECK(!first.image.CGImage && !settings.avatarImageView);
    CHECK(mainDecodes==0);
    printf("Navigation popover/settings: 2 consumers -> 1 network start; 100 stable rebinds -> 0 additional starts; same-key invalidation cancels pending work and clears stale images; lifecycle/account/contact/URL/target guards passed; main-thread thumbnail decodes=0.\n");
}
int main(void) { @autoreleasepool {
    fixture=PNG(.2);
    NSURLSessionConfiguration *config=NSURLSessionConfiguration.ephemeralSessionConfiguration;config.protocolClasses=@[ImageProtocol.class];
    CSNavigationImageLoader *loader=[[CSNavigationImageLoader alloc] initWithSessionConfiguration:config];
    NSMutableArray *requests=[NSMutableArray array];__block NSUInteger delivered=0;
    for (NSUInteger i=0;i<20;i++) [requests addObject:[loader loadURL:URL(@"shared") fallbackFileURL:nil scope:@"A" maxPixelSize:64 completion:^(UIImage *image,NSURL *resolved) {
        CHECK(NSThread.isMainThread);CHECK([resolved isEqual:URL(@"shared")]);CHECK(CGImageGetWidth(image.CGImage)==64);CHECK(CGImageGetHeight(image.CGImage)==32);delivered++;
    }]];
    [requests[0] cancel];[requests[1] cancel];Wait(^BOOL{return delivered==18;});
    CHECK(networkStarts==1 && decoded==1 && mainDecodes==0);
    UIImage *cached=Load(loader,URL(@"shared"),nil,@"A",64);CHECK(cached && networkStarts==1 && decoded==1);
    CHECK(Load(loader,URL(@"shared"),nil,@"B",64)!=cached);CHECK(networkStarts==2);
    CHECK(CGImageGetWidth(Load(loader,URL(@"shared"),nil,@"A",128).CGImage)==128);CHECK(networkStarts==3);
    NSUInteger before=networkStarts;
    __block BOOL cancelledDelivered=NO;
    CSNavigationImageRequest *cancelled=[loader loadURL:URL(@"cancel") fallbackFileURL:nil scope:@"A" maxPixelSize:64 completion:^(__unused UIImage *image,__unused NSURL *resolved) {cancelledDelivered=YES;}];
    Wait(^BOOL{return networkStarts>before;});[cancelled cancel];Run(.08);CHECK(!cancelledDelivered && networkStops>0);
    CHECK(Load(loader,URL(@"cancel"),nil,@"A",64));CHECK(networkStarts==before+2);
    before=networkStarts;CHECK(!Load(loader,URL(@"error"),nil,@"A",64));CHECK(!Load(loader,URL(@"error"),nil,@"A",64));CHECK(networkStarts==before+2);
    NSUInteger beforeDecode=decoded;
    NSURL *directory=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    [NSFileManager.defaultManager createDirectoryAtURL:directory withIntermediateDirectories:YES attributes:nil error:NULL];
    NSURL *file=[directory URLByAppendingPathComponent:@"separator.png"];
    [fixture writeToURL:file atomically:YES];
    UIImage *first=Load(loader,file,nil,@"A",128);CHECK(first && decoded==beforeDecode+1);
    CHECK(Load(loader,file,nil,@"A",128)==first);CHECK(decoded==beforeDecode+1);
    [PNG(.8) writeToURL:file atomically:YES];
    [NSFileManager.defaultManager setAttributes:@{NSFileModificationDate:[NSDate dateWithTimeIntervalSinceNow:10]} ofItemAtPath:file.path error:NULL];
    CHECK(Load(loader,file,nil,@"A",128)!=first);CHECK(decoded==beforeDecode+2);
    CHECK(Load(loader,[directory URLByAppendingPathComponent:@"missing.png"],file,@"A",128));
    [NSFileManager.defaultManager removeItemAtURL:file error:NULL];CHECK(!Load(loader,file,nil,@"A",128));
    [@"broken" writeToURL:file atomically:YES encoding:NSUTF8StringEncoding error:NULL];CHECK(!Load(loader,file,nil,@"A",128));
    [NSFileManager.defaultManager removeItemAtURL:directory error:NULL];
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    before=networkStarts;CHECK(Load(loader,URL(@"shared"),nil,@"A",64));CHECK(networkStarts==before+1);
    CHECK(mainDecodes==0);
    // The real binding methods use the same production loader, with an offline URLProtocol session.
    fixtureLoader=loader;
    Method sharedMethod=class_getClassMethod(CSNavigationImageLoader.class,@selector(sharedLoader));
    IMP sharedImplementation=method_setImplementation(sharedMethod,(IMP)SharedFixture);
    CSAvatarTitleView *view=[CSAvatarTitleView new];view.avatarSize=44;view.otherAvatarImageView=[UIImageView new];view.selfAvatarImageView=[UIImageView new];
    [view updateOtherAvatarWithUrl:URL(@"old").absoluteString];
    [view updateOtherAvatarWithUrl:URL(@"new").absoluteString];
    Wait(^BOOL{return view.otherAvatarLoaded;});CHECK([view.otherAvatarUrl isEqual:URL(@"new").absoluteString]);
    before=networkStarts;beforeDecode=decoded;
    for (NSUInteger i=0;i<1000;i++) [view updateOtherAvatarWithUrl:URL(@"new").absoluteString];
    Run(.03);CHECK(networkStarts==before && decoded==beforeDecode);
    [view updateSelfAvatarWithUrl:URL(@"account-late").absoluteString];currentAccount=@"B";Run(.12);
    CHECK(!view.selfAvatarLoaded && view.selfAvatarImageView.image==[UIImage imageNamed:@"DefaultProfileHead_phone"]);
    CHECK(!view.selfAvatarRequest); // A dropped account result must not leave a permanently "loading" binding.
    currentAccount=@"A";[view updateSelfAvatarWithUrl:URL(@"account-late").absoluteString];Wait(^BOOL{return view.selfAvatarLoaded;});
    currentAccount=@"B";
    [view updateSelfAvatarWithUrl:URL(@"account-late").absoluteString];Wait(^BOOL{return view.selfAvatarLoaded;});
    [view updateOtherAvatarWithUrl:nil];CHECK(view.otherAvatarImageView.image==[UIImage imageNamed:@"DefaultProfileHead_phone"]);
    PopoverChecks();
    method_setImplementation(sharedMethod,sharedImplementation);fixtureLoader=nil;
    printf("Navigation images: %lu checks passed; shared downloads, cancellation, account/size/file invalidation and background thumbnail decoding\n",(unsigned long)checks);
    return 0;
} }
