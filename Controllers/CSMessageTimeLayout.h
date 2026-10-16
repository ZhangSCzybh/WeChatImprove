#import <UIKit/UIKit.h>

FOUNDATION_EXPORT BOOL CSMessageTimeCanToggle(BOOL enabled, BOOL tapToShow, NSString *text);
FOUNDATION_EXPORT void CSMessageTimePositionLabel(UIView *label, UIView *container, UIView *head, UIView *content,
                                                BOOL sender, BOOL belowAvatar);

FOUNDATION_EXPORT BOOL CSMessageTimeReadTimestamp(id model, unsigned int *timestamp);
FOUNDATION_EXPORT NSString *CSMessageTimeText(unsigned int timestamp, NSUserDefaults *defaults);

FOUNDATION_EXPORT BOOL CSMessageTimeReadSender(id model, BOOL *sender);
FOUNDATION_EXPORT BOOL CSMessageTimeShowsModel(id model, BOOL belowAvatar);
FOUNDATION_EXPORT UIView *CSMessageTimeAnchor(id cell);
