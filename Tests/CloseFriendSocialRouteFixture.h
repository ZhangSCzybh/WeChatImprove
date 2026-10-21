// Moments must never acquire a whole-page unlock cover; content filtering has
// separate production album/detail fixtures.
@interface SocialRoutePage : NSObject
@property(nonatomic) NSUInteger nativeLoads,nativeLayouts;
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
@end
@implementation SocialRoutePage
- (void)viewDidLoad {self.nativeLoads++;}
- (void)viewDidLayoutSubviews {self.nativeLayouts++;}
@end
@interface WCListViewController : SocialRoutePage
@property(nonatomic,strong) id m_contact;
@end
@implementation WCListViewController @end
@interface WCTimelineFlutterProfileViewController : SocialRoutePage
@property(nonatomic,strong) id contact;
@end
@implementation WCTimelineFlutterProfileViewController @end
@interface WCCommentDetailViewControllerFB : SocialRoutePage
@property(nonatomic,strong) id dataItem;
@end
@implementation WCCommentDetailViewControllerFB @end
@interface WCTimelineFlutterDetailViewController : SocialRoutePage
@property(nonatomic,strong) id dataItem;
@end
@implementation WCTimelineFlutterDetailViewController @end
@interface WCTimelineFlutterAlbumV2ViewController : SocialRoutePage @end
@implementation WCTimelineFlutterAlbumV2ViewController @end
@interface WCTimelineFlutterViewController : SocialRoutePage @end
@implementation WCTimelineFlutterViewController @end
@interface WCCommentDetailViewController : SocialRoutePage @end
@implementation WCCommentDetailViewController @end

static int TestSocialRoutes(void) {
    Policy(NO,100);
    NSArray *classes=@[@"WCListViewController",@"WCTimelineFlutterProfileViewController",@"WCCommentDetailViewControllerFB",@"WCTimelineFlutterDetailViewController",@"WCTimelineFlutterAlbumV2ViewController",@"WCTimelineFlutterViewController"];
    for(NSString *cls in classes) {
        CSCFSocialProtectRoute(cls,CSCloseFriendSurfaceTimeline);
        SocialRoutePage *page=[NSClassFromString(cls) new];
        for(NSNumber *revealed in @[@NO,@YES,@NO]) {
            Policy(revealed.boolValue,100+page.nativeLoads);
            [page viewDidLoad]; [page viewDidLayoutSubviews];
            Check(![RouteGates objectForKey:page]);
        }
        Check(page.nativeLoads==3 && page.nativeLayouts==3);
    }
    puts("Social routes: all native Moments lifecycle calls preserved without page unlock covers");
    return 0;
}
