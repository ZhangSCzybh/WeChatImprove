#pragma once
#import <UIKit/UIKit.h>

static inline UIColor *CSMomentsPageFill(void) { return UIColor.systemGroupedBackgroundColor; }

static inline void CSMomentsStyleCard(UICollectionViewCell *cell) {
    CALayer *surface = cell.contentView.layer;
    CALayer *outer = cell.layer;
    BOOL dark = cell.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    cell.clipsToBounds = NO;
    outer.shouldRasterize = NO;
    outer.shadowColor = UIColor.blackColor.CGColor;
    outer.shadowOpacity = dark ? 0 : 0.09;
    outer.shadowRadius = 3;
    outer.shadowOffset = CGSizeMake(0, 1);
    CGFloat scale = cell.traitCollection.displayScale;
    surface.borderWidth = dark ? 1.0 / MAX(1.0, scale) : 0;
    surface.borderColor = dark ? [UIColor.separatorColor resolvedColorWithTraitCollection:cell.traitCollection].CGColor : NULL;
}

static inline void CSMomentsLayoutCardShadow(UICollectionViewCell *cell) {
    if (cell.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) return;
    CGRect bounds = [cell.contentView convertRect:cell.contentView.bounds toView:cell];
    if (!CGRectIsEmpty(bounds) && (!cell.layer.shadowPath || !CGRectEqualToRect(CGPathGetPathBoundingBox(cell.layer.shadowPath), bounds))) {
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    }
}
