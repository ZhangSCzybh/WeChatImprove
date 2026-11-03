#import <UIKit/UIKit.h>

// Register a real MMUIViewController subclass at runtime, without linking private symbols.
FOUNDATION_EXPORT Class CSNativeSettingsControllerClass(void);
FOUNDATION_EXPORT UIViewController *CSNativeSettingsHostForContent(UIViewController *content);
