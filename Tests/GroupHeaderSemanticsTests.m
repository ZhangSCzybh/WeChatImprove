// Actual header hooks and scopes with MMTableView semantics recovered from the
// 8.0.78.34 artifact. This is a host replay, not a UIKit/device rendering test.
#import <Foundation/Foundation.h>
#import "CSGroupIndexScope.h"
#import <math.h>
@interface UIView : NSObject @end
@implementation UIView @end
@interface UISearchBar : UIView @end
@implementation UISearchBar @end
@interface WCSearchBar : UIView @end
@implementation WCSearchBar @end
@class Table;
@interface CSGroupListAdapter : NSObject
@property(nonatomic,strong) UIView *nativeHeader;
@property(nonatomic) BOOL updatingHeader;
+ (instancetype)adapterForTable:(Table *)table;
- (UIView *)nativeTableHeaderView;
@end
@interface Table : NSObject
@property(nonatomic,strong) CSGroupListAdapter *adapter;
@property(nonatomic,strong) UIView *displayHeader;
@property(nonatomic) BOOL forceAuto,enableInset,throwDuringClassification;
@property(nonatomic) double rawTop,automaticTop,offset;
- (UIView *)tableHeaderView;
- (UIView *)originalTableHeaderView;
- (BOOL)hasSearchBarHeader;
- (BOOL)originalHasSearchBarHeader;
- (double)contentInset;
- (double)adjustedContentInset;
- (void)setContentInset:(double)value;
@end
@implementation CSGroupListAdapter
+ (instancetype)adapterForTable:(Table *)table { return table.adapter; }
- (UIView *)nativeTableHeaderView { return self.nativeHeader; }
@end
@implementation Table
#include "GroupHeaderBodies.h"
- (UIView *)originalTableHeaderView { return self.displayHeader; }
- (BOOL)originalHasSearchBarHeader {
    if (self.throwDuringClassification) [NSException raise:@"fixture" format:@"classification failure"];
    return [[self tableHeaderView] isKindOfClass:UISearchBar.class] ||
           [[self tableHeaderView] isKindOfClass:WCSearchBar.class];
}
// MMTableView 0x116728d34: enable => super.contentInset;
// otherwise force || hasSearchBarHeader => super.adjustedContentInset.
- (double)contentInset {
    return !self.enableInset && (self.forceAuto || self.hasSearchBarHeader) ? self.adjustedContentInset : self.rawTop;
}
- (double)adjustedContentInset { return self.rawTop+self.automaticTop; }
// MMTableView 0x116728b28: automatic branch clears super.contentInset,
// manual branch accepts the supplied top (with separate bottom adjustments).
- (void)setContentInset:(double)value {
    self.rawTop=!self.enableInset && (self.forceAuto || self.hasSearchBarHeader) ? 0 : value;
}
@end
static NSUInteger checks,failures;
static void Check(BOOL c,NSString *message) {
    checks++; if (!c) { failures++; fprintf(stderr,"FAIL: %s\n",message.UTF8String); }
}
static BOOL Near(double a,double b) { return fabs(a-b)<0.001; }
static Table *Grouped(Class headerClass) {
    Table *table=[Table new]; table.automaticTop=103;
    table.adapter=[CSGroupListAdapter new]; table.adapter.nativeHeader=[headerClass new];
    table.displayHeader=[UIView new]; return table;
}
int main(void) { @autoreleasepool {
    for (Class headerClass in @[UISearchBar.class,WCSearchBar.class]) {
        Table *table=Grouped(headerClass);
        Check(table.tableHeaderView==table.displayHeader,@"UIKit continues to see the displayed grouping wrapper");
        Check(table.hasSearchBarHeader,@"native header classification survives the grouping wrapper");
        CSGroupWithNativeIndices(table, ^{
            Check(table.tableHeaderView==table.adapter.nativeHeader,@"native row scope keeps its original header view");
            Check(table.hasSearchBarHeader,@"classification agrees in native row scope");
        });
        CSGroupWithDisplayIndices(table, ^{
            Check(table.hasSearchBarHeader,@"display row scope cannot switch inset semantics");
            Check(!CSGroupUsesNativeIndices(table),@"header classification does not change row domain");
            Check(table.tableHeaderView==table.displayHeader,@"header read scope ends after classification");
        });
        table.adapter.updatingHeader=YES;
        Check(table.hasSearchBarHeader,@"classification remains native during composite-header publication");
        Check(table.tableHeaderView==table.displayHeader,@"publication still lays out the real composite header");
        table.adapter.updatingHeader=NO;
        // Return flow: native reads its effective top; setter can run outside
        // the row domain. 1.6-18 crosses contracts here and writes 103 as raw.
        for (NSNumber *top in @[@103,@97.67,@103]) {
            table.automaticTop=top.doubleValue;
            __block double hostInset=0;
            CSGroupWithNativeIndices(table, ^{ hostInset=table.contentInset; });
            table.contentInset=hostInset;
            table.offset=-table.adjustedContentInset;
            Check(Near(table.rawTop,0) && Near(table.offset,-top.doubleValue),@"page return never copies adjusted top into raw top");
            Check(Near(table.contentInset,table.adjustedContentInset),@"effective inset interpretation stays the same after returning");
        }
        table.rawTop=103; table.contentInset=0;
        Check(Near(table.rawTop,0),@"native automatic setter can clear a pre-existing raw residue");
    }
    Table *table=Grouped(UIView.class);
    Check(!table.hasSearchBarHeader,@"non-search native headers remain non-search");
    table.contentInset=27;
    Check(Near(table.rawTop,27) && Near(table.contentInset,27),@"legitimate manual top padding is preserved");
    table.forceAuto=YES; table.contentInset=27;
    Check(Near(table.rawTop,0) && Near(table.contentInset,103),@"native force-auto policy remains authoritative");
    table.enableInset=YES; table.contentInset=27;
    Check(Near(table.rawTop,27),@"native enable-inset policy remains authoritative");
    table=Grouped(UISearchBar.class); table.enableInset=YES; table.contentInset=52;
    Check(Near(table.rawTop,52),@"native explicit inset mode still works with the composite header");
    // Other tables and detached grouping use their actual header unchanged.
    Table *other=[Table new]; other.displayHeader=[UISearchBar new];
    Check(other.hasSearchBarHeader,@"unattached search table uses its original classifier");
    other.displayHeader=[UIView new];
    Check(!other.hasSearchBarHeader,@"unattached non-search table uses its original classifier");
    table=Grouped(UISearchBar.class);
    CSGroupWithNativeHeader(table, ^{
        Check(CSGroupUsesNativeHeader(table) && !CSGroupUsesNativeHeader(other),@"native header scope is isolated per table");
        CSGroupWithDisplayIndices(table, ^{
            Check(table.tableHeaderView==table.adapter.nativeHeader && !CSGroupUsesNativeIndices(table),@"header and row domains nest independently");
        });
        CSGroupWithNativeHeader(other, ^{
            Check(CSGroupUsesNativeHeader(table) && CSGroupUsesNativeHeader(other),@"nested table header scopes preserve outer identity");
        });
        Check(!CSGroupUsesNativeHeader(other) && CSGroupUsesNativeHeader(table),@"inner header scope is removed independently");
    });
    Check(!CSGroupUsesNativeHeader(table),@"header scope does not leak after return");
    table.throwDuringClassification=YES;
    @try { (void)table.hasSearchBarHeader; } @catch (__unused NSException *exception) {}
    Check(!CSGroupUsesNativeHeader(table) && table.tableHeaderView==table.displayHeader,@"classification exception restores the scope");
    table.throwDuringClassification=NO;
    table.adapter.nativeHeader=nil;
    Check(!table.hasSearchBarHeader,@"removed native search header is respected immediately");
    fprintf(stdout,"Group header semantics: %lu checks, %lu failures\n",(unsigned long)checks,(unsigned long)failures);
    return failures ? 1 : 0;
} }
