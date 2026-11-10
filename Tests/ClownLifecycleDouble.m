#import "CSClownPresentation.h"

// Legacy gesture/time regressions exercise their own renderers with the local overlay inactive.
void CSClownRestoreCell(__unused id cell) {}
void CSClownRenderCell(__unused id cell) {}
void CSClownReuseCell(__unused id cell) {}
