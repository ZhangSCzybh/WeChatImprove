#import <Foundation/Foundation.h>
#import "CSListCornerConfiguration.h"
#include <math.h>

// No real NSUserDefaults or user account is opened by these tests.
@interface MemoryDefaults : NSObject
@property(nonatomic,strong) NSMutableDictionary *values;
- (float)floatForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;
@end
@implementation MemoryDefaults
- (instancetype)init { if ((self=[super init])) _values=[NSMutableDictionary dictionary]; return self; }
- (float)floatForKey:(NSString *)key { return [self.values[key] floatValue]; }
- (BOOL)boolForKey:(NSString *)key { return [self.values[key] boolValue]; }
- (id)objectForKey:(NSString *)key { return self.values[key]; }
@end
static NSUInteger checks;
static void Check(BOOL result, const char *message) {
    checks++; if (!result) { fprintf(stderr,"FAIL: %s\n",message); exit(1); }
}
static BOOL Near(CGFloat a, CGFloat b) { return fabs(a-b)<0.000001; }
int main(void) { @autoreleasepool {
    MemoryDefaults *memory=[MemoryDefaults new]; NSUserDefaults *defaults=(id)memory;
    NSArray *keys=@[kListCornerRadiusKey,kListLeftMarginKey,kListRightMarginKey,kListTopSessionTopMarginKey,kListNormalSessionTopMarginKey];
    const CGFloat fallback[]={10,15,15,10,10};
    Check(!CSListCornerEnabled(defaults),"missing switch is disabled");
    memory.values[kListCornerRadiusEnabledKey]=@YES;
    Check(CSListCornerEnabled(defaults),"existing switch key is read");
    for (NSUInteger field=0;field<keys.count;field++) {
        [memory.values removeObjectForKey:keys[field]];
        Check(CSListCornerNumberValue(defaults,field)==fallback[field],"missing numeric setting retains 1.7-17 default");
        for (NSNumber *number in @[@0,@1,@5,@10.25,@15,@30,@50,@(-4)]) {
            memory.values[keys[field]]=number;
            CGFloat value=number.floatValue;
            CGFloat rendering=field<3 && !(value>0) ? fallback[field] : value;
            CGFloat editing=field<3 && value==0 ? fallback[field] : value;
            Check(CSListCornerNumberValue(defaults,field)==rendering,"rendering numeric fallback remains compatible");
            Check(CSListCornerSettingsNumberValue(defaults,field)==editing,"settings display retains legacy numeric semantics");
        }
    }
    NSArray *colorKeys=@[
        @[kListLightModeBgColorRedKey,kListLightModeBgColorGreenKey,kListLightModeBgColorBlueKey,kListLightModeBgColorAlphaKey],
        @[kListDarkModeBgColorRedKey,kListDarkModeBgColorGreenKey,kListDarkModeBgColorBlueKey,kListDarkModeBgColorAlphaKey],
        @[kTopSessionTopMarginLightBgColorRedKey,kTopSessionTopMarginLightBgColorGreenKey,kTopSessionTopMarginLightBgColorBlueKey,kTopSessionTopMarginLightBgColorAlphaKey],
        @[kTopSessionTopMarginDarkBgColorRedKey,kTopSessionTopMarginDarkBgColorGreenKey,kTopSessionTopMarginDarkBgColorBlueKey,kTopSessionTopMarginDarkBgColorAlphaKey],
        @[kNormalSessionTopMarginLightBgColorRedKey,kNormalSessionTopMarginLightBgColorGreenKey,kNormalSessionTopMarginLightBgColorBlueKey,kNormalSessionTopMarginLightBgColorAlphaKey],
        @[kNormalSessionTopMarginDarkBgColorRedKey,kNormalSessionTopMarginDarkBgColorGreenKey,kNormalSessionTopMarginDarkBgColorBlueKey,kNormalSessionTopMarginDarkBgColorAlphaKey]];
    for (NSUInteger role=0;role<colorKeys.count;role++) {
        [memory.values removeAllObjects];
        CSListCornerRGBA c=CSListCornerColorValue(defaults,role);
        Check(Near(c.red,role==0 ? 1 : role==1 ? .11 : 0) && Near(c.blue,role==0 ? 1 : role==1 ? .12 : 0) && c.alpha==(role<2 ? 1 : 0),"six missing palettes retain original defaults");
        NSArray *rgba=@[@0.2,@0.4,@0.8,@0.35];
        for (NSUInteger i=0;i<4;i++) memory.values[colorKeys[role][i]]=rgba[i];
        c=CSListCornerColorValue(defaults,role);
        Check(Near(c.red,.2)&&Near(c.green,.4)&&Near(c.blue,.8)&&Near(c.alpha,.35),"each palette reads its own RGBA keys including alpha");
        memory.values[colorKeys[role][3]]=@0;
        c=CSListCornerColorValue(defaults,role);
        Check(Near(c.red,.2)&&c.alpha==0,"nonzero RGB with zero alpha remains transparent");
        for (NSString *key in colorKeys[role]) memory.values[key]=@0;
        c=CSListCornerColorValue(defaults,role);
        Check(c.alpha==(role<2 ? 1 : 0),"all-zero color sentinel intentionally retains legacy behavior");
        [memory.values removeAllObjects];memory.values[colorKeys[role][3]]=@0.5;
        c=CSListCornerColorValue(defaults,role);
        Check(c.red==0&&c.green==0&&c.blue==0&&c.alpha==.5,"partially stored color retains original component reads");
        NSDictionary *before=[memory.values copy];
        (void)CSListCornerColorValue(defaults,role);
        Check([before isEqual:memory.values],"read helpers do not migrate or write settings");
    }
    // Interleaved themes do not use a sticky global theme/color cache.
    [memory.values removeAllObjects];
    Check(CSListCornerColorValue(defaults,CSListCornerColorCardLight).red==1,"light palette");
    Check(Near(CSListCornerColorValue(defaults,CSListCornerColorCardDark).red,.11),"dark palette");
    Check(CSListCornerColorValue(defaults,CSListCornerColorCardLight).red==1,"return to light palette");
    printf("List corner configuration: %lu checks passed\n",(unsigned long)checks);
} return 0; }
