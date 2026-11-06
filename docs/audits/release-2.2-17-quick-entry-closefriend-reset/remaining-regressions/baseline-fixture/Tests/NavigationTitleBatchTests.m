#import <UIKit/UIKit.h>
#import <objc/runtime.h>
typedef NS_ENUM(NSInteger, CSNavigationAvatarMode) { CSNavigationAvatarModeNone,CSNavigationAvatarModeOther,CSNavigationAvatarModeSelf,CSNavigationAvatarModeBoth };
typedef NS_ENUM(NSInteger, CSNavigationNicknamePosition) { CSNavigationNicknamePositionRight,CSNavigationNicknamePositionLeft,CSNavigationNicknamePositionTop,CSNavigationNicknamePositionBottom };
enum { NSTextAlignmentCenter=1, NSTextAlignmentRight=2, NSStringDrawingUsesLineFragmentOrigin=1 };
@interface UILabel (TitleTest)
@property(nonatomic) NSInteger textAlignment;
@end
static char alignmentKey;
@implementation UILabel (TitleTest)
- (NSInteger)textAlignment { return [objc_getAssociatedObject(self,&alignmentKey) integerValue]; }
- (void)setTextAlignment:(NSInteger)value { objc_setAssociatedObject(self,&alignmentKey,@(value),OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
@end
static NSUInteger separatorMeasures,nicknameMeasures;
@interface NSString (TitleTest)
- (CGSize)sizeWithAttributes:(NSDictionary *)attributes;
- (CGRect)boundingRectWithSize:(CGSize)size options:(NSUInteger)options attributes:(NSDictionary *)attributes context:(id)context;
@end
@implementation NSString (TitleTest)
- (CGSize)sizeWithAttributes:(NSDictionary *)attributes { separatorMeasures++;return CGSizeMake(self.length*[attributes[NSFontAttributeName] lineHeight]/2,20); }
- (CGRect)boundingRectWithSize:(CGSize)size options:(NSUInteger)options attributes:(NSDictionary *)attributes context:(id)context {
    nicknameMeasures++;return CGRectMake(0,0,MIN(size.width,self.length*[attributes[NSFontAttributeName] lineHeight]/2),20);
}
@end
@class CSNavigationImageRequest;
@interface CContact : NSObject
@property(nonatomic,copy) NSString *m_nsUsrName,*m_nsHeadImgUrl,*m_nsNickName,*m_nsRemark;
@end
@implementation CContact @end
@interface CSContactSeparatorManager : NSObject
+ (instancetype)sharedManager;
- (NSString *)separatorTextForContactId:(NSString *)contactId;
- (CGFloat)separatorSizeForContactId:(NSString *)contactId;
- (CGFloat)avatarSpacingForContactId:(NSString *)contactId;
- (CGFloat)verticalOffsetForContactId:(NSString *)contactId;
@end
@implementation CSContactSeparatorManager
+ (instancetype)sharedManager { static id manager; if (!manager) manager=[self new];return manager; }
- (NSString *)separatorTextForContactId:(NSString *)contactId { return @"friend"; }
- (CGFloat)separatorSizeForContactId:(NSString *)contactId { return 18; }
- (CGFloat)avatarSpacingForContactId:(NSString *)contactId { return 7; }
- (CGFloat)verticalOffsetForContactId:(NSString *)contactId { return 3; }
@end
#import "NavigationTitleConstants.h"
#import "NavigationTitleDeclarations.h"
@implementation CSAvatarTitleView
#include "NavigationTitleBodies.h"
- (void)updateOtherAvatarWithUrl:(NSString *)url { self.otherAvatarUrl=url; }
- (void)updateSelfAvatarWithUrl:(NSString *)url { self.selfAvatarUrl=url; }
- (void)reloadSeparatorImage {}
@end
static NSUInteger checks;
#define CHECK(value) do { checks++; if (!(value)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#value);return 1; } } while(0)
static CSAvatarTitleView *Title(void) {
    CSAvatarTitleView *v=[CSAvatarTitleView new];v.frame=CGRectMake(0,0,100,35);v.avatarSize=35;v.separatorSize=22;v.separatorText=@"global";v.avatarMode=CSNavigationAvatarModeBoth;
    v.otherAvatarContainer=[UIView new];v.selfAvatarContainer=[UIView new];v.separatorContainer=[UIView new];
    v.otherAvatarImageView=[UIImageView new];v.selfAvatarImageView=[UIImageView new];v.separatorImageView=[UIImageView new];
    v.separatorLabel=[UILabel new];v.nicknameLabel=[UILabel new];return v;
}
static NSUserDefaults *isolated;
static id Defaults(id cls,SEL selector) { return isolated; }
int main(void) { @autoreleasepool {
    NSString *suite=[@"com.wechatimprove.test.navigation-title." stringByAppendingString:NSUUID.UUID.UUIDString];
    isolated=[[NSUserDefaults alloc] initWithSuiteName:suite];
    Method getter=class_getClassMethod(NSUserDefaults.class,@selector(standardUserDefaults));IMP original=method_setImplementation(getter,(IMP)Defaults);
    @try {
        [isolated setBool:YES forKey:kNavigationShowSelfAvatarKey];[isolated setBool:YES forKey:kNavigationShowOtherAvatarKey];
        [isolated setDouble:40 forKey:kNavigationAvatarSizeKey];[isolated setDouble:.3 forKey:kNavigationAvatarRadiusKey];
        CSAvatarTitleView *v=Title();
        separatorMeasures=0;[v updateSeparatorText:@"single"];
        CHECK(separatorMeasures==1 && v.separatorWidth==70 && v.frame.size.width==140);
        CGRect standalone=v.frame;
        separatorMeasures=0;[v performTitleUpdates:^{
            [v updateSeparatorText:@"intermediate"];[v updateSizeAndRadius:40 radius:.3];
            [v performTitleUpdates:^{ [v updateSeparatorSize:18];[v updateSeparatorText:@"final"]; }];
            [v updateAvatarSpacing:7];[v updateVerticalOffset:3];
        }];
        CHECK(separatorMeasures==1 && !v.titleUpdateDepth && !v.titleLayoutPending);
        CHECK(v.avatarSize==40 && v.separatorSize==18 && v.separatorWidth==49 && v.frame.size.width==143);
        CHECK(v.otherAvatarContainer.frame.origin.y==-3 && v.otherAvatarImageView.layer.cornerRadius==12);
        CHECK(!CGRectEqualToRect(v.frame,standalone));
        // Contact overrides remain the final values, even inside a larger update.
        CContact *contact=[CContact new];contact.m_nsUsrName=@"alice";contact.m_nsNickName=@"Alice";contact.m_nsHeadImgUrl=@"avatar";
        separatorMeasures=0;[v performTitleUpdates:^{ [v updateSeparatorText:@"global"];[v updateSeparatorSize:22];[v updateOtherAvatarWithContact:contact forGroup:NO]; }];
        CHECK(separatorMeasures==1 && [v.separatorText isEqual:@"friend"] && v.separatorSize==18 && v.avatarSpacing==7 && v.verticalOffset==3);
        CHECK([v.contactId isEqual:@"alice"] && [v.otherAvatarUrl isEqual:@"avatar"]);
        // The actual settings handler nests the same contact override batch.
        separatorMeasures=0;[v settingsChanged:nil];CHECK(separatorMeasures==1 && v.avatarMode==CSNavigationAvatarModeBoth);
        [isolated setBool:YES forKey:kNavigationShowOtherNicknameKey];
        separatorMeasures=0;nicknameMeasures=0;[v settingsChanged:nil];
        CHECK(separatorMeasures==1 && nicknameMeasures==1 && v.avatarMode==CSNavigationAvatarModeOther && !v.nicknameLabel.hidden);
        for (NSNumber *position in @[@0,@1,@2,@3]) {
            [isolated setInteger:position.integerValue forKey:kNavigationNicknamePositionKey];
            nicknameMeasures=0;[v updateOtherNickname:@"Changed"];CHECK(nicknameMeasures==1 && v.nicknamePosition==position.integerValue);
        }
        separatorMeasures=0;BOOL caught=NO;
        @try { [v performTitleUpdates:^{ [v updateSeparatorText:@"exception"];[NSException raise:@"fixture" format:@"fixture"]; }]; }
        @catch (__unused NSException *exception) { caught=YES; }
        CHECK(caught && !v.titleUpdateDepth && !v.titleLayoutPending && separatorMeasures==1);
        [v updateSeparatorText:@"after"];CHECK(separatorMeasures==2);
        [isolated removePersistentDomainForName:suite];
    } @finally { method_setImplementation(getter,original); }
    printf("Navigation title batching: %lu checks passed; nested updates, final contact overrides, single setters, nickname modes and exception recovery\n",(unsigned long)checks);
}return 0;}
