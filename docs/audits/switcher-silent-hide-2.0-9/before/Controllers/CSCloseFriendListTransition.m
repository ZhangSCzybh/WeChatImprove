#import "CSCloseFriendListTransition.h"
#import <QuartzCore/QuartzCore.h>

@interface CSCloseFriendTransitionRow : UILabel
@property(nonatomic,weak) UITableViewCell *cell;
@property(nonatomic,strong) id originalAccessibilityElements;
@property(nonatomic) BOOL originalAccessibilityElement, originalInteraction;
@end
@implementation CSCloseFriendTransitionRow @end

@interface CSCloseFriendListTransition ()
@property(nonatomic,strong) NSMutableArray<CSCloseFriendTransitionRow *> *shields;
@property(nonatomic) BOOL animationPending;
@end
@implementation CSCloseFriendListTransition
- (void)shieldCell:(UITableViewCell *)cell {
    if (!cell || cell.hidden) return;
    for (CSCloseFriendTransitionRow *shield in self.shields) if (shield.cell==cell) {
        [cell bringSubviewToFront:shield]; return;
    }
    CSCloseFriendTransitionRow *shield=[[CSCloseFriendTransitionRow alloc] initWithFrame:cell.bounds];
    shield.cell=cell; shield.backgroundColor=UIColor.systemBackgroundColor;
    shield.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    shield.text=@"密友已隐藏"; shield.textAlignment=NSTextAlignmentCenter;
    shield.textColor=UIColor.secondaryLabelColor; shield.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    shield.isAccessibilityElement=YES;
    shield.originalAccessibilityElement=cell.isAccessibilityElement;
    shield.originalAccessibilityElements=cell.accessibilityElements;
    shield.originalInteraction=cell.userInteractionEnabled;
    cell.isAccessibilityElement=NO; cell.accessibilityElements=@[shield]; cell.userInteractionEnabled=NO;
    [cell addSubview:shield];
    if (!self.shields) self.shields=[NSMutableArray new];
    [self.shields addObject:shield];
}
- (void)stopAnimationOnTable:(UITableView *)table {
    [table.layer removeAnimationForKey:@"CSCloseFriendHideShake"];
    [table.layer removeAnimationForKey:@"CSCloseFriendHideSettle"];
}
- (void)prepareForPublication {
    self.animationPending|=self.shields.count>0;
    // Restore ownership before native reload reuses/configures cells. Clearing
    // after reload could overwrite a new cell's accessibility or interaction.
    for (CSCloseFriendTransitionRow *shield in self.shields) {
        UITableViewCell *cell=shield.cell;
        cell.isAccessibilityElement=shield.originalAccessibilityElement;
        cell.accessibilityElements=shield.originalAccessibilityElements;
        cell.userInteractionEnabled=shield.originalInteraction;
        [shield removeFromSuperview];
    }
    [self.shields removeAllObjects];
}
- (void)finishOnTable:(UITableView *)table animated:(BOOL)animated {
    [self prepareForPublication];
    BOOL hadShields=self.animationPending; self.animationPending=NO;
    if (!hadShields) { if (!animated) [self stopAnimationOnTable:table]; return; }
    [self stopAnimationOnTable:table];
    if (!hadShields || !animated || table.hidden || !table.window || UIAccessibilityIsReduceMotionEnabled() ||
        UIApplication.sharedApplication.applicationState==UIApplicationStateBackground) return;
    // The underlying list is already filtered. These animations have no completion
    // dependency: suspension cannot retain a cover or leave a transformed table.
    CAKeyframeAnimation *shake=[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.values=@[@0,@(-5),@4,@(-2),@0]; shake.duration=0.24; shake.additive=YES;
    [table.layer addAnimation:shake forKey:@"CSCloseFriendHideShake"];
    CAKeyframeAnimation *settle=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    CGFloat scale=[[table.layer valueForKeyPath:@"transform.scale"] doubleValue];
    settle.values=@[@(scale),@(scale*0.985),@(scale)]; settle.duration=0.24;
    [table.layer addAnimation:settle forKey:@"CSCloseFriendHideSettle"];
}
@end
