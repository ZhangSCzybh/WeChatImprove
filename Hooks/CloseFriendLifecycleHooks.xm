#import "../Controllers/CSCloseFriendBridge.h"
#import "../Controllers/CSCloseFriendManager.h"
static void (*CSHomeDidAppearOriginal)(id,SEL,BOOL);
static void CSHomeDidAppear(id self, SEL command, BOOL animated) {
    CSHomeDidAppearOriginal(self,command,animated);
    [CSCloseFriendManager.sharedManager start];
    [CSCloseFriendManager.sharedManager refreshAccount];
    [CSCloseFriendManager.sharedManager attachRecoveryGestureTo:self];
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
        CSCloseFriendInstallHook(@"UIWindow",@"motionBegan:withEvent:",(IMP)CSMotionBegan,(IMP *)&CSMotionBeganOriginal,"v@:q@");
        CSCloseFriendInstallHook(@"UIWindow",@"motionEnded:withEvent:",(IMP)CSMotionEnded,(IMP *)&CSMotionEndedOriginal,"v@:q@");
        [CSCloseFriendManager.sharedManager start];
    });
}
