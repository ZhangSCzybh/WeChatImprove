#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
BOOL CSVoicePlaybackTestClaimsTouch=NO;
void CSVoicePlaybackRefreshCell(__unused id cell) {}
void CSVoicePlaybackDetachCell(__unused id cell) {}
BOOL CSVoicePlaybackOwnsTouch(__unused id cell, __unused CGPoint pointInCell) {
    return CSVoicePlaybackTestClaimsTouch;
}
