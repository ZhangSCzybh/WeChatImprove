#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "CSCloseFriendContactProjection.h"
#import "CSCloseFriendSignatures.h"

static NSUInteger checks,epoch=1;
static CSCloseFriendSnapshot *current;
static char SelectionKey;
#define CHECK(value) do { checks++; if (!(value)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#value); exit(1); } } while (0)
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) { return current; }
static NSUInteger CSCloseFriendAccountEpoch(void) { return epoch; }
static void CSCFTrackSurface(id owner,NSString *selector) { (void)owner; (void)selector; }
#import "ForwardSelectionProductionBodies.h"

@interface Contact : NSObject { @public NSString *m_nsUsrName; }
@end
@implementation Contact
@end
static Contact *Person(NSString *name) { Contact *contact=[Contact new]; contact->m_nsUsrName=name; return contact; }
// Native 8.0.80 uses an ordered dictionary here, not m_selectedContacts, until endMultiSelect:.
@interface OrderedSelection : NSObject
@property(nonatomic, strong) NSMutableArray *values;
@property(nonatomic) NSUInteger reads;
- (id)allValuesInOrder;
@end
@implementation OrderedSelection
- (id)allValuesInOrder { _reads++; return _values; }
@end
// Actual 8.0.80 OrderedDictionary inherits NSMutableDictionary. Its method name
// must remain an Objective-C selector even when an identical dictionary key exists.
@interface OrderedDictionary : NSMutableDictionary
@property(nonatomic, strong) NSMutableDictionary *storage;
@property(nonatomic, strong) NSMutableArray *values;
- (id)allValuesInOrder;
@end
@implementation OrderedDictionary
- (instancetype)init { if ((self=[super init])) _storage=[NSMutableDictionary dictionary]; return self; }
- (NSUInteger)count { return _storage.count; }
- (NSEnumerator *)keyEnumerator { return _storage.keyEnumerator; }
- (id)objectForKey:(id)key { return _storage[key]; }
- (void)setObject:(id)object forKey:(id<NSCopying>)key { [_storage setObject:object forKey:key]; }
- (void)removeObjectForKey:(id)key { [_storage removeObjectForKey:key]; }
- (id)allValuesInOrder { return _values; }
@end
@interface WrongSelection : NSObject
- (unsigned int)allValuesInOrder;
@end
@implementation WrongSelection
- (unsigned int)allValuesInOrder { CHECK(NO); return 1; }
@end
@interface SessionSelectView : NSObject { @public OrderedSelection *m_dicMultiSelect; }
@end
@implementation SessionSelectView
@end
@interface SessionSelectController : NSObject {
@public
    NSMutableArray *m_selectedContacts;
    SessionSelectView *m_selectView;
}
@property(nonatomic) NSUInteger nativeDoneCalls,nativePageDoneCalls,callbackCalls,cancelCalls;
@property(nonatomic, copy) NSArray *callbackRecipients;
- (void)onMultiDone;
- (void)onMultiDoneInPageSheetMode;
- (void)cancelMultiSelect;
@end
@implementation SessionSelectController
- (void)endMultiSelect {
    // Reflect the verified native order: this field is populated inside the original completion.
    m_selectedContacts=[[m_selectView->m_dicMultiSelect allValuesInOrder] mutableCopy];
}
- (void)performCallback { _callbackCalls++; _callbackRecipients=[m_selectedContacts copy]; }
- (void)onMultiDone { _nativeDoneCalls++; [self endMultiSelect]; [self performCallback]; }
- (void)onMultiDoneInPageSheetMode { _nativePageDoneCalls++; [self endMultiSelect]; [self performCallback]; }
- (void)cancelMultiSelect { _cancelCalls++; }
@end
static NSMutableDictionary<NSString *,id> *hookBodies;
static void Hook0(NSString *className,NSString *selector,void (^body)(id,void(^)(void))) {
    CHECK([className isEqual:@"SessionSelectController"]); hookBodies[selector]=[body copy];
}
#import "ForwardSelectionHooksUnderTest.h"

static CSCloseFriendSnapshot *Policy(BOOL enabled,BOOL revealed,NSUInteger revision,NSString *account) {
    return [[CSCloseFriendSnapshot alloc] initWithAccountID:account profile:@{@"enabled":@(enabled),@"friends":@[@"secret"],@"groups":@[],@"options":CSCloseFriendDefaultOptions()} revealed:revealed revision:revision blocked:NO];
}
static SessionSelectController *Picker(NSArray *contacts,NSArray *staleContacts) {
    SessionSelectController *picker=[SessionSelectController new]; picker->m_selectView=[SessionSelectView new];
    picker->m_selectView->m_dicMultiSelect=[OrderedSelection new];
    picker->m_selectView->m_dicMultiSelect.values=[contacts mutableCopy]; picker->m_selectedContacts=[staleContacts mutableCopy];
    return picker;
}
static void Complete(SessionSelectController *picker,NSString *selector) {
    void (^body)(id,void(^)(void))=hookBodies[selector]; CHECK(body!=nil);
    body(picker,^{ ((void(*)(id,SEL))objc_msgSend)(picker,NSSelectorFromString(selector)); });
}
static NSUInteger NativeCalls(SessionSelectController *picker) { return picker.nativeDoneCalls+picker.nativePageDoneCalls; }

static void TestTypedReadAndCurrentRecipients(void) {
    Contact *visible=Person(@"ordinary"),*hidden=Person(@"secret");
    SessionSelectController *picker=Picker(@[visible,hidden],nil); OrderedSelection *selection=picker->m_selectView->m_dicMultiSelect;
    CHECK(![picker respondsToSelector:NSSelectorFromString(@"m_selectedContacts")]);
    CHECK(![picker respondsToSelector:NSSelectorFromString(@"m_selectView")]);
    CHECK(![picker->m_selectView respondsToSelector:NSSelectorFromString(@"m_dicMultiSelect")]);
    CHECK(CSCloseFriendRead(picker,@"m_selectedContacts")==nil);
    CHECK(CSCloseFriendRead(picker,@"m_selectView")==picker->m_selectView);
    CHECK(CSCloseFriendRead(picker->m_selectView,@"m_dicMultiSelect")==selection);
    CHECK([CSCloseFriendUserName(hidden) isEqual:@"secret"]);
    NSArray *recipients=CSCFCurrentForwardRecipients(picker);
    CHECK(([recipients isEqual:@[visible,hidden]])); CHECK(recipients!=selection.values);
    CHECK(picker->m_selectedContacts==nil && NativeCalls(picker)==0 && selection.values.count==2);
    picker->m_selectedContacts=[@[hidden] mutableCopy]; NSMutableArray *stale=picker->m_selectedContacts;
    CHECK(([CSCFCurrentForwardRecipients(picker) isEqual:@[visible,hidden]]));
    CHECK(picker->m_selectedContacts==stale && [stale isEqual:@[hidden]]);
    CHECK(!CSCFCurrentForwardRecipients([NSObject new]));
    picker->m_selectView->m_dicMultiSelect=(id)[WrongSelection new]; CHECK(!CSCFCurrentForwardRecipients(picker));
    picker->m_selectView=nil; CHECK(!CSCFCurrentForwardRecipients(picker));
}

static void TestEnabledAndDisabledCompletion(NSString *selector) {
    Contact *visible=Person(@"ordinary"),*hidden=Person(@"secret");
    for (NSUInteger mode=0;mode<3;mode++) {
        current=Policy(mode!=0,mode==1,10+mode,@"account");
        // A stale previous selection deliberately differs from the current selection.
        NSArray *contacts=mode==2 ? @[visible] : @[hidden,visible];
        SessionSelectController *picker=Picker(contacts,mode==0 ? nil : @[hidden]);
        OrderedSelection *selection=picker->m_selectView->m_dicMultiSelect; NSMutableArray *source=selection.values;
        NSArray *before=[source copy]; Complete(picker,selector);
        CHECK(NativeCalls(picker)==1 && picker.callbackCalls==1 && picker.cancelCalls==0);
        CHECK([picker.callbackRecipients isEqual:contacts] && [picker->m_selectedContacts isEqual:contacts]);
        CHECK(selection.values==source && [source isEqual:before]);
        CHECK([selector isEqual:@"onMultiDone"] ? picker.nativeDoneCalls==1 && picker.nativePageDoneCalls==0 : picker.nativeDoneCalls==0 && picker.nativePageDoneCalls==1);
    }
}

static void TestHiddenAndStaleTickets(NSString *selector) {
    Contact *visible=Person(@"ordinary"),*hidden=Person(@"secret");
    current=Policy(YES,NO,20,@"account");
    SessionSelectController *concealed=Picker(@[visible,hidden],@[visible]);
    NSMutableArray *old=concealed->m_selectedContacts,*source=concealed->m_selectView->m_dicMultiSelect.values;
    Complete(concealed,selector);
    CHECK(NativeCalls(concealed)==0 && concealed.callbackCalls==0 && concealed.cancelCalls==1);
    CHECK(concealed->m_selectedContacts==old && [old isEqual:@[visible]]);
    CHECK((concealed->m_selectView->m_dicMultiSelect.values==source && [source isEqual:@[visible,hidden]]));
    for (NSUInteger mode=0;mode<3;mode++) {
        current=Policy(YES,YES,30,@"account"); SessionSelectController *stale=Picker(@[visible],nil); CSCFBeginSelection(stale);
        if (mode==0) current=Policy(YES,NO,31,@"account");
        else if (mode==1) current=Policy(YES,YES,30,@"different-account");
        else epoch++;
        Complete(stale,selector);
        CHECK(NativeCalls(stale)==0 && stale.callbackCalls==0 && stale.cancelCalls==1 && stale->m_selectedContacts==nil);
        CHECK([stale->m_selectView->m_dicMultiSelect.values isEqual:@[visible]]);
    }
}

static void TestDictionarySubclassSelectorBoundary(void) {
    Contact *visible=Person(@"ordinary"),*hidden=Person(@"secret");
    current=Policy(NO,NO,50,@"account"); SessionSelectController *picker=Picker(@[],nil);
    OrderedDictionary *selection=[OrderedDictionary new]; selection.values=[@[visible,hidden] mutableCopy];
    NSArray *decoy=@[@"dictionary-key-is-not-the-selection"];
    selection[@"allValuesInOrder"]=decoy; picker->m_selectView->m_dicMultiSelect=(id)selection;
    CHECK([selection isKindOfClass:NSMutableDictionary.class]);
    CHECK(CSCloseFriendRead(selection,@"allValuesInOrder")==decoy);
    CHECK(([CSCFCurrentForwardRecipients(picker) isEqual:@[visible,hidden]]));
    Complete(picker,@"onMultiDone");
    CHECK(NativeCalls(picker)==1 && picker.callbackCalls==1 && picker.cancelCalls==0);
    CHECK(([picker.callbackRecipients isEqual:@[visible,hidden]]));
    CHECK(selection[@"allValuesInOrder"]==decoy && selection.values.count==2);
}

int main(void) { @autoreleasepool {
    CHECK(NSThread.isMainThread); hookBodies=[NSMutableDictionary dictionary]; InstallForwardSelectionBoundaryHooks(); CHECK(hookBodies.count==2);
    TestTypedReadAndCurrentRecipients();
    for (NSString *selector in @[@"onMultiDone",@"onMultiDoneInPageSheetMode"]) {
        TestEnabledAndDisabledCompletion(selector); TestHiddenAndStaleTickets(selector);
    }
    TestDictionarySubclassSelectorBoundary();
    fprintf(stdout,"Forward selection boundary passed (%lu checks)\n",(unsigned long)checks);
} return 0; }
