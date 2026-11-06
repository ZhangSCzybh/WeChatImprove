// Production merge + bubble adapters. Native dispatch signatures follow the supplied
// 8.0.80 Mach-O. Geometry/pixels below are controlled fixtures, not device samples.
#import <UIKit/UIKit.h>
#import "CSMessageMergeAdapter.h"
#import "CSMessageMergePolicy.h"
#import "CSBubbleStyleAdapter.h"
#import "CSBubbleStylePolicy.h"
#import <objc/runtime.h>
#include <math.h>
static unsigned checks, failures;
#define CHECK(x) do { checks++; if (!(x)) { failures++; fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); } } while (0)
@interface MMContext : NSObject
+ (NSString *)currentUserName;
@end
@implementation MMContext
+ (NSString *)currentUserName { return @"isolated-test-account"; }
@end
@interface CMessageWrap : NSObject
@property(nonatomic) unsigned int m_uiMesLocalID, m_uiMessageType, m_uiAppMsgInnerType;
@property(nonatomic,copy) NSString *m_nsFromUsr, *m_nsRealChatUsr;
@end
@implementation CMessageWrap @end
@interface BubbleInfo : NSObject
@property(nonatomic) unsigned int position;
@property(nonatomic) NSUInteger requests;
@property(nonatomic,strong) UIImage *normal;
- (id)getBubbleImage:(BOOL)highlighted isDarkMode:(BOOL)dark useCache:(BOOL)cache;
@end
@implementation BubbleInfo
- (id)getBubbleImage:(BOOL)highlighted isDarkMode:(BOOL)dark useCache:(BOOL)cache {
    CHECK(cache);self.requests++;return self.normal;
}
@end
@interface CommonMessageViewModel : NSObject
@property(nonatomic,strong) CMessageWrap *messageWrap;
@property(nonatomic,strong) BubbleInfo *bgBubbleInfo;
@property(nonatomic) BOOL isSender;
@property(nonatomic) CGSize contentViewSize;
- (BOOL)isShowChatRoomDisplayName;
- (void)resetLayoutCache;
@end
@implementation CommonMessageViewModel
- (BOOL)isShowChatRoomDisplayName { return !CSMessageMergeHidesName(self); }
- (void)resetLayoutCache { CSMessageMergeResetGeometry(self); }
@end
@interface TextMessageViewModel : CommonMessageViewModel
- (long long)numberOfRowsInSection;
- (id)cellDataForRow:(unsigned long long)row;
@end
@implementation TextMessageViewModel
- (long long)numberOfRowsInSection { return 1; }
- (id)cellDataForRow:(unsigned long long)row { return self; }
@end
@interface UnsupportedTextMessageViewModel : TextMessageViewModel @end
@implementation UnsupportedTextMessageViewModel @end
@interface CommonMessageCellView : UIView { @public UIView *m_chatRoomNameLabel; }
@property(nonatomic,strong) TextMessageViewModel *viewModel;
@property(nonatomic,strong) UIView *content;
@property(nonatomic,strong) UIImageView *background;
@property(nonatomic,strong) UIView *head;
- (id)getContentView;
- (id)getBgImageView;
- (id)getHeadImageView;
@end
@implementation CommonMessageCellView
- (id)getContentView { return self.content; }
- (id)getBgImageView { return self.background; }
- (id)getHeadImageView { return self.head; }
@end
@interface NativeTableCell : NSObject
@property(nonatomic,strong) CommonMessageCellView *cellView;
@end
@implementation NativeTableCell @end
@interface BaseMsgContentViewController : UIViewController
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) NSArray *nodes;
- (id)getTableView;
- (id)getCurrentChatName;
- (id)GetMessageNodeDataArray;
- (double)tableView:(id)table heightForRowAtIndexPath:(id)path;
- (id)tableView:(id)table cellForRowAtIndexPath:(id)path;
- (void)tableView:(id)table willDisplayCell:(id)cell forRowAtIndexPath:(id)path;
@end
@implementation BaseMsgContentViewController
- (id)getTableView { return self.table; }
- (id)getCurrentChatName { return @"isolated-group@chatroom"; }
- (id)GetMessageNodeDataArray { return self.nodes; }
// Same call order as MessageMergeHooks. Native row measurement is 8pt top +
// 38pt controlled body + 9pt bottom. No plugin padding is injected into it.
- (double)tableView:(id)table heightForRowAtIndexPath:(id)path {
    CSMessageMergePrepare(self,table,path);
    TextMessageViewModel *model=self.nodes[[path section]];
    return CSMessageMergeRowHeight(self,table,path,(!model.isSender && [path section]==0) ? 67 : 55);
}
- (id)tableView:(id)table cellForRowAtIndexPath:(id)path {
    CSMessageMergePrepare(self,table,path);id cell=[table cellForRowAtIndexPath:path];
    CSMessageMergeBind(self,table,path,cell);return cell;
}
- (void)tableView:(id)table willDisplayCell:(id)cell forRowAtIndexPath:(id)path {
    CSMessageMergeBind(self,table,path,cell);
}
@end
static UIImage *NativeTemplate(void) {
    CGImageRef pixels=CSBubbleCreateTemplate((CSBubbleRGBA){.7,.2,.5,1},8,0,2,(CSBubbleInsets){1,2,3,4},NO);
    UIImage *image=[UIImage imageWithCGImage:pixels scale:2 orientation:UIImageOrientationUp];CGImageRelease(pixels);
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(11,12,13,14) resizingMode:UIImageResizingModeStretch];
}
static void ABI(Class cls, SEL selector, const char *result, NSArray *arguments) {
    Method method=class_getInstanceMethod(cls,selector);CHECK(method!=NULL);
    CHECK(method_getNumberOfArguments(method)==2+arguments.count);
    char type[128]={0};method_getReturnType(method,type,sizeof(type));CHECK(strcmp(type,result)==0);
    for (NSUInteger i=0;i<arguments.count;i++) { method_getArgumentType(method,(unsigned)i+2,type,sizeof(type));CHECK(strcmp(type,[arguments[i] UTF8String])==0); }
}
static void Configure(BOOL compact, BOOL legacy, BOOL style) {
    NSMutableDictionary *settings=[@{CSMessageMergeEnabledKey:@YES,CSMessageMergeScopeKey:@3,
        CSMessageMergeAvatarKey:@2,@"com.wechat.enhance.bubble_style.enabled":@(style),
        @"com.wechat.enhance.messageTime.enabled":@NO,
        CSBubbleStyleKindKey:@1} mutableCopy];
    if (!legacy) settings[CSMessageMergeSpacingModeKey]=@(compact ? 1 : 0);
    settings[CSMessageMergeSpacingKey]=@(compact ? (legacy ? -8 : 0) : -8);
    [NSUserDefaults.standardUserDefaults setVolatileDomain:settings forName:NSArgumentDomain];
    CSMessageMergeConfiguration *config=[[CSMessageMergeConfiguration alloc] initWithDefaults:NSUserDefaults.standardUserDefaults];
    CHECK(config.spacingMode==(compact ? CSMessageSpacingCompact : CSMessageSpacingNormal));
    printf("SETTINGS new-mode=%s legacy=%g actual=%ld expected=%ld\n",legacy ? "absent" : (compact ? "1" : "0"),
        [settings[CSMessageMergeSpacingKey] doubleValue],(long)config.spacingMode,(long)(compact ? 1 : 0));
    CSBubbleStyleStart();[NSNotificationCenter.defaultCenter postNotificationName:NSUserDefaultsDidChangeNotification object:nil];
    [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.002]];
}
static void Scenario(BOOL compact, BOOL legacy, BOOL unsupported, BOOL style, BOOL outgoing) {
    Configure(compact,legacy,style);
    BOOL known=[@[@"8.0.78",@"8.0.80",@"8.0.80.34"] containsObject:NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"]];
    BOOL shouldCompact=known && compact && !unsupported;
    BaseMsgContentViewController *page=[BaseMsgContentViewController new];
    UITableView *table=[UITableView new];UIWindow *window=[UIWindow new];table.window=window;
    table.bounds=CGRectMake(0,0,320,600);page.table=table;page.view=table;
    BubbleInfo *info=[BubbleInfo new];info.normal=NativeTemplate();
    NSMutableArray *nodes=[NSMutableArray array],*views=[NSMutableArray array],*heights=[NSMutableArray array];
    NSMutableDictionary *cells=[NSMutableDictionary dictionary];
    for (NSUInteger i=0;i<2;i++) {
        TextMessageViewModel *m=unsupported ? [UnsupportedTextMessageViewModel new] : [TextMessageViewModel new];
        m.messageWrap=[CMessageWrap new];m.messageWrap.m_uiMesLocalID=(unsigned)i+1;m.messageWrap.m_uiMessageType=1;
        m.messageWrap.m_nsFromUsr=@"sender";m.messageWrap.m_nsRealChatUsr=@"sender";m.isSender=outgoing;
        m.bgBubbleInfo=info;m.contentViewSize=CGSizeMake(180,38);[nodes addObject:m];
    }
    page.nodes=nodes;CSMessageMergeActivate(page);
    for (NSUInteger i=0;i<2;i++) {
        NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];
        CGFloat height=[page tableView:table heightForRowAtIndexPath:path];[heights addObject:@(height)];
        CommonMessageCellView *v=[CommonMessageCellView new];v.viewModel=nodes[i];
        v.frame=CGRectMake(0,0,320,height);v.bounds=CGRectMake(0,0,320,height);
        BOOL named=!outgoing && i==0;
        v.content=[UIView new];v.content.frame=CGRectMake(40,named ? 17 : 8,240,38);v.content.bounds=CGRectMake(0,0,240,38);[v addSubview:v.content];
        v.background=[UIImageView new];v.background.frame=CGRectMake(10,0,180,38);v.background.bounds=CGRectMake(0,0,180,38);
        v.background.image=info.normal;v.background.highlightedImage=info.normal;[v.content addSubview:v.background];
        v.head=[UIView new];v.head.frame=CGRectMake(outgoing ? 282 : 0,named ? 3 : 8,38,38);v.head.bounds=CGRectMake(0,0,38,38);[v addSubview:v.head];
        if (named) { v->m_chatRoomNameLabel=[UIView new];v->m_chatRoomNameLabel.frame=CGRectMake(50,0,160,14);v->m_chatRoomNameLabel.bounds=CGRectMake(0,0,160,14);[v addSubview:v->m_chatRoomNameLabel]; }
        NativeTableCell *cell=[NativeTableCell new];cell.cellView=v;cells[path]=cell;[views addObject:v];
    }
    table.testCells=cells;table.testHeights=heights;
    for (NSUInteger i=0;i<2;i++) { NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:i];id cell=[page tableView:table cellForRowAtIndexPath:path];[page tableView:table willDisplayCell:cell forRowAtIndexPath:path]; }
    CGFloat nativeGap=outgoing ? 21 : 24;
    CGFloat target=shouldCompact ? 2 : nativeGap; // Native visible perimeter: 9+8+1+3=21.
    for (NSUInteger pass=0;pass<4;pass++) {
        // Native subsequent layout rewrites its original 8pt container origin.
        // The production render boundary runs AFTER that original layout.
        for (CommonMessageCellView *v in views) { CSMessageMergeRestore(v);CGRect f=v.frame;f.origin.y=0;v.frame=f;CSMessageMergeRender(v); }
        CommonMessageCellView *first=views[0],*last=views[1];
        CGFloat end=first.frame.origin.y+CGRectGetMaxY([first convertRect:first.background.bounds fromView:first.background])-3;
        CGFloat start=last.frame.origin.y+CGRectGetMinY([last convertRect:last.background.bounds fromView:last.background])+1;
        CGFloat gap=[heights[0] doubleValue]+start-end;
        printf("GAP version=%s mode=%s unsupported=%d style=%d outgoing=%d pass=%lu actual=%.3f target=%.3f heights=%.3f,%.3f\n",
            [NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"] UTF8String],compact ? "compact" : "normal",unsupported,style,outgoing,(unsigned long)pass,gap,target,[heights[0] doubleValue],[heights[1] doubleValue]);
        CHECK(fabs(gap-target)<.01);if (shouldCompact) CHECK(gap<nativeGap/2); // Fixed logical geometry, no timing threshold.
        for (NSUInteger i=0;i<2;i++) CHECK([page tableView:table heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]]==[heights[i] doubleValue]);
        if (!shouldCompact) { CHECK([heights[0] doubleValue]==(outgoing ? 55 : 67));CHECK([heights[1] doubleValue]==55); }
    }
    for (CommonMessageCellView *v in views) { CSMessageMergeReuse(v);CSBubbleStyleDetach(v);CHECK(v.frame.origin.y==0);CHECK(!v.head.hidden); }
    CSMessageMergeDeactivate(page);
}
int main(void) { @autoreleasepool {
    printf("BUNDLE %s\n",[NSBundle.mainBundle.infoDictionary.description UTF8String]);
    ABI(TextMessageViewModel.class,@selector(cellDataForRow:),"@",@[@"Q"]);
    ABI(TextMessageViewModel.class,@selector(numberOfRowsInSection),"q",@[]);
    ABI(BaseMsgContentViewController.class,@selector(tableView:heightForRowAtIndexPath:),"d",@[@"@",@"@"]);
    ABI(BaseMsgContentViewController.class,@selector(tableView:cellForRowAtIndexPath:),"@",@[@"@",@"@"]);
    ABI(BaseMsgContentViewController.class,@selector(tableView:willDisplayCell:forRowAtIndexPath:),"v",@[@"@",@"@",@"@"]);
    ABI(BubbleInfo.class,@selector(getBubbleImage:isDarkMode:useCache:),"@",@[@"B",@"B",@"B"]);
    for (NSUInteger style=0;style<2;style++) {
        Scenario(YES,NO,NO,style,YES);Scenario(NO,NO,NO,style,YES);Scenario(YES,YES,NO,style,YES);Scenario(YES,NO,YES,style,YES);
        Scenario(YES,NO,NO,style,NO);Scenario(NO,NO,NO,style,NO);
    }
    printf("%s: %u checks, %u failures; actual production merge/bubble version gates, no CS_BUBBLE_TESTING/CS_MERGE_TESTING\n",failures ? "FAIL" : "PASS",checks,failures);
} return failures ? 1 : 0; }
