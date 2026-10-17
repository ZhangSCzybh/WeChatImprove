#import "CSMessageGestureAdapter.h"
#import "CSMessageMergeAdapter.h"
#import "CSMessageCellLifecycle.h"
@interface NSObject (TimeLifecycleTest)
- (void)cs_messageTimeLayout;
@end
CSMessageGestureAdapter *CSMessageGestureAdapterForCell(id cell, BOOL create) { return nil; }
void CSMessageMergeRestore(id cell) {}
void CSMessageMergeReuse(id cell) {}
void CSMessageMergeRender(id cell) { [cell cs_messageTimeLayout]; }
id CSMessageActionObjectGetter(id object, SEL selector) {
    return CSMessageNativeObject(object,NSStringFromSelector(selector));
}
