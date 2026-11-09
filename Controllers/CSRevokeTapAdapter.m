#import "CSRevokeTapAdapter.h"
#import "CSChatNativeBridge.h"
#import "CSMessageNavigation.h"
#import "CSRevokeReference.h"
#import "CSServiceCenter.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

static char CSRevokeTapKey;
static BOOL CSRevokeTapEnabled(void) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"com.wechat.enhance.revoke.enabled"];
}

static CSRevokeReference *CSRevokeTapReference(id source, id link) {
    id wrap=CSMessageNativeObject(CSMessageNativeObject(source,@"viewModel"),@"messageWrap");
    NSString *content=CSMessageNativeObject(wrap,@"m_nsContent"),*pattern=CSMessageNativeObject(wrap,@"m_nsPattern");
    // A leftover style must not turn a reused/edited ordinary message into an owned tip.
    if (!CSRevokeResolveReference(nil,content,pattern)) return nil;
    return CSRevokeResolveReference(link,content,pattern);
}

static BOOL CSRevokeTapIsScrolling(UIView *source) {
    for (UIView *view=source;view;view=view.superview)
        if ([view isKindOfClass:UIScrollView.class] &&
            (((UIScrollView *)view).dragging || ((UIScrollView *)view).decelerating)) return YES;
    return NO;
}

static NSString *CSRevokeTapLink(id source, CGPoint point, UIView *coordinateView) {
    id rich=CSMessageNativeObject(source,@"getRichTextView");
    id style=nil;
    if ([rich isKindOfClass:UIView.class]) {
        if ([(UIView *)rich isHidden] || [(UIView *)rich alpha]<=0.01) return nil;
        id styles=CSMessageNativeObject(rich,@"arrStyles");
        id parser=[rich class];
        SEL selector=NSSelectorFromString(@"targetLinkStyleFromStyles:withPoint:");
        NSMethodSignature *signature=[parser methodSignatureForSelector:selector];
        if (![styles isKindOfClass:NSArray.class] || signature.numberOfArguments!=4 ||
            signature.methodReturnType[0]!='@' || [signature getArgumentTypeAtIndex:2][0]!='@' ||
            strcmp([signature getArgumentTypeAtIndex:3],@encode(CGPoint))!=0) return nil;
        CGPoint local=[(UIView *)rich convertPoint:point fromView:coordinateView];
        style=((id (*)(id,SEL,id,CGPoint))objc_msgSend)(parser,selector,styles,local);
    }
    id link=[style isKindOfClass:NSString.class] ? style : CSMessageNativeObject(style,@"nsUrl");
    return [link isKindOfClass:NSString.class] && CSRevokeOwnsLink(link) && CSRevokeTapReference(source,link) ? link : nil;
}

@interface CSRevokeTapBinding : NSObject <UIGestureRecognizerDelegate>
@property(nonatomic,weak) UIView *source;
@property(nonatomic,strong) UITapGestureRecognizer *gesture;
@property(nonatomic,weak) id pendingModel;
@property(nonatomic,copy) NSString *pendingAccount;
@property(nonatomic,copy) NSString *pendingLink;
- (void)clearPending;
- (void)tapped:(UITapGestureRecognizer *)gesture;
@end

@implementation CSRevokeTapBinding
- (void)clearPending { self.pendingModel=nil;self.pendingAccount=nil;self.pendingLink=nil; }
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldReceiveTouch:(UITouch *)touch {
    [self clearPending];
    UIView *source=self.source;
    if (!gesture.enabled || !CSRevokeTapEnabled() || !source.window || CSRevokeTapIsScrolling(source)) return NO;
    NSString *account=CSMessageCurrentAccount();
    NSString *link=CSRevokeTapLink(source,[touch locationInView:source],source);
    id model=CSMessageNativeObject(source,@"viewModel");
    if (!account.length || !model || !link.length) return NO;
    self.pendingModel=model;self.pendingAccount=account;self.pendingLink=link;
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture {
    return gesture.enabled && CSRevokeTapEnabled() && self.pendingLink.length && self.pendingModel &&
        self.pendingModel==CSMessageNativeObject(self.source,@"viewModel") &&
        [self.pendingAccount isEqual:CSMessageCurrentAccount()] && !CSRevokeTapIsScrolling(self.source);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other {
    return NO;
}
- (void)tapped:(UITapGestureRecognizer *)gesture {
    UIView *source=self.source;
    NSString *link=self.pendingLink;
    BOOL valid=NSThread.isMainThread && gesture.enabled && CSRevokeTapEnabled() && gesture.state==UIGestureRecognizerStateEnded &&
        source.window && self.pendingModel==CSMessageNativeObject(source,@"viewModel") &&
        [self.pendingAccount isEqual:CSMessageCurrentAccount()] && !CSRevokeTapIsScrolling(source) &&
        link.length && [link isEqual:CSRevokeTapLink(source,[gesture locationInView:source],source)];
    [self clearPending];
    if (valid) CSMessageHandleRevokeLink(source,CSGetService(NSClassFromString(@"CMessageMgr")),link,nil);
}
@end

void CSRevokeTapBind(id cellView, BOOL enabled) {
    if (!NSThread.isMainThread || ![cellView isKindOfClass:UIView.class]) return;
    CSRevokeTapBinding *binding=objc_getAssociatedObject(cellView,&CSRevokeTapKey);
    BOOL active=enabled && CSRevokeTapReference(cellView,nil)!=nil;
    if (!active) {
        binding.gesture.enabled=NO;
        [binding clearPending];
        return;
    }
    if (!binding) {
        binding=[CSRevokeTapBinding new];binding.source=cellView;
        binding.gesture=[[UITapGestureRecognizer alloc] initWithTarget:binding action:@selector(tapped:)];
        binding.gesture.delegate=binding;
        // Recognition cancels the underlying rich-text touch, so this exact link has one owner.
        binding.gesture.cancelsTouchesInView=YES;
        binding.gesture.delaysTouchesEnded=YES;
        objc_setAssociatedObject(cellView,&CSRevokeTapKey,binding,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [(UIView *)cellView addGestureRecognizer:binding.gesture];
    }
    binding.gesture.enabled=YES;
}
