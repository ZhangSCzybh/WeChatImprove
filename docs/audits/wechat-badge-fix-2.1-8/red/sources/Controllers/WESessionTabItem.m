#import "WESessionTabItem.h"

@implementation WESessionTabItem

+ (instancetype)tabWithType:(WETabType)type {
    WESessionTabItem *item = [[WESessionTabItem alloc] init];
    item.type = type;
    item.tabId = [NSString stringWithFormat:@"preset_%ld", (long)type];
    item.sortOrder = type;
    item.createTime = [NSDate date];
    item.updateTime = [NSDate date];
    
    switch (type) {
        case WETabTypeAll:
            item.tabName = @"全部";
            break;
        case WETabTypeGroup:
            item.tabName = @"群聊";
            break;
        case WETabTypePrivate:
            item.tabName = @"私聊";
            break;
        case WETabTypeOfficial:
            item.tabName = @"服务";
            break;
        default:
            break;
    }
    
    return item;
}

+ (instancetype)customTabWithName:(NSString *)name sessionUserNames:(NSArray<NSString *> *)userNames {
    WESessionTabItem *item = [[WESessionTabItem alloc] init];
    item.type = WETabTypeCustom;
    item.tabId = [[NSUUID UUID] UUIDString];
    item.tabName = name;
    item.sessionUserNames = userNames ?: @[];
    item.createTime = [NSDate date];
    item.updateTime = [NSDate date];
    item.sortOrder = 999;
    
    return item;
}

- (NSString *)displayName {
    return self.tabName ?: @"";
}

- (BOOL)isPresetTab {
    return self.type != WETabTypeCustom;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _tabId = [coder decodeObjectForKey:@"tabId"];
        _tabName = [coder decodeObjectForKey:@"tabName"];
        _type = [coder decodeIntegerForKey:@"type"];
        _sessionUserNames = [coder decodeObjectForKey:@"sessionUserNames"];
        _sortOrder = [coder decodeIntegerForKey:@"sortOrder"];
        _createTime = [coder decodeObjectForKey:@"createTime"];
        _updateTime = [coder decodeObjectForKey:@"updateTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.tabId forKey:@"tabId"];
    [coder encodeObject:self.tabName forKey:@"tabName"];
    [coder encodeInteger:self.type forKey:@"type"];
    [coder encodeObject:self.sessionUserNames forKey:@"sessionUserNames"];
    [coder encodeInteger:self.sortOrder forKey:@"sortOrder"];
    [coder encodeObject:self.createTime forKey:@"createTime"];
    [coder encodeObject:self.updateTime forKey:@"updateTime"];
}

@end
