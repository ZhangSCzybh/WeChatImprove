#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSCloseFriendPolicy.h"
#import "CSGroupProjection.h"
#import "WESessionTabItem.h"
static CSCloseFriendSnapshot *Policy;
static NSHashTable *Owners,*TabOwners;
static NSUInteger Epoch=23,Failures;
static CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void){return Policy;}
static NSUInteger CSCloseFriendAccountEpoch(void){return Epoch;}
static NSString *CSGroupCurrentAccountID(void){return @"red-fixture-account";}
static NSHashTable *Adapters(void){return Owners;}
static BOOL CSGroupIsFoldedController(id owner){(void)owner;return NO;}
typedef NS_ENUM(NSUInteger,CSGroupFoldedPrivacyState){CSGroupFoldedPrivacyUnknown,CSGroupFoldedPrivacyNoHidden,CSGroupFoldedPrivacyMixed,CSGroupFoldedPrivacyAllHidden};
static NSArray *CSGroupCopyFoldedUserNames(void){return nil;}
static CSGroupFoldedPrivacyState CSGroupAssessFoldedUserNames(NSArray *names,NSSet *hidden){(void)names;(void)hidden;return CSGroupFoldedPrivacyUnknown;}
static id CSCloseFriendRead(id owner,NSString *key){return [owner valueForKey:key];}
@interface CSGroupListAdapter:NSObject
@property(nonatomic,strong) id controller;
@property(nonatomic,copy) NSArray *cachedNativeSections,*alertBadgeKey;
@property(nonatomic,strong) NSNumber *alertBadge;
@property(nonatomic) NSUInteger changeDepth,snapshotRevision,modelRevision,snapshotEpoch;
@property(nonatomic) BOOL dirty;
@property(nonatomic,copy) NSString *snapshotAccount;
+(NSNumber *)closeFriendAlertBadgeCount;
@end
@implementation CSGroupListAdapter
#include "legacy-getter.inc"
@end
@interface NewMainFrameViewController:NSObject @end
@implementation NewMainFrameViewController @end
@interface UINavigationController:NSObject
@property(nonatomic,copy) NSArray *viewControllers;
@end
@implementation UINavigationController @end
@interface RedOwner:NSObject
@property(nonatomic,copy) NSArray *viewControllers;
@property(nonatomic) NSUInteger originalCalls;
@property(nonatomic) unsigned long long lastOriginalCount,badgeCount;
@property(nonatomic) BOOL hidden;
@end
@implementation RedOwner @end
#include "legacy-ChatTab.inc"
static void OriginalNumber(id object,SEL selector,unsigned long long count,unsigned long long index){
    (void)selector;(void)index;RedOwner *owner=object;owner.originalCalls++;owner.lastOriginalCount=count;owner.badgeCount=count;owner.hidden=count==0;
}
static IMP tab=(IMP)OriginalNumber;
static CSGroupRow *Row(NSUInteger index,NSString *name,NSUInteger unread){NSUInteger p[]={0,index};return [[CSGroupRow alloc]initWithNativePath:[NSIndexPath indexPathWithIndexes:p length:2] userName:name kind:CSGroupRowKindSession category:CSGroupRowCategoryPrivate top:NO unreadCount:unread redDot:NO];}
static void Run(BOOL revealed,BOOL dirty,void(^hook)(id,unsigned long long,unsigned long long)){
    Policy=[[CSCloseFriendSnapshot alloc]initWithAccountID:CSGroupCurrentAccountID() profile:@{@"enabled":@YES,@"friends":@[@"protected"],@"groups":@[],@"options":@{@"hideSessions":@YES,@"silenceMessages":@YES}} revealed:revealed revision:41 blocked:NO];
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.controller=@"main";adapter.cachedNativeSections=@[@[Row(0,@"protected",3),Row(1,@"ordinary",7)]];adapter.modelRevision=adapter.snapshotRevision=17;adapter.snapshotEpoch=Epoch;adapter.snapshotAccount=Policy.accountID;adapter.dirty=dirty;
    Owners=[NSHashTable weakObjectsHashTable];[Owners addObject:adapter];
    RedOwner *owner=[RedOwner new];UINavigationController *navigation=[UINavigationController new];navigation.viewControllers=@[[NewMainFrameViewController new]];owner.viewControllers=@[[NSObject new],[NSObject new],navigation];owner.badgeCount=10;
    NSNumber *decision=[CSGroupListAdapter closeFriendAlertBadgeCount];hook(owner,10,2);
    BOOL passed=revealed ? owner.originalCalls==1 && owner.lastOriginalCount==10 : owner.originalCalls==0 && owner.badgeCount==10 && !owner.hidden;
    if(!passed){Failures++;fprintf(stderr,"EXPECTED RED: %s, actual legacy decision=%s, originalCalls=%lu, originalCount=%llu\n",revealed?"revealed must preserve native10":"same-boundary dirty must hold without numeric0",decision.description.UTF8String,(unsigned long)owner.originalCalls,owner.lastOriginalCount);}
    NSDictionary *row=@{@"case":revealed?@"revealed-native10-protected3":@"dirty-same-boundary-hold",@"nativeInput":@10,@"protectedNumericContribution":@3,@"ordinaryUnread":@7,@"revealed":@(revealed),@"dirty":@(dirty),@"legacyGetter":decision?:NSNull.null,@"originalNumericCalls":@(owner.originalCalls),@"originalNumericArgument":@(owner.lastOriginalCount),@"hostBadgeCount":@(owner.badgeCount),@"hostHidden":@(owner.hidden),@"expected":revealed?@"one native numeric10 call":@"hold prior10 without a setter",@"passed":@(passed),@"actualWeChatLoaded":@NO,@"nativeEffectsAreHostFixture":@YES};
    NSData *data=[NSJSONSerialization dataWithJSONObject:row options:NSJSONWritingSortedKeys error:NULL];fwrite(data.bytes,1,data.length,stdout);fputc('\n',stdout);
}
int main(void){@autoreleasepool{
    TabOwners=[NSHashTable weakObjectsHashTable];void(^number)(id,unsigned long long,unsigned long long)=
#include "legacy-numeric.inc"
    ;Run(YES,NO,number);Run(NO,YES,number);return Failures?1:0;
}}
