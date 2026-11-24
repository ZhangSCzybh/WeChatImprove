#import <Foundation/Foundation.h>
#import "CSInputTextGestureEditing.h"
#import "CSInputTextGesturePreferences.h"
#include <math.h>

static NSUInteger checks, failures;
static void Check(BOOL passed, NSString *message) {
    checks++;
    if (!passed) { failures++; fprintf(stderr, "FAIL: %s\n", message.UTF8String); }
}

// Memory-only defaults: no standard domain, account, or persistent suite is touched.
@interface InputGestureDefaults : NSUserDefaults
@property(nonatomic, strong) NSMutableDictionary *values;
@property(nonatomic) NSUInteger writes;
@end
@implementation InputGestureDefaults
- (instancetype)init { if ((self = [super init])) _values = [NSMutableDictionary dictionary]; return self; }
- (id)objectForKey:(NSString *)key { return self.values[key]; }
- (void)setObject:(id)value forKey:(NSString *)key { self.writes++; self.values[key] = value; }
@end

static InputGestureDefaults *fixtureDefaults;
@interface InputGesturePreferences : CSInputTextGesturePreferences @end
@implementation InputGesturePreferences
+ (NSUserDefaults *)cs_defaults { return fixtureDefaults; }
@end

@interface GestureEditor : NSObject <CSInputTextGestureEditor>
@property(nonatomic, copy) NSString *text;
@property(nonatomic) NSRange selectedRange;
@property(nonatomic, strong) id selectedTextRange;
@property(nonatomic, copy) NSString *documentText;
@property(nonatomic, strong) id markedTextRange;
@property(nonatomic, copy) NSString *clipboard;
@property(nonatomic) BOOL nativeAllowed, rejectMutation, documentUnavailable;
@property(nonatomic) NSUInteger queries, copies, cuts, pastes, deletes;
@property(nonatomic) NSRange actionRange;
@end
@implementation GestureEditor
- (instancetype)init {
    if ((self = [super init])) {
        _text = @"开头🙂正文末尾";
        self.selectedRange = NSMakeRange(2, 2);
        _clipboard = @"原剪贴板";
        _nativeAllowed = YES;
    }
    return self;
}
- (NSRange)selectedRange { return [self.selectedTextRange rangeValue]; }
- (void)setSelectedRange:(NSRange)range { self.selectedTextRange = [NSValue valueWithRange:range]; }
- (NSString *)nativeDocument { return self.documentText ?: self.text; }
- (id)beginningOfDocument { return @0; }
- (id)endOfDocument { return @(self.nativeDocument.length); }
- (id)textRangeFromPosition:(id)fromPosition toPosition:(id)toPosition {
    if (self.documentUnavailable || !fromPosition || !toPosition) return nil;
    return [NSValue valueWithRange:NSMakeRange([fromPosition unsignedIntegerValue],
                                             [toPosition unsignedIntegerValue] - [fromPosition unsignedIntegerValue])];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    (void)sender;
    self.queries++;
    if (!self.nativeAllowed) return NO;
    if (action == @selector(paste:)) return self.clipboard.length > 0;
    return action == @selector(copy:) || action == @selector(cut:) || action == @selector(deleteBackward);
}
- (void)copy:(id)sender {
    (void)sender;
    self.copies++; self.actionRange = self.selectedRange;
    self.clipboard = [self.nativeDocument substringWithRange:self.selectedRange];
}
- (void)cut:(id)sender {
    (void)sender;
    self.cuts++; self.actionRange = self.selectedRange;
    if (self.rejectMutation) return;
    self.clipboard = [self.nativeDocument substringWithRange:self.selectedRange];
    self.text = [self.nativeDocument stringByReplacingCharactersInRange:self.selectedRange withString:@""];
    if (self.documentText) self.documentText = self.text;
    self.selectedRange = NSMakeRange(self.selectedRange.location, 0);
}
- (void)paste:(id)sender {
    (void)sender;
    self.pastes++; self.actionRange = self.selectedRange;
    if (self.rejectMutation) return;
    self.text = [self.nativeDocument stringByReplacingCharactersInRange:self.selectedRange withString:self.clipboard];
    if (self.documentText) self.documentText = self.text;
    self.selectedRange = NSMakeRange(self.selectedRange.location + self.clipboard.length, 0);
}
- (void)deleteBackward {
    self.deletes++; self.actionRange = self.selectedRange;
    if (self.rejectMutation) return;
    self.text = [self.nativeDocument stringByReplacingCharactersInRange:self.selectedRange withString:@""];
    if (self.documentText) self.documentText = self.text;
    self.selectedRange = NSMakeRange(self.selectedRange.location, 0);
}
@end

@interface GestureTool : NSObject <CSInputTextGestureSending>
@property(nonatomic) NSUInteger sends;
@end
@implementation GestureTool
- (void)onTapSendButton { self.sends++; }
@end

static NSUInteger ActionCount(GestureEditor *editor, GestureTool *tool) {
    return editor.copies + editor.cuts + editor.pastes + editor.deletes + tool.sends;
}
static void Pump(void) {
    [NSRunLoop.mainRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.03]];
}

static void TestPreferences(void) {
    fixtureDefaults = [InputGestureDefaults new];
    Check(![InputGesturePreferences enabled], @"absent settings leave the gesture disabled");
    Check([InputGesturePreferences actionForKey:CSInputTextGestureLeftActionKey] == CSInputTextGestureActionDisabled &&
          [InputGesturePreferences actionForKey:CSInputTextGestureRightActionKey] == CSInputTextGestureActionDisabled,
          @"both directions default to disabled without writing defaults");
    Check(fixtureDefaults.writes == 0 && fixtureDefaults.values.count == 0, @"read-only defaults do not create configuration");
    Check([CSInputTextGestureEnabledKey isEqual:@"com.wechat.enhance.inputText.gesture.enabled"] &&
          [CSInputTextGestureLeftActionKey isEqual:@"com.wechat.enhance.inputText.gesture.leftAction"] &&
          [CSInputTextGestureRightActionKey isEqual:@"com.wechat.enhance.inputText.gesture.rightAction"],
          @"settings use the input module's established default domain keys");
    __block NSUInteger notifications = 0;
    __block BOOL deliveredOnMain = YES;
    id observer = [NSNotificationCenter.defaultCenter addObserverForName:CSInputTextGesturePreferencesDidChangeNotification
        object:nil queue:nil usingBlock:^(__unused NSNotification *note) {
            notifications++; deliveredOnMain = deliveredOnMain && NSThread.isMainThread;
        }];
    [InputGesturePreferences setEnabled:YES];
    [InputGesturePreferences setAction:CSInputTextGestureActionClear forKey:CSInputTextGestureLeftActionKey];
    [InputGesturePreferences setAction:CSInputTextGestureActionPaste forKey:CSInputTextGestureRightActionKey];
    Check([InputGesturePreferences enabled] &&
          [InputGesturePreferences actionForKey:CSInputTextGestureLeftActionKey] == CSInputTextGestureActionClear &&
          [InputGesturePreferences actionForKey:CSInputTextGestureRightActionKey] == CSInputTextGestureActionPaste,
          @"each direction stores an independent action while the gesture switch is enabled");
    Pump();
    Check(notifications == 1 && deliveredOnMain, @"batched changes refresh once on the main thread");
    NSUInteger writes = fixtureDefaults.writes;
    [InputGesturePreferences setEnabled:YES];
    [InputGesturePreferences setAction:CSInputTextGestureActionClear forKey:CSInputTextGestureLeftActionKey];
    Pump();
    Check(fixtureDefaults.writes == writes && notifications == 1, @"unchanged settings avoid duplicate writes and refreshes");
    [InputGesturePreferences setEnabled:NO];
    Check([InputGesturePreferences actionForKey:CSInputTextGestureLeftActionKey] == CSInputTextGestureActionClear &&
          [InputGesturePreferences actionForKey:CSInputTextGestureRightActionKey] == CSInputTextGestureActionPaste,
          @"turning off the gesture preserves both saved actions");
    for (NSInteger raw = CSInputTextGestureActionDisabled; raw <= CSInputTextGestureActionSend; raw++) {
        [InputGesturePreferences setAction:(CSInputTextGestureAction)raw forKey:CSInputTextGestureLeftActionKey];
        Check([InputGesturePreferences actionForKey:CSInputTextGestureLeftActionKey] == raw, @"all persisted action values round-trip");
        Check([InputGesturePreferences titleForAction:(CSInputTextGestureAction)raw].length > 0, @"every action has a visible settings title");
    }
    for (id invalid in @[@(-1), @6, @1.5, @(NAN), @(INFINITY), @"2", @[], @{}, NSNull.null]) {
        fixtureDefaults.values[CSInputTextGestureLeftActionKey] = invalid;
        Check([InputGesturePreferences actionForKey:CSInputTextGestureLeftActionKey] == CSInputTextGestureActionDisabled,
              @"invalid stored action values cannot activate an operation");
    }
    [InputGesturePreferences setAction:(CSInputTextGestureAction)999 forKey:CSInputTextGestureLeftActionKey];
    Check([InputGesturePreferences actionForKey:CSInputTextGestureLeftActionKey] == CSInputTextGestureActionDisabled,
          @"invalid action writes normalize to disabled");
    writes = fixtureDefaults.writes;
    [InputGesturePreferences setAction:CSInputTextGestureActionSend forKey:@"host.unrelated"];
    Check(fixtureDefaults.writes == writes && [InputGesturePreferences actionForKey:@"host.unrelated"] == CSInputTextGestureActionDisabled,
          @"the preferences API rejects unrelated keys");
    Pump();
    [NSNotificationCenter.defaultCenter removeObserver:observer];
}

static void TestEditing(void) {
    GestureEditor *editor = [GestureEditor new]; GestureTool *tool = [GestureTool new];
    NSString *original = editor.text, *clipboard = editor.clipboard;
    NSRange selection = editor.selectedRange;
    id nativeSelection = editor.selectedTextRange;
    Check(CSInputTextGesturePerformAction(CSInputTextGestureActionCopy, editor, tool), @"copy reports native submission");
    Check(editor.copies == 1 && [editor.clipboard isEqual:original] && [editor.text isEqual:original],
          @"copy exports the complete draft through the native copy action");
    Check(NSEqualRanges(editor.actionRange, NSMakeRange(0, original.length)) && NSEqualRanges(editor.selectedRange, selection),
          @"copy selects the native document and restores the user's original selection");
    Check(editor.selectedTextRange == nativeSelection, @"copy restores the original native selection object");

    editor = [GestureEditor new]; tool = [GestureTool new];
    Check(CSInputTextGesturePerformAction(CSInputTextGestureActionCut, editor, tool), @"cut reports native submission");
    Check(editor.cuts == 1 && editor.text.length == 0 && [editor.clipboard isEqual:original],
          @"cut moves the complete draft to the clipboard once using native cut");
    Check(NSEqualRanges(editor.actionRange, NSMakeRange(0, original.length)), @"cut includes text outside the previous selection");

    for (NSNumber *raw in @[@1, @2, @3]) {
        editor = [GestureEditor new]; tool = [GestureTool new];
        editor.text = @"[微笑][呲牙]"; editor.documentText = @"🙂😄";
        editor.selectedRange = NSMakeRange(2, 2); nativeSelection = editor.selectedTextRange;
        Check(editor.text.length != editor.documentText.length, @"emoji fixture has different encoded and native document lengths");
        Check(CSInputTextGesturePerformAction((CSInputTextGestureAction)raw.integerValue, editor, tool),
              @"encoded emoji drafts use native document positions for editing");
        Check(NSEqualRanges(editor.actionRange, NSMakeRange(0, 4)), @"whole-draft editing selects the actual native emoji document length");
        if (raw.integerValue == CSInputTextGestureActionCopy) {
            Check([editor.clipboard isEqual:@"🙂😄"] && editor.selectedTextRange == nativeSelection && [editor.text isEqual:@"[微笑][呲牙]"],
                  @"native copy preserves its encoded draft and restores its native selection");
        } else Check(editor.text.length == 0 && editor.documentText.length == 0, @"native clear and cut remove the full emoji document");
    }

    editor = [GestureEditor new]; tool = [GestureTool new];
    Check(CSInputTextGesturePerformAction(CSInputTextGestureActionClear, editor, tool), @"clear reports native submission");
    Check(editor.deletes == 1 && editor.text.length == 0 && [editor.clipboard isEqual:clipboard],
          @"clear deletes the complete draft through native editing and preserves the clipboard");

    editor = [GestureEditor new]; tool = [GestureTool new]; editor.clipboard = @"插入\n内容";
    NSString *pasted = [original stringByReplacingCharactersInRange:selection withString:editor.clipboard];
    Check(CSInputTextGesturePerformAction(CSInputTextGestureActionPaste, editor, tool), @"paste reports native submission");
    Check(editor.pastes == 1 && [editor.text isEqual:pasted] && NSEqualRanges(editor.actionRange, selection),
          @"paste respects the current selection and the native insertion path");

    editor = [GestureEditor new]; tool = [GestureTool new];
    Check(CSInputTextGesturePerformAction(CSInputTextGestureActionSend, editor, tool), @"send reports native submission without claiming delivery");
    Check(tool.sends == 1 && ActionCount(editor, tool) == 1 && [editor.text isEqual:original] && NSEqualRanges(editor.selectedRange, selection),
          @"send submits the current native tool once without rewriting or clearing the draft");

    for (NSNumber *raw in @[@0, @(-1), @6, @(NSIntegerMax)]) {
        editor = [GestureEditor new]; tool = [GestureTool new];
        Check(!CSInputTextGesturePerformAction((CSInputTextGestureAction)raw.integerValue, editor, tool), @"disabled and invalid actions report no submission");
        Check(ActionCount(editor, tool) == 0 && editor.queries == 0 && [editor.text isEqual:original] &&
              NSEqualRanges(editor.selectedRange, selection) && [editor.clipboard isEqual:clipboard],
              @"disabled and invalid actions do not query or mutate native editing");
    }
    for (NSInteger action = CSInputTextGestureActionClear; action <= CSInputTextGestureActionSend; action++) {
        editor = [GestureEditor new]; tool = [GestureTool new]; editor.markedTextRange = [NSObject new];
        CSInputTextGesturePerformAction((CSInputTextGestureAction)action, editor, tool);
        Check(ActionCount(editor, tool) == 0 && [editor.text isEqual:original] && NSEqualRanges(editor.selectedRange, selection),
              @"active input-method composition blocks all gesture operations");
    }
    for (NSNumber *raw in @[@1, @2, @3, @5]) {
        editor = [GestureEditor new]; tool = [GestureTool new]; editor.text = @""; editor.selectedRange = NSMakeRange(0, 0);
        CSInputTextGesturePerformAction((CSInputTextGestureAction)raw.integerValue, editor, tool);
        Check(ActionCount(editor, tool) == 0 && [editor.clipboard isEqual:clipboard],
              @"empty drafts do not clear, copy, cut, or send placeholder text");
    }
    editor = [GestureEditor new]; tool = [GestureTool new]; editor.text = @""; editor.selectedRange = NSMakeRange(0, 0);
    CSInputTextGesturePerformAction(CSInputTextGestureActionPaste, editor, tool);
    Check(editor.pastes == 1 && [editor.text isEqual:clipboard], @"paste can populate an empty draft");

    editor = [GestureEditor new]; tool = [GestureTool new]; editor.clipboard = @"";
    CSInputTextGesturePerformAction(CSInputTextGestureActionPaste, editor, tool);
    Check(editor.pastes == 0 && [editor.text isEqual:original] && NSEqualRanges(editor.selectedRange, selection),
          @"an unavailable native paste action preserves the draft and selection");
    for (NSInteger action = CSInputTextGestureActionCopy; action <= CSInputTextGestureActionPaste; action++) {
        editor = [GestureEditor new]; tool = [GestureTool new]; editor.nativeAllowed = NO;
        CSInputTextGesturePerformAction((CSInputTextGestureAction)action, editor, tool);
        Check(ActionCount(editor, tool) == 0 && [editor.text isEqual:original] &&
              [editor.clipboard isEqual:clipboard] && NSEqualRanges(editor.selectedRange, selection),
              @"native capability rejection preserves text, clipboard, and the user's selection");
    }
    for (NSNumber *raw in @[@1, @3]) {
        editor = [GestureEditor new]; tool = [GestureTool new]; editor.rejectMutation = YES;
        nativeSelection = editor.selectedTextRange;
        CSInputTextGesturePerformAction((CSInputTextGestureAction)raw.integerValue, editor, tool);
        Check(ActionCount(editor, tool) == 1 && [editor.text isEqual:original] && editor.selectedTextRange == nativeSelection,
              @"a native mutation that leaves the original text untouched restores the original selection");
    }
    editor = [GestureEditor new]; tool = [GestureTool new]; editor.documentUnavailable = YES;
    Check(!CSInputTextGesturePerformAction(CSInputTextGestureActionClear, editor, tool) && ActionCount(editor, tool) == 0 &&
          [editor.text isEqual:original] && NSEqualRanges(editor.selectedRange, selection),
          @"missing native document positions preserve the draft and selection");
    for (NSInteger action = CSInputTextGestureActionClear; action <= CSInputTextGestureActionSend; action++) {
        editor = [GestureEditor new]; tool = [GestureTool new];
        dispatch_semaphore_t done = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            CSInputTextGesturePerformAction((CSInputTextGestureAction)action, editor, tool);
            dispatch_semaphore_signal(done);
        });
        Check(dispatch_semaphore_wait(done, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2)) == 0,
              @"background rejection completes without queueing an edit to the main thread");
        Check(ActionCount(editor, tool) == 0 && editor.queries == 0 && [editor.text isEqual:original],
              @"background calls cannot operate the native editor or submit messages");
    }
}

int main(void) { @autoreleasepool {
    TestPreferences(); TestEditing();
    printf("Input text gesture preferences and native editing: %lu checks, %lu failures; memory-only host doubles\n",
           (unsigned long)checks, (unsigned long)failures);
    return failures ? 1 : 0;
} }
