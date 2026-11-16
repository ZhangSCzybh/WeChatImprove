#import <UIKit/UIKit.h>
#import "CSSettingTableViewCell.h"
#include "SettingCellUnderTest.h"
#include <math.h>
#include <stdio.h>

// Only the manager's read-only presentation inputs are modeled here. Execute the
// real summary/date methods without timers, audio, settings, or account state.
@interface CSBackgroundRunManager : NSObject
@property(nonatomic,strong) NSDate *lastBackgroundStartedAt,*firstScheduledCheckAt,*lastPeriodicCheckAt,*lastTaskExpiredAt,*lastBackgroundStoppedAt,*lastForegroundReturnedAt,*lastBackgroundCheckedAt;
@property(nonatomic,copy) NSString *lastBackgroundResult,*lastBackgroundStopReason,*lastBackgroundCheckStatus;
@property(nonatomic) BOOL lastBackgroundStartObserved;
@property(nonatomic) NSUInteger periodicCheckCount;
@property(nonatomic) NSTimeInterval lastCheckToForegroundInterval;
@end
@implementation CSBackgroundRunManager @end
@interface CSBackgroundRunViewController : NSObject
@property(nonatomic,strong) NSDateFormatter *fullRecordDateFormatter,*recordDateFormatter;
@end
@implementation CSBackgroundRunViewController
#include "BackgroundRecordSummaryUnderTest.h"
@end

static NSUInteger Checks,Failures;
static void Check(BOOL condition,NSString *message) {
    Checks++;
    if(!condition) {Failures++;fprintf(stderr,"FAIL: %s\n",message.UTF8String);}
}
static BOOL Near(CGFloat a,CGFloat b) {return fabs(a-b)<.001;}
static CSSettingTableViewCell *Cell(void) {return [[CSSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];}
static NSArray<UISwitch *> *Switches(CSSettingTableViewCell *cell) {
    return [cell.contentView.subviews filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id view,NSDictionary *bindings){return [view isKindOfClass:UISwitch.class];}]];
}
static UIImageView *ImageFor(CSSettingTableViewCell *cell,UIImage *image) {
    for(UIView *view in cell.contentView.subviews) if([view isKindOfClass:UIImageView.class] && [(UIImageView *)view image]==image)return (id)view;
    return nil;
}
static UIImageView *SymbolFor(CSSettingTableViewCell *cell,NSString *name) {
    for(UIView *view in cell.contentView.subviews) if([view isKindOfClass:UIImageView.class] && [[(UIImageView *)view image].symbolName isEqual:name])return (id)view;
    return nil;
}
static CSSettingItem *Normal(NSString *symbol,NSString *detail) {return [CSSettingItem itemWithTitle:@"设置项目" iconName:symbol iconColor:UIColor.systemBlueColor detail:detail];}
static CSSettingItem *Typed(CSSettingItemType type) {CSSettingItem *item=Normal(@"gearshape",@"当前值");[item setValue:@(type) forKey:@"itemType"];return item;}
static void AssertIconGeometry(CSSettingTableViewCell *cell,UIImageView *icon,CGFloat height) {
    cell.frame=CGRectMake(0,0,390,height);
    NSUInteger nativeBefore=cell.nativeImageLayouts;
    [cell layoutSubviews];
    Check(cell.nativeImageLayouts==nativeBefore+1,@"production layout calls native superclass layout");
    Check(icon && icon!=cell.imageView,@"visible setting icon is independent of UIKit-managed imageView");
    Check(icon && !icon.hidden && !icon.isAccessibilityElement,@"configured icon is visible without becoming a duplicate accessibility element");
    Check(icon.superview==cell.contentView,@"setting icon remains inside contentView");
    Check(Near(icon.frame.origin.x,15) && Near(icon.frame.size.width,29) && Near(icon.frame.size.height,29),@"setting icon keeps leading inset and 29-point square through native layout");
    Check(Near(CGRectGetMidY(icon.frame),height/2),[NSString stringWithFormat:@"setting icon remains centered in %.0f-point row",height]);
    Check(Near(cell.textLabel.frame.origin.x,54),@"title keeps established 54-point leading inset");
}
static void TestNativeLayoutAndHeights(void) {
    CSSettingTableViewCell *cell=Cell();
    [cell configureWithItem:Normal(@"person.crop.circle",@"已登录")];
    UIImageView *icon=SymbolFor(cell,@"person.crop.circle");
    for(NSNumber *height in @[@44,@56,@72,@88,@112,@44])AssertIconGeometry(cell,icon,height.doubleValue);
    Check(cell.imageView.image==nil,@"UIKit image slot remains unused by setting icons");
    Check(cell.imageView.translatesAutoresizingMaskIntoConstraints,@"UIKit keeps autoresizing ownership of its native image view");
    for(NSLayoutConstraint *constraint in cell.imageView.constraints)Check(!constraint.active,@"setting cell does not install active icon constraints on UIKit-owned imageView");
}
static void TestImageTransitionsAndReuse(void) {
    CSSettingTableViewCell *cell=Cell();UIImage *custom=[UIImage new];custom.size=CGSizeMake(96,40);
    CSSettingItem *customItem=Normal(@"star",nil);customItem.customImage=custom;
    [cell configureWithItem:customItem];UIImageView *icon=ImageFor(cell,custom);
    Check(icon.contentMode==UIViewContentModeScaleAspectFit && icon.tintColor==nil,@"custom image uses aspect-fit and its original colors");
    AssertIconGeometry(cell,icon,88);
    [cell configureWithItem:Normal(@"hourglass",nil)];
    Check(SymbolFor(cell,@"hourglass")==icon,@"system symbol reuses the setting icon view");
    Check(icon.contentMode==UIViewContentModeCenter && [icon.tintColor isEqual:UIColor.systemBlueColor],@"symbol configuration clears custom-image presentation");
    [cell configureWithItem:Normal(nil,nil)];
    Check(icon.image==nil && icon.hidden && icon.tintColor==nil && icon.contentMode==UIViewContentModeCenter,@"no-image configuration hides and clears previous image, tint and custom mode");
    [cell configureWithItem:Normal(@"fixture.unsupported",nil)];
    Check(SymbolFor(cell,@"questionmark.circle")==icon,@"unavailable system symbol keeps the icon slot through a supported fallback");
    [cell configureWithItem:customItem];[cell prepareForReuse];
    Check(icon.image==nil && icon.hidden && icon.tintColor==nil && icon.contentMode==UIViewContentModeCenter,@"prepareForReuse hides and clears custom icon presentation");
    Check(cell.textLabel.text==nil && cell.detailTextLabel.text==nil,@"prepareForReuse clears both labels");
    Check(cell.accessoryType==UITableViewCellAccessoryNone && cell.accessoryView==nil,@"prepareForReuse clears accessory state");
    [cell configureWithItem:Normal(@"hourglass",nil)];AssertIconGeometry(cell,icon,44);
}
static void TestSwitchAndTypeTransitions(void) {
    CSSettingTableViewCell *cell=Cell();__block NSUInteger oldCallbacks=0,newCallbacks=0;
    CSSettingItem *first=[CSSettingItem switchItemWithTitle:@"旧开关" iconName:@"bell" iconColor:nil switchValue:YES valueChangedBlock:^(BOOL value){oldCallbacks++;}];
    [cell configureWithItem:first];
    Check(Switches(cell).count==1 && Switches(cell).firstObject.isOn,@"switch configuration attaches exactly one control with its value");
    UISwitch *firstSwitch=Switches(cell).firstObject;[firstSwitch sendActionsForControlEvents:UIControlEventValueChanged];
    Check(oldCallbacks==1,@"live switch invokes the configured model callback");
    CSSettingItem *second=[CSSettingItem switchItemWithTitle:@"新开关" iconName:@"bell" iconColor:nil switchValue:NO valueChangedBlock:^(BOOL value){newCallbacks++;}];
    for(NSUInteger i=0;i<8;i++)[cell configureWithItem:second];
    Check(Switches(cell).count==1 && !Switches(cell).firstObject.isOn,@"repeated switch configuration does not accumulate controls");
    UISwitch *secondSwitch=Switches(cell).firstObject;secondSwitch.on=YES;[secondSwitch sendActionsForControlEvents:UIControlEventValueChanged];
    Check(oldCallbacks==1 && newCallbacks==1 && second.switchValue,@"current switch updates only its current model");
    [cell configureWithItem:Normal(@"gearshape",@"正常值")];
    Check(Switches(cell).count==0 && firstSwitch.superview==nil && secondSwitch.superview==nil,@"normal configuration removes previous switch controls");
    Check(cell.selectionStyle==UITableViewCellSelectionStyleDefault && cell.accessoryType==UITableViewCellAccessoryNone,@"normal configuration restores selectable plain-row state");
    Check([cell.detailTextLabel.text isEqual:@"正常值"],@"normal detail replaces empty switch detail");
    [cell configureWithItem:Typed(CSSettingItemTypeDisclosure)];
    Check(cell.accessoryType==UITableViewCellAccessoryDisclosureIndicator && Switches(cell).count==0,@"disclosure configuration has one native accessory and no switch");
    [cell configureWithItem:Typed(CSSettingItemTypeDraggable)];
    UIImageView *handle=SymbolFor(cell,@"line.3.horizontal");
    Check(!handle.hidden && cell.showsReorderControl && !cell.shouldIndentWhileEditing,@"draggable configuration enables the drag affordance");
    cell.editing=YES;[cell layoutSubviews];Check(handle.hidden,@"native editing hides the custom drag handle");
    cell.editing=NO;[cell layoutSubviews];Check(!handle.hidden,@"ending editing restores the custom drag handle");
    [cell configureWithItem:Typed(CSSettingItemTypeInput)];
    Check(handle.hidden && !cell.showsReorderControl && cell.shouldIndentWhileEditing,@"input configuration clears draggable state without a reuse call");
    Check(cell.accessoryType==UITableViewCellAccessoryDisclosureIndicator,@"input retains its disclosure accessory");
    [cell configureWithItem:Typed(CSSettingItemTypeAction)];
    Check(cell.selectionStyle==UITableViewCellSelectionStyleDefault && cell.accessoryType==UITableViewCellAccessoryDisclosureIndicator,@"action keeps standard selectable disclosure presentation");
    [cell configureWithItem:second];[cell prepareForReuse];
    Check(Switches(cell).count==0 && cell.settingSwitch==nil,@"prepareForReuse removes switch views and clears the control reference");
    Check(handle.hidden && !cell.showsReorderControl && cell.shouldIndentWhileEditing,@"prepareForReuse restores default drag state");
    Check(cell.selectionStyle==UITableViewCellSelectionStyleDefault,@"prepareForReuse clears switch selection style");
}
static void TestBackgroundExpirationRow(void) {
    CSBackgroundRunViewController *page=[CSBackgroundRunViewController new];
    CSBackgroundRunManager *manager=[CSBackgroundRunManager new];CSSettingTableViewCell *cell=Cell();
    for(NSUInteger state=0;state<3;state++) {
        if(state) {manager.lastBackgroundStartedAt=[NSDate dateWithTimeIntervalSince1970:1700000000];manager.lastBackgroundResult=@"已停止";manager.lastBackgroundStopReason=@"系统到期";manager.lastBackgroundCheckStatus=@"后台";}
        if(state==2)manager.lastTaskExpiredAt=[NSDate dateWithTimeIntervalSince1970:1700000025];
        for(NSNumber *full in @[@NO,@YES]) {
            NSDictionary *expiry=nil;
            for(NSDictionary *row in [page recordSummaryForManager:manager full:full.boolValue])if([row[@"title"] isEqual:@"系统到期时间"])expiry=row;
            Check([expiry[@"icon"] isEqual:@"hourglass"],@"actual background summary uses the iOS 15 hourglass for expiration");
            if(state<2)Check([expiry[@"detail"] isEqual:state ? @"未记录到期" : @"尚无记录"],@"expiration summary retains the correct empty-record fallback");
            else Check([expiry[@"detail"] containsString:@":"],@"expiration summary formats the recorded expiration time");
            [cell configureWithItem:Normal(expiry[@"icon"],expiry[@"detail"])];[cell layoutSubviews];
            UIImageView *icon=SymbolFor(cell,@"hourglass");
            Check(icon && !icon.hidden && icon!=cell.imageView,@"actual expiration record produces a visible independent hourglass icon");
        }
    }
}
int main(void) {@autoreleasepool {
    TestNativeLayoutAndHeights();TestImageTransitionsAndReuse();TestSwitchAndTypeTransitions();TestBackgroundExpirationRow();
    printf("Setting cell layout: %lu checks, %lu failures\n",(unsigned long)Checks,(unsigned long)Failures);
    return Failures ? 1 : 0;
}}
