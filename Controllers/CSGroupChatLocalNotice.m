#import "CSGroupChatLocalNotice.h"
#import "CSGroupChatNoticeReference.h"
#import "CSGroupChatTemplate.h"
#import "CSGroupChatNativeAdapter.h"
#import "CSChatNativeBridge.h"
#import "CSMessageNativeActionAdapter.h"
#import "CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import <substrate.h>
#include <math.h>

static char CSGroupNoticeOwnedKey,CSGroupNoticeTapKey,CSGroupNoticeLastTapKey;
static BOOL CSNoticeAccountValid(NSString *account, NSUInteger epoch) {
    return CSBackupIsReady() && !CSBackupAccountIsSuspended() && epoch==CSBackupAccountEpoch() &&
        account.length && [account isEqual:CSMessageCurrentAccount()];
}
BOOL CSGroupChatPostDepartureNotice(NSString *account, NSString *roomID, NSString *memberID, NSDate *date, NSString *eventID, NSString *format, NSDictionary<NSString *,NSString *> *values, BOOL (^stillAuthorized)(void)) {
    if (!NSThread.isMainThread || !stillAuthorized || !stillAuthorized()) return NO;
    NSUInteger epoch=CSBackupAccountEpoch();
    NSString *link=CSGroupChatNoticeLink(account,roomID,memberID,eventID);
    if (!link || !CSNoticeAccountValid(account,epoch) || ![date isKindOfClass:NSDate.class] || !isfinite(date.timeIntervalSince1970) || date.timeIntervalSince1970<0 || date.timeIntervalSince1970>UINT_MAX) return NO;
    if (![format isKindOfClass:NSString.class] || !format.length || format.length>4000) format=CSGroupChatDefaultDeparture();
    NSMutableDictionary *escaped=[NSMutableDictionary dictionaryWithCapacity:values.count];
    for (NSString *token in values) {
        NSString *value=values[token];
        if (![value isKindOfClass:NSString.class] || value.length>2048) return NO;
        escaped[token]=CSGroupChatEscapeXML(value);
    }
    // Escape the literal template first. Only this internally built anchor is markup.
    NSString *name=escaped[@"@昵称"];
    escaped[@"@昵称"]=[NSString stringWithFormat:@"<a href=\"%@\">%@</a>",link,name.length?name:CSGroupChatEscapeXML(memberID)];
    NSString *content=CSGroupChatRenderTemplate(CSGroupChatEscapeXML(format),escaped);
    if (!content.length || content.length>65536) return NO;
    @try {
        CSMessageNativeEnvironment *environment=[CSMessageNativeEnvironment new];
        id manager=[environment serviceNamed:@"CMessageMgr"], allocated=[NSClassFromString(@"CMessageWrap") alloc];
        if (!CSMessageNativeSupports(allocated,@"initWithMsgType:",@"@",@[@"q"])) return NO;
        NSString *insert=nil; NSArray *arguments=nil;
        if (CSMessageNativeSupports(manager,@"AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:Unique:",@"v",@[@"@",@"@",@"B",@"B",@"B"])) insert=@"AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:Unique:";
        else if (CSMessageNativeSupports(manager,@"AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:",@"v",@[@"@",@"@",@"B",@"B"])) insert=@"AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:";
        // A short AddLocalMsg variant cannot explicitly suppress arrival notifications.
        if (!insert) return NO;
        id wrap=CSMessageNativeInvoke(allocated,@"initWithMsgType:",@[@10000]);
        if (!wrap || !CSMessageNativeSet(wrap,@"setM_nsFromUsr:",roomID,YES) || !CSMessageNativeSet(wrap,@"setM_nsToUsr:",roomID,YES) ||
            !CSMessageNativeSet(wrap,@"setM_nsContent:",content,YES) || !CSMessageNativeSet(wrap,@"setM_nsPattern:",link,YES) ||
            !CSMessageNativeSet(wrap,@"setM_uiStatus:",@4,YES) || !CSMessageNativeSet(wrap,@"setM_uiCreateTime:",@((unsigned int)date.timeIntervalSince1970),YES) ||
            !CSMessageNativeSet(wrap,@"setM_n64MesSvrID:",@0,YES) || !CSMessageNativeSet(wrap,@"setM_uiMesLocalID:",@0,YES)) return NO;
        CSMessageNativeSet(wrap,@"setM_nsRealChatUsr:",nil,NO);
        objc_setAssociatedObject(wrap,&CSGroupNoticeOwnedKey,@YES,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        arguments=[insert hasSuffix:@"Unique:"]?@[roomID,wrap,@YES,@NO,@YES]:@[roomID,wrap,@YES,@NO];
        __block BOOL inserted=NO;
        CSBackupPerformAtAccountEpoch(epoch,^{
            if (!CSNoticeAccountValid(account,epoch) || !stillAuthorized()) return;
            CSMessageNativeInvoke(manager,insert,arguments); inserted=YES;
        });
        return inserted;
    } @catch (__unused NSException *exception) { return NO; }
}

static id CSNoticeModel(id cell) { return CSMessageNativeObject(cell,@"viewModel"); }
static NSDictionary *CSNoticeReference(id cell, id clickedLink) {
    @try {
    id wrap=CSMessageNativeObject(CSNoticeModel(cell),@"messageWrap");
    if (!wrap || CSMessageNativeUnsigned(wrap,@"m_uiMessageType")!=10000 || CSMessageNativeUnsigned(wrap,@"m_n64MesSvrID")) return nil;
    NSDictionary *reference=CSGroupChatResolveNoticeLink(clickedLink,CSMessageNativeObject(wrap,@"m_nsContent"),CSMessageNativeObject(wrap,@"m_nsPattern"));
    if (!reference || ![reference[@"account"] isEqual:CSMessageCurrentAccount()]) return nil;
    NSString *from=CSMessageNativeObject(wrap,@"m_nsFromUsr"), *to=CSMessageNativeObject(wrap,@"m_nsToUsr");
    NSString *room=reference[@"room"], *account=reference[@"account"];
    if ((!([from isEqual:room] && ([to isEqual:room] || [to isEqual:account]))) &&
        !([to isEqual:room] && [from isEqual:account])) return nil;
    NSString *modelRoom=CSMessageModelChatName(CSNoticeModel(cell));
    return !modelRoom.length || [modelRoom isEqual:reference[@"room"]] ? reference : nil;
    } @catch (__unused NSException *exception) { return nil; }
}
static UIViewController *CSNoticeController(id cell, NSString *room) {
    id model=CSNoticeModel(cell);
    NSArray *owners=@[CSMessageNativeObject(cell,@"getCurrViewController")?:NSNull.null,
        CSMessageNativeObject(cell,@"getViewController")?:NSNull.null,
        CSMessageNativeObject(CSMessageNativeObject(model,@"delegate"),@"getViewController")?:NSNull.null];
    for (id owner in owners) if ([owner isKindOfClass:UIViewController.class] &&
        [CSMessageNativeObject(owner,@"getCurrentChatName") isEqual:room] && [owner viewIfLoaded].window) return owner;
    id cursor=cell;
    for (NSUInteger i=0;cursor && i<32;i++) {
        if ([cursor isKindOfClass:UIViewController.class] && [CSMessageNativeObject(cursor,@"getCurrentChatName") isEqual:room] && [cursor viewIfLoaded].window) return cursor;
        cursor=CSMessageNativeObject(cursor,@"nextResponder");
    }
    return nil;
}
static BOOL CSNoticeScrolling(UIView *source) {
    for (UIView *view=source;view;view=view.superview) if ([view isKindOfClass:UIScrollView.class] &&
        (((UIScrollView *)view).dragging || ((UIScrollView *)view).decelerating)) return YES;
    return NO;
}
static BOOL CSNoticeHandle(id cell, id link) {
    @try {
    if (!NSThread.isMainThread || ![cell isKindOfClass:UIView.class] || ![(UIView *)cell window] || CSNoticeScrolling(cell)) return NO;
    NSUInteger epoch=CSBackupAccountEpoch(); NSDictionary *reference=CSNoticeReference(cell,link);
    if (!reference || !CSNoticeAccountValid(reference[@"account"],epoch)) return NO;
    id model=CSNoticeModel(cell); UIViewController *owner=CSNoticeController(cell,reference[@"room"]);
    if (!owner || owner.viewIfLoaded.window!=[(UIView *)cell window]) return YES;
    NSDictionary *last=objc_getAssociatedObject(cell,&CSGroupNoticeLastTapKey); NSTimeInterval now=NSProcessInfo.processInfo.systemUptime;
    if ([last[@"link"] isEqual:reference[@"link"]] && [last[@"epoch"] unsignedIntegerValue]==epoch && now-[last[@"time"] doubleValue]<0.4) return YES;
    objc_setAssociatedObject(cell,&CSGroupNoticeLastTapKey,@{@"link":reference[@"link"],@"epoch":@(epoch),@"time":@(now)},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    __block BOOL opened=NO;
    CSBackupPerformAtAccountEpoch(epoch,^{
        if (model==CSNoticeModel(cell) && CSNoticeAccountValid(reference[@"account"],epoch) &&
            [CSNoticeReference(cell,link)[@"link"] isEqual:reference[@"link"]] &&
            [CSMessageNativeObject(owner,@"getCurrentChatName") isEqual:reference[@"room"]])
            opened=CSGroupChatOpenMemberProfile(reference[@"room"],reference[@"member"],owner);
    });
    if (!opened && CSNoticeAccountValid(reference[@"account"],epoch) && owner.viewIfLoaded.window && !owner.presentedViewController) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"无法打开成员资料" message:@"该成员的资料暂不可用，请稍后重试。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [owner presentViewController:alert animated:YES completion:nil];
    }
    return YES;
    } @catch (__unused NSException *exception) { return NO; }
}
static NSString *CSNoticeLinkAtPoint(id cell, CGPoint point) {
    @try {
    id rich=CSMessageNativeObject(cell,@"getRichTextView");
    if (![rich isKindOfClass:UIView.class] || [rich isHidden] || [rich alpha]<=0.01) return nil;
    id styles=CSMessageNativeObject(rich,@"arrStyles"); Class parser=[rich class];
    SEL selector=NSSelectorFromString(@"targetLinkStyleFromStyles:withPoint:");
    NSMethodSignature *signature=[parser methodSignatureForSelector:selector];
    if (![styles isKindOfClass:NSArray.class] || signature.numberOfArguments!=4 || signature.methodReturnType[0]!='@' ||
        [signature getArgumentTypeAtIndex:2][0]!='@' || strcmp([signature getArgumentTypeAtIndex:3],@encode(CGPoint))) return nil;
    CGPoint local=[rich convertPoint:point fromView:cell];
    id style=((id(*)(id,SEL,id,CGPoint))objc_msgSend)(parser,selector,styles,local);
    id link=[style isKindOfClass:NSString.class]?style:CSMessageNativeObject(style,@"nsUrl");
    return CSNoticeReference(cell,link)?CSGroupChatParseNoticeLink(link)[@"link"]:nil;
    } @catch (__unused NSException *exception) { return nil; }
}
@interface CSGroupNoticeTapBinding : NSObject <UIGestureRecognizerDelegate>
@property(nonatomic,weak) UIView *cell;
@property(nonatomic,strong) UITapGestureRecognizer *gesture;
@property(nonatomic,weak) id pendingModel;
@property(nonatomic,copy) NSString *pendingLink,*pendingAccount;
@property(nonatomic) NSUInteger pendingEpoch;
- (void)clearPending;
- (void)tapped:(UITapGestureRecognizer *)gesture;
@end
@implementation CSGroupNoticeTapBinding
- (void)clearPending { self.pendingModel=nil; self.pendingLink=nil; self.pendingAccount=nil; }
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    [self clearPending];
    if (!gesture.enabled || !self.cell.window || CSNoticeScrolling(self.cell)) return NO;
    NSString *link=CSNoticeLinkAtPoint(self.cell,[touch locationInView:self.cell]);
    NSDictionary *reference=CSNoticeReference(self.cell,link); NSUInteger epoch=CSBackupAccountEpoch();
    if (!link || !reference || !CSNoticeAccountValid(reference[@"account"],epoch)) return NO;
    self.pendingModel=CSNoticeModel(self.cell); self.pendingLink=link; self.pendingAccount=reference[@"account"]; self.pendingEpoch=epoch;
    return self.pendingModel!=nil;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture {
    return gesture.enabled && self.pendingLink.length && self.pendingModel==CSNoticeModel(self.cell) &&
        CSNoticeAccountValid(self.pendingAccount,self.pendingEpoch) && !CSNoticeScrolling(self.cell);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other { (void)gesture; (void)other; return NO; }
- (void)tapped:(UITapGestureRecognizer *)gesture {
    NSString *link=self.pendingLink;
    BOOL valid=NSThread.isMainThread && gesture.enabled && gesture.state==UIGestureRecognizerStateEnded && self.cell.window &&
        self.pendingModel==CSNoticeModel(self.cell) && CSNoticeAccountValid(self.pendingAccount,self.pendingEpoch) && !CSNoticeScrolling(self.cell) &&
        link.length && [link isEqual:CSNoticeLinkAtPoint(self.cell,[gesture locationInView:self.cell])];
    [self clearPending]; if (valid) CSNoticeHandle(self.cell,link);
}
@end
static void CSNoticeBind(id cell) {
    if (!NSThread.isMainThread || ![cell isKindOfClass:UIView.class]) return;
    CSGroupNoticeTapBinding *binding=objc_getAssociatedObject(cell,&CSGroupNoticeTapKey);
    if (!CSNoticeReference(cell,nil)) { binding.gesture.enabled=NO; [binding clearPending]; return; }
    if (!binding) {
        binding=[CSGroupNoticeTapBinding new]; binding.cell=cell;
        binding.gesture=[[UITapGestureRecognizer alloc] initWithTarget:binding action:@selector(tapped:)]; binding.gesture.delegate=binding;
        binding.gesture.cancelsTouchesInView=YES; binding.gesture.delaysTouchesEnded=YES;
        objc_setAssociatedObject(cell,&CSGroupNoticeTapKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [(UIView *)cell addGestureRecognizer:binding.gesture];
    }
    binding.gesture.enabled=YES;
}
static BOOL CSNoticeMethod(Class cls, NSString *name, NSArray<NSString *> *types) {
    Method method=class_getInstanceMethod(cls,NSSelectorFromString(name));
    if (!method || method_getNumberOfArguments(method)!=types.count+2) return NO;
    char type[256]={0}; method_getReturnType(method,type,sizeof(type)); if (strcmp(type,"v")) return NO;
    for (NSUInteger i=0;i<types.count;i++) { method_getArgumentType(method,(unsigned int)i+2,type,sizeof(type)); if (strcmp(type,types[i].UTF8String)) return NO; }
    return YES;
}
void CSGroupChatInstallNoticeHooks(void) {
    static dispatch_once_t once; dispatch_once(&once,^{
        Class cell=NSClassFromString(@"SystemMessageCellView");
        if (CSNoticeMethod(cell,@"layoutContentView",@[])) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(@"layoutContentView");
            IMP replacement=imp_implementationWithBlock(^(id object){ ((void(*)(id,SEL))original)(object,selector); CSNoticeBind(object); });
            MSHookMessageEx(cell,selector,replacement,&original);
        }
        NSString *rect=[NSString stringWithUTF8String:@encode(CGRect)];
        if (CSNoticeMethod(cell,@"onLinkClicked:withRect:",@[@"@",rect])) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(@"onLinkClicked:withRect:");
            IMP replacement=imp_implementationWithBlock(^(id object,id link,CGRect bounds){ if (!CSNoticeHandle(object,link)) ((void(*)(id,SEL,id,CGRect))original)(object,selector,link,bounds); });
            MSHookMessageEx(cell,selector,replacement,&original);
        }
        if (CSNoticeMethod(cell,@"onLinkClicked:withRect:withView:",@[@"@",rect,@"@"])) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(@"onLinkClicked:withRect:withView:");
            IMP replacement=imp_implementationWithBlock(^(id object,id link,CGRect bounds,id view){ if (!CSNoticeHandle(object,link)) ((void(*)(id,SEL,id,CGRect,id))original)(object,selector,link,bounds,view); });
            MSHookMessageEx(cell,selector,replacement,&original);
        }
        if (CSNoticeMethod(cell,@"onLinkClicked:backupUrl:withRect:",@[@"@",@"@",rect])) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(@"onLinkClicked:backupUrl:withRect:");
            IMP replacement=imp_implementationWithBlock(^(id object,id link,id backup,CGRect bounds){ if (!CSNoticeHandle(object,link)) ((void(*)(id,SEL,id,id,CGRect))original)(object,selector,link,backup,bounds); });
            MSHookMessageEx(cell,selector,replacement,&original);
        }
        if (CSNoticeMethod(cell,@"onLinkClicked:backupUrl:withRect:extraInfo:",@[@"@",@"@",rect,@"@"])) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(@"onLinkClicked:backupUrl:withRect:extraInfo:");
            IMP replacement=imp_implementationWithBlock(^(id object,id link,id backup,CGRect bounds,id info){ if (!CSNoticeHandle(object,link)) ((void(*)(id,SEL,id,id,CGRect,id))original)(object,selector,link,backup,bounds,info); });
            MSHookMessageEx(cell,selector,replacement,&original);
        }
        Class rich=NSClassFromString(@"RichTextView");
        if (CSNoticeMethod(rich,@"clickOnLinkEvent:",@[@"@"])) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(@"clickOnLinkEvent:");
            IMP replacement=imp_implementationWithBlock(^(id object,id link){
                if (CSGroupChatParseNoticeLink(link)) {
                    UIView *cursor=[object isKindOfClass:UIView.class]?[object superview]:nil;
                    for (NSUInteger i=0;cursor && i<16;i++,cursor=cursor.superview) if ([cursor isKindOfClass:cell] && CSMessageNativeObject(cursor,@"getRichTextView")==object) {
                        if (CSNoticeHandle(cursor,link)) return; break;
                    }
                }
                ((void(*)(id,SEL,id))original)(object,selector,link);
            });
            MSHookMessageEx(rich,selector,replacement,&original);
        }
    });
}
