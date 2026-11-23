#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <objc/runtime.h>
#import "CSQuickPanelAppearance.h"
#import "CSQuickPanelPreferences.h"
#import "CSSettingsHomeTheme.h"
#import "QuickPanelAppearanceProduction.inc"

static NSUserDefaults *CSQuickPanelAppearanceDefaults;
static NSUInteger checks;
static id CSIsolatedDefaults(__unused id self,__unused SEL selector) { return CSQuickPanelAppearanceDefaults; }
static void Require(BOOL condition,NSString *message) {
    checks++;if(!condition){NSLog(@"FAIL: %@",message);exit(1);}
}
static BOOL Near(CGFloat a,CGFloat b) { return fabs(a-b)<.000001; }
static BOOL Color(UIColor *color,unsigned int rgb,CGFloat alpha) {
    CGFloat r=0,g=0,b=0,a=0;return [color getRed:&r green:&g blue:&b alpha:&a] &&
        Near(r,((rgb>>16)&255)/255.0)&&Near(g,((rgb>>8)&255)/255.0)&&Near(b,(rgb&255)/255.0)&&Near(a,alpha);
}
static BOOL Monospaced(UIFont *font) {
    for(NSDictionary *feature in [font.fontDescriptor objectForKey:UIFontDescriptorFeatureSettingsAttribute])
        if([feature[UIFontFeatureTypeIdentifierKey] isEqual:@(kNumberSpacingType)]&&[feature[UIFontFeatureSelectorIdentifierKey] isEqual:@(kMonospacedNumbersSelector)])return YES;
    return NO;
}
static CSQuickPanelContentView *Content(CSQuickPanelActionCell **cellOut) {
    CSQuickPanelContentView *content=[CSQuickPanelContentView new];
    content.nicknameLabel=[UILabel new];content.wechatIDLabel=[UILabel new];content.timeLabel=[UILabel new];content.dateLabel=[UILabel new];
    content.emptyLabel=[UILabel new];content.emptySettingsButton=[UIButton new];content.separator=[UIView new];content.avatarView=[UIImageView new];
    content.collection=[UICollectionView new];content.identifiers=@[@"scan"];
    CSQuickPanelActionCell *cell=[CSQuickPanelActionCell new];cell.iconView=[UIImageView new];cell.iconTile=[UIView new];cell.titleLabel=[UILabel new];
    content.collection.visibleCells=@[cell];*cellOut=cell;return content;
}

static void VerifyColors(void) {
    [CSQuickPanelPreferences resetForegroundColors];
    Require(Color([CSQuickPanelAppearance primaryTextColorForLightContent:NO],0,1),@"default dark foreground for light background");
    Require(Color([CSQuickPanelAppearance primaryTextColorForLightContent:YES],0xffffff,1),@"default light foreground for dark background");
    Require(Color([CSQuickPanelAppearance secondaryTextColorForLightContent:YES],0xffffff,.67),@"default secondary alpha preserved");
    const unsigned int themes[]={0x05944a,0x0875ed,0x7b45df,0xf1730c};
    for(NSUInteger i=0;i<4;i++){
        [CSSettingsHomeTheme setPresetIndex:i];
        Require(Color(CSQuickPanelAppearance.iconColor,themes[i],1),@"default icon exactly matches each interface preset");
        Require(Color([CSQuickPanelAppearance iconTileColorForLightContent:NO],themes[i],.10),@"light icon tile retains interface RGB");
        Require(Color([CSQuickPanelAppearance iconTileColorForLightContent:YES],themes[i],.19),@"dark icon tile retains interface RGB");
    }
    for(NSNumber *rgb in @[@0,@0xffffff,@0x76b5ce]) {
        unsigned int value=rgb.unsignedIntValue;
        [CSSettingsHomeTheme setCustomColor:[UIColor colorWithRed:((value>>16)&255)/255.0 green:((value>>8)&255)/255.0 blue:(value&255)/255.0 alpha:1]];
        Require(Color(CSQuickPanelAppearance.iconColor,value,1),@"arbitrary interface accent is never silently lightened or darkened");
        Require(Color([CSQuickPanelAppearance iconTileColorForLightContent:NO],value,.10)&&Color([CSQuickPanelAppearance iconTileColorForLightContent:YES],value,.19),@"black/white/custom icon hue survives both backgrounds");
    }
    [CSQuickPanelPreferences setTextColorHex:@"#a1b2c3"];
    [CSQuickPanelPreferences setIconColorHex:@"#123abc"];
    Require(Color([CSQuickPanelAppearance primaryTextColorForLightContent:YES],0xa1b2c3,1)&&Color([CSQuickPanelAppearance primaryTextColorForLightContent:NO],0xa1b2c3,1),@"custom text overrides either background");
    Require(Color([CSQuickPanelAppearance secondaryTextColorForLightContent:YES],0xa1b2c3,.67),@"secondary custom text retains exact RGB");
    Require(Color(CSQuickPanelAppearance.iconColor,0x123abc,1),@"custom icon overrides interface tint");
    [CSSettingsHomeTheme setPresetIndex:1];
    Require(Color(CSQuickPanelAppearance.iconColor,0x123abc,1),@"interface change does not overwrite explicit icon color");
    [CSQuickPanelPreferences setIconColorHex:nil];
    Require(Color(CSQuickPanelAppearance.iconColor,0x0875ed,1),@"icon reset resumes current interface tint");
    Require(Color([CSQuickPanelAppearance primaryTextColorForLightContent:NO],0xa1b2c3,1),@"icon reset preserves custom text");
    [CSQuickPanelAppearanceDefaults setObject:@"invalid" forKey:CSQuickPanelIconColorHexKey];
    [CSQuickPanelAppearanceDefaults setObject:@42 forKey:CSQuickPanelTextColorHexKey];
    Require(Color(CSQuickPanelAppearance.iconColor,0x0875ed,1)&&Color([CSQuickPanelAppearance primaryTextColorForLightContent:YES],0xffffff,1),@"malformed persisted overrides fall back safely");
    for(NSNumber *rgb in @[@0,@0xffffff]) {
        unsigned int value=rgb.unsignedIntValue;
        NSString *hex=[NSString stringWithFormat:@"#%06X",value];
        [CSQuickPanelPreferences setTextColorHex:hex];[CSQuickPanelPreferences setIconColorHex:hex];
        Require(Color([CSQuickPanelAppearance primaryTextColorForLightContent:NO],value,1)&&Color([CSQuickPanelAppearance primaryTextColorForLightContent:YES],value,1),@"explicit black/white text is honored without contrast substitution");
        Require(Color(CSQuickPanelAppearance.iconColor,value,1),@"explicit black/white icons are honored without contrast substitution");
    }
}

static void VerifyAppliedForeground(void) {
    CSQuickPanelActionCell *cell=nil;CSQuickPanelContentView *content=Content(&cell);
    [CSQuickPanelPreferences resetForegroundColors];[CSSettingsHomeTheme setPresetIndex:0];
    [content updateTheme];
    Require(Color(content.nicknameLabel.textColor,0,1)&&Color(content.timeLabel.textColor,0,1),@"production header primary labels use default text");
    Require(Color(content.wechatIDLabel.textColor,0,.67)&&Color(content.dateLabel.textColor,0,.67)&&Color(content.emptyLabel.textColor,0,.67),@"production auxiliary labels use shared hierarchy");
    Require(Color(cell.iconView.tintColor,0x05944a,1)&&Color(cell.titleLabel.textColor,0,1),@"production visible cell receives shared defaults");
    Require(Color(content.emptySettingsButton.titleColor,0,1),@"empty settings button follows text preference");
    [CSQuickPanelPreferences setTextColorHex:@"#556677"];[CSQuickPanelPreferences setIconColorHex:@"#ABCDEF"];
    [content updateTheme];
    Require(Color(content.nicknameLabel.textColor,0x556677,1)&&Color(content.timeLabel.textColor,0x556677,1),@"production header receives custom text");
    Require(Color(content.wechatIDLabel.textColor,0x556677,.67)&&Color(content.dateLabel.textColor,0x556677,.67)&&Color(content.emptyLabel.textColor,0x556677,.67),@"production secondary labels receive custom text hue");
    Require(Color(content.emptySettingsButton.titleColor,0x556677,1)&&Color(content.emptySettingsButton.tintColor,0x556677,1),@"production button text uses custom text rather than icon color");
    Require(Color(cell.titleLabel.textColor,0x556677,1)&&Color(cell.iconView.tintColor,0xabcdef,1)&&Color(cell.iconTile.backgroundColor,0xabcdef,.10),@"production cell independently applies custom title/icon/tile");
    content.backgroundUsesLightContent=YES;
    Require(Color(content.nicknameLabel.textColor,0x556677,1)&&Color(cell.titleLabel.textColor,0x556677,1)&&Color(cell.iconView.tintColor,0xabcdef,1)&&Color(cell.iconTile.backgroundColor,0xabcdef,.19),@"background change does not override explicit foreground RGB");
    [CSSettingsHomeTheme setPresetIndex:2];[content updateTheme];
    Require(Color(cell.iconView.tintColor,0xabcdef,1),@"visible custom cell survives interface theme refresh");
    [CSQuickPanelPreferences resetForegroundColors];[content updateTheme];
    Require(Color(cell.titleLabel.textColor,0xffffff,1)&&Color(cell.iconView.tintColor,0x7b45df,1),@"visible reused cell returns to latest default text and tint");
    [cell configureWithIdentifier:@"wallet" lightContent:NO];
    Require(Color(cell.titleLabel.textColor,0,1)&&Color(cell.iconView.tintColor,0x7b45df,1)&&[cell.titleLabel.text isEqual:@"钱包"],@"reconfigured reused cell resolves current defaults");
    [CSQuickPanelPreferences setTextColorHex:@"#102030"];[CSQuickPanelPreferences setIconColorHex:@"#C0D0E0"];
    [cell configureWithIdentifier:@"favorites" lightContent:YES];
    Require(Color(cell.titleLabel.textColor,0x102030,1)&&Color(cell.iconView.tintColor,0xc0d0e0,1)&&[cell.titleLabel.text isEqual:@"收藏"],@"new or reused cell resolves current custom colors");
}

static void VerifyFonts(void) {
    const CGFloat sizes[]={17,12,29,11},caps[]={22,16,34,14};
    const UIFontWeight weights[]={UIFontWeightSemibold,UIFontWeightRegular,UIFontWeightMedium,UIFontWeightMedium};
    NSArray *styles=@[UIFontTextStyleHeadline,UIFontTextStyleCaption1,UIFontTextStyleTitle2,UIFontTextStyleCaption2];
    for(NSUInteger i=0;i<4;i++){
        UIFont *font=[CSQuickPanelAppearance headerFontForRole:i];
        Require([[font.fontDescriptor objectForKey:@"design"] isEqual:UIFontDescriptorSystemDesignRounded],@"each header role uses rounded system design");
        Require(Near(font.pointSize,sizes[i])&&Near(font.weight,weights[i]),@"header role preserves intended size and hierarchy");
        Require([[font.fontDescriptor objectForKey:@"metricsStyle"] isEqual:styles[i]],@"header uses corresponding dynamic text style");
        CSQuickPanelTestFontScale=3;
        UIFont *large=[CSQuickPanelAppearance headerFontForRole:i];
        Require(Near(large.pointSize,caps[i]),@"large dynamic type respects original per-role cap");
        CSQuickPanelTestFontScale=1;
    }
    Require(Monospaced([CSQuickPanelAppearance headerFontForRole:CSQuickPanelHeaderFontTime]),@"clock restores monospaced numerals after rounded descriptor drops features");
    Require(!Monospaced([CSQuickPanelAppearance headerFontForRole:CSQuickPanelHeaderFontNickname]),@"nickname is not forced to monospaced numerals");
    CSQuickPanelTestRoundedUnavailable=YES;
    Require(Monospaced([CSQuickPanelAppearance headerFontForRole:CSQuickPanelHeaderFontTime]),@"unavailable rounded design retains native monospaced clock fallback");
    Require(Near([CSQuickPanelAppearance headerFontForRole:CSQuickPanelHeaderFontNickname].pointSize,17),@"unavailable rounded design still gives valid native font");
    CSQuickPanelTestRoundedUnavailable=NO;
    CSQuickPanelActionCell *cell=nil;CSQuickPanelContentView *content=Content(&cell);[content updateFonts];
    Require([[content.nicknameLabel.font.fontDescriptor objectForKey:@"design"] isEqual:@"rounded"]&&[[content.wechatIDLabel.font.fontDescriptor objectForKey:@"design"] isEqual:@"rounded"]&&[[content.dateLabel.font.fontDescriptor objectForKey:@"design"] isEqual:@"rounded"],@"production header maps each identity/date label to rounded type");
    Require(Monospaced(content.timeLabel.font)&&Near(content.timeLabel.font.weight,UIFontWeightMedium),@"production clock applies rounded medium monospaced font");
    [cell configureWithIdentifier:@"scan" lightContent:NO];
    Require([[cell.titleLabel.font.fontDescriptor objectForKey:@"design"] isEqual:@"system"]&&Near(cell.titleLabel.font.pointSize,12),@"entry label typography remains unchanged");
}

int main(void) {
    @autoreleasepool {
        NSString *suite=[@"com.wechatimprove.tests.panel-appearance." stringByAppendingString:NSUUID.UUID.UUIDString];
        CSQuickPanelAppearanceDefaults=[[NSUserDefaults alloc] initWithSuiteName:suite];
        [CSQuickPanelAppearanceDefaults removePersistentDomainForName:suite];
        Method method=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));
        IMP old=method_setImplementation(method,(IMP)CSIsolatedDefaults);
        @try { VerifyColors();VerifyAppliedForeground();VerifyFonts(); }
        @finally { method_setImplementation(method,old);[CSQuickPanelAppearanceDefaults removePersistentDomainForName:suite]; }
        printf("Quick panel appearance: %lu checks passed (production colors, header fonts and applied content/cell methods).\n",(unsigned long)checks);
    }
    return 0;
}
