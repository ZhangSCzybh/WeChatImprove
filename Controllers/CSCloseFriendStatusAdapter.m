#import "CSCloseFriendSocialAdapter.h"
#import <objc/message.h>
static id GridOwner;
static char StatusRevisionKey, CardRevisionKey, EmptySupplementKey;
static NSArray *RawNames(id owner) { id names=CSCloseFriendRead(owner,@"usernameList"); return [names isKindOfClass:NSArray.class] ? names : @[]; }
static CSCloseFriendSocialProjection *Cards(id owner) { return CSCFSocialProject(CSCFPageIsCurrent(owner) ? RawNames(owner) : @[],CSCloseFriendSurfaceStatus); }
static void Track(id owner) {
    CSCFPageIsCurrent(owner);
    CSCFSocialTrack(owner,^(id page){
        objc_setAssociatedObject(page,&StatusRevisionKey,@(CSCloseFriendCurrentSnapshot().revision),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        CSCFReloadTables(page);
        id cards=CSCloseFriendRead(page,@"cardListViewController");
        if([cards isKindOfClass:UIViewController.class]) {
            // Revealed card state must never survive a relock, even if the native sliding window caches it.
            if(CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceStatus)) {
                CSCFSocialGate(cards,CSCloseFriendSurfaceStatus,YES);
                UIViewController *vc=cards;
                if(vc.presentingViewController) [vc dismissViewControllerAnimated:NO completion:nil];
                else if(vc.navigationController.topViewController==vc) [vc.navigationController popViewControllerAnimated:NO];
            } else CSCFCallVoid(cards,@"reloadData");
        }
    });
}
static id BeginGrid(id owner) { id old=GridOwner; GridOwner=NSThread.isMainThread ? owner : nil; Track(owner); return old; }
static BOOL CurrentGrid(id owner) { NSNumber *revision=objc_getAssociatedObject(owner,&StatusRevisionKey); return CSCFPageIsCurrent(owner) && revision && revision.unsignedIntegerValue==CSCloseFriendCurrentSnapshot().revision; }
static BOOL TopicHasHidden(id owner,NSInteger section) {
    SEL selector=NSSelectorFromString(@"topInfoCellCount");
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],selector),"q@:")) return YES;
    NSInteger top=((NSInteger(*)(id,SEL))objc_msgSend)(owner,selector);
    NSArray *topics=CSCloseFriendRead(owner,@"friendTopicList");
    if(section<top || (NSUInteger)(section-top)>=topics.count) return NO;
    id old=GridOwner; GridOwner=nil;
    NSArray *names=CSCloseFriendRead(topics[(NSUInteger)(section-top)],@"usernames"); GridOwner=old;
    return CSCFSocialProject(names,CSCloseFriendSurfaceStatus).visible.count<[names count];
}
static BOOL CardUnsupported(id page) {
    NSNumber *revision=objc_getAssociatedObject(page,&CardRevisionKey);
    return !CSCFPageIsCurrent(page) || !revision || revision.unsignedIntegerValue!=CSCloseFriendCurrentSnapshot().revision || !CSCFIsClass(CSCloseFriendRead(page,@"dataProvider"),@"TextStateFriendSquareViewController");
}
static void InstallGrid(void) {
    __block IMP names=NULL;
    IMP replacement=imp_implementationWithBlock(^id(id topic){id source=((id(*)(id,SEL))names)(topic,NSSelectorFromString(@"usernames"));
        NSArray *topics=NSThread.isMainThread && GridOwner ? CSCloseFriendRead(GridOwner,@"friendTopicList") : nil;
        return [topics containsObject:topic] ? CSCFSocialProject(CSCFPageIsCurrent(GridOwner) ? source : @[],CSCloseFriendSurfaceStatus).visible : source;
    });
    if(!CSCloseFriendInstallHook(@"TextStateTopicModel",@"usernames",replacement,&names,"@@:")) imp_removeBlock(replacement);
    __block IMP count=NULL;
    replacement=imp_implementationWithBlock(^NSInteger(id owner,id collection,NSInteger section){
        id old=BeginGrid(owner); objc_setAssociatedObject(owner,&StatusRevisionKey,@(CSCloseFriendCurrentSnapshot().revision),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        @try {return ((NSInteger(*)(id,SEL,id,NSInteger))count)(owner,NSSelectorFromString(@"collectionView:numberOfItemsInSection:"),collection,section);} @finally {GridOwner=old;}
    });
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"collectionView:numberOfItemsInSection:",replacement,&count,"q@:@q")) imp_removeBlock(replacement);
    __block IMP cell=NULL;
    replacement=imp_implementationWithBlock(^id(id owner,id collection,id path){id old=BeginGrid(owner); @try {return ((id(*)(id,SEL,id,id))cell)(owner,NSSelectorFromString(@"collectionView:cellForItemAtIndexPath:"),collection,path);} @finally {GridOwner=old;} });
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"collectionView:cellForItemAtIndexPath:",replacement,&cell,"@@:@@")) imp_removeBlock(replacement);
    __block IMP select=NULL;
    replacement=imp_implementationWithBlock(^(id owner,id collection,id path){if(!CurrentGrid(owner)) return; id old=BeginGrid(owner); @try {((void(*)(id,SEL,id,id))select)(owner,NSSelectorFromString(@"collectionView:didSelectItemAtIndexPath:"),collection,path);} @finally {GridOwner=old;} });
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"collectionView:didSelectItemAtIndexPath:",replacement,&select,"v@:@@")) imp_removeBlock(replacement);
    __block IMP supplementary=NULL;
    replacement=imp_implementationWithBlock(^id(id owner,id collection,id kind,id path){id old=BeginGrid(owner); @try {UIView *view=((id(*)(id,SEL,id,id,id))supplementary)(owner,NSSelectorFromString(@"collectionView:viewForSupplementaryElementOfKind:atIndexPath:"),collection,kind,path);
            NSArray *saved=objc_getAssociatedObject(view,&EmptySupplementKey);
            if(saved) {view.hidden=[saved[0] boolValue]; view.accessibilityElementsHidden=[saved[1] boolValue]; objc_setAssociatedObject(view,&EmptySupplementKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
            if(TopicHasHidden(owner,[path section])) {objc_setAssociatedObject(view,&EmptySupplementKey,@[@(view.hidden),@(view.accessibilityElementsHidden)],OBJC_ASSOCIATION_RETAIN_NONATOMIC); view.hidden=YES; view.accessibilityElementsHidden=YES;}
            return view;} @finally {GridOwner=old;} });
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"collectionView:viewForSupplementaryElementOfKind:atIndexPath:",replacement,&supplementary,"@@:@@@")) imp_removeBlock(replacement);
    __block IMP size=NULL;
    replacement=imp_implementationWithBlock(^CGSize(id owner,id collection,id layout,id path){id old=BeginGrid(owner); @try {return ((CGSize(*)(id,SEL,id,id,id))size)(owner,NSSelectorFromString(@"collectionView:layout:sizeForItemAtIndexPath:"),collection,layout,path);} @finally {GridOwner=old;} });
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"collectionView:layout:sizeForItemAtIndexPath:",replacement,&size,"{CGSize=dd}@:@@@")) imp_removeBlock(replacement);
    for(NSString *name in @[@"collectionView:layout:referenceSizeForHeaderInSection:",@"collectionView:layout:referenceSizeForFooterInSection:"]) {
        __block IMP raw=NULL; SEL selector=NSSelectorFromString(name);
        replacement=imp_implementationWithBlock(^CGSize(id owner,id collection,id layout,NSInteger section){id old=BeginGrid(owner); @try {return TopicHasHidden(owner,section) ? CGSizeZero : ((CGSize(*)(id,SEL,id,id,NSInteger))raw)(owner,selector,collection,layout,section);} @finally {GridOwner=old;} });
        if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",name,replacement,&raw,"{CGSize=dd}@:@@q")) imp_removeBlock(replacement);
    }
    __block IMP index=NULL;
    replacement=imp_implementationWithBlock(^id(id owner,id username){if(!CSCFPageIsCurrent(owner) || CSCFSocialHidden(username,CSCloseFriendSurfaceStatus)) return nil; id old=BeginGrid(owner); @try {return ((id(*)(id,SEL,id))index)(owner,NSSelectorFromString(@"indexPathForUsername:"),username);} @finally {GridOwner=old;} });
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"indexPathForUsername:",replacement,&index,"@@:@")) imp_removeBlock(replacement);
    CSCFSocialHook1(@"TextStateFriendSquareViewController",@"jumpToCardListForUsername:",^(id owner,id username,void(^orig)(id)){
        if(!CSCFPageIsCurrent(owner) || CSCFSocialHidden(username,CSCloseFriendSurfaceStatus)) return;
        id old=GridOwner; GridOwner=nil; @try {orig(username);} @finally {GridOwner=old;}
    });
}
static void InstallCards(void) {
    __block IMP count=NULL;
    IMP replacement=imp_implementationWithBlock(^NSUInteger(id owner){Track(owner); return Cards(owner).visible.count;});
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"count",replacement,&count,"Q@:")) imp_removeBlock(replacement);
    __block IMP configure=NULL;
    replacement=imp_implementationWithBlock(^(id owner,id card,NSUInteger index){Track(owner); NSUInteger source=[Cards(owner) sourceIndex:index]; if(source!=NSNotFound) ((void(*)(id,SEL,id,NSUInteger))configure)(owner,NSSelectorFromString(@"configureCardView:atIndex:"),card,source);});
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"configureCardView:atIndex:",replacement,&configure,"v@:@Q")) imp_removeBlock(replacement);
    __block IMP change=NULL;
    replacement=imp_implementationWithBlock(^(id owner,NSUInteger index){NSUInteger source=[Cards(owner) sourceIndex:index]; if(source!=NSNotFound) ((void(*)(id,SEL,NSUInteger))change)(owner,NSSelectorFromString(@"onChangeToCardAtIndex:"),source);});
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"onChangeToCardAtIndex:",replacement,&change,"v@:Q")) imp_removeBlock(replacement);
    __block IMP begin=NULL;
    replacement=imp_implementationWithBlock(^NSUInteger(id owner){NSUInteger source=((NSUInteger(*)(id,SEL))begin)(owner,NSSelectorFromString(@"beginIndex")); NSUInteger visible=[Cards(owner).indexes indexOfObject:@(source)]; return visible==NSNotFound ? 0 : visible;});
    if(!CSCloseFriendInstallHook(@"TextStateFriendSquareViewController",@"beginIndex",replacement,&begin,"Q@:")) imp_removeBlock(replacement);
    // Direct/single providers have no verified owner identity on every state variant. Gate those
    // routes while concealed, rather than showing an unverified native single-card source.
    for(NSString *name in @[@"viewDidLoad",@"viewDidLayoutSubviews"]) CSCFSocialHook0(@"TextStateCardListViewController",name,^(id page,void(^orig)(void)){
        if([name isEqual:@"viewDidLoad"]) objc_setAssociatedObject(page,&CardRevisionKey,@(CSCloseFriendCurrentSnapshot().revision),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        orig(); BOOL unsupported=CardUnsupported(page);
        CSCFSocialGate(page,CSCloseFriendSurfaceStatus,unsupported);
        CSCFSocialTrack(page,^(id owner){
            if(CSCloseFriendSurfaceConcealed(CSCloseFriendCurrentSnapshot(),CSCloseFriendSurfaceStatus)) {
                CSCFSocialGate(owner,CSCloseFriendSurfaceStatus,YES);
                UIViewController *vc=owner;
                if(vc.presentingViewController) [vc dismissViewControllerAnimated:NO completion:nil];
                else if(vc.navigationController.topViewController==vc) [vc.navigationController popViewControllerAnimated:NO];
            } else {CSCFSocialGate(owner,CSCloseFriendSurfaceStatus,NO); CSCFCallVoid(owner,@"reloadData");}
        });
    });
    for(NSString *name in @[@"onTapCommentButton:",@"doHeadImageAction:"]) CSCFSocialHook1(@"TextStateCardListViewController",name,^(id owner,id arg,void(^orig)(id)){
        BOOL unsupported=CardUnsupported(owner);
        if(!CSCFSocialGate(owner,CSCloseFriendSurfaceStatus,unsupported)) orig(arg);
    });
}
void CSCFStatusInstall(void) {
    BOOL ready=CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(@"TextStateTopicModel"),NSSelectorFromString(@"usernames")),"@@:");
    NSDictionary *contracts=@{@"usernameList":@"@@:",@"friendTopicList":@"@@:",@"topInfoCellCount":@"q@:",@"count":@"Q@:",@"configureCardView:atIndex:":@"v@:@Q",@"beginIndex":@"Q@:",@"collectionView:numberOfItemsInSection:":@"q@:@q",@"collectionView:cellForItemAtIndexPath:":@"@@:@@",@"collectionView:didSelectItemAtIndexPath:":@"v@:@@"};
    for(NSString *selector in contracts) ready &= CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(@"TextStateFriendSquareViewController"),NSSelectorFromString(selector)),[contracts[selector] UTF8String]);
    CSCloseFriendRecordCapability(@"social.status.coupled",ready);
    if(!ready) {CSCFSocialProtectRoute(@"TextStateFriendSquareViewController",CSCloseFriendSurfaceStatus); CSCFSocialProtectRoute(@"TextStateCardListViewController",CSCloseFriendSurfaceStatus); return;}
    InstallGrid(); InstallCards();
    CSCFSocialHook0(@"TextStateFriendSquareViewController",@"viewDidLoad",^(id owner,void(^orig)(void)){orig(); Track(owner);});
    CSCloseFriendRecordCapability(@"social.status.single.filtered",NO);
}
