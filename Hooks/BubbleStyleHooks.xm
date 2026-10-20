// A single owner applies custom backgrounds to actual message cells. BubbleInfo getters stay native.
#import <UIKit/UIKit.h>
#import "../Controllers/CSBubbleStyleAdapter.h"
#import "../Controllers/CSBubbleTextColors.h"

%hook CommonMessageCellView
- (id)initWithViewModel:(id)model {
    id cell=%orig;
    CSBubbleStyleApply(cell);
    return cell;
}
- (void)setViewModel:(id)model {
    CSBubbleStyleDetach((UIView *)self);
    %orig;
    CSBubbleStyleApply((UIView *)self);
}
- (void)prepareForReuse {
    CSBubbleStyleDetach((UIView *)self);
    %orig;
}
- (void)layoutSubviews {
    %orig;
    CSBubbleStyleApply((UIView *)self);
}
- (void)updateBgImageView:(BOOL)update {
    %orig;
    CSBubbleStyleNativeChanged((UIView *)self);
}
- (void)traitCollectionDidChange:(UITraitCollection *)previous {
    %orig;
    CSBubbleStyleNativeChanged((UIView *)self);
}
- (void)onExtChatBackgroundChanged:(id)notification {
    %orig;
    CSBubbleStyleNativeChanged((UIView *)self);
}
- (void)onAppear {
    %orig;
    CSBubbleStyleApply((UIView *)self);
}
%end

// Call records can replace their background while their status/content changes.
// Their own boundaries also cover runtimes whose layout bypasses the common hook.
%hook VoIPBubbleMessageCellView
- (void)layoutContentView { %orig; CSBubbleStyleApply((UIView *)self); }
- (void)updateStatus { %orig; CSBubbleStyleNativeChanged((UIView *)self); }
%end

%hook TextMessageCellView
- (void)layoutContentView { %orig; CSBubbleStyleApply((UIView *)self); }
- (void)updateStatus { %orig; CSBubbleStyleApply((UIView *)self); }
%end

%hook VoiceMessageCellView
- (void)layoutContentView { %orig; CSBubbleStyleApply((UIView *)self); }
- (void)updateSecLabelColor { %orig; CSBubbleStyleApply((UIView *)self); }
%end

%hook RichTextView
- (void)setOTextColor:(id)color { %orig(CSBubbleTextColorAssignment(self,color)); }
%end

%hook VoIPSignalMessageCellView
- (void)layoutContentView { %orig; CSBubbleStyleApply((UIView *)self); }
- (void)updateStatus { %orig; CSBubbleStyleNativeChanged((UIView *)self); }
%end

// YYAsyncImageView may assign decoded/dynamic native images after the cell's layout.
// Only associated message background instances are observed; all other images pass through.
%hook YYAsyncImageView
- (void)setImage:(id)image {
    %orig(CSBubbleStyleImageAssignment((UIImageView *)self,image,NO));
}
- (void)setHighlightedImage:(id)image {
    %orig(CSBubbleStyleImageAssignment((UIImageView *)self,image,YES));
}
- (id)newAsyncDisplayTask {
    id task=%orig;
    // didSetDynamicYYImage only registers dark-mode observation, before decoding.
    CSBubbleStyleObserveDisplayTask((UIImageView *)self,task);
    return task;
}
%end

%hook YYImage
- (id)decodeImage {
    id decoded=%orig;
    CSBubbleStyleObserveDecodedImage(self,decoded);
    return decoded;
}
%end

%ctor { CSBubbleStyleStart(); }
