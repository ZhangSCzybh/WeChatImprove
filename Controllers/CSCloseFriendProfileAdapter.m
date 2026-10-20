#import "CSCloseFriendProfileAdapter.h"
@interface CSCFProfileState : NSObject
@property(nonatomic,weak) UIViewController *owner;
@property(nonatomic,copy) NSString *userName, *coverUserName;
@property(nonatomic) NSUInteger epoch;
@property(nonatomic,strong) UIView *cover;
@property(nonatomic,strong) NSMapTable<UIView *,NSNumber *> *hidden;
@property(nonatomic,copy) NSArray *rightItems;
@property(nonatomic,strong) UIView *titleView;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) id accessibilityElements;
@property(nonatomic) BOOL accessibilityElement, refreshing;
- (void)localAdd;
@end
static char ProfileKey;
static BOOL Masked(CSCFProfileState *state) {
    if(!state) return NO;
    if(state.epoch!=CSCloseFriendAccountEpoch() || CSCloseFriendCurrentSnapshot().blocked) return YES;
    return ![state.userName hasSuffix:@"@chatroom"] && CSCloseFriendShouldHideUserName(state.userName,CSCloseFriendSurfaceProfile);
}
@implementation CSCFProfileState
- (void)localAdd {
    if(!Masked(self) || !self.owner || self.epoch!=CSCloseFriendAccountEpoch()) return;
    // This target has no connection to native add/verify/message/call selectors.
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"暂时无法添加到通讯录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil]];
    [self.owner presentViewController:alert animated:YES completion:nil];
}
@end
void CSCFProfileBind(id controller) {
    if(![controller isKindOfClass:UIViewController.class] || !CSCFIsClass(controller,@"ContactInfoViewController")) return;
    CSCFProfileState *state=objc_getAssociatedObject(controller,&ProfileKey);
    if(!state) {
        state=[CSCFProfileState new]; state.owner=controller; state.epoch=CSCloseFriendAccountEpoch();
        objc_setAssociatedObject(controller,&ProfileKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    state.userName=CSCloseFriendUserName(CSCloseFriendRead(controller,@"m_contact"));
    id assist=CSCloseFriendRead(controller,@"m_oContactInfoAssist") ?: CSCloseFriendRead(controller,@"getContactInfoAssist");
    if(assist) objc_setAssociatedObject(assist,&ProfileKey,state,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    static NSHashTable *pages; static dispatch_once_t once;
    dispatch_once(&once,^{
        pages=[NSHashTable weakObjectsHashTable];
        [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){for(id page in pages.allObjects) CSCFProfileRefresh(page);}];
    });
    [pages addObject:controller];
}
BOOL CSCFProfileBlocksAction(id object) {
    CSCFProfileState *state=objc_getAssociatedObject(object,&ProfileKey);
    {
        id owner=state.owner ?: (CSCFIsClass(object,@"ContactInfoViewController") ? object : CSCloseFriendRead(object,@"getViewController"));
        CSCFProfileBind(owner); state=objc_getAssociatedObject(object,&ProfileKey);
    }
    return Masked(state);
}
static NSString *PublicNickname(id contact,NSString *fallback) {
    id name=CSCloseFriendRead(contact,@"m_nsNickName");
    return [name isKindOfClass:NSString.class] && [name length] ? name : fallback;
}
static UIView *PublicAvatar(id assist) {
    UIView *head=CSCloseFriendRead(assist,@"m_headView");
    if([head isKindOfClass:UIView.class] && head.bounds.size.width>0 && head.bounds.size.height>0) {
        // Snapshot only the public avatar view, never the surrounding remark/status header.
        UIView *snapshot=[head snapshotViewAfterScreenUpdates:NO]; if(snapshot) {snapshot.userInteractionEnabled=NO; return snapshot;}
    }
    UIImageView *fallback=[[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"person.crop.square.fill"]];
    fallback.tintColor=UIColor.tertiaryLabelColor; fallback.contentMode=UIViewContentModeScaleAspectFit; return fallback;
}
void CSCFProfileRefresh(id controller) {
    CSCFProfileBind(controller);
    CSCFProfileState *state=objc_getAssociatedObject(controller,&ProfileKey); UIViewController *page=state.owner;
    if(!state || !page.isViewLoaded || state.refreshing) return;
    state.refreshing=YES;
    BOOL identityChanged=state.cover && ![state.coverUserName isEqual:state.userName];
    if(!Masked(state) || identityChanged) {
        if(state.cover) {
            [state.cover removeFromSuperview]; state.cover=nil;
            for(UIView *child in state.hidden) child.hidden=[[state.hidden objectForKey:child] boolValue];
            page.view.isAccessibilityElement=state.accessibilityElement; page.view.accessibilityElements=state.accessibilityElements;
            page.navigationItem.rightBarButtonItems=state.rightItems; page.navigationItem.titleView=state.titleView; page.navigationItem.title=state.title; state.hidden=nil;
            // Rebuild from the intact real contact, rather than replaying cached friend controls.
            CSCFCallVoid(page,@"reloadView"); CSCFCallVoid(CSCloseFriendRead(page,@"m_oContactInfoAssist"),@"reloadTableView");
        }
        if(!Masked(state)) {state.refreshing=NO; return;}
    }
    BOOL stale=state.epoch!=CSCloseFriendAccountEpoch() || CSCloseFriendCurrentSnapshot().blocked;
    if(!state.cover) {
        state.hidden=[NSMapTable weakToStrongObjectsMapTable]; state.rightItems=page.navigationItem.rightBarButtonItems; state.titleView=page.navigationItem.titleView; state.title=page.navigationItem.title;
        state.accessibilityElement=page.view.isAccessibilityElement; state.accessibilityElements=page.view.accessibilityElements;
        UIView *cover=[[UIView alloc] initWithFrame:page.view.bounds]; cover.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight; cover.backgroundColor=UIColor.systemGroupedBackgroundColor;
        UIView *card=[UIView new]; card.backgroundColor=UIColor.systemBackgroundColor;
        UIView *avatar=PublicAvatar(CSCloseFriendRead(page,@"m_oContactInfoAssist")); avatar.layer.cornerRadius=8; avatar.clipsToBounds=YES;
        id contact=CSCloseFriendRead(page,@"m_contact");
        UILabel *nickname=[UILabel new]; nickname.text=PublicNickname(contact,state.userName); nickname.font=[UIFont preferredFontForTextStyle:UIFontTextStyleTitle2]; nickname.numberOfLines=2;
        UILabel *identity=[UILabel new]; identity.text=[NSString stringWithFormat:@"微信号：%@",state.userName ?: @""]; identity.textColor=UIColor.secondaryLabelColor; identity.font=[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]; identity.numberOfLines=2;
        UIStackView *text=[[UIStackView alloc] initWithArrangedSubviews:@[nickname,identity]]; text.axis=UILayoutConstraintAxisVertical; text.spacing=8;
        UIButton *add=[UIButton buttonWithType:UIButtonTypeSystem]; [add setTitle:@"添加到通讯录" forState:UIControlStateNormal]; add.titleLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]; add.backgroundColor=UIColor.systemBackgroundColor; [add addTarget:state action:@selector(localAdd) forControlEvents:UIControlEventTouchUpInside];
        [cover addSubview:card]; [card addSubview:avatar]; [card addSubview:text]; [cover addSubview:add];
        for(UIView *view in @[card,avatar,text,add]) view.translatesAutoresizingMaskIntoConstraints=NO;
        [NSLayoutConstraint activateConstraints:@[
            [card.topAnchor constraintEqualToAnchor:cover.safeAreaLayoutGuide.topAnchor], [card.leadingAnchor constraintEqualToAnchor:cover.leadingAnchor], [card.trailingAnchor constraintEqualToAnchor:cover.trailingAnchor],
            [avatar.topAnchor constraintEqualToAnchor:card.topAnchor constant:24], [avatar.leadingAnchor constraintEqualToAnchor:card.leadingAnchor constant:24], [avatar.widthAnchor constraintEqualToConstant:64], [avatar.heightAnchor constraintEqualToConstant:64], [avatar.bottomAnchor constraintLessThanOrEqualToAnchor:card.bottomAnchor constant:-24],
            [text.leadingAnchor constraintEqualToAnchor:avatar.trailingAnchor constant:18], [text.trailingAnchor constraintEqualToAnchor:card.trailingAnchor constant:-24], [text.topAnchor constraintEqualToAnchor:card.topAnchor constant:24], [text.bottomAnchor constraintEqualToAnchor:card.bottomAnchor constant:-24],
            [add.topAnchor constraintEqualToAnchor:card.bottomAnchor constant:12], [add.leadingAnchor constraintEqualToAnchor:cover.leadingAnchor], [add.trailingAnchor constraintEqualToAnchor:cover.trailingAnchor], [add.heightAnchor constraintGreaterThanOrEqualToConstant:56]
        ]];
        state.cover=cover; state.coverUserName=state.userName;
    }
    for(UIView *child in page.view.subviews) if(child!=state.cover) {if(![state.hidden objectForKey:child]) [state.hidden setObject:@(child.hidden) forKey:child]; child.hidden=YES;}
    // On an account boundary even public identity from the previous account is no longer displayed.
    for(UIView *child in state.cover.subviews) child.hidden=stale;
    if(state.cover.superview!=page.view) [page.view addSubview:state.cover];
    [page.view bringSubviewToFront:state.cover]; page.navigationItem.rightBarButtonItems=nil; page.navigationItem.titleView=nil; page.navigationItem.title=@"详细资料";
    page.view.isAccessibilityElement=NO; page.view.accessibilityElements=@[state.cover]; state.refreshing=NO;
}
