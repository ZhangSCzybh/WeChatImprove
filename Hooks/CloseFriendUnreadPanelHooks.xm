#import "../Controllers/CSCloseFriendUnreadPanelAdapter.h"
#import "../Controllers/CSCloseFriendBridge.h"
#import "../Controllers/CSCloseFriendContactAdapter.h"
#import <objc/message.h>

static BOOL UnreadHook0(NSString *cls,NSString *name,void (^body)(id,void(^)(void))) {
    __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
    IMP replacement=imp_implementationWithBlock(^(id object){body(object,^{((void(*)(id,SEL))original)(object,selector);});});
    BOOL installed=CSCloseFriendInstallHook(cls,name,replacement,&original,"v@:");
    if(!installed)imp_removeBlock(replacement);
    return installed;
}
typedef id (*CSCFUnreadInitIMP)(id,SEL) __attribute__((ns_returns_retained));
static CSCFUnreadInitIMP UnreadLogicInitOriginal, UnreadControllerInitOriginal;
static id UnreadLogicInit(id object,SEL selector) __attribute__((ns_returns_retained));
static id UnreadLogicInit(id object,SEL selector) {
    CSCFUnreadPanelBind(object);
    id result=UnreadLogicInitOriginal(object,selector); CSCFUnreadPanelBind(result); return result;
}
static id UnreadControllerInit(id object,SEL selector) __attribute__((ns_returns_retained));
static id UnreadControllerInit(id object,SEL selector) {
    CSCFUnreadPanelBind(object);
    id result=UnreadControllerInitOriginal(object,selector); CSCFUnreadPanelTrackController(result); return result;
}
static NSInteger UnreadIndex(id path) {
    SEL selector=NSSelectorFromString(@"row");
    if(!CSCloseFriendMethodMatches(class_getInstanceMethod([path class],selector),"q@:"))return -1;
    return ((NSInteger(*)(id,SEL))objc_msgSend)(path,selector);
}
void CSCFUnreadPanelInstallHooks(void) {
    static dispatch_once_t once;
    dispatch_once(&once,^{
        NSString *logic=@"MainFrameAggregationLogic", *controller=@"MainFrameAggregationViewController";
        BOOL boundLogic=CSCloseFriendInstallHook(logic,@"init",(IMP)UnreadLogicInit,(IMP *)&UnreadLogicInitOriginal,"@@:");
        BOOL boundPage=CSCloseFriendInstallHook(controller,@"init",(IMP)UnreadControllerInit,(IMP *)&UnreadControllerInitOriginal,"@@:");
        __block IMP canShow=NULL;
        IMP predicate=imp_implementationWithBlock(^BOOL(id object,id session){
            return CSCFUnreadPanelAllowsSession(object,session) && ((BOOL(*)(id,SEL,id))canShow)(object,NSSelectorFromString(@"canShowSession:"),session);
        });
        BOOL filtering=CSCloseFriendInstallHook(logic,@"canShowSession:",predicate,&canShow,"B@:@");
        if(!filtering)imp_removeBlock(predicate);
        filtering=filtering && boundLogic && boundPage && CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(logic),NSSelectorFromString(@"rebuildSessionList")),"v@:") &&
            CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(logic),NSSelectorFromString(@"currentSessionList")),"@@:") &&
            CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(controller),NSSelectorFromString(@"dataLogic")),"@@:") &&
            CSCloseFriendMethodMatches(class_getInstanceMethod(NSClassFromString(controller),NSSelectorFromString(@"updateContent")),"v@:");
        __block IMP count=NULL;
        IMP unreadCount=imp_implementationWithBlock(^NSInteger(id object){
            NSInteger native=((NSInteger(*)(id,SEL))count)(object,NSSelectorFromString(@"notifySessionCount"));
            return CSCFUnreadPanelNotifyCount(object,native);
        });
        BOOL counted=CSCloseFriendInstallHook(logic,@"notifySessionCount",unreadCount,&count,"q@:");
        if(!counted)imp_removeBlock(unreadCount);
        filtering=filtering && counted;
        for(NSString *name in @[@"rebuildSessionList"]) {
            BOOL observed=UnreadHook0(logic,name,^(id object,void(^native)(void)){
                CSCFUnreadPanelSourceWillChange(object);
                @try { native(); } @finally { CSCFUnreadPanelSourceDidChange(object); }
            });
            filtering=filtering && observed;
        }
        // MainSessionMgr streams a whole reload between these callbacks. Keep
        // one outer transaction so a relock cannot splice a full rebuild into it.
        BOOL began=UnreadHook0(logic,@"onMainFrameBeginReload",^(id object,void(^native)(void)){
            CSCFUnreadPanelSourceWillChange(object); native();
        });
        BOOL ended=UnreadHook0(logic,@"onMainFrameEndReload",^(id object,void(^native)(void)){
            @try { native(); } @finally { CSCFUnreadPanelSourceDidChange(object); }
        });
        filtering=filtering && began && ended;
        __block IMP handle=NULL;
        IMP update=imp_implementationWithBlock(^(id object,id session){
            CSCFUnreadPanelSourceWillChange(object);
            @try { ((void(*)(id,SEL,id))handle)(object,NSSelectorFromString(@"onMainFrameHandleSession:"),session); }
            @finally { CSCFUnreadPanelSourceDidChange(object); }
        });
        BOOL handled=CSCloseFriendInstallHook(logic,@"onMainFrameHandleSession:",update,&handle,"v@:@");
        if(!handled)imp_removeBlock(update);
        BOOL loaded=UnreadHook0(controller,@"viewDidLoad",^(id object,void(^native)(void)){CSCFUnreadPanelTrackController(object); native(); CSCFUnreadPanelRefresh(object);});
        filtering=filtering && handled && loaded;
        for(NSString *name in @[@"viewWillAppear:",@"viewDidAppear:"]) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
            IMP replacement=imp_implementationWithBlock(^(id object,BOOL animated){
                CSCFUnreadPanelPreparePresentation(object);
                ((void(*)(id,SEL,BOOL))original)(object,selector,animated);
                CSCFUnreadPanelPreparePresentation(object);
            });
            if(!CSCloseFriendInstallHook(controller,name,replacement,&original,"v@:B"))imp_removeBlock(replacement);
        }
        UnreadHook0(controller,@"onPushTransitionWillBegin",^(id object,void(^native)(void)){CSCFUnreadPanelPreparePresentation(object); native();});
        UnreadHook0(controller,@"onPushTransitionEnd",^(id object,void(^native)(void)){native(); CSCFUnreadPanelPreparePresentation(object);});
        __block IMP cell=NULL;
        IMP render=imp_implementationWithBlock(^id(id object,id table,id path){
            CSCFUnreadPanelPreparePresentation(object);
            NSInteger index=UnreadIndex(path); id ticket=CSCFUnreadPanelCaptureRow(object,index);
            id result=((id(*)(id,SEL,id,id))cell)(object,NSSelectorFromString(@"tableView:cellForRowAtIndexPath:"),table,path);
            CSCFUnreadPanelFinishRow(object,index,ticket,result); return result;
        });
        BOOL rendered=CSCloseFriendInstallHook(controller,@"tableView:cellForRowAtIndexPath:",render,&cell,"@@:@@");
        if(!rendered)imp_removeBlock(render);
        filtering=filtering && rendered;
        __block IMP select=NULL;
        IMP selection=imp_implementationWithBlock(^(id object,id table,id path){
            CSCFUnreadPanelPerformRowAction(object,UnreadIndex(path),^{
                ((void(*)(id,SEL,id,id))select)(object,NSSelectorFromString(@"tableView:didSelectRowAtIndexPath:"),table,path);
            });
        });
        BOOL selected=CSCloseFriendInstallHook(controller,@"tableView:didSelectRowAtIndexPath:",selection,&select,"v@:@@");
        if(!selected)imp_removeBlock(selection);
        filtering=filtering && selected;
        __block IMP edit=NULL;
        IMP editing=imp_implementationWithBlock(^(id object,id table,NSInteger style,id path){
            CSCFUnreadPanelPerformRowAction(object,UnreadIndex(path),^{
                ((void(*)(id,SEL,id,NSInteger,id))edit)(object,NSSelectorFromString(@"tableView:commitEditingStyle:forRowAtIndexPath:"),table,style,path);
            });
        });
        BOOL edited=CSCloseFriendInstallHook(controller,@"tableView:commitEditingStyle:forRowAtIndexPath:",editing,&edit,"v@:@q@");
        if(!edited)imp_removeBlock(editing);
        filtering=filtering && edited;
        __block IMP mutation=NULL;
        IMP mark=imp_implementationWithBlock(^(id object,NSInteger index){
            id page=CSCloseFriendRead(object,@"delegate");
            if(CSCFUnreadPanelAllowsRowAction(page,index))
                ((void(*)(id,SEL,NSInteger))mutation)(object,NSSelectorFromString(@"changeReadStatusAtIndex:"),index);
        });
        BOOL mutated=CSCloseFriendInstallHook(logic,@"changeReadStatusAtIndex:",mark,&mutation,"v@:q");
        if(!mutated)imp_removeBlock(mark);
        filtering=filtering && mutated;
        __block IMP open=NULL;
        IMP navigation=imp_implementationWithBlock(^(id object,id page,id session){
            if(CSCFIsClass(page,controller) && CSCFUnreadPanelAllowsOpen(page,session))
                ((void(*)(id,SEL,id,id))open)(object,NSSelectorFromString(@"onAggregation:openSession:"),page,session);
        });
        BOOL navigated=CSCloseFriendInstallHook(@"NewMainFrameViewController",@"onAggregation:openSession:",navigation,&open,"v@:@@");
        if(!navigated)imp_removeBlock(navigation);
        filtering=filtering && navigated;
        __block IMP animate=NULL;
        IMP transition=imp_implementationWithBlock(^(id object,id context){
            CSCFUnreadPanelBind(object);
            CSCloseFriendSnapshot *before=CSCloseFriendCurrentSnapshot(); NSUInteger epoch=CSCloseFriendAccountEpoch();
            id page=CSCloseFriendRead(object,@"delegate");
            if(CSCFIsClass(page,controller))CSCFUnreadPanelPreparePresentation(page);
            ((void(*)(id,SEL,id))animate)(object,NSSelectorFromString(@"animateTransition:"),context);
            CSCloseFriendSnapshot *after=CSCloseFriendCurrentSnapshot();
            if(epoch!=CSCloseFriendAccountEpoch() || before.revision!=after.revision || !CSCFUnreadPanelIsCurrent(object))
                CSCFUnreadPanelInvalidatePresentation(object);
        });
        if(!CSCloseFriendInstallHook(@"MainFrameAggregationTransition",@"animateTransition:",transition,&animate,"v@:@"))imp_removeBlock(transition);
        CSCFUnreadPanelSetFilteringAvailable(filtering);
    });
}
%ctor { dispatch_async(dispatch_get_main_queue(),^{ CSCFUnreadPanelInstallHooks(); }); }
