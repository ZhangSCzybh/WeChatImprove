#import "../Controllers/CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import "../Controllers/CSMessageMergeAdapter.h"
#import "../Controllers/CSMessageNavigation.h"
#import "../Controllers/CSMessageGestureAdapter.h"

@interface BaseMsgContentViewController : UIViewController @end
@interface CommonMessageViewModel : NSObject @end
@interface BaseMessageViewModel : NSObject @end
@interface CommonMessageCellView : UIView @end

%hook BaseMsgContentViewController
- (void)viewDidLoad { %orig; CSMessageMergeActivate(self); }
- (void)viewWillAppear:(BOOL)animated { %orig; CSMessageMergeActivate(self); }
- (void)viewDidDisappear:(BOOL)animated { CSMessageGestureCancelForController(self); CSMessageNavigationCancel(self); CSMessageMergeDeactivate(self); %orig; }
- (double)tableView:(UITableView *)table heightForRowAtIndexPath:(NSIndexPath *)path {
    CSMessageMergePrepare(self,table,path);
    double height = %orig;
    return CSMessageMergeRowHeight(self,table,path,height);
}
- (id)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)path {
    CSMessageMergePrepare(self,table,path);
    id cell = %orig;
    CSMessageMergeBind(self,table,path,cell);
    CSMessageNavigationBind(self,table,path,cell);
    return cell;
}
- (void)tableView:(UITableView *)table willDisplayCell:(id)cell forRowAtIndexPath:(NSIndexPath *)path {
    %orig; CSMessageMergeBind(self,table,path,cell); CSMessageNavigationBind(self,table,path,cell);
    CSMessageNavigationLayoutReady(self);
}
- (void)scrollViewDidEndDragging:(id)scroll willDecelerate:(BOOL)decelerate {
    %orig; if (!decelerate) CSMessageMergeFlush(self);
}
- (void)scrollViewWillBeginDragging:(id)scroll { CSMessageNavigationCancel(self); %orig; }
- (void)scrollViewDidEndScrollingAnimation:(id)scroll { %orig; CSMessageNavigationCheck(self); CSMessageMergeFlush(self); }
- (void)mmTableViewDidFinishedLoading:(id)table { %orig; CSMessageNavigationFinishedLoading(self); CSMessageMergeFlush(self); }
- (void)onLoadMessageFail { CSMessageNavigationFailed(self); %orig; }
- (void)scrollViewDidEndDecelerating:(id)scroll { %orig; CSMessageMergeFlush(self); }
- (void)MenuControllerWillHide:(id)notification {
    %orig;
    __weak id weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{ CSMessageMergeFlush(weakSelf); });
}
- (void)viewDidAppear:(BOOL)animated { %orig; CSMessageMergeFlush(self); CSMessageNavigationLayoutReady(self); }
- (void)viewDidLayoutSubviews { %orig; CSMessageNavigationLayoutReady(self); }
- (void)addMessageNode:(id)node layout:(BOOL)layout addMoreMsg:(BOOL)more {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)addMessageNode:(id)node addMoreMsg:(BOOL)more {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)addChatViewModel:(id)node addMoreMsg:(BOOL)more {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)replaceMessageNode:(id)node withMessageNodeList:(id)nodes {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)removeObjectsFromMessageNodeDatas:(id)nodes {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)deleteNode:(id)node {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)deleteNode:(id)node withDB:(BOOL)withDB animated:(BOOL)animated {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)removeAllObjectsFromMessageNodeDatas {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)reloadMessagesInternal {
    CSMessageMergeInvalidateLayout(self);
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)reloadTableData {
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)reloadNodeWithMessageWrap:(id)wrap {
    CSMessageMergeInvalidateLayout(self);
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)reloadNodeWithMessageWrap:(id)wrap WithTryScroll:(BOOL)scroll ReloadAll:(BOOL)all {
    CSMessageMergeInvalidateLayout(self);
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
- (void)clearNodeLayoutCache {
    CSMessageMergeInvalidateLayout(self);
    CSMessageNavigationContentChanged(self); CSMessageMergeWillMutate(self); @try { %orig; } @finally { CSMessageMergeDidMutate(self); }
}
%end

%hook CommonMessageViewModel
- (BOOL)isShowChatRoomDisplayName {
    BOOL native = %orig;
    return native && !CSMessageMergeHidesName(self);
}

%end

%hook BaseMessageViewModel
- (void)resetLayoutCache { CSMessageMergeResetGeometry(self); %orig; }
%end

%ctor {
    CSBackupWhenReady(^{ %init; });
}
