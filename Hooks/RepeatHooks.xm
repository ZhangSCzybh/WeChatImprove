#import <UIKit/UIKit.h>
#import "CSMessageActionMenuAdapter.h"

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

%hook ImageMessageCellView
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
- (id)generateOperationMenu {
    id items=%orig;
    [CSMessageActionMenuAdapter recordMenuStage:@"menu.generate" cell:self items:items];
    return items;
}
- (id)uniqMenuItems:(id)items {
    [CSMessageActionMenuAdapter recordMenuStage:@"menu.uniq.in" cell:self items:items];
    id prepared=[CSMessageActionMenuAdapter itemsBeforeNativeDedupForCell:self items:items];
    id result=%orig(prepared);
    [CSMessageActionMenuAdapter recordMenuStage:@"menu.uniq.out" cell:self items:result];
    return result;
}
- (id)filteredMenuItems:(id)items {
    [CSMessageActionMenuAdapter recordMenuStage:@"menu.filter.in" cell:self items:items];
    id result=%orig;
    [CSMessageActionMenuAdapter recordMenuStage:@"menu.filter.out" cell:self items:result];
    return result;
}
%end
