// A single owner applies custom backgrounds to actual message cells. BubbleInfo getters stay native.
#import <UIKit/UIKit.h>
#import "../Controllers/CSBubbleStyleAdapter.h"

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

// YYAsyncImageView may assign decoded/dynamic native images after the cell's layout.
// Only associated message background instances are observed; all other images pass through.
%hook YYAsyncImageView
- (void)setImage:(id)image {
    %orig(CSBubbleStyleImageAssignment((UIImageView *)self,image,NO));
}
- (void)setHighlightedImage:(id)image {
    %orig(CSBubbleStyleImageAssignment((UIImageView *)self,image,YES));
}
- (void)didSetDynamicYYImage {
    %orig;
    // The current object may have decoded in place, without another setImage: call.
    CSBubbleStyleImageDecoded((UIImageView *)self);
}
%end

%ctor { CSBubbleStyleStart(); }
