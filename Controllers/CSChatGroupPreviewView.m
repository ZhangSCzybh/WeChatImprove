#import "CSChatGroupPreviewView.h"
#import "WESessionTabContainerView.h"
#import "CSGroupAppearance.h"

// Selection in a settings sample must not trigger the user's real haptics.
@interface CSGroupPreviewTabContainer : WESessionTabContainerView @end
@implementation CSGroupPreviewTabContainer
- (void)triggerHapticFeedback {}
@end

@interface CSChatGroupPreviewView ()
@property(nonatomic, strong) CSGroupPreviewTabContainer *tabBar;
@property(nonatomic, copy) NSArray<WESessionTabItem *> *tabs;
@property(nonatomic, strong) NSArray<UIImageView *> *avatars;
@property(nonatomic, strong) NSArray<UILabel *> *names, *messages, *times;
@property(nonatomic, strong) UIView *separator;
@property(nonatomic, strong) UILabel *emptyLabel;
@end

@implementation CSChatGroupPreviewView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        self.clipsToBounds=YES;
        self.layer.cornerRadius=10;
        self.backgroundColor=UIColor.systemBackgroundColor;
        self.accessibilityIdentifier=@"cs.preview.chat-group";
        self.tabBar=[[CSGroupPreviewTabContainer alloc] initWithFrame:CGRectZero];
        [self addSubview:self.tabBar];
        __weak typeof(self) weakSelf=self;
        self.tabBar.onTabSelected=^(__unused NSInteger index) { [weakSelf updateSampleContent]; };
        NSMutableArray *avatars=[NSMutableArray array], *names=[NSMutableArray array];
        NSMutableArray *messages=[NSMutableArray array], *times=[NSMutableArray array];
        for (NSUInteger i=0;i<2;i++) {
            UIImageView *avatar=[[UIImageView alloc] initWithImage:[UIImage systemImageNamed:i ? @"person.2.fill" : @"person.fill"]];
            avatar.contentMode=UIViewContentModeScaleAspectFit;
            avatar.tintColor=i ? UIColor.systemOrangeColor : UIColor.systemTealColor;
            avatar.backgroundColor=[avatar.tintColor colorWithAlphaComponent:.12];
            avatar.layer.cornerRadius=7; avatar.clipsToBounds=YES;
            [self addSubview:avatar]; [avatars addObject:avatar];
            UILabel *name=[[UILabel alloc] init]; name.font=[UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
            name.textColor=UIColor.labelColor;
            UILabel *message=[[UILabel alloc] init]; message.font=[UIFont systemFontOfSize:11];
            message.textColor=UIColor.secondaryLabelColor;
            UILabel *time=[[UILabel alloc] init]; time.font=[UIFont systemFontOfSize:10];
            time.textColor=UIColor.tertiaryLabelColor; time.textAlignment=NSTextAlignmentRight;
            time.text=i ? @"09:38" : @"09:41";
            for (UILabel *label in @[name,message,time]) { label.lineBreakMode=NSLineBreakByTruncatingTail; [self addSubview:label]; }
            [names addObject:name]; [messages addObject:message]; [times addObject:time];
        }
        self.avatars=avatars; self.names=names; self.messages=messages; self.times=times;
        self.separator=[[UIView alloc] init]; self.separator.backgroundColor=UIColor.separatorColor; [self addSubview:self.separator];
        self.emptyLabel=[[UILabel alloc] init]; self.emptyLabel.text=@"分组均已隐藏，可在下方恢复显示";
        self.emptyLabel.textColor=UIColor.secondaryLabelColor; self.emptyLabel.font=[UIFont systemFontOfSize:12];
        self.emptyLabel.textAlignment=NSTextAlignmentCenter; self.emptyLabel.numberOfLines=2; [self addSubview:self.emptyLabel];
    }
    return self;
}

- (void)configureWithTabs:(NSArray<WESessionTabItem *> *)tabs {
    self.tabs=[tabs copy];
    NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
    [self.tabBar applyAppearanceWithFontSize:CSGroupTabFontSize(defaults) showsSearchButton:CSGroupSearchButtonVisible(defaults)];
    [self.tabBar updateTabs:self.tabs];
    [self.tabBar refreshAppearance];
    for (NSUInteger i=0;i<self.tabs.count;i++) {
        WESessionTabItem *tab=self.tabs[i];
        BOOL hidden=[defaults boolForKey:tab.type==WETabTypeAll ? @"com.wechat.enhance.chat_group.hide_all_badge" : @"com.wechat.enhance.chat_group.hide_group_badge"];
        // Explicitly fictional unread counts, never obtained from WeChat's sessions.
        [self.tabBar updateUnreadCount:hidden ? 0 : (tab.type==WETabTypeAll ? 3 : 1) hasRedDot:NO forTabIndex:(NSInteger)i];
    }
    self.emptyLabel.hidden=self.tabs.count>0;
    [self updateSampleContent];
    [self setNeedsLayout];
}

- (void)updateSampleContent {
    NSInteger selected=self.tabBar.selectedIndex;
    WETabType type=selected>=0 && selected<(NSInteger)self.tabs.count ? self.tabs[(NSUInteger)selected].type : WETabTypeAll;
    NSArray *titles=type==WETabTypeGroup ? @[@"周末出游群",@"项目讨论群"] :
        type==WETabTypeOfficial ? @[@"服务通知",@"订阅号消息"] :
        type==WETabTypePrivate ? @[@"微信好友",@"文件传输助手"] : @[@"微信好友",@"周末出游群"];
    self.names[0].text=titles[0]; self.names[1].text=titles[1];
    self.messages[0].text=@"这是一条示例消息"; self.messages[1].text=@"预览当前标签与角标样式";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=CGRectGetWidth(self.bounds), height=CGRectGetHeight(self.bounds);
    CGFloat tabHeight=MIN(MAX(52,self.tabBar.intrinsicContentSize.height),MAX(0,height-76));
    self.tabBar.frame=CGRectMake(0,0,width,tabHeight);
    CGFloat rowHeight=MAX(0,(height-tabHeight)/2);
    for (NSUInteger i=0;i<2;i++) {
        CGFloat y=tabHeight+i*rowHeight;
        self.avatars[i].frame=CGRectMake(10,y+MAX(0,(rowHeight-30)/2),30,30);
        self.names[i].frame=CGRectMake(49,y+5,MAX(0,width-103),18);
        self.messages[i].frame=CGRectMake(49,y+23,MAX(0,width-59),15);
        self.times[i].frame=CGRectMake(MAX(0,width-46),y+7,36,14);
    }
    self.separator.frame=CGRectMake(49,tabHeight+rowHeight,MAX(0,width-49),.5);
    self.emptyLabel.frame=CGRectMake(12,0,MAX(0,width-24),tabHeight);
    self.tabBar.hidden=!self.tabs.count;
}
@end
