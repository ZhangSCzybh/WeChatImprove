#import "../Controllers/CSBackupBootstrap.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CSPaymentAutomation.h"
#import "CSRedEnvelopConfig.h"

@interface HongBaoReq : NSObject
@property(nonatomic, readonly) id reqText;
@end
@interface WCRedEnvelopesNetworkHelper : NSObject @end
@interface WCRedEnvelopesLogicMgr : NSObject @end
%hook WCRedEnvelopesNetworkHelper
- (void)WCToHongbaoCommonRequest:(id)request {
    CSPaymentCaptureRequest(request,[request reqText],YES);
    %orig;
}
%end
%hook WCRedEnvelopesLogicMgr
- (void)OnWCToHongbaoCommonResponse:(id)response Request:(id)request {
    NSDictionary *snapshot=CSPaymentResponseSnapshot(response,request,YES,NO);
    %orig;
    CSPaymentHandleResponse(snapshot);
}
- (void)OnWCToHongbaoCommonErrorResponse:(id)response Request:(id)request {
    NSDictionary *snapshot=CSPaymentResponseSnapshot(response,request,YES,YES);
    %orig;
    CSPaymentHandleResponse(snapshot);
}
- (void)OnWCToHongbaoCommonSystemErrorResponse:(id)response Request:(id)request {
    NSDictionary *snapshot=CSPaymentResponseSnapshot(response,request,YES,YES);
    %orig;
    CSPaymentHandleResponse(snapshot);
}
%end

#pragma mark - 红包详情页汇总

static const void *kCSRedEnvelopSummaryLabelKey = &kCSRedEnvelopSummaryLabelKey;


static long long CSRedEnvelopSummaryLongLongFromObject(id obj, NSString *fieldName) {
    if (!obj || !fieldName || fieldName.length == 0) return 0;
    
    SEL sel = NSSelectorFromString(fieldName);
    if ([obj respondsToSelector:sel]) {
        @try {
            return ((long long (*)(id, SEL))objc_msgSend)(obj, sel);
        } @catch (NSException *exception) {}
    }
    
    @try {
        id value = [obj valueForKey:fieldName];
        if (value && [value respondsToSelector:@selector(longLongValue)]) {
            return [value longLongValue];
        }
        if (value && [value respondsToSelector:@selector(integerValue)]) {
            return (long long)[value integerValue];
        }
    } @catch (NSException *exception) {}
    
    return 0;
}

static id CSRedEnvelopSummaryGetData(id target) {
    if (!target) return nil;
    
    if ([target respondsToSelector:@selector(m_data)]) {
        @try {
            return ((id (*)(id, SEL))objc_msgSend)(target, @selector(m_data));
        } @catch (NSException *exception) {}
    }
    
    @try {
        return [target valueForKey:@"m_data"];
    } @catch (NSException *exception) {}
    
    return nil;
}

static id CSRedEnvelopSummaryGetDetailInfo(id data) {
    if (!data) return nil;
    
    if ([data respondsToSelector:@selector(m_oWCRedEnvelopesDetailInfo)]) {
        @try {
            return ((id (*)(id, SEL))objc_msgSend)(data, @selector(m_oWCRedEnvelopesDetailInfo));
        } @catch (NSException *exception) {}
    }
    
    @try {
        return [data valueForKey:@"m_oWCRedEnvelopesDetailInfo"];
    } @catch (NSException *exception) {}
    
    return nil;
}

static UILabel *CSRedEnvelopSummaryLabelForView(UIView *container, BOOL createIfNeeded) {
    UILabel *label = objc_getAssociatedObject(container, kCSRedEnvelopSummaryLabelKey);
    if (label || !createIfNeeded) return label;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.userInteractionEnabled = NO;
    label.hidden = NO;
    
    objc_setAssociatedObject(container, kCSRedEnvelopSummaryLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [container addSubview:label];
    
    return label;
}

static void CSRedEnvelopSummaryLayoutLabel(UIView *container, UILabel *label) {
    if (!container || !label) return;
    
    CGFloat width = CGRectGetWidth(container.frame);
    if (width <= 0) width = CGRectGetWidth(container.bounds);
    if (width <= 0) return;
    
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *scene = (UIWindowScene *)[UIApplication.sharedApplication.connectedScenes anyObject];
        if (scene) {
            statusBarHeight = scene.statusBarManager.statusBarFrame.size.height;
        }
    }
    if (statusBarHeight <= 0) {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    if (statusBarHeight <= 0) statusBarHeight = 44;
    
    CGRect frame=CGRectMake(0, statusBarHeight, width, 80);
    if (!CGRectEqualToRect(label.frame,frame)) label.frame=frame;
}

static void CSRedEnvelopSummaryApplyToTarget(id target) {
    if (![target isKindOfClass:[UIViewController class]]) return;
    
    UIView *container = nil;
    @try {
        container = ((UIViewController *)target).view;
    } @catch (NSException *exception) {
        return;
    }
    
    if (!container) return;
    
    UILabel *existing = CSRedEnvelopSummaryLabelForView(container, NO);
    
    CSRedEnvelopConfig *config = [CSRedEnvelopConfig sharedConfig];
    if (!config.receiveDonePageSummaryEnable) {
        existing.hidden = YES;
        return;
    }
    
    id data = CSRedEnvelopSummaryGetData(target);
    id detailInfo = CSRedEnvelopSummaryGetDetailInfo(data);
    
    if (!detailInfo) {
        existing.hidden = YES;
        return;
    }
    
    UILabel *label = existing ?: CSRedEnvelopSummaryLabelForView(container, YES);
    if (!label) return;
    
    long long totalAmount = CSRedEnvelopSummaryLongLongFromObject(detailInfo, @"m_lTotalAmount");
    long long totalNum = CSRedEnvelopSummaryLongLongFromObject(detailInfo, @"m_lTotalNum");
    long long recNum = CSRedEnvelopSummaryLongLongFromObject(detailInfo, @"m_lRecNum");
    long long recAmount = CSRedEnvelopSummaryLongLongFromObject(detailInfo, @"m_lRecAmount");
    
    totalAmount = MAX(0, totalAmount);
    totalNum = MAX(0, totalNum);
    recNum = MAX(0, recNum);
    recAmount = MAX(0, recAmount);
    
    long long remainNum = MAX(0, totalNum - recNum);
    long long remainAmount = MAX(0, totalAmount - recAmount);
    
    label.hidden = NO;
    NSString *text = [NSString stringWithFormat:@"总额：%.2f元 / 总数：%lld个\n剩余：%lld个(%.2f元)",
                  ((double)totalAmount) / 100.0,
                  totalNum,
                  remainNum,
                  ((double)remainAmount) / 100.0];
    
    if (![label.text isEqualToString:text]) label.text=text;
    CSRedEnvelopSummaryLayoutLabel(container, label);
    
}

// Native refreshViewWithData: updates m_data after detail responses. Refresh on
// that event and layout, without a timer guessing when networking has finished.
@interface WCRedEnvelopesStoryViewController : UIViewController @end
%hook WCRedEnvelopesStoryViewController
- (void)viewDidLoad {
    %orig;
    @try { CSRedEnvelopSummaryApplyToTarget(self); } @catch (__unused NSException *e) {}
}
- (void)refreshViewWithData:(id)data {
    %orig;
    @try { CSRedEnvelopSummaryApplyToTarget(self); } @catch (__unused NSException *e) {}
}
- (void)viewDidLayoutSubviews {
    %orig;
    @try { CSRedEnvelopSummaryApplyToTarget(self); } @catch (__unused NSException *e) {}
}
%end

%ctor {
    CSBackupWhenReady(^{ %init; });
}
