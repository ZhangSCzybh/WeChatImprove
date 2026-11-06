#import <Foundation/Foundation.h>
// Exactly one outermost scheduler owns each subclass/super lifecycle chain.
FOUNDATION_EXPORT void CSMessageCellPerformLayout(id cell, void (^native)(void));
FOUNDATION_EXPORT void CSMessageCellPerformBinding(id cell, id model, void (^native)(void));
FOUNDATION_EXPORT void CSMessageCellPerformReuse(id cell, void (^native)(void));
FOUNDATION_EXPORT void CSMessageCellRefresh(id cell);
FOUNDATION_EXPORT void CSMessageCellWindowChanged(id cell);
// Implemented by MessageTimeHooks; private label/settings state stays in that translation unit.
FOUNDATION_EXPORT void CSMessageTimePrepareCell(id cell);
FOUNDATION_EXPORT void CSMessageTimeResetCell(id cell);
