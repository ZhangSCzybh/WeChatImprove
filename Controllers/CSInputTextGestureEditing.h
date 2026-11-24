#import <Foundation/Foundation.h>
#import "CSInputTextGesturePreferences.h"

// UITextView's native editing entry points, kept separate from gesture routing.
@protocol CSInputTextGestureEditor <NSObject>
@property(nonatomic, readonly, copy) NSString *text;
@property(nonatomic) NSRange selectedRange;
@property(nonatomic) id selectedTextRange;
@property(nonatomic, readonly) id beginningOfDocument;
@property(nonatomic, readonly) id endOfDocument;
@property(nonatomic, readonly) id markedTextRange;
- (id)textRangeFromPosition:(id)fromPosition toPosition:(id)toPosition;
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender;
- (void)copy:(id)sender;
- (void)cut:(id)sender;
- (void)paste:(id)sender;
- (void)deleteBackward;
@end

@protocol CSInputTextGestureSending <NSObject>
- (void)onTapSendButton;
@end

// YES means the native operation was submitted; it does not mean network delivery.
FOUNDATION_EXPORT BOOL CSInputTextGesturePerformAction(CSInputTextGestureAction action,
    id<CSInputTextGestureEditor> editor, id<CSInputTextGestureSending> tool);
