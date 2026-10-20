#import "CSCloseFriendProfileAdapter.h"
@interface CSCFProfileState : NSObject
@property(nonatomic,weak) UIViewController *owner;
@property(nonatomic,copy) NSString *userName, *coverUserName;
@property(nonatomic) NSUInteger epoch, generation;
@property(nonatomic,weak) id activeAssist;
@property(nonatomic,strong) UIView *cover;
@property(nonatomic,strong) NSMapTable<UIView *,NSNumber *> *hidden;
@property(nonatomic,copy) NSArray *rightItems;
@property(nonatomic,strong) UIView *titleView;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) id accessibilityElements;
@property(nonatomic) BOOL accessibilityElement, refreshing;
- (void)localAdd;
@end
@interface CSCFProfileAssistBinding : NSObject
@property(nonatomic,weak,readonly) UIViewController *owner;
@property(nonatomic,copy,readonly) NSString *userName;
@property(nonatomic,readonly) NSUInteger epoch, generation;
- (instancetype)initWithOwner:(UIViewController *)owner userName:(NSString *)userName epoch:(NSUInteger)epoch generation:(NSUInteger)generation;
@end
@implementation CSCFProfileAssistBinding
- (instancetype)initWithOwner:(UIViewController *)owner userName:(NSString *)userName epoch:(NSUInteger)epoch generation:(NSUInteger)generation {
    if((self=[super init])) { _owner=owner; _userName=[userName copy]; _epoch=epoch; _generation=generation; } return self;
}
@end
static char ProfileKey, AssistBindingKey;
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
    NSString *userName=CSCloseFriendUserName(CSCloseFriendRead(controller,@"m_contact"));
    id assist=CSCloseFriendRead(controller,@"m_oContactInfoAssist") ?: CSCloseFriendRead(controller,@"getContactInfoAssist");
    if(![state.userName isEqual:userName] || state.activeAssist!=assist) state.generation++;
    state.userName=userName; state.activeAssist=assist;
    NSString *assistUserName=CSCloseFriendUserName(CSCloseFriendRead(assist,@"m_contact"));
    if(assist && userName.length && [assistUserName isEqual:userName]) {
        CSCFProfileAssistBinding *binding=objc_getAssociatedObject(assist,&AssistBindingKey);
        if(binding.owner!=controller || binding.generation!=state.generation || binding.epoch!=state.epoch || ![binding.userName isEqual:userName]) {
            binding=[[CSCFProfileAssistBinding alloc] initWithOwner:controller userName:userName epoch:state.epoch generation:state.generation];
            objc_setAssociatedObject(assist,&AssistBindingKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    static NSHashTable *pages; static dispatch_once_t once;
    dispatch_once(&once,^{
        pages=[NSHashTable weakObjectsHashTable];
        [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){for(id page in pages.allObjects) CSCFProfileRefresh(page);}];
    });
    [pages addObject:controller];
}
BOOL CSCFProfileBlocksAction(id object) {
    if(CSCFIsClass(object,@"ContactInfoViewController")) {
        CSCFProfileBind(object); return Masked(objc_getAssociatedObject(object,&ProfileKey));
    }
    CSCFProfileAssistBinding *binding=objc_getAssociatedObject(object,&AssistBindingKey);
    id owner=binding.owner ?: CSCloseFriendRead(object,@"getViewController");
    CSCFProfileBind(owner);
    binding=objc_getAssociatedObject(object,&AssistBindingKey);
    CSCFProfileState *state=objc_getAssociatedObject(owner,&ProfileKey);
    NSString *actualUserName=CSCloseFriendUserName(CSCloseFriendRead(object,@"m_contact"));
    if(state || binding) {
        // A retired assist never borrows the replacement contact's authorization.
        if(!binding || !state || state.activeAssist!=object || binding.owner!=owner ||
           binding.epoch!=CSCloseFriendAccountEpoch() || binding.generation!=state.generation ||
           ![binding.userName isEqual:state.userName] || ![binding.userName isEqual:actualUserName]) return YES;
    }
    if(CSCloseFriendCurrentSnapshot().blocked) return YES;
    return ![actualUserName hasSuffix:@"@chatroom"] && CSCloseFriendShouldHideUserName(actualUserName,CSCloseFriendSurfaceProfile);
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
