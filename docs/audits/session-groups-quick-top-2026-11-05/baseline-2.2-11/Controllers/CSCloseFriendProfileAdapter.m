#import "CSCloseFriendProfileAdapter.h"
@interface CSCFProfileState : NSObject
@property(nonatomic,weak) UIViewController *owner;
@property(nonatomic,copy) NSString *userName;
@property(nonatomic) NSUInteger epoch, generation, renderedGeneration;
@property(nonatomic,weak) id activeAssist;
@property(nonatomic) BOOL refreshing, rendered, renderedMasked, shielded, originalHidden;
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
static char ProfileKey, AssistBindingKey, PresentationDepthKey;
static BOOL Masked(CSCFProfileState *state) {
    if(!state) return NO;
    if(state.epoch!=CSCloseFriendAccountEpoch() || CSCloseFriendCurrentSnapshot().blocked) return YES;
    return ![state.userName hasSuffix:@"@chatroom"] && CSCloseFriendShouldHideUserName(state.userName,CSCloseFriendSurfaceProfile);
}
@implementation CSCFProfileState
- (void)localAdd {
    if(!Masked(self) || !self.owner || self.epoch!=CSCloseFriendAccountEpoch()) return;
    // The intercepted native Add action stops here; it never reaches verification/network code.
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
        [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){for(id page in pages.allObjects) CSCFRefreshSurface(page,^(id owner){CSCFProfileRefresh(owner);});}];
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
BOOL CSCFProfileBlocksNavigation(id object) {
    // Keep ordinary/revealed native routing and the existing binding validation.
    // Only a concealed CURRENT profile receives this read-only exception.
    if(!CSCFProfileBlocksAction(object)) return NO;
    if(CSCloseFriendCurrentSnapshot().blocked) return YES;
    if(CSCFIsClass(object,@"ContactInfoViewController")) {
        CSCFProfileState *state=objc_getAssociatedObject(object,&ProfileKey);
        return !state || state.epoch!=CSCloseFriendAccountEpoch();
    }
    CSCFProfileAssistBinding *binding=objc_getAssociatedObject(object,&AssistBindingKey);
    CSCFProfileState *state=objc_getAssociatedObject(binding.owner,&ProfileKey);
    NSString *actualUserName=CSCloseFriendUserName(CSCloseFriendRead(object,@"m_contact"));
    return !binding || !state || state.activeAssist!=object ||
        state.epoch!=CSCloseFriendAccountEpoch() || binding.epoch!=state.epoch ||
        binding.generation!=state.generation || ![binding.userName isEqual:state.userName] ||
        ![binding.userName isEqual:actualUserName];
}
void CSCFProfileWithNativePresentation(id object,void (^render)(void)) {
    if(!NSThread.isMainThread || !CSCFProfileBlocksAction(object)) { render(); return; }
    NSUInteger depth=[objc_getAssociatedObject(object,&PresentationDepthKey) unsignedIntegerValue];
    objc_setAssociatedObject(object,&PresentationDepthKey,@(depth+1),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    @try { render(); }
    @finally { objc_setAssociatedObject(object,&PresentationDepthKey,@(depth),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
}
BOOL CSCFProfileUsesNativeStranger(id object) {
    return NSThread.isMainThread && [objc_getAssociatedObject(object,&PresentationDepthKey) unsignedIntegerValue]>0 && CSCFProfileBlocksAction(object);
}
void CSCFProfileLocalAdd(id object) {
    id owner=CSCFIsClass(object,@"ContactInfoViewController") ? object : CSCloseFriendRead(object,@"getViewController");
    CSCFProfileBind(owner);
    CSCFProfileState *state=objc_getAssociatedObject(owner,&ProfileKey);
    [state localAdd];
}
void CSCFProfileRefresh(id controller) {
    CSCFProfileBind(controller);
    CSCFProfileState *state=objc_getAssociatedObject(controller,&ProfileKey); UIViewController *page=state.owner;
    if(!state || !page.isViewLoaded || state.refreshing) return;
    BOOL stale=state.epoch!=CSCloseFriendAccountEpoch() || CSCloseFriendCurrentSnapshot().blocked;
    if(stale) {
        if(!state.shielded) state.originalHidden=page.view.hidden;
        state.shielded=YES; page.view.hidden=YES; return;
    }
    if(state.shielded) { page.view.hidden=state.originalHidden; state.shielded=NO; }
    BOOL masked=Masked(state);
    BOOL changed=!state.rendered || state.renderedMasked!=masked || state.renderedGeneration!=state.generation;
    state.rendered=YES; state.renderedMasked=masked; state.renderedGeneration=state.generation;
    if(!changed) return;
    state.refreshing=YES;
    @try {
        // Rebuild the ORIGINAL native sections/buttons in a narrow display scope.
        // No overlay, copied avatar, synthetic profile or mutation of CContact friendship.
        CSCFCallVoid(state.activeAssist,@"reloadTableView");
    } @finally { state.refreshing=NO; }
}
