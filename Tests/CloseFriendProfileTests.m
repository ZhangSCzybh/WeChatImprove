#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSCloseFriendPolicy.h"
#import "CSCloseFriendSignatures.h"
static NSUInteger Epoch=1,Checks;
static CSCloseFriendSnapshot *Current;
static NSString *const CSCloseFriendPolicyDidChangeNotification=@"PolicyChanged";
static NSUInteger CSCloseFriendAccountEpoch(void) {return Epoch;}
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {return Current;}
static BOOL CSCloseFriendShouldHideUserName(NSString *name,CSCloseFriendSurface surface) {return [Current hidesUserName:name surface:surface];}
static id CSCloseFriendRead(id object,NSString *key) {@try {return [object valueForKey:key];} @catch(__unused NSException *e) {return nil;}}
static NSString *CSCloseFriendUserName(id object) {return CSCloseFriendRead(object,@"username");}
static BOOL CSCFIsClass(id object,NSString *name) {return [object isKindOfClass:NSClassFromString(name)];}
// Page visibility scheduling is covered by the contact fixture; run its callback inline here.
static void CSCFRefreshSurface(id owner,void (^refresh)(id)) {refresh(owner);}
static BOOL CSCFCallVoid(id object,NSString *name) {
    SEL selector=NSSelectorFromString(name); Method method=class_getInstanceMethod([object class],selector);
    if(!CSCloseFriendMethodMatches(method,"v@:")) return NO;
    ((void(*)(id,SEL))objc_msgSend)(object,selector); return YES;
}
static BOOL CSCloseFriendInstallHook(NSString *cls,NSString *name,IMP replacement,IMP *original,const char *encoding) {
    Class type=NSClassFromString(cls); SEL selector=NSSelectorFromString(name); Method method=class_getInstanceMethod(type,selector);
    if(!CSCloseFriendMethodMatches(method,encoding)) return NO;
    *original=method_getImplementation(method); class_replaceMethod(type,selector,replacement,method_getTypeEncoding(method)); return YES;
}
@interface UIView : NSObject
@property(nonatomic) BOOL hidden;
@end
@implementation UIView @end
@interface UIViewController : NSObject
@property(nonatomic,strong) UIView *view;
@property(nonatomic) BOOL isViewLoaded;
@property(nonatomic) NSUInteger alerts;
- (void)presentViewController:(id)controller animated:(BOOL)animated completion:(void(^)(void))completion;
@end
@implementation UIViewController
- (void)presentViewController:(__unused id)controller animated:(__unused BOOL)animated completion:(void(^)(void))completion {self.alerts++; if(completion)completion();}
@end
#define UIAlertControllerStyleAlert 1
#define UIAlertActionStyleCancel 1
@interface UIAlertAction : NSObject
+ (instancetype)actionWithTitle:(NSString *)title style:(NSInteger)style handler:(id)handler;
@end
@implementation UIAlertAction
+ (instancetype)actionWithTitle:(__unused NSString *)title style:(__unused NSInteger)style handler:(__unused id)handler {return [self new];}
@end
@interface UIAlertController : UIViewController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NSInteger)style;
- (void)addAction:(UIAlertAction *)action;
@end
@implementation UIAlertController
+ (instancetype)alertControllerWithTitle:(__unused NSString *)title message:(__unused NSString *)message preferredStyle:(__unused NSInteger)style {return [self new];}
- (void)addAction:(__unused UIAlertAction *)action {}
@end
@interface Contact : NSObject
@property(nonatomic,copy) NSString *username;
@property(nonatomic) BOOL isFriend;
@end
@implementation Contact @end
@interface ContactInfoViewController : UIViewController
@property(nonatomic,strong) Contact *m_contact;
@property(nonatomic,strong) id m_oContactInfoAssist;
@property(nonatomic) NSUInteger chats;
- (void)jumpToContentViewController:(id)contact;
@end
@implementation ContactInfoViewController
- (void)jumpToContentViewController:(__unused id)contact {self.chats++;}
@end
@interface CBaseContactInfoAssist : NSObject
@property(nonatomic,strong) Contact *m_contact;
@property(nonatomic,weak) ContactInfoViewController *owner;
- (id)getViewController;
- (BOOL)isInMyContactList;
@end
@implementation CBaseContactInfoAssist
- (id)getViewController {return self.owner;}
- (BOOL)isInMyContactList {return self.m_contact.isFriend;}
@end
@interface WeixinContactInfoAssist : CBaseContactInfoAssist
@property(nonatomic) NSUInteger albums,socials,messages,calls,voiceCalls,callMenus,adds,reloads;
@property(nonatomic,copy) NSString *nativeButton;
@property(nonatomic) BOOL nativeCallButtonVisible;
- (void)showAlbumList;
- (void)onSocialInfoHandle;
- (void)onNewMessage:(id)sender;
- (void)onOpenVoipView;
- (void)onOpenVoiceVoipView;
- (void)onOpenVoipActionSheet:(id)sender;
- (BOOL)canShowVOIPBtn;
- (void)onAddToContacts;
- (void)addMsgActionView;
- (void)reloadTableView;
@end
@implementation WeixinContactInfoAssist
- (void)showAlbumList {self.albums++;}
- (void)onSocialInfoHandle {self.socials++;}
- (void)onNewMessage:(__unused id)sender {self.messages++;}
- (void)onOpenVoipView {self.calls++;}
- (void)onOpenVoiceVoipView {self.voiceCalls++;}
- (void)onOpenVoipActionSheet:(__unused id)sender {self.callMenus++;}
- (BOOL)canShowVOIPBtn {return self.m_contact.isFriend;}
- (void)onAddToContacts {self.adds++;}
- (void)addMsgActionView {self.nativeButton=[self isInMyContactList] ? @"发消息" : @"添加到通讯录";self.nativeCallButtonVisible=[self canShowVOIPBtn];}
- (void)reloadTableView {self.reloads++; [self addMsgActionView];}
@end
void CSCFProfileRefresh(id controller);
#include "ProfileAdapterBodies.h"
#include "ProfileHookBodies.h"
#define Check(x) do {Checks++; if(!(x)){fprintf(stderr,"FAIL %s:%d: %s\n",__FILE__,__LINE__,#x);return 1;}} while(0)
static void Policy(BOOL revealed,BOOL blocked) {
    Current=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"self" profile:@{@"enabled":@YES,@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:Epoch blocked:blocked];
}
static Contact *Person(NSString *name) {Contact *contact=[Contact new];contact.username=name;contact.isFriend=YES;return contact;}
static WeixinContactInfoAssist *Bind(ContactInfoViewController *page,Contact *contact) {
    WeixinContactInfoAssist *assist=[WeixinContactInfoAssist new]; assist.owner=page; assist.m_contact=contact;
    page.m_contact=contact; page.m_oContactInfoAssist=assist; CSCFProfileBind(page); return assist;
}
int main(void) { @autoreleasepool {
    Policy(NO,NO); InstallProfileHooks();
    Contact *secret=Person(@"secret"), *ordinary=Person(@"ordinary");
    ContactInfoViewController *page=[ContactInfoViewController new]; page.view=[UIView new]; page.isViewLoaded=YES;
    WeixinContactInfoAssist *assist=Bind(page,secret);
    [assist showAlbumList]; [assist onSocialInfoHandle];
    Check(assist.albums==1 && assist.socials==1);
    [assist onNewMessage:nil]; [assist onOpenVoipView]; [page jumpToContentViewController:secret];
    [assist onOpenVoiceVoipView]; [assist onOpenVoipActionSheet:nil];
    Check(assist.messages==0 && assist.calls==0 && page.chats==0);
    Check(assist.voiceCalls==0 && assist.callMenus==0);
    [assist addMsgActionView]; [assist onAddToContacts];
    Check([assist.nativeButton isEqual:@"添加到通讯录"] && assist.adds==0 && page.alerts==1);
    Check(!assist.nativeCallButtonVisible);
    Check(secret.isFriend && [assist isInMyContactList]);
    Policy(YES,NO); CSCFProfileRefresh(page);
    [assist showAlbumList]; [assist onSocialInfoHandle]; [assist onNewMessage:nil]; [assist onOpenVoipView]; [page jumpToContentViewController:secret];
    [assist onOpenVoiceVoipView]; [assist onOpenVoipActionSheet:nil];
    Check(assist.albums==2 && assist.socials==2 && assist.messages==1 && assist.calls==1 && page.chats==1);
    Check(assist.voiceCalls==1 && assist.callMenus==1 && assist.nativeCallButtonVisible);
    Check([assist.nativeButton isEqual:@"发消息"]);
    Policy(NO,NO); CSCFProfileRefresh(page); [assist showAlbumList]; [assist onSocialInfoHandle];
    Check(assist.albums==3 && assist.socials==3 && [assist.nativeButton isEqual:@"添加到通讯录"]);
    [assist onOpenVoipView]; [assist onOpenVoiceVoipView]; [assist onOpenVoipActionSheet:nil];
    Check(assist.calls==1 && assist.voiceCalls==1 && assist.callMenus==1 && !assist.nativeCallButtonVisible);
    WeixinContactInfoAssist *replacement=Bind(page,ordinary);
    [replacement showAlbumList]; [replacement onSocialInfoHandle]; [replacement onNewMessage:nil]; [page jumpToContentViewController:ordinary];
    Check(replacement.albums==1 && replacement.socials==1 && replacement.messages==1 && page.chats==2);
    [replacement onOpenVoipView]; [replacement onOpenVoiceVoipView]; [replacement onOpenVoipActionSheet:nil];
    Check(replacement.calls==1 && replacement.voiceCalls==1 && replacement.callMenus==1);
    [assist showAlbumList]; [assist onSocialInfoHandle]; [assist onNewMessage:nil];
    Check(assist.albums==3 && assist.socials==3 && assist.messages==1);
    Policy(YES,NO); [assist showAlbumList]; [assist onSocialInfoHandle];
    Check(assist.albums==3 && assist.socials==3);
    [assist onOpenVoipView]; [assist onOpenVoiceVoipView]; [assist onOpenVoipActionSheet:nil];
    Check(assist.calls==1 && assist.voiceCalls==1 && assist.callMenus==1);
    // An assist whose contact was changed before the owner catches up has no valid binding.
    replacement.m_contact=secret; [replacement showAlbumList]; [replacement onSocialInfoHandle];
    Check(replacement.albums==1 && replacement.socials==1);
    replacement.m_contact=ordinary;
    Policy(YES,YES); [replacement showAlbumList]; [replacement onSocialInfoHandle];
    Check(replacement.albums==1 && replacement.socials==1);
    Policy(YES,NO); Epoch++; [replacement showAlbumList]; [replacement onSocialInfoHandle]; [page jumpToContentViewController:ordinary];
    Check(replacement.albums==1 && replacement.socials==1 && page.chats==2);
    Check(CSCFProfileBlocksNavigation(page));
    WeixinContactInfoAssist *fresh;
    @autoreleasepool {
        ContactInfoViewController *newPage=[ContactInfoViewController new];
        fresh=Bind(newPage,secret); Policy(NO,NO);
        [fresh showAlbumList]; [fresh onSocialInfoHandle];
        Check(fresh.albums==1 && fresh.socials==1);
    }
    [fresh showAlbumList]; [fresh onSocialInfoHandle];
    Check(fresh.albums==1 && fresh.socials==1);
    printf("Close-friend profile: %lu checks passed (native routes, sensitive actions, reveal/relock and stale bindings)\n",(unsigned long)Checks);
} return 0;}
