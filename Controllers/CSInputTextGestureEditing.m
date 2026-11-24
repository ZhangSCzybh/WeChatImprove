#import "CSInputTextGestureEditing.h"

BOOL CSInputTextGesturePerformAction(CSInputTextGestureAction action,
    id<CSInputTextGestureEditor> editor, id<CSInputTextGestureSending> tool) {
    if (!NSThread.isMainThread || !editor || editor.markedTextRange ||
        action <= CSInputTextGestureActionDisabled || action > CSInputTextGestureActionSend) return NO;
    NSString *text = [editor.text copy];
    if (![text isKindOfClass:NSString.class]) return NO;
    if (action == CSInputTextGestureActionPaste) {
        if (![editor canPerformAction:@selector(paste:) withSender:nil]) return NO;
        [editor paste:nil];
        return YES;
    }
    if (!text.length) return NO;
    if (action == CSInputTextGestureActionSend) {
        if (![tool respondsToSelector:@selector(onTapSendButton)]) return NO;
        [tool onTapSendButton];
        return YES;
    }
    id selection = editor.selectedTextRange;
    id wholeDocument = [editor textRangeFromPosition:editor.beginningOfDocument toPosition:editor.endOfDocument];
    if (!wholeDocument) return NO;
    BOOL submitted = NO;
    @try {
        // WeChat's encoded plain text can have a different length from its
        // attributed document (emoji and mentions). Use native document positions.
        editor.selectedTextRange = wholeDocument;
        switch (action) {
            case CSInputTextGestureActionCopy:
                if ([editor canPerformAction:@selector(copy:) withSender:nil]) {
                    [editor copy:nil]; submitted = YES;
                }
                break;
            case CSInputTextGestureActionCut:
                if ([editor canPerformAction:@selector(cut:) withSender:nil]) {
                    [editor cut:nil]; submitted = YES;
                }
                break;
            case CSInputTextGestureActionClear:
                // Native deletion keeps WeChat's text/mention/height callbacks intact.
                [editor deleteBackward]; submitted = YES;
                break;
            default: break;
        }
    } @finally {
        // Copy and refused edits must not move the user's insertion point.
        if (action == CSInputTextGestureActionCopy || [editor.text isEqualToString:text]) {
            editor.selectedTextRange = selection;
        }
    }
    return submitted;
}
