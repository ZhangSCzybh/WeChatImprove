#import <Foundation/Foundation.h>

/// Hints never authorize stale coordinates: publication still compares verified rows.
typedef NS_OPTIONS(NSUInteger, CSGroupChangeKind) {
    CSGroupChangeUnread = 1 << 0,
    CSGroupChangeContent = 1 << 1,
    CSGroupChangeStructure = 1 << 2,
    CSGroupChangeUnknown = 1 << 3
};
