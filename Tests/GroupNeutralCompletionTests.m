// Production completion helper with controlled UIKit placements/reentry.
#define main GroupContainerCoreMain
#include "GroupContainerReturnTests.m"
#undef main
static CSGroupListAdapter *CompletionList(void) {
    policy=Policy(NO,NO,301);CSGroupListAdapter *a=List(NO);[a.table originalLayout];Reset(a);
    [a neutralizeVisibleContent];return a;
}
static void CompletionRepair(BOOL placeholder,BOOL reentry) {
    scenario=[NSString stringWithFormat:@"neutral-completion/%@/%@",placeholder?@"placeholder":@"unknown-raw-cell",reentry?@"policy-reentry":@"unchanged-plan"];
    CSGroupListAdapter *a=CompletionList();NSMutableArray *cells=[a.table.visibleCells mutableCopy];
    NSUInteger index=MIN((NSUInteger)3,cells.count-1);UITableViewCell *replacement=[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:nil];
    replacement.textLabel.text=placeholder?@"":@"secret@chatroom";
    if(placeholder)objc_setAssociatedObject(replacement,&CellRowKey,@{@"neutral":@YES},OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    cells[index]=replacement;a.table.visibleCells=cells;
    __block BOOL maskDuringRepair=NO;
    a.table.afterOriginalLayout=^{maskDuringRepair=a.table.layer.mask!=nil;if(reentry)policy=Policy(NO,YES,302);};
    [a finishNeutralPublication:NO];a.table.afterOriginalLayout=nil;
    Check(a.table.rowReloads==1,@"only mismatched visible placement is repaired through local row refresh");
    Check(a.table.reloads==0,@"completion never uses a full table reload");
    Check(maskDuringRepair,@"content mask remains installed during row repair and layout");
    Check(a.controller.privateCellCalls==0,@"repair never requests native protected cell");
    if(reentry) {
        Check(a.table.layer.mask!=nil && a.table.accessibilityElementsHidden,@"policy reentry keeps all content masked");
    } else {
        Check(a.table.layer.mask==nil && !a.table.accessibilityElementsHidden,@"verified repaired placements reveal together after final geometry");
        Check(a.neutralViewport==nil,@"verified completion releases the retained safe viewport");
        BOOL protected=NO;for(UITableViewCell *cell in a.table.visibleCells)protected|=[cell.textLabel.text hasPrefix:@"secret"];
        Check(!protected,@"first revealed content contains no protected identity");
    }
    Emit(@"completion-result",@{@"placeholder":@(placeholder),@"policyReentry":@(reentry),@"rowReloads":@(a.table.rowReloads),@"fullReloads":@(a.table.reloads),@"masked":@(a.table.layer.mask!=nil),@"maskDuringRepair":@(maskDuringRepair),@"privateNativeCellCalls":@(a.controller.privateCellCalls)});
}
static void CompletionStage(BOOL native,BOOL publishing) {
    scenario=[NSString stringWithFormat:@"neutral-completion/%@/%@",native?@"ready-native-unlocked":@"ready-filtered",publishing?@"publication-in-progress":@"idle"];
    CSGroupListAdapter *a=CompletionList();if(native){policy=Policy(YES,NO,303);a.projecting=NO;a.projection=nil;[a.table originalLayout];Reset(a);}
    a.publishing=publishing;[a finishNeutralPublication:NO];
    if(publishing){Check(a.table.layer.mask!=nil,@"nested table layout never reveals a publication in progress");Check(a.table.layoutRequests>0,@"nested native publication requests a natural completion layout");a.publishing=NO;[a.table layoutSubviews];}
    Check(a.table.layer.mask==nil,@"ready table layout completes filtered/native publication without an optional scroll callback");
    Check(a.table.reloads==0,@"ready native completion does not reconstruct the table");
}
int main(void) {@autoreleasepool {
    Emit(@"probe-boundary",@{@"deviceEvidence":@NO,@"scope":@"Extracted production completion helper; deterministic visible placement replacement and synchronous policy reentry"});
    CompletionRepair(YES,NO);CompletionRepair(NO,NO);CompletionRepair(YES,YES);CompletionRepair(NO,YES);
    CompletionStage(NO,NO);CompletionStage(NO,YES);CompletionStage(YES,NO);CompletionStage(YES,YES);
    Emit(@"result",@{@"checks":@(checks),@"failures":@(failures)});
    fprintf(stderr,"Group neutral completion HOST: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);return failures?1:0;
}}
