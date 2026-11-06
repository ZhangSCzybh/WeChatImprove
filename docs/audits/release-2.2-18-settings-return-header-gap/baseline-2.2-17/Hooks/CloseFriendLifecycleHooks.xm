#import "../Controllers/CSCloseFriendBridge.h"
#import "../Controllers/CSCloseFriendManager.h"
static void (*CSHomeDidAppearOriginal)(id,SEL,BOOL);
static void CSHomeDidAppear(id self, SEL command, BOOL animated) {
    CSHomeDidAppearOriginal(self,command,animated);
    [CSCloseFriendManager.sharedManager start];
    [CSCloseFriendManager.sharedManager refreshAccount];
    [CSCloseFriendManager.sharedManager attachRecoveryGestureTo:self];
}
static void (*CSChatDidAppearOriginal)(id,SEL,BOOL);
static void CSChatDidAppear(id self,SEL command,BOOL animated) {
    CSChatDidAppearOriginal(self,command,animated);
    // Returning from a normal page may uncover an older chat in its back stack.
    [CSCloseFriendManager.sharedManager returnToChatListIfNeeded];
}
static void (*CSMotionEndedOriginal)(id,SEL,UIEventSubtype,UIEvent *);
static void (*CSMotionBeganOriginal)(id,SEL,UIEventSubtype,UIEvent *);
static void CSMotionBegan(id self, SEL command, UIEventSubtype motion, UIEvent *event) {
    CSMotionBeganOriginal(self,command,motion,event);
    if(motion==UIEventSubtypeMotionShake) [CSCloseFriendManager.sharedManager handleShake];
}
static void CSMotionEnded(id self, SEL command, UIEventSubtype motion, UIEvent *event) {
    CSMotionEndedOriginal(self,command,motion,event);
    if(motion==UIEventSubtypeMotionShake) [CSCloseFriendManager.sharedManager handleShake];
}
%ctor {
    // Only register deferred bootstrap. No service lookup, Keychain access, file read or class scan here.
    dispatch_async(dispatch_get_main_queue(),^{
        CSCloseFriendInstallHook(@"NewMainFrameViewController",@"viewDidAppear:",(IMP)CSHomeDidAppear,(IMP *)&CSHomeDidAppearOriginal,"v@:B");
        // Native custom-navigation layouts may replace/reparent the title after
        // viewDidAppear. Refresh only the attachment at those existing callbacks.
        for(NSString *name in @[@"initNavigationTitileView",@"viewDidLayoutSubviews"]) {
            __block IMP original=NULL; SEL selector=NSSelectorFromString(name);
            IMP replacement=imp_implementationWithBlock(^(id page){
                ((void(*)(id,SEL))original)(page,selector);
                [CSCloseFriendManager.sharedManager attachRecoveryGestureTo:page];
            });
            if(!CSCloseFriendInstallHook(@"NewMainFrameViewController",name,replacement,&original,"v@:")) imp_removeBlock(replacement);
        }
        CSCloseFriendInstallHook(@"UIWindow",@"motionBegan:withEvent:",(IMP)CSMotionBegan,(IMP *)&CSMotionBeganOriginal,"v@:q@");
        CSCloseFriendInstallHook(@"UIWindow",@"motionEnded:withEvent:",(IMP)CSMotionEnded,(IMP *)&CSMotionEndedOriginal,"v@:q@");
        CSCloseFriendInstallHook(@"BaseMsgContentViewController",@"viewDidAppear:",(IMP)CSChatDidAppear,(IMP *)&CSChatDidAppearOriginal,"v@:B");
        [CSCloseFriendManager.sharedManager start];
    });
}
