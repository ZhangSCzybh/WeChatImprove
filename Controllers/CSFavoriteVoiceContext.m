#import "CSFavoriteVoiceContext.h"
#import "CSMessageNativeActionAdapter.h"
#include <limits.h>

static BOOL CSFavoriteIntegerGetter(id object, NSString *selector, NSString *type) {
    return CSMessageNativeSupports(object,selector,type,@[]);
}
static NSString *CSFavoriteString(id object, NSString *selector) {
    if (!CSMessageNativeSupports(object,selector,@"@",@[])) return nil;
    id value=CSMessageActionObjectGetter(object,NSSelectorFromString(selector));
    return [value isKindOfClass:NSString.class] ? value : nil;
}
static BOOL CSFavoriteMD5Valid(NSString *value) {
    if (!value.length) return YES;
    if (value.length!=32) return NO;
    return [value rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"] invertedSet]].location==NSNotFound;
}
static id CSFavoriteSingleVoiceField(id item) {
    if (!NSThread.isMainThread) return nil;
    Class itemClass=NSClassFromString(@"FavoritesItem"), fieldClass=NSClassFromString(@"FavoritesItemDataField");
    if (!itemClass || !fieldClass || ![item isKindOfClass:itemClass] ||
        !(CSFavoriteIntegerGetter(item,@"type",@"i") || CSFavoriteIntegerGetter(item,@"type",@"I")) ||
        CSMessageNativeUnsigned(item,@"type")!=3 || !CSMessageNativeSupports(item,@"dataList",@"@",@[])) return nil;
    id dataList=CSMessageActionObjectGetter(item,NSSelectorFromString(@"dataList"));
    if (![dataList isKindOfClass:NSArray.class] || [dataList count]!=1) return nil;
    id field=[dataList firstObject];
    if (![field isKindOfClass:fieldClass] ||
        !(CSFavoriteIntegerGetter(field,@"dataType",@"i") || CSFavoriteIntegerGetter(field,@"dataType",@"I")) ||
        CSMessageNativeUnsigned(field,@"dataType")!=3 || !CSMessageNativeSupports(field,@"isRecording",@"B",@[])) return nil;
    @try { if ([CSMessageNativeInvoke(field,@"isRecording",@[]) boolValue]) return nil; }
    @catch (__unused NSException *exception) { return nil; }
    return field;
}

@implementation CSFavoriteVoiceContext
+ (id)standaloneItemForListObject:(id)object {
    if (CSFavoriteSingleVoiceField(object)) return object;
    Class wrapperClass=NSClassFromString(@"FavDataItemWrap");
    if (!NSThread.isMainThread || !wrapperClass || ![object isKindOfClass:wrapperClass] ||
        !CSMessageNativeSupports(object,@"parent",@"@",@[]) ||
        !CSMessageNativeSupports(object,@"dataItem",@"@",@[])) return nil;
    @try {
        id parent=CSMessageNativeInvoke(object,@"parent",@[]);
        id field=CSFavoriteSingleVoiceField(parent);
        id wrappedField=CSMessageNativeInvoke(object,@"dataItem",@[]);
        // Native whole-item wrappers have a nil dataItem. A field wrapper must
        // point to the standalone parent's sole voice field, never a nested one.
        return field && (!wrappedField || wrappedField==field) ? parent : nil;
    } @catch (__unused NSException *exception) { return nil; }
}
+ (instancetype)contextWithItem:(id)item accountID:(NSString *)accountID accountEpoch:(NSUInteger)epoch {
    if (!NSThread.isMainThread || ![accountID isKindOfClass:NSString.class] || !accountID.length || !epoch) return nil;
    id field=CSFavoriteSingleVoiceField(item);
    if (!field || !CSFavoriteIntegerGetter(item,@"localId",@"I") || !CSFavoriteIntegerGetter(item,@"favId",@"I") ||
        !CSFavoriteIntegerGetter(field,@"duration",@"I") || !CSFavoriteIntegerGetter(field,@"dataSize",@"Q") ||
        !CSMessageNativeSupports(field,@"dataId",@"@",@[]) || !CSMessageNativeSupports(field,@"dataMd5",@"@",@[]) ||
        !CSMessageNativeSupports(field,@"dataFmt",@"@",@[])) return nil;
    unsigned int local=(unsigned int)CSMessageNativeUnsigned(item,@"localId"), favorite=(unsigned int)CSMessageNativeUnsigned(item,@"favId");
    unsigned long long expected=CSMessageNativeUnsigned(field,@"dataSize");
    for (NSString *getter in @[@"dataId",@"dataMd5",@"dataFmt"]) {
        id value=CSMessageActionObjectGetter(field,NSSelectorFromString(getter));
        if (value && ![value isKindOfClass:NSString.class]) return nil;
    }
    NSString *dataID=CSFavoriteString(field,@"dataId") ?: @"", *md5=CSFavoriteString(field,@"dataMd5") ?: @"";
    if ((!local && !favorite) || (!dataID.length && !md5.length) || dataID.length>512 || !CSFavoriteMD5Valid(md5) || expected>UINT_MAX) return nil;
    CSFavoriteVoiceContext *context=[self new];
    context->_accountID=[accountID copy]; context->_accountEpoch=epoch;
    context->_localID=local; context->_favoriteID=favorite; context->_dataID=[dataID copy]; context->_dataMD5=[md5.lowercaseString copy];
    context->_sourceItem=item; context->_dataItem=field;
    context->_durationMilliseconds=(unsigned int)CSMessageNativeUnsigned(field,@"duration"); context->_expectedBytes=(unsigned int)expected;
    NSString *format=CSFavoriteString(field,@"dataFmt").lowercaseString;
    NSNumber *mapped=@{@"amr":@0,@"speex":@1,@"mp3":@2,@"wav":@3,@"silk":@4}[format ?: @""];
    context->_formatKnown=mapped!=nil; context->_format=mapped ? mapped.unsignedIntValue : UINT_MAX;
    context->_stableIdentity=[[NSString stringWithFormat:@"a%lu:%@|e%lu|l%u|f%u|d%lu:%@|m%@",(unsigned long)accountID.length,accountID,(unsigned long)epoch,local,favorite,(unsigned long)dataID.length,dataID,context->_dataMD5] copy];
    return context;
}
- (id)dataItemInItem:(id)item {
    if (!NSThread.isMainThread) return nil;
    CSFavoriteVoiceContext *candidate=[CSFavoriteVoiceContext contextWithItem:item accountID:_accountID accountEpoch:_accountEpoch];
    if (!candidate || (_localID && candidate.localID && _localID!=candidate.localID) ||
        (_favoriteID && candidate.favoriteID && _favoriteID!=candidate.favoriteID)) return nil;
    if (!((_localID && _localID==candidate.localID) || (_favoriteID && _favoriteID==candidate.favoriteID))) return nil;
    if ((_dataID.length && ![_dataID isEqualToString:candidate.dataID]) ||
        (_dataMD5.length && ![_dataMD5 isEqualToString:candidate.dataMD5])) return nil;
    return candidate.dataItem;
}
- (BOOL)matchesItem:(id)item { return [self dataItemInItem:item]!=nil; }
@end
