#import "CSSettingsHomeModel.h"
#import "CSSettingTableViewCell.h"

@interface CSSettingsHomeModel ()
@property(nonatomic, copy) NSArray<CSSettingSection *> *sourceSections;
@property(nonatomic, copy) NSString *accountIdentifier;
@end

@implementation CSSettingsHomeModel
- (instancetype)init {
    if ((self=[super init])) { _query=@""; _sourceSections=@[]; }
    return self;
}
- (BOOL)replaceSections:(NSArray<CSSettingSection *> *)sections accountIdentifier:(NSString *)identifier {
    BOOL changed=self.accountIdentifier && ![self.accountIdentifier isEqualToString:identifier];
    self.accountIdentifier=identifier;
    self.sourceSections=sections;
    if (changed) { self.selectedIndex=0; self.searching=NO; self.query=@""; }
    return changed;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex { _selectedIndex=MIN(selectedIndex,3); }
- (NSArray<CSSettingSection *> *)displayedSections {
    if (self.sourceSections.count<5) return @[];
    if (!self.searching) return @[self.sourceSections[self.selectedIndex],self.sourceSections.lastObject];
    NSString *query=[self.query stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (!query.length) return self.sourceSections;
    NSMutableArray *result=[NSMutableArray array];
    NSStringCompareOptions options=NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch|NSWidthInsensitiveSearch;
    for (CSSettingSection *section in self.sourceSections) {
        NSMutableArray *items=[NSMutableArray array];
        BOOL categoryMatch=[section.header rangeOfString:query options:options].location!=NSNotFound;
        for (CSSettingItem *item in section.items) {
            if (categoryMatch || [item.title rangeOfString:query options:options].location!=NSNotFound)
                [items addObject:item];
        }
        if (items.count) [result addObject:[CSSettingSection sectionWithHeader:section.header items:items]];
    }
    return result;
}
@end
