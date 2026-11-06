#import "CSGroupInvocationMapper.h"

static NSDictionary<NSString *, NSArray<NSNumber *> *> *PathArguments(void) {
    static NSDictionary *arguments; static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSMutableDictionary *d=[NSMutableDictionary dictionary];
        for (NSString *name in @[@"cellForRowAtIndexPath", @"heightForRowAtIndexPath", @"estimatedHeightForRowAtIndexPath", @"didSelectRowAtIndexPath", @"didDeselectRowAtIndexPath", @"willSelectRowAtIndexPath", @"willDeselectRowAtIndexPath", @"canEditRowAtIndexPath", @"canMoveRowAtIndexPath", @"editingStyleForRowAtIndexPath", @"titleForDeleteConfirmationButtonForRowAtIndexPath", @"shouldIndentWhileEditingRowAtIndexPath", @"willBeginEditingRowAtIndexPath", @"didEndEditingRowAtIndexPath", @"indentationLevelForRowAtIndexPath", @"shouldHighlightRowAtIndexPath", @"didHighlightRowAtIndexPath", @"didUnhighlightRowAtIndexPath", @"shouldShowMenuForRowAtIndexPath", @"accessoryTypeForRowWithIndexPath", @"accessoryButtonTappedForRowWithIndexPath", @"prefetchRowsAtIndexPaths", @"cancelPrefetchingForRowsAtIndexPaths"]) {
            d[[NSString stringWithFormat:@"tableView:%@:",name]]=@[@3];
        }
        d[@"tableView:willDisplayCell:forRowAtIndexPath:"]=@[@4];
        d[@"tableView:didEndDisplayingCell:forRowAtIndexPath:"]=@[@4];
        d[@"tableView:commitEditingStyle:forRowAtIndexPath:"]=@[@4];
        d[@"tableView:moveRowAtIndexPath:toIndexPath:"]=@[@3,@4];
        d[@"tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:"]=@[@3,@4];
        d[@"tableView:canPerformAction:forRowAtIndexPath:withSender:"]=@[@4];
        d[@"tableView:performAction:forRowAtIndexPath:withSender:"]=@[@4];
        arguments=[d copy];
    }); return arguments;
}
BOOL CSGroupInvocationReturnsPath(SEL sel) {
    NSString *s=NSStringFromSelector(sel);
    return [@[@"tableView:willSelectRowAtIndexPath:",@"tableView:willDeselectRowAtIndexPath:",@"tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:"] containsObject:s];
}
BOOL CSGroupInvocationIsSupported(SEL sel) {
    NSString *s=NSStringFromSelector(sel);
    if (PathArguments()[s]) return YES;
    static NSSet *plain; static dispatch_once_t once;
    dispatch_once(&once, ^{ plain=[NSSet setWithArray:@[@"numberOfSectionsInTableView:",@"tableView:numberOfRowsInSection:",@"tableView:titleForHeaderInSection:",@"tableView:titleForFooterInSection:",@"tableView:viewForHeaderInSection:",@"tableView:viewForFooterInSection:",@"tableView:heightForHeaderInSection:",@"tableView:heightForFooterInSection:",@"tableView:estimatedHeightForHeaderInSection:",@"tableView:estimatedHeightForFooterInSection:",@"tableView:willDisplayHeaderView:forSection:",@"tableView:willDisplayFooterView:forSection:",@"tableView:didEndDisplayingHeaderView:forSection:",@"tableView:didEndDisplayingFooterView:forSection:",@"sectionIndexTitlesForTableView:",@"tableView:sectionForSectionIndexTitle:atIndex:",@"scrollViewDidScroll:",@"scrollViewDidZoom:",@"scrollViewWillBeginDragging:",@"scrollViewWillEndDragging:withVelocity:targetContentOffset:",@"scrollViewDidEndDragging:willDecelerate:",@"scrollViewWillBeginDecelerating:",@"scrollViewDidEndDecelerating:",@"scrollViewDidEndScrollingAnimation:",@"viewForZoomingInScrollView:",@"scrollViewWillBeginZooming:withView:",@"scrollViewDidEndZooming:withView:atScale:",@"scrollViewShouldScrollToTop:",@"scrollViewDidScrollToTop:",@"scrollViewDidChangeAdjustedContentInset:"]]; });
    return [plain containsObject:s];
}
BOOL CSGroupMapInvocationPaths(NSInvocation *inv, NSIndexPath *(^map)(NSIndexPath *)) {
    NSArray *slots=PathArguments()[NSStringFromSelector(inv.selector)];
    if (!CSGroupInvocationIsSupported(inv.selector)) return NO;
    NSMutableArray *mapped=[NSMutableArray array];
    for (NSNumber *slot in slots) {
        NSUInteger idx=slot.unsignedIntegerValue;
        if (idx>=inv.methodSignature.numberOfArguments || strcmp([inv.methodSignature getArgumentTypeAtIndex:idx],"@")!=0) return NO;
        __unsafe_unretained id value=nil; [inv getArgument:&value atIndex:idx];
        if (!value) { [mapped addObject:NSNull.null]; continue; }
        if ([value isKindOfClass:NSIndexPath.class]) {
            NSIndexPath *p=map(value); if (!p) return NO; [mapped addObject:p];
        } else if ([value isKindOfClass:NSArray.class]) {
            NSMutableArray *paths=[NSMutableArray array];
            for (id p in value) { if (![p isKindOfClass:NSIndexPath.class]) return NO; NSIndexPath *out=map(p); if (!out) return NO; [paths addObject:out]; }
            [mapped addObject:[paths copy]];
        } else return NO;
    }
    [slots enumerateObjectsUsingBlock:^(NSNumber *slot, NSUInteger i, BOOL *stop) {
        (void)stop;
        id value=mapped[i]==NSNull.null ? nil : mapped[i]; [inv setArgument:&value atIndex:slot.unsignedIntegerValue];
    }];
    [inv retainArguments]; return YES;
}
