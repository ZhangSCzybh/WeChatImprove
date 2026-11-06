#import <UIKit/UIKit.h>
#import "CSSettingsTableViewController.h"
#import "ProductionRoutes.h"

static NSUInteger checks, failures;
static NSMutableArray *samples;
static NSMutableDictionary *phaseCounts;
static void Check(BOOL ok, NSString *condition, NSString *route, NSString *phase) {
    checks++;
    if (!ok) {
        failures++;
        if(failures<=24) fprintf(stderr,"FAIL route=%s phase=%s condition=%s\n",route.UTF8String,phase.UTF8String,condition.UTF8String);
    }
}
static NSArray *TraceRect(CGRect r) { return @[@(r.origin.x),@(r.origin.y),@(r.size.width),@(r.size.height)]; }
// All state below is a host policy model, not an MMTabBar instance or UIKit transition.
// Native disassembly establishes that the owner uses destination/top.hidesBottomBarWhenPushed.
@interface NavigationPolicyModel : NSObject
@property BOOL hidden;
@property CGFloat alpha;
@property CGRect frame;
@property NSString *superview;
@property NSString *window;
@property BOOL snapshotVisible;
@property NSUInteger selectedTab;
@property NSUInteger nativeBarCount;
@property BOOL styled;
@property BOOL modal;
- (void)resolve:(UIViewController *)destination depth:(NSUInteger)depth;
- (void)prepareFrom:(BOOL)sourceHidden destination:(UIViewController *)destination depth:(NSUInteger)depth;
- (void)finish:(UIViewController *)destination depth:(NSUInteger)depth;
@end
@implementation NavigationPolicyModel
- (instancetype)init {
    if((self=[super init])){_alpha=1;_frame=CGRectMake(0,803,393,49);_superview=@"host-model-tab-owner";_window=@"host-model-window";_nativeBarCount=1;}
    return self;
}
- (void)resolve:(UIViewController *)destination depth:(NSUInteger)depth {
    self.hidden=self.modal || (depth>1 && destination.hidesBottomBarWhenPushed);
    self.alpha=1;self.snapshotVisible=NO;
}
- (void)prepareFrom:(BOOL)sourceHidden destination:(UIViewController *)destination depth:(NSUInteger)depth {
    BOOL target=self.modal || (depth>1 && destination.hidesBottomBarWhenPushed);
    self.snapshotVisible=!self.modal && sourceHidden!=target;
    // The native owner renders a transition copy when the visibility policy changes.
    // We record its presence separately; no claim is made about device hidden/alpha timing.
    self.hidden=target;
    self.alpha=self.snapshotVisible && !target ? 0 : 1;
}
- (void)finish:(UIViewController *)destination depth:(NSUInteger)depth { [self resolve:destination depth:depth]; }
@end
static void Sample(NavigationPolicyModel *model,UIViewController *vc,NSString *route,NSString *phase,BOOL expectHidden,BOOL child,NSUInteger cycle) {
    BOOL visible=(!model.hidden && model.alpha>.01) || model.snapshotVisible;
    [samples addObject:@{@"evidence_type":@"host-policy-model; NOT device runtime",@"route":route,@"phase":phase,@"cycle":@(cycle),
        @"MMTabBar_runtime":@"UNAVAILABLE; this is a model object",@"hidden":@(model.hidden),@"alpha":@(model.alpha),@"superview":model.superview,@"frame":TraceRect(model.frame),@"window":model.window,
        @"native_transition_copy_visible":@(model.snapshotVisible),@"rendered_bar_visible":@(visible),@"expected_hidden":@(expectHidden),
        @"vc_class":NSStringFromClass(vc.class),@"hidesBottomBarWhenPushed":@(vc.hidesBottomBarWhenPushed),@"modal":@(model.modal),@"is_child_controller":@(child),
        @"style_enabled_input":@(model.styled),@"selected_tab":@(model.selectedTab),@"native_bar_count":@(model.nativeBarCount)}];
    phaseCounts[phase]=@([phaseCounts[phase] unsignedIntegerValue]+1);
    Check(visible==!expectHidden,@"rendered native bar and transition copy respect destination policy",route,phase);
    Check(model.nativeBarCount==1,@"single native bar owner retained",route,phase);
}
static UIViewController *NativeRoot(void) {
    UIViewController *root=[UIViewController new];
    // Contract from MMUIViewController initWithNibName:bundle: at 0x1158785cc..5dc.
    root.hidesBottomBarWhenPushed=YES;
    return root;
}
int main(int argc,const char *argv[]) {
    @autoreleasepool {
        samples=[NSMutableArray array];phaseCounts=[NSMutableDictionary dictionary];
        NSArray<NSDictionary *> *routes=ProductionRoutes();
        for(NSDictionary *route in routes)for(NSUInteger style=0;style<2;style++)for(NSUInteger modal=0;modal<2;modal++)for(NSUInteger initializer=0;initializer<3;initializer++) {
            NSString *name=[NSString stringWithFormat:@"%@/style%lu/modal%lu/init%lu",route[@"label"],style,modal,initializer];
            Class cls=NSClassFromString(route[@"class"]);
            UIViewController *vc=initializer==1 && [cls isSubclassOfClass:UITableViewController.class]?[[cls alloc]initWithStyle:UITableViewStyleInsetGrouped]:initializer==2?[[cls alloc]initWithCoder:[[NSKeyedArchiver alloc]initRequiringSecureCoding:YES]]:[cls new];
            Check(vc!=nil,@"source-derived route class exists",name,@"constructed-before-view-load");
            Check(vc.hidesBottomBarWhenPushed,@"plugin page declares hidden bottom bar before view loading",name,@"constructed-before-view-load");
            [vc loadViewIfNeeded];
            Check(vc.hidesBottomBarWhenPushed,@"page policy remains hidden after full base viewDidLoad",name,@"after-view-load");
            NavigationPolicyModel *model=[NavigationPolicyModel new];model.modal=modal;model.styled=style;model.selectedTab=3;
            UIViewController *root=NativeRoot(),*pluginList=NativeRoot(),*main=[UIViewController new];
            for(NSUInteger cycle=0;cycle<2;cycle++) {
                [model resolve:root depth:2];
                Sample(model,root,name,@"root-list-appeared",YES,YES,cycle);
                Sample(model,root,name,@"push-start-before-owner-decision",YES,YES,cycle);
                [model prepareFrom:model.hidden destination:vc depth:3];
                for(NSUInteger tick=1;tick<=12;tick++)Sample(model,vc,name,[NSString stringWithFormat:@"push-middle-%02lu",tick],YES,NO,cycle);
                [model finish:vc depth:3];Sample(model,vc,name,@"push-complete",YES,NO,cycle);
                // Cancelled pop retains the child policy, without inheriting a sticky override.
                [model prepareFrom:model.hidden destination:root depth:2];
                Sample(model,root,name,@"pop-start",YES,YES,cycle);
                [model finish:vc depth:3];Sample(model,vc,name,@"pop-cancelled",YES,NO,cycle);
                [model prepareFrom:model.hidden destination:root depth:2];
                Sample(model,root,name,@"pop-start-after-cancel",YES,YES,cycle);
                for(NSUInteger tick=1;tick<=12;tick++)Sample(model,root,name,[NSString stringWithFormat:@"pop-middle-%02lu",tick],YES,YES,cycle);
                [model finish:root depth:2];Sample(model,root,name,@"pop-complete-root",YES,YES,cycle);
                [model finish:pluginList depth:2];Sample(model,pluginList,name,@"plugin-list-returned",YES,NO,cycle);
                BOOL wasModal=model.modal;model.modal=NO;
                [model finish:main depth:1];Sample(model,main,name,@"exit-plugin-main",NO,NO,cycle);
                Check(!main.hidesBottomBarWhenPushed,@"ordinary main controller keeps UIKit default NO",name,@"exit-plugin-main");
                for(NSUInteger tab=0;tab<8;tab++){model.selectedTab=tab%4;[model resolve:main depth:1];Sample(model,main,name,[NSString stringWithFormat:@"main-tab-%lu",tab],NO,NO,cycle);}
                model.modal=wasModal;model.selectedTab=3;
            }
        }
        NSDictionary *report=@{@"evidence_type":@"host-policy-model; actual UIKit/native bar runtime NOT executed",@"assertions":@(checks),@"passed":@(checks-failures),@"failed":@(failures),@"route_count":@(routes.count),@"sample_count":@(samples.count),@"phase_counts":phaseCounts,@"samples":samples};
        NSData *json=[NSJSONSerialization dataWithJSONObject:report options:NSJSONWritingPrettyPrinted error:nil];
        if(argc>1)[json writeToFile:[NSString stringWithUTF8String:argv[1]] atomically:YES];
        printf("RESULT assertions=%lu passed=%lu failed=%lu routes=%lu samples=%lu\n",checks,checks-failures,failures,routes.count,samples.count);
        return failures?1:0;
    }
}
