#import <UIKit/UIKit.h>
@class CSBubbleStyleConfiguration;

// Settings-only preview, rendered by the same template policy as chat bubbles.
@interface CSBubbleStylePreview : UIView
@property(nonatomic, strong) CSBubbleStyleConfiguration *configuration;
@property(nonatomic) BOOL mergesMessages;
@property(nonatomic, strong) UIColor *draftColor;
@property(nonatomic) NSInteger draftPalette;
@property(nonatomic) BOOL draftIsText;
- (void)refresh;
@end
