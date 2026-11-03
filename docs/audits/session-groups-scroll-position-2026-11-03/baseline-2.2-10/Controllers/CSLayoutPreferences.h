#import <Foundation/Foundation.h>
typedef struct { double chatFontSize, globalScale; } CSLayoutValues;
// UIFont getters can run on workers. Reads perform one atomic load, without Defaults access.
FOUNDATION_EXPORT CSLayoutValues CSLayoutPreferencesRead(void);
FOUNDATION_EXPORT void CSLayoutPreferencesInstall(NSUserDefaults *defaults);
FOUNDATION_EXPORT void CSLayoutPreferencesReload(void);
