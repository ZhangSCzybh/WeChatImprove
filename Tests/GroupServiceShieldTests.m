// Focused Service-tab return regression. The included fixture executes the
// extracted production shield, real projection/policy and actual proxy. These
// callbacks are explicit host inputs, not a reconstructed phone lifecycle.
#define main GroupContainerCoreMain
#include "GroupContainerReturnTests.m"
#undef main

static NSString *TabName(WETabType type) {
    return type==WETabTypeAll?@"Whole":type==WETabTypeGroup?@"Group":type==WETabTypePrivate?@"Friend":@"Service";
}
static CSGroupListAdapter *ServiceList(WETabType type) {
    CSGroupListAdapter *a=List(NO);
    NSMutableArray *tabs=[NSMutableArray array];
    for (NSNumber *value in @[@(WETabTypeAll),@(WETabTypeGroup),@(WETabTypePrivate),@(WETabTypeOfficial)])
        [tabs addObject:[WESessionTabItem tabWithType:value.integerValue]];
    a.preferences.tabs=tabs;a.preferences.selectedTabID=[[WESessionTabItem tabWithType:type] tabId];
    a.dirty=YES;[a refresh];[a.table originalLayout];Reset(a);return a;
}
static NSDictionary *Predicate(UITableViewCell *cell) {
    NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);CSGroupRow *row=delivery[@"row"];
    BOOL unknown=policy.blocked || ![delivery[@"account"] isEqual:policy.accountID] ||
        ![policy.accountID isEqual:account] || !row;
    BOOL direct=[policy hidesUserName:row.userName surface:CSCloseFriendSurfaceSession];
    BOOL blanket=row.kind==CSGroupRowKindAggregate && policy.protectedUserNames.count>0;
    return @{@"name":row.userName ?: @"business-banner",@"kind":@(row.kind),@"category":@(row.category),
        @"unknown":@(unknown),@"directHiddenIdentity":@(direct),@"blanketAggregate":@(blanket),
        @"protectedNames":@(policy.protectedUserNames.count),@"hiddenBefore":@(cell.hidden)};
}
static void KnownRows(WETabType tab,BOOL revealed,NSString *path) {
    scenario=[NSString stringWithFormat:@"service-shield/%@/%@/%@",path,TabName(tab),revealed?@"unlocked":@"locked"];
    policy=Policy(revealed,NO,210+revealed);CSGroupListAdapter *a=ServiceList(tab);
    CGSize size=a.table.contentSize;CGPoint offset=a.table.contentOffset;
    NSMutableArray *predicates=[NSMutableArray array];
    for(UITableViewCell *cell in a.table.visibleCells)[predicates addObject:Predicate(cell)];
    [a shieldVisiblePrivateRows];
    NSUInteger serviceAggregates=0,hiddenHarmless=0,hiddenPrivate=0;
    for(NSUInteger i=0;i<a.table.visibleCells.count;i++) {
        UITableViewCell *cell=a.table.visibleCells[i];NSDictionary *before=predicates[i];
        BOOL ordinary=!([before[@"directHiddenIdentity"] boolValue] || [before[@"unknown"] boolValue]);
        BOOL service=([before[@"name"] isEqual:@"brandsessionholder"] || [before[@"name"] isEqual:@"brandservicesessionholder"]);
        if(service) { serviceAggregates++;Check(!cell.hidden,@"unrelated official/service aggregate never individually disappears"); }
        if(ordinary) { hiddenHarmless+=cell.hidden;Check(!cell.hidden,@"known ordinary row remains visible during return shielding"); }
        if([before[@"directHiddenIdentity"] boolValue])hiddenPrivate+=cell.hidden;
        NSMutableDictionary *after=[before mutableCopy];after[@"hiddenAfter"]=@(cell.hidden);Emit(@"shield-predicate",after);
    }
    if(tab==WETabTypeAll || tab==WETabTypeOfficial)Check(serviceAggregates==2,@"Whole and Service fixture really contain both official/service aggregates");
    else Check(serviceAggregates==0,@"Group and Friend membership excludes unrelated service containers");
    Check(a.table.layer.mask==nil,@"known ready return never neutralizes harmless content as a whole");
    Check(CGSizeEqualToSize(size,a.table.contentSize) && CGPointEqualToPoint(offset,a.table.contentOffset),@"shield keeps original geometry and viewport");
    Check(a.table.reloads==0 && a.table.rowReloads==0 && a.table.offsetWrites==0,@"shield causes no reload or intermediate offset write");
    Emit(@"shield-stage-result",@{@"tab":TabName(tab),@"revealed":@(revealed),@"visibleCells":@(a.table.visibleCells.count),
        @"serviceAggregateRows":@(serviceAggregates),@"hiddenHarmlessRows":@(hiddenHarmless),@"hiddenPrivateRows":@(hiddenPrivate),
        @"contentWidth":@(size.width),@"contentHeight":@(size.height),@"offsetX":@(offset.x),@"offsetY":@(offset.y),
        @"standardAppearanceCallbacks":@0,@"entryInput":path});
    [a.privacyShield prepareForPublication];
    for(UITableViewCell *cell in a.table.visibleCells)Check(!cell.hidden,@"safe publication restores original per-cell hidden state");
}
static void LockStaleVisibleRows(NSString *path) {
    scenario=[NSString stringWithFormat:@"service-shield/%@/visible-unlocked-to-locked",path];
    policy=Policy(YES,NO,230);CSGroupListAdapter *a=ServiceList(WETabTypeAll);policy=Policy(NO,NO,231);
    [a shieldVisiblePrivateRows];NSUInteger protectedRows=0,harmlessAggregates=0;
    for(UITableViewCell *cell in a.table.visibleCells) {
        NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);CSGroupRow *row=delivery[@"row"];
        if([policy hidesUserName:row.userName surface:CSCloseFriendSurfaceSession]) {
            protectedRows++;Check(cell.hidden,@"lock transition conceals each previously delivered protected friend/group");
        }
        if([row.userName isEqual:@"brandsessionholder"] || [row.userName isEqual:@"brandservicesessionholder"]) {
            harmlessAggregates++;Check(!cell.hidden,@"lock transition does not conceal unrelated service aggregate");
        }
        Emit(@"lock-transition-predicate",Predicate(cell));
    }
    Check(protectedRows==2 && harmlessAggregates==2,@"stale unlocked fixture includes protected friend/group plus both harmless aggregates");
}
static void UnknownRows(NSString *path,NSString *reason,BOOL preexistingMask) {
    scenario=[NSString stringWithFormat:@"service-shield/%@/unknown-%@/old-mask-%@",path,reason,preexistingMask?@"yes":@"no"];
    policy=Policy(NO,NO,250);CSGroupListAdapter *a=ServiceList(WETabTypeOfficial);
    CALayer *oldMask=preexistingMask?[CALayer new]:nil;oldMask.bounds=CGRectMake(0,0,320,600);a.table.layer.mask=oldMask;
    a.table.accessibilityElementsHidden=preexistingMask;
    NSMutableArray *oldHidden=[NSMutableArray array];for(UITableViewCell *cell in a.table.visibleCells)[oldHidden addObject:@(cell.hidden)];
    CGSize size=a.table.contentSize;CGPoint offset=a.table.contentOffset;
    if([reason isEqual:@"nil-policy"])policy=nil;
    else if([reason isEqual:@"blocked-policy"])policy=Policy(NO,YES,251);
    else if([reason isEqual:@"missing-delivery"])
        objc_setAssociatedObject(a.table.visibleCells.lastObject,&CellRowKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    else if([reason isEqual:@"delivery-account-mismatch"]) {
        UITableViewCell *cell=a.table.visibleCells.lastObject;
        NSMutableDictionary *delivery=[objc_getAssociatedObject(cell,&CellRowKey) mutableCopy];delivery[@"account"]=@"other-account";
        objc_setAssociatedObject(cell,&CellRowKey,delivery,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else if([reason isEqual:@"policy-account-mismatch"])
        policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"other-account" profile:@{@"enabled":@YES,@"friends":@[],@"groups":@[],@"options":@{}} revealed:NO revision:251 blocked:NO];
    [a shieldVisiblePrivateRows];
    BOOL coherent=a.table.layer.mask && a.table.layer.mask!=oldMask && CGRectIsEmpty(a.table.layer.mask.bounds);
    NSUInteger changedHidden=0,hidden=0;
    for(NSUInteger i=0;i<a.table.visibleCells.count;i++) {
        UITableViewCell *cell=a.table.visibleCells[i];changedHidden+=cell.hidden!=[oldHidden[i] boolValue];hidden+=cell.hidden;
    }
    Check(coherent,@"unknown policy/delivery neutralizes complete content layer with one empty mask");
    Check(a.table.accessibilityElementsHidden,@"whole neutral content is unavailable to accessibility");
    Check(changedHidden==0,@"unknown content never hides isolated cells or creates row holes");
    Check(CGSizeEqualToSize(size,a.table.contentSize) && CGPointEqualToPoint(offset,a.table.contentOffset),@"whole neutralization retains geometry and viewport");
    Check(a.table.reloads==0 && a.table.rowReloads==0 && a.table.offsetWrites==0,@"whole neutralization adds no reload or offset change");
    CALayer *neutralMask=a.table.layer.mask;[a shieldVisiblePrivateRows];
    Check(a.table.layer.mask==neutralMask,@"repeated unknown stage keeps the same neutral content mask");
    Emit(@"unknown-stage-result",@{@"reason":reason,@"entryInput":path,@"preexistingMask":@(preexistingMask),
        @"wholeContentNeutral":@(coherent),@"accessibilityHidden":@(a.table.accessibilityElementsHidden),
        @"visibleCells":@(a.table.visibleCells.count),@"hiddenCells":@(hidden),@"individualHiddenChanges":@(changedHidden),
        @"contentWidth":@(a.table.contentSize.width),@"contentHeight":@(a.table.contentSize.height),
        @"offsetX":@(a.table.contentOffset.x),@"offsetY":@(a.table.contentOffset.y),@"fullReloads":@(a.table.reloads),
        @"rowReloads":@(a.table.rowReloads),@"offsetWrites":@(a.table.offsetWrites)});
    [a.privacyShield prepareForPublication];
    Check(a.table.layer.mask==neutralMask && a.table.accessibilityElementsHidden,@"prepare-for-publication retains whole mask until verified content and viewport finish");
    policy=Policy(NO,NO,252);[a.privacyShield finishTablePublication];
    Check(a.table.layer.mask==oldMask,@"publication restores the original content mask exactly");
    Check(a.table.accessibilityElementsHidden==preexistingMask,@"publication restores original accessibility state");
    BOOL restored=YES;for(NSUInteger i=0;i<a.table.visibleCells.count;i++)restored&=a.table.visibleCells[i].hidden==[oldHidden[i] boolValue];
    Check(restored,@"publication preserves all original per-cell hidden flags");
}
int main(void) {@autoreleasepool {
    Emit(@"probe-boundary",@{@"deviceEvidence":@NO,@"scope":@"Production shield and proxy/projection/policy with deterministic UIKit doubles; miniapp/chat labels are controlled entry inputs"});
    for(NSString *path in @[@"miniapp-container-return",@"chat-return"])
        for(NSNumber *revealed in @[@NO,@YES])
            for(NSNumber *tab in @[@(WETabTypeAll),@(WETabTypeGroup),@(WETabTypePrivate),@(WETabTypeOfficial)])
                KnownRows(tab.integerValue,revealed.boolValue,path);
    LockStaleVisibleRows(@"miniapp-container-return");LockStaleVisibleRows(@"chat-return");
    for(NSString *path in @[@"miniapp-container-return",@"chat-return"])
        for(NSString *reason in @[@"nil-policy",@"blocked-policy",@"missing-delivery",@"delivery-account-mismatch",@"policy-account-mismatch"])
            for(NSNumber *mask in @[@NO,@YES])UnknownRows(path,reason,mask.boolValue);
    Emit(@"result",@{@"checks":@(checks),@"failures":@(failures)});
    fprintf(stderr,"Group service shield HOST: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);return failures?1:0;
}}
