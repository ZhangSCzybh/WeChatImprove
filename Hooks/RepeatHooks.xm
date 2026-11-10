#import "../Controllers/CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import "CSMessageActionMenuAdapter.h"
#import "CSClownMenuAdapter.h"

// Centralized policy and native actions; these are compatibility entry points only.

%hook CommonMessageCellView
- (id)operationMenuItems { return [CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook TextMessageCellView
- (id)operationMenuItems { return [CSClownMenuAdapter itemsByAddingActionsForCell:self items:[CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSClownMenuAdapter isPluginSelector:action]) return [CSClownMenuAdapter canPerformSelector:action cell:self];
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_clownEditText:(id)sender { [CSClownMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook ImageMessageCellView
- (id)operationMenuItems { return [CSClownMenuAdapter itemsByAddingActionsForCell:self items:[CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSClownMenuAdapter isPluginSelector:action]) return [CSClownMenuAdapter canPerformSelector:action cell:self];
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleAddStickerMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_clownEditImage:(id)sender { [CSClownMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook EmoticonMessageCellView
- (id)operationMenuItems { return [CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%end

// Dice and rock-paper-scissors build their menu without calling the common builder.
%hook GameMessageCellView
- (id)operationMenuItems { return [CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook VideoMessageCellView
- (id)operationMenuItems { return [CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook VoiceMessageCellView
- (id)operationMenuItems { return [CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook AppEmoticonMessageCellView
- (id)operationMenuItems { return [CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook AppFileMessageCellView
- (id)operationMenuItems { return [CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%end

%hook ShareCardMessageCellView
- (id)operationMenuItems { return [CSMessageActionMenuAdapter itemsByAddingActionsForCell:self items:%orig]; }
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([CSMessageActionMenuAdapter isPluginSelector:action]) return [CSMessageActionMenuAdapter canPerformSelector:action cell:self];
    return %orig;
}
%new
- (void)cs_handleRepeatMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%new
- (void)cs_handleVoiceForwardMenuItem:(id)sender { [CSMessageActionMenuAdapter performSelector:_cmd cell:self]; }
%end

// The device's alternate sticker menu path reaches uniq even when its builder is bypassed.
%hook BaseMessageCellView
- (id)uniqMenuItems:(id)items {
    id prepared=[CSMessageActionMenuAdapter itemsBeforeNativeDedupForCell:self items:items];
    return %orig(prepared);
}
%end

%ctor {
    CSBackupWhenReady(^{ %init; });
}
