// The fixture installs production route registration, lifecycle hooks, and identity
// setters. Only UIKit's cover painting is replaced with the recorded gate decision.
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
    InstallTimelineRoutes(); Policy(NO,100);
    NSDictionary *ordinary=@{@"m_nsUsrName":@"alice"}, *secret=@{@"m_nsUsrName":@"secret"};
    WCDataItem *post=[WCDataItem new]; post.username=@"alice";
    post.likeUsers=@[@{@"username":@"secret"}]; post.commentUsers=post.likeUsers;
    post.selectContacts=[NSSet setWithObject:@"secret"];
    WCDataItem *secretPost=[WCDataItem new]; secretPost.username=@"secret";
    NSArray *subjects=@[ordinary,ordinary,post,post], *hidden=@[secret,secret,secretPost,secretPost];
    NSArray *classes=@[@"WCListViewController",@"WCTimelineFlutterProfileViewController",@"WCCommentDetailViewControllerFB",@"WCTimelineFlutterDetailViewController"];
    NSArray *setters=@[@"setM_contact:",@"setContact:",@"setDataItem:",@"setDataItem:"];
    for(NSUInteger i=0;i<classes.count;i++) {
        SocialRoutePage *page=[NSClassFromString(classes[i]) new]; SEL setter=NSSelectorFromString(setters[i]);
        void(^set)(id)=^(id subject){((void(*)(id,SEL,id))objc_msgSend)(page,setter,subject);};
        set(subjects[i]); [page viewDidLoad]; [page viewDidLayoutSubviews];
        Check(page.nativeLoads==1 && page.nativeLayouts==1 && [[RouteGates objectForKey:page] isEqual:@NO]);
        void(^refresh)(id)=[Refreshes objectForKey:page]; Check(refresh!=nil);
        Policy(YES,101); refresh(page); Policy(NO,102); refresh(page);
        Check([[RouteGates objectForKey:page] isEqual:@NO]);
        // Identity changes are checked immediately, before the next layout.
        set(hidden[i]); Check([[RouteGates objectForKey:page] isEqual:@YES]);
        Policy(YES,103); refresh(page); Check([[RouteGates objectForKey:page] isEqual:@NO]);
        Policy(NO,104); refresh(page); Check([[RouteGates objectForKey:page] isEqual:@YES]);
        set(subjects[i]); Check([[RouteGates objectForKey:page] isEqual:@NO]);
        set(nil); Check([[RouteGates objectForKey:page] isEqual:@YES]);
        set(subjects[i]); Check([[RouteGates objectForKey:page] isEqual:@NO]);
        NSUInteger epoch=Epoch; Epoch++; refresh(page);
        Check([[RouteGates objectForKey:page] isEqual:@YES]); Epoch=epoch;
    }
    Check(post.likeUsers.count==1 && post.commentUsers.count==1 && [post.selectContacts containsObject:@"secret"]);
    WCTimelineFlutterAlbumV2ViewController *ownAlbum=[WCTimelineFlutterAlbumV2ViewController new];
    [ownAlbum viewDidLoad]; [ownAlbum viewDidLayoutSubviews]; Check([[RouteGates objectForKey:ownAlbum] isEqual:@NO]);
    WCTimelineFlutterViewController *mixed=[WCTimelineFlutterViewController new];
    [mixed viewDidLoad]; Check([[RouteGates objectForKey:mixed] isEqual:@YES]);
    WCCommentDetailViewController *finder=[WCCommentDetailViewController new];
    [finder viewDidLoad]; [finder viewDidLayoutSubviews];
    Check(finder.nativeLoads==1 && finder.nativeLayouts==1 && ![RouteGates objectForKey:finder]);
    WCListViewController *album=[WCListViewController new]; album.m_contact=secret;
    NSMutableDictionary *options=[CSCloseFriendDefaultOptions() mutableCopy]; options[@"hideTimeline"]=@NO;
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":options} revealed:NO revision:105 blocked:NO];
    [album viewDidLoad]; Check([[RouteGates objectForKey:album] isEqual:@NO]);
    // Interaction-only hiding does not turn a visible author's entire page into a gate.
    Check(CSCloseFriendSurfaceConcealed(Snapshot,CSCloseFriendSurfaceInteraction));
    for(NSDictionary *profile in @[
        @{@"enabled":@NO,@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()},
        @{@"enabled":@YES,@"friends":@[],@"groups":@[],@"options":CSCloseFriendDefaultOptions()}]) {
        Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:profile revealed:NO revision:106 blocked:NO];
        [album viewDidLayoutSubviews]; Check([[RouteGates objectForKey:album] isEqual:@NO]);
        [mixed viewDidLayoutSubviews]; Check([[RouteGates objectForKey:mixed] isEqual:@NO]);
    }
    Snapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"fixture" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:NO revision:107 blocked:YES];
    album.m_contact=ordinary; [ownAlbum viewDidLayoutSubviews];
    Check([[RouteGates objectForKey:album] isEqual:@YES] && [[RouteGates objectForKey:ownAlbum] isEqual:@YES]);
    Policy(NO,108);
    puts("Social routes: ordinary albums/details open, hidden authors protected, identity/reveal/relock/account transitions and native lifecycle preserved");
    return 0;
}
