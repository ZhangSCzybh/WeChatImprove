#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

// Main-thread boundaries owned by the existing message-cell lifecycle scheduler.
FOUNDATION_EXPORT void CSVoicePlaybackRefreshCell(id cell);
FOUNDATION_EXPORT void CSVoicePlaybackDetachCell(id cell);
// Point is in cell coordinates. Admission only; never starts or seeks audio.
FOUNDATION_EXPORT BOOL CSVoicePlaybackOwnsTouch(id cell, CGPoint pointInCell);
