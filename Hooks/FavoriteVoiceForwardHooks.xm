#import "../Controllers/CSBackupBootstrap.h"
#import "CSFavoriteVoiceForwardAdapter.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static id CSFavoriteVoiceItemForDetailController(id controller) {
    if (!controller) return nil;
    @try {
        // In 8.0.80 this object ivar is inherited from FavBaseDetailViewController.
        Ivar itemIvar=class_getInstanceVariable(object_getClass(controller),"m_favItem");
        const char *encoding=itemIvar ? ivar_getTypeEncoding(itemIvar) : NULL;
        return encoding && encoding[0]=='@' ? object_getIvar(controller,itemIvar) : nil;
    } @catch (__unused NSException *exception) {
        return nil;
    }
}

%hook FavVoiceDetaiViewController
- (void)onAction:(id)sender {
    [CSFavoriteVoiceForwardAdapter.sharedAdapter withDetailMenuForController:self perform:^{ %orig; }];
}

%new
- (void)onFavActionSheetSelectedForwardToUser:(id)sender {
    id item=CSFavoriteVoiceItemForDetailController(self);
    [CSFavoriteVoiceForwardAdapter.sharedAdapter forwardItem:item fromController:self];
}
%end

%hook FavActionSheet
- (id)initWithFavDelegate:(id)delegate enableType:(unsigned long long)enabled {
    unsigned long long effective=(unsigned long long)[CSFavoriteVoiceForwardAdapter.sharedAdapter menuEnableType:(long long)enabled delegate:delegate];
    return %orig(delegate,effective);
}
%end

%hook MyFavoritesViewController
- (void)forwardData:(id)data {
    // Native filtered/search lists also pass FavDataItemWrap. Resolve only a
    // standalone voice parent; wrapped records and multi-selection stay native.
    if ([data isKindOfClass:NSArray.class] && [(NSArray *)data count]==1) {
        id item=[CSFavoriteVoiceContext standaloneItemForListObject:[(NSArray *)data firstObject]];
        CSFavoriteVoiceForwardAdapter *adapter=CSFavoriteVoiceForwardAdapter.sharedAdapter;
        if ([adapter canForwardItem:item]) {
            [adapter forwardItem:item fromController:self];
            return;
        }
    }
    %orig;
}
%end

%hook FavoritesMgr
- (void)onDownloadFavoritesItemFinished:(id)item ErrCode:(int)error {
    %orig;
    if (!CSFavoriteHasPendingVoiceDownloads()) return;
    // Native completion persists the file before the adapter verifies its bytes.
    void (^continuation)(void)=^{ [CSFavoriteVoiceForwardAdapter.sharedAdapter downloadFinishedForItem:item error:error]; };
    if (NSThread.isMainThread) continuation(); else dispatch_async(dispatch_get_main_queue(),continuation);
}
%end

%ctor {
    CSBackupWhenReady(^{ %init; });
}
