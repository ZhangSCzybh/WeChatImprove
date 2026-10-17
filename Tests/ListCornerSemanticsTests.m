#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CSListCornerConfiguration.h"
#import "CSListCornerSectionPolicy.h"
#import "CSListCornerPageContext.h"
#import "CSListCornerRenderer.h"
#import "CSListCornerSessionAdapter.h"
#import "CSListCornerContactsAdapter.h"
#import "CSListCornerDiscoverAdapter.h"
#import "CSListCornerMoreAdapter.h"
#import "CSGroupListAdapter.h"
#import <math.h>
@interface MemoryDefaults : NSObject <CSListCornerDefaults>
@property(nonatomic,strong) NSMutableDictionary *values;
@property(nonatomic) NSUInteger reads,writes,syncs;
@end
@implementation MemoryDefaults
- (instancetype)init { if((self=[super init]))_values=[NSMutableDictionary dictionary];return self; }
- (id)objectForKey:(NSString *)key { self.reads++;return self.values[key]; }
- (float)floatForKey:(NSString *)key { return [[self objectForKey:key] floatValue]; }
- (BOOL)boolForKey:(NSString *)key { return [[self objectForKey:key] boolValue]; }
- (void)setFloat:(float)value forKey:(NSString *)key { self.writes++;self.values[key]=@(value); }
- (void)setBool:(BOOL)value forKey:(NSString *)key { self.writes++;self.values[key]=@(value); }
- (BOOL)synchronize { self.syncs++;return YES; }
@end
#define OWNER_CLASS(name,ivarName) \
@interface name : UIViewController { @public UITableView *ivarName; } @end \
@implementation name @end
OWNER_CLASS(NewMainFrameViewController,m_tableView)
OWNER_CLASS(ContactsViewController,m_tableView)
OWNER_CLASS(FindFriendEntryViewController,m_tableView)
OWNER_CLASS(MoreViewController,_frontTableView)
#define VIEW_CLASS(name,base) @interface name : base @end @implementation name @end
VIEW_CLASS(MainFrameItemView,UIView)
VIEW_CLASS(FakeMainFrameItemView,UIView)
VIEW_CLASS(MFBannerBtn,UIView)
VIEW_CLASS(MFWebMMBtn,UIView)
VIEW_CLASS(ContactsItemView,UIView)
VIEW_CLASS(MMUIView,UIView)
VIEW_CLASS(MMBadgeView,UIView)
VIEW_CLASS(RichTextView,UIView)
VIEW_CLASS(MMHeadImageView,UIImageView)
VIEW_CLASS(MMCPLabel,UILabel)
VIEW_CLASS(MMUILabel,UILabel)
VIEW_CLASS(MMUIButton,UIView)
VIEW_CLASS(TextStatePublishEntryButton,UIView)
VIEW_CLASS(TextStateFriendTopicButton,UIView)
VIEW_CLASS(TextStateProfileCardContentView,UIView)
@interface ReentrantContentCell : UITableViewCell
@property(nonatomic,copy) void (^onContent)(void);
@end
@implementation ReentrantContentCell
- (UIView *)contentView { if(self.onContent)self.onContent();return [super contentView]; }
@end
@interface ProjectionFixture : NSObject
@property(nonatomic,copy) NSArray *sections;
@end
@implementation ProjectionFixture @end
@interface CSGroupListAdapter ()
@property(nonatomic,readwrite,getter=isActive) BOOL active;
@property(nonatomic,strong) ProjectionFixture *projection;
@property(nonatomic,copy) NSDictionary *nativeToDisplay;
@end
@implementation CSGroupListAdapter
+ (instancetype)adapterForTable:(UITableView *)table { return table.groupAdapter; }
- (NSIndexPath *)displayPath:(NSIndexPath *)path { return self.nativeToDisplay[path]; }
@end
static MemoryDefaults *FixtureDefaults;
static CSListCornerConfiguration *FixtureConfiguration;
static id SharedConfiguration(id self,SEL command) { return FixtureConfiguration; }
@interface SettingsFixture : NSObject
@property(nonatomic) CGFloat cornerRadius,leftMargin,rightMargin,topSessionTopMargin,normalSessionTopMargin;
- (void)saveColor:(UIColor *)color redKey:(NSString *)red greenKey:(NSString *)green blueKey:(NSString *)blue alphaKey:(NSString *)alpha;
@end
@implementation SettingsFixture
- (void)saveColor:(UIColor *)color redKey:(NSString *)red greenKey:(NSString *)green blueKey:(NSString *)blue alphaKey:(NSString *)alpha { [FixtureConfiguration saveColor:color redKey:red greenKey:green blueKey:blue alphaKey:alpha]; }
@end
#include "ListCornerBodies.h"
static NSUInteger checks,failures;
static void Check(BOOL pass,NSString *message) { checks++;if(!pass) {failures++;fprintf(stderr,"FAIL: %s\n",message.UTF8String);} }
static BOOL Near(double a,double b) { return fabs(a-b)<0.001; }
static UIView *View(Class cls,CGRect frame) { return [[cls alloc] initWithFrame:frame]; }
static NSIndexPath *Path(NSInteger row,NSInteger section) { return [NSIndexPath indexPathForRow:row inSection:section]; }
static id Owner(CSListCornerPage page,UITableView *table) {
    id owner;
    switch(page) {
        case CSListCornerPageSession: {NewMainFrameViewController *o=[NewMainFrameViewController new];o->m_tableView=table;owner=o;break;}
        case CSListCornerPageContacts: {ContactsViewController *o=[ContactsViewController new];o->m_tableView=table;owner=o;break;}
        case CSListCornerPageDiscover: {FindFriendEntryViewController *o=[FindFriendEntryViewController new];o->m_tableView=table;owner=o;break;}
        case CSListCornerPageMore: {MoreViewController *o=[MoreViewController new];o->_frontTableView=table;owner=o;break;}
    }
    table.responder=owner;return owner;
}
static UITableView *Table(void) { UITableView *t=[[UITableView alloc] initWithFrame:CGRectMake(0,0,390,700)];t.rows=@[@3,@1,@0,@1,@2];return t; }
static UITableViewCell *Cell(UITableView *table,NSInteger row,NSInteger section) {
    UITableViewCell *c=[[UITableViewCell alloc] initWithFrame:CGRectMake(0,0,390,60)];c.contentView.frame=c.bounds;c.path=Path(row,section);[table addSubview:c];return c;
}
static void Configure(void) {
    [FixtureConfiguration saveEnabled:YES];[FixtureConfiguration saveNumber:15 forKey:kListLeftMarginKey];[FixtureConfiguration saveNumber:23 forKey:kListRightMarginKey];
}
static UIView *Background(UITableViewCell *cell) { return CSListCornerOwnedBackground(cell.contentView); }
static BOOL Rounded(UIView *background,CGPoint point) { return CGPathContainsPoint(((CAShapeLayer *)background.layer.mask).path,NULL,point,NO); }
static void ConfigurationTests(NSDictionary *baseline) {
    CSListCornerSnapshot *defaults=FixtureConfiguration.snapshot;
    Check(!defaults.enabled && Near(defaults.radius,10) && Near(defaults.leftMargin,15) && Near(defaults.rightMargin,15) && Near(defaults.pinnedGap,10) && Near(defaults.normalGap,10),@"frozen numeric defaults and disabled switch");
    for(NSArray *entry in ProductionKeys()) Check([baseline[@"keys"][entry[0]] isEqual:entry[1]],@"all 30 persisted keys match 1.7-17");
    NSUInteger reads=FixtureDefaults.reads;Check(FixtureConfiguration.snapshot==defaults && FixtureDefaults.reads==reads,@"immutable configuration snapshot is cached");
    [FixtureConfiguration saveNumber:0 forKey:kListTopSessionTopMarginKey];Check(FixtureConfiguration.snapshot.pinnedGap==0 && defaults.pinnedGap==10,@"explicit zero gap and immutable old snapshot");
    [FixtureConfiguration saveNumber:0 forKey:kListCornerRadiusKey];Check(FixtureConfiguration.snapshot.radius==10,@"zero radius retains fallback semantics");
    FixtureDefaults.values[kListCornerRadiusKey]=@24;
    NSUInteger notificationWrites=FixtureDefaults.writes, notificationSyncs=FixtureDefaults.syncs;
    [[NSNotificationCenter defaultCenter] postNotificationName:NSUserDefaultsDidChangeNotification object:FixtureDefaults];
    Check(FixtureDefaults.writes==notificationWrites && FixtureDefaults.syncs==notificationSyncs,@"defaults notification invalidates without writes or synchronization");
    Check(FixtureConfiguration.snapshot.radius==24,@"defaults notification invalidates cache");
    for(UIUserInterfaceStyle style=UIUserInterfaceStyleLight;style<=UIUserInterfaceStyleDark;style++) {
        UIColor *bg=[defaults backgroundForStyle:style];Check(Near(bg.alpha,1) && Near(bg.red,style==UIUserInterfaceStyleDark?0.11:1),@"all-zero background sentinel keeps opaque defaults per style");
        Check([defaults pinnedColorForStyle:style].alpha==0 && [defaults normalColorForStyle:style].alpha==0,@"all-zero gap sentinel remains clear in both styles");
    }
    NSArray *prefixes=@[@"light_bg_color",@"dark_bg_color",@"top_session_top_margin_light_bg_color",@"top_session_top_margin_dark_bg_color",@"normal_session_top_margin_light_bg_color",@"normal_session_top_margin_dark_bg_color"];
    for(NSString *prefix in prefixes) {
        NSString *base=[@"com.wechat.enhance.list_corner_radius." stringByAppendingString:prefix];
        [FixtureConfiguration saveColor:[UIColor colorWithRed:.2 green:.3 blue:.4 alpha:.5] redKey:[base stringByAppendingString:@".red"] greenKey:[base stringByAppendingString:@".green"] blueKey:[base stringByAppendingString:@".blue"] alphaKey:[base stringByAppendingString:@".alpha"]];
    }
    CSListCornerSnapshot *custom=FixtureConfiguration.snapshot;
    for(UIUserInterfaceStyle style=UIUserInterfaceStyleLight;style<=UIUserInterfaceStyleDark;style++) {
        for(UIColor *c in @[[custom backgroundForStyle:style],[custom pinnedColorForStyle:style],[custom normalColorForStyle:style]]) Check(Near(c.red,.2) && Near(c.green,.3) && Near(c.blue,.4) && Near(c.alpha,.5),@"six RGBA values preserve channels and opacity");
    }
    Check(FixtureDefaults.syncs==FixtureDefaults.writes-18,@"color saves synchronize as one complete RGBA operation");
    [FixtureConfiguration saveEnabled:YES];NSDictionary *before=FixtureDefaults.values.copy;
    ProductionReset([SettingsFixture new]);CSListCornerSnapshot *reset=FixtureConfiguration.snapshot;
    Check(reset.enabled && reset.radius==10 && reset.leftMargin==15 && reset.rightMargin==15 && reset.pinnedGap==10 && reset.normalGap==10,@"production reset preserves switch and numeric defaults");
    for(NSString *key in before) if([key containsString:@"margin_"] && [key containsString:@"bg_color"]) Check([before[key] isEqual:FixtureDefaults.values[key]],@"production reset retains existing gap colors");
    CGFloat (*validators[5])(CGFloat)={ProductionValidateRadius,ProductionValidateLeft,ProductionValidateRight,ProductionValidatePinned,ProductionValidateNormal};
    for(NSUInteger n=0;n<5;n++) {
        CGFloat minimum=[baseline[@"numericRanges"][n][0] doubleValue],maximum=[baseline[@"numericRanges"][n][1] doubleValue];
        for(NSInteger value=-1;value<=55;value++) Check(validators[n](value)==MIN(maximum,MAX(minimum,value)),@"production picker validation preserves exact frozen numeric ranges");
    }
    Configure();
}
static void HeightTests(NSDictionary *baseline) {
    CGFloat (*hooks[4][2])(id,id,NSInteger)={{HookSessionHeader,HookSessionFooter},{HookContactsHeader,HookContactsFooter},{HookDiscoverHeader,HookDiscoverFooter},{HookMoreHeader,HookMoreFooter}};
    NSArray *names=@[@"Session",@"Contacts",@"Discover",@"More"];
    for(NSInteger page=0;page<4;page++) {
        CGFloat (*headerHook)(id,id,NSInteger)=hooks[page][0],(*footerHook)(id,id,NSInteger)=hooks[page][1];
        UITableView *t=Table();id owner=Owner(page,t);t.throwsOnQuery=YES;
        for(NSNumber *enabled in @[@NO,@YES]) {
            [FixtureConfiguration saveEnabled:enabled.boolValue];
            for(NSUInteger n=0;n<[baseline[@"headerSections"] count];n++) {
                NSInteger section=[baseline[@"headerSections"][n] integerValue];
                for(NSInteger domain=0;domain<2;domain++) {
                    void (^run)(void)=^{
                        CGFloat header=headerHook(owner,t,section),footer=footerHook(owner,t,section);
                        double expected=enabled.boolValue ? [baseline[@"headers"][names[page]][n] doubleValue] : 7;
                        Check(Near(header,expected),@"production height hook matches legal-value frozen header fixture");
                        Check(Near(footer,enabled.boolValue ? [baseline[@"footers"][names[page]] doubleValue] : 7),@"production footer hook matches frozen fixture");
                        Check(CSGroupUsesNativeIndices(t)==(domain==0),@"height hook preserves actual group scope");
                    };
                    if(domain==0)CSGroupWithNativeIndices(t,run);else CSGroupWithDisplayIndices(t,run);
                }
            }
        }
        Check(t.queries==0 && t.reloads==0 && t.originalCalls==56,@"all height callbacks invoke original exactly once and never query/reload");
        UITableView *other=Table();other.throwsOnQuery=YES;
        Check(hooks[page][0](owner,other,0)==7 && hooks[page][1](owner,other,0)==7,@"height hooks preserve non-owner table unchanged without queries");
    }
    Configure();
}
static void RendererTests(void) {
    UIView *view=View(UIView.class,CGRectZero);UIColor *color=UIColor.whiteColor;
    for(NSUInteger role=0;role<4;role++) {
        BOOL first=role==0 || role==3,last=role==2 || role==3;
        CSListApplyCardBackground(view,CGRectMake(15,0,352,60),10,first,last,color);
        Check(Rounded(view,CGPointMake(1,1))==!first && Rounded(view,CGPointMake(1,59))==!last,@"single/first/middle/last corner paths");
        CAShapeLayer *mask=(id)view.layer.mask;CGPathRef path=mask.path;
        CSListApplyCardBackground(view,view.frame,10,first,last,color);
        Check(view.layer.mask==mask && mask.path==path,@"same shape reuses mask and path");
        view.layer.mask=nil;view.layer.cornerRadius=0;view.layer.masksToBounds=NO;view.backgroundColor=UIColor.clearColor;mask.frame=CGRectZero;view.userInteractionEnabled=YES;
        CSListApplyCardBackground(view,CGRectMake(15,0,352,60),10,first,last,color);
        Check(view.layer.mask==mask && CGRectEqualToRect(mask.frame,CGRectMake(0,0,352,60)) && view.layer.masksToBounds && [view.backgroundColor isEqual:color] && !view.userInteractionEnabled,@"actual mask/frame/radius/color/interaction resets repaired");
    }
    CAShapeLayer *mask=(id)view.layer.mask;mask.frame=CGRectZero;
    CSListApplyCardBackground(view,view.frame,10,YES,YES,color);Check(mask.frame.size.width==352,@"mask frame alone is repaired without other changes");
    CSListApplyCardBackground(view,CGRectMake(15,0,400,60),12,YES,YES,color);Check(((CAShapeLayer *)view.layer.mask).path!=NULL && view.frame.size.width==400,@"width and radius changes repair geometry");
    CGRect old=view.frame;CSListApplyCardBackground(view,CGRectMake(0,0,NAN,0),10,YES,YES,color);Check(CGRectEqualToRect(old,view.frame),@"invalid geometry is ignored");
}
static void OwnershipAndSessionTests(void) {
    UITableView *t=Table();id owner=Owner(CSListCornerPageSession,t);UITableViewCell *c=Cell(t,0,0);
    UIView *item=View(MainFrameItemView.class,c.bounds);item.backgroundColor=UIColor.whiteColor;[c.contentView addSubview:item];
    UIView *banner=View(MFBannerBtn.class,CGRectMake(0,0,390,44));[c.contentView addSubview:banner];
    UIView *unrelated=View(UIView.class,CGRectMake(4,3,10,10));unrelated.backgroundColor=UIColor.whiteColor;[c.contentView addSubview:unrelated];
    CSListCornerSessionDecorate(c,t,c.path,owner);UIView *bg=Background(c);
    Check(bg.frame.origin.x==15 && bg.frame.size.width==352 && banner.frame.size.width==352 && item.backgroundColor.alpha==0,@"session card/banner geometry and known native background preserved");
    Check(unrelated.backgroundColor.alpha==1 && !unrelated.layer.mask && !c.layer.mask && !c.contentView.layer.mask,@"unrelated subviews and menu-bearing containers stay intact");
    NSUInteger reads=FixtureDefaults.reads;CSListCornerSessionDecorate(c,t,c.path,owner);Check(reads==FixtureDefaults.reads && Background(c)==bg,@"one operation uses immutable cached configuration and owned background");
    CGRect native=CGRectMake(15,0,999,60);CGRect adjusted=CSListCornerSessionItemFrame(item,native);
    Check(adjusted.origin.x==15 && adjusted.size.width==352,@"MainFrame width repaired even when left margin already correct");
    UIView *fake=View(FakeMainFrameItemView.class,native);[c.contentView addSubview:fake];Check(CSListCornerSessionItemFrame(fake,native).size.width==352,@"Fake item uses same native nominal width");
    c.contentView.frame=CGRectMake(-80,0,390,60);CSListCornerSessionDecorate(c,t,c.path,owner);Check(bg.frame.origin.x==15,@"swipe translation remains native while card moves locally with content");
    UIView *replacement=View(UIView.class,CGRectMake(0,0,450,70));c.contentView=replacement;[c addSubview:replacement];CSListCornerSessionDecorate(c,t,c.path,owner);
    Check(Background(c)!=bg && bg.superview==nil && Background(c).superview==replacement && Background(c).frame.size.width==412,@"replacement actual content gets fresh owned background and new width");
    UITableView *search=Table();search.responder=owner;UITableViewCell *sc=Cell(search,0,0);search.throwsOnQuery=YES;
    CSListCornerSessionDecorate(sc,search,sc.path,owner);Check(search.queries==0 && sc.contentView.subviews.count==0,@"same owner/class search table is excluded");
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.active=YES;adapter.projection=[ProjectionFixture new];adapter.projection.sections=@[@[@"B",@"D"]];adapter.nativeToDisplay=@{Path(1,0):Path(0,0),Path(3,0):Path(1,0)};t.groupAdapter=adapter;t.throwsOnQuery=YES;
    CSGroupWithNativeIndices(t,^{CSListCornerSessionDecorate(c,t,Path(3,0),owner);Check(Rounded(Background(c),CGPointMake(1,1)) && !Rounded(Background(c),CGPointMake(1,69)),@"real group role lookup maps native D to display last role");});
    CSGroupWithDisplayIndices(t,^{CSListCornerSessionDecorate(c,t,Path(0,0),owner);Check(!Rounded(Background(c),CGPointMake(1,1)) && Rounded(Background(c),CGPointMake(1,69)),@"real group lookup respects display index scope");});
    NSUInteger queries=t.queries;CGRect before=Background(c).frame;
    CSGroupWithNativeIndices(t,^{CSListCornerSessionDecorate(c,t,Path(2,0),owner);});
    Check(t.queries==queries && CGRectEqualToRect(Background(c).frame,before),@"active-invalid group path cannot fall through to native row guessing");
    t.throwsOnQuery=NO;adapter.active=NO;
    ReentrantContentCell *reentrant=[[ReentrantContentCell alloc] initWithFrame:CGRectMake(0,0,390,60)];reentrant.contentView.frame=reentrant.bounds;[t addSubview:reentrant];
    __weak ReentrantContentCell *weakCell=reentrant;
    __block NSUInteger visits=0;reentrant.onContent=^{visits++;CSListCornerSessionDecorate(weakCell,t,Path(0,0),owner);};
    CSListCornerSessionDecorate(reentrant,t,Path(0,0),owner);Check(visits==1,@"per-cell guard blocks contentView-triggered decoration recursion");reentrant.onContent=nil;
    Check(!CSListCornerBeginOperation(nil),@"nil guard is safe");Check(CSListCornerBeginOperation(c) && !CSListCornerBeginOperation(c),@"reentry guard is per object");CSListCornerEndOperation(c);Check(CSListCornerBeginOperation(c),@"guard releases after operation");CSListCornerEndOperation(c);
}
static void ContactsDiscoverMoreTests(void) {
    UITableView *contacts=Table();Owner(CSListCornerPageContacts,contacts);contacts.rows=@[@0,@1];UITableViewCell *c=Cell(contacts,0,1);
    UIView *wrapper=View(UIView.class,CGRectMake(15,0,352,60)),*item=View(ContactsItemView.class,CGRectMake(0,0,352,60));[wrapper addSubview:item];[c.contentView addSubview:wrapper];
    HookNewContactsItemCellLayout(c);Check(item.frame.origin.x==0 && item.frame.size.width==352 && !Rounded(Background(c),CGPointMake(1,1)) && !Rounded(Background(c),CGPointMake(1,59)),@"contacts first-four merge bounds to actual two sections and nested content avoids double inset");
    __block NSUInteger queryReentries=0;
    __weak UITableViewCell *weakContactsCell=c;
    contacts.onQuery=^{ queryReentries++;HookNewContactsItemCellLayout(weakContactsCell); };
    HookNewContactsItemCellLayout(c);contacts.onQuery=nil;
    Check(queryReentries>0 && queryReentries<8,@"layout guard covers indexPath and row queries that synchronously reenter layout");
    NSUInteger q=contacts.queries;HookNewContactsItemCellLayout(c);Check(item.frame.origin.x==0 && contacts.queries>q,@"contacts repeated layout is stable");
    UITableView *discover=Table();id discoverOwner=Owner(CSListCornerPageDiscover,discover);UITableViewCell *d=Cell(discover,1,0);
    UILabel *label=(id)View(UILabel.class,CGRectMake(68,20,100,20));UIView *badge=View(MMBadgeView.class,CGRectMake(180,22,9,9));MMUIView *native=(id)View(MMUIView.class,d.bounds);native.backgroundColor=UIColor.whiteColor;d->m_subContentView=native;
    [d.contentView addSubview:native];[d.contentView addSubview:label];[d.contentView addSubview:badge];
    HookMMTableViewCellLayout(d);Check(badge.frame.origin.x==179 && label.frame.origin.x==67 && native.backgroundColor.alpha==0,@"discover direct badge native spacing and owned opaque content role");
    CGRect badgeFrame=badge.frame;for(NSUInteger n=0;n<20;n++)HookMMTableViewCellLayout(d);Check(CGRectEqualToRect(badge.frame,badgeFrame),@"discovery badge never drifts across repeated decoration");
    d.contentView.frame=CGRectMake(0,0,450,60);CSListCornerDiscoverDecorate(d,discover,d.path,discoverOwner);Check(label.frame.size.width==344 && badge.frame.origin.x==179,@"discover width change resizes text without shifting badge repeatedly");
    UITableViewCell *nestedCell=Cell(discover,0,1);
    MMUIView *nested=(id)View(MMUIView.class,nestedCell.bounds);nestedCell->m_subContentView=nested;
    UIView *nestedIcon=View(UIImageView.class,CGRectMake(16,10,24,24)),*nestedTitle=View(UILabel.class,CGRectMake(52,10,150,20)),*rich=View(RichTextView.class,CGRectMake(300,10,40,20));
    for(UIView *v in @[nestedIcon,nestedTitle,rich])[nested addSubview:v];[nestedCell.contentView addSubview:nested];
    HookMMTableViewCellLayout(nestedCell);CGRect nestedFrame=nested.frame,richFrame=rich.frame;
    HookMMTableViewCellLayout(nestedCell);
    Check(nested.frame.origin.x==15 && nested.frame.size.width==352 && nestedIcon.frame.origin.x==15 && nestedTitle.frame.origin.x==51 && rich.frame.origin.x==289,@"discover verified MMUIView retains distinct nested icon/title/rich-text formulas");
    Check(CGRectEqualToRect(nested.frame,nestedFrame) && CGRectEqualToRect(rich.frame,richFrame),@"nested discovery content remains idempotent");
    UITableView *more=Table();id moreOwner=Owner(CSListCornerPageMore,more);UITableViewCell *m=Cell(more,0,1);
    UIImageView *icon=(id)View(UIImageView.class,CGRectMake(16,10,24,24));UILabel *title=(id)View(UILabel.class,CGRectMake(52,10,150,20));[m.contentView addSubview:icon];[m.contentView addSubview:title];
    CSListCornerMoreDecorate(m,more,m.path,moreOwner);Check(icon.frame.origin.x==31 && title.frame.origin.x==67 && Background(m).frame.size.width==352,@"More keeps its direct icon/title formula");
    // Global cell hooks must not query any table in disabled or non-target layouts.
    for(UITableView *table in @[contacts,discover,more]) {
        UITableViewCell *cell=Cell(table,0,0);NSUInteger queriesBefore=table.queries;table.throwsOnQuery=YES;[FixtureConfiguration saveEnabled:NO];
        HookMMTableViewCellLayout(cell);HookNewContactsItemCellLayout(cell);Check(table.queries==queriesBefore,@"disabled global layout executes without a row query");table.throwsOnQuery=NO;
    }
    Configure();UITableView *other=Table();Owner(CSListCornerPageSession,other);UITableViewCell *otherCell=Cell(other,0,0);other.throwsOnQuery=YES;HookMMTableViewCellLayout(otherCell);HookNewContactsItemCellLayout(otherCell);Check(other.queries==0,@"enabled global layout excludes unrelated owned table before query");
    UIView *header=View(MMUIButton.class,CGRectMake(0,0,390,200));header.backgroundColor=[UIColor colorWithRed:.8 green:.7 blue:.6 alpha:1];more.tableHeaderView=header;[more addSubview:header];
    UIView *avatar=View(MMHeadImageView.class,CGRectMake(0,10,60,60)),*name=View(MMCPLabel.class,CGRectMake(80,10,200,24)),*status=View(TextStatePublishEntryButton.class,CGRectMake(90,75,64,25)),*topic=View(TextStateFriendTopicButton.class,CGRectMake(90,75,50,25)),*detail=View(TextStateProfileCardContentView.class,CGRectMake(0,110,390,80)),*qr=View(MMUIButton.class,CGRectMake(350,30,20,20));
    for(UIView *v in @[avatar,name,status,topic,detail,qr])[header addSubview:v];
    CSListCornerMoreDecorateHeader(header);UIView *bg=CSListCornerOwnedBackground(header);
    Check(header.frame.origin.x==15 && header.frame.size.width==352 && avatar.frame.origin.x==16 && name.frame.origin.x==92 && status.frame.origin.x==92 && topic.frame.origin.x==164,@"More profile native avatar/title/status formulas retained");
    Check(header.backgroundColor.alpha==0 && Near(bg.backgroundColor.red,.8) && !header.layer.mask && !detail.layer.mask && qr.userInteractionEnabled && !bg.userInteractionEnabled,@"profile preserves native color/status/touch targets and rounds only plugin background");
    NSUInteger invalidations=header.layoutInvalidations;for(NSUInteger n=0;n<20;n++)CSListCornerMoreDecorateHeader(header);Check(header.layoutInvalidations==invalidations && topic.frame.origin.x==164,@"profile normal layout invalidation remains bounded and buttons do not drift");
    header.frame=CGRectMake(0,0,390,240);bg.layer.mask=nil;header.backgroundColor=UIColor.whiteColor;CSListCornerMoreDecorateHeader(header);Check(header.frame.size.height==240 && header.frame.size.width==352 && bg.layer.mask && bg.backgroundColor.red==1,@"profile native width/height/color/mask reset repaired while preserving expanded height");
    more.frame=CGRectMake(0,0,500,700);CSListCornerMoreDecorateHeader(header);Check(header.frame.size.width==462 && detail.frame.size.width==462 && detail.frame.size.height==80,@"profile uses actual container width and preserves status-detail height");
    UIView *ordinary=View(MMUIButton.class,CGRectMake(0,0,120,44));[other addSubview:ordinary];Check(CGRectEqualToRect(CSListCornerMoreHeaderFrame(ordinary,ordinary.frame),ordinary.frame),@"ordinary MMUIButton never becomes a profile card");
}
int main(int argc,const char **argv) { @autoreleasepool {
    if(argc!=2)return 2;
    NSDictionary *baseline=[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:@(argv[1])] options:0 error:NULL];
    FixtureDefaults=[MemoryDefaults new];FixtureConfiguration=[[CSListCornerConfiguration alloc] initWithDefaults:FixtureDefaults];
    method_setImplementation(class_getClassMethod(CSListCornerConfiguration.class,@selector(sharedConfiguration)),(IMP)SharedConfiguration);
    ConfigurationTests(baseline);HeightTests(baseline);RendererTests();OwnershipAndSessionTests();ContactsDiscoverMoreTests();
    fprintf(stdout,"List corners: %lu checks, %lu failures (production modules, extracted Hooks + group role function, real index scopes; host doubles, no device rendering claim)\n",(unsigned long)checks,(unsigned long)failures);
    return failures?1:0;
} }
