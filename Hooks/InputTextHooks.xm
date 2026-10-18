#import <UIKit/UIKit.h>
#import "CSInputTextStyle.h"

@interface BaseMsgContentViewController : UIViewController @end
@interface MMGrowTextView : UIView @end
@interface MMInputToolView : UIView
@property(nonatomic, strong) MMGrowTextView *textView;
@end

// Scope styles to the owning chat instead of a process-wide "in chat" flag.
%hook BaseMsgContentViewController
- (void)viewWillAppear:(BOOL)animated { %orig; CSInputTextStyleChatVisibility(self, YES); }
- (void)viewWillDisappear:(BOOL)animated { CSInputTextStyleChatVisibility(self, NO); %orig; }
%end

%hook MMGrowTextView
- (void)layoutSubviews { %orig; CSInputTextStyleApply(self); }
- (void)didMoveToWindow { %orig; CSInputTextStyleApply(self); }
- (void)didMoveToSuperview { %orig; CSInputTextStyleApply(self); }
- (void)traitCollectionDidChange:(UITraitCollection *)previous { %orig; CSInputTextStyleApply(self); }

// Keep the latest native placeholder for disable/leave-chat restoration. A depth
// guard in the adapter prevents recursive application through native setters.
- (void)setPlaceHolder:(NSString *)text {
    CSInputTextStyleNativeBegin(self, CSInputTextNativePlain, text);
    @try { %orig; } @finally { CSInputTextStyleNativeEnd(self); }
}
- (void)setAttributePlaceholder:(NSAttributedString *)text {
    CSInputTextStyleNativeBegin(self, CSInputTextNativeAttributed, text);
    @try { %orig; } @finally { CSInputTextStyleNativeEnd(self); }
}
- (void)setPlaceHolderColor:(UIColor *)color {
    CSInputTextStyleNativeBegin(self, CSInputTextNativeColor, color);
    @try { %orig; } @finally { CSInputTextStyleNativeEnd(self); }
}
- (void)setPlaceHolderMultiLine:(BOOL)multiline {
    CSInputTextStyleNativeBegin(self, CSInputTextNativeMultiline, @(multiline));
    @try { %orig; } @finally { CSInputTextStyleNativeEnd(self); }
}
- (void)setPlaceholder:(NSString *)text animated:(BOOL)animated {
    CSInputTextStyleNativeBegin(self, CSInputTextNativePlain, text);
    @try { %orig; } @finally { CSInputTextStyleNativeEnd(self); }
}
- (void)setAttributedPlaceholder:(NSAttributedString *)text animated:(BOOL)animated {
    CSInputTextStyleNativeBegin(self, CSInputTextNativeAttributed, text);
    @try { %orig; } @finally { CSInputTextStyleNativeEnd(self); }
}
%end

%hook MMInputToolView
- (void)layoutSubviews { %orig; CSInputTextStyleApply(self.textView); }
- (void)updateToolViewHeight:(BOOL)animated { %orig; CSInputTextStyleApply(self.textView); }
- (void)onWillAppear { %orig; CSInputTextStyleApply(self.textView); }
- (void)onViewDidInit { %orig; CSInputTextStyleApply(self.textView); }
%end

%ctor { CSInputTextStyleInstall(NSUserDefaults.standardUserDefaults); }
