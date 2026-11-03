#import "CSBackupSettingsCell.h"

@interface CSBackupSettingsCell ()
@property(nonatomic) BOOL showsSettingSwitch;
@end

@implementation CSBackupSettingsCell
+ (NSString *)reuseIdentifier { return @"CSBackupSettingsCell"; }

- (void)configureWithItem:(CSSettingItem *)item {
    [super configureWithItem:item];
    self.showsSettingSwitch = item.itemType == CSSettingItemTypeSwitch;
    self.textLabel.numberOfLines = 1;
    self.detailTextLabel.numberOfLines = 1;
    self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // Preserve the common cell's 54pt text origin, 15pt trailing inset and 8pt gap.
    // Recalculate both widths on every layout so reused cells can grow again.
    CGFloat leading = 54.0, trailing = 15.0, gap = 8.0;
    CGFloat available = MAX(0, CGRectGetWidth(self.contentView.bounds) - leading - trailing);
    CGFloat titleWidth = available;
    if (self.showsSettingSwitch) {
        for (UIView *view in self.contentView.subviews) {
            if ([view isKindOfClass:UISwitch.class]) {
                titleWidth = MAX(0, available - view.intrinsicContentSize.width - gap);
                break;
            }
        }
    } else if (self.detailTextLabel.text.length) {
        CGFloat desired = [self.detailTextLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        CGFloat titleDesired = [self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        CGFloat reservedTitle = MIN(titleDesired, MAX(0, (available - gap) * 0.5));
        CGFloat detailWidth = MIN(desired, MAX(0, available - reservedTitle - gap));
        CGRect detailFrame = self.detailTextLabel.frame;
        detailFrame.origin.x = leading + available - detailWidth;
        detailFrame.size.width = detailWidth;
        self.detailTextLabel.frame = detailFrame;
        titleWidth = MAX(0, available - detailWidth - gap);
    }
    CGRect titleFrame = self.textLabel.frame;
    titleFrame.origin.x = leading;
    titleFrame.size.width = titleWidth;
    self.textLabel.frame = titleFrame;
}
@end
