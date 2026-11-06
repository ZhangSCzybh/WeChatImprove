#import "CSMessageTimeLayout.h"
#import "CSChatNativeBridge.h"
#import <objc/message.h>
#include <math.h>
#include <limits.h>

BOOL CSMessageTimeCanToggle(BOOL enabled, BOOL tapToShow, NSString *text) {
    return enabled && tapToShow && text.length > 0 && ![text isEqualToString:@"-1"];
}

void CSMessageTimePositionLabel(UIView *label, UIView *container, UIView *head, UIView *content,
                               BOOL sender, BOOL belowAvatar) {
    // All anchors may be nested in different native containers. Their frames are
    // not in the label owner's coordinates. Convert bounds, including native offsets.
    // Keep hidden tap labels positioned without changing their visibility.
    if (!label || !container) return;
    if (belowAvatar && head && !head.hidden && head.alpha > .01) {
        CGRect rect=[container convertRect:head.bounds fromView:head];
        label.center = CGPointMake(CGRectGetMidX(rect),
            CGRectGetMaxY(rect)+label.bounds.size.height/2-7);
    } else if (content) {
        CGRect rect=[container convertRect:content.bounds fromView:content];
        CGFloat x = sender ? CGRectGetMinX(rect)-1-label.bounds.size.width/2 :
                             CGRectGetMaxX(rect)+1+label.bounds.size.width/2;
        label.center = CGPointMake(x,CGRectGetMaxY(rect)-label.bounds.size.height/2);
    }
}

BOOL CSMessageTimeReadSender(id model, BOOL *sender) {
    if (!sender) return NO;
    *sender=NO;
    id logical=CSMessageNativeObject(model,@"parentModel") ?: model;
    SEL sel=NSSelectorFromString(@"isSender");
    NSMethodSignature *signature=[logical methodSignatureForSelector:sel];
    if (signature.numberOfArguments!=2) return NO;
    if (strcmp(signature.methodReturnType,@encode(BOOL))==0) {
        *sender=((BOOL (*)(id,SEL))objc_msgSend)(logical,sel);return YES;
    }
    if (strcmp(signature.methodReturnType,@encode(char))==0) {
        *sender=((char (*)(id,SEL))objc_msgSend)(logical,sel)!=0;return YES;
    }
    return NO;
}
BOOL CSMessageTimeShowsModel(id model, BOOL belowAvatar) {
    id parent=CSMessageNativeObject(model,@"parentModel");
    NSArray *parts=CSMessageNativeObject(parent,@"subViewModels");
    if (![parts isKindOfClass:NSArray.class] || !parts.count) return YES;
    return (belowAvatar ? parts.firstObject : parts.lastObject)==model;
}
UIView *CSMessageTimeAnchor(id cell) {
    // m_contentView may be a full-row container: use the actual bubble when available.
    for (NSString *selector in @[@"getBgImageView",@"getContentView"]) {
        id view=CSMessageNativeObject(cell,selector);
        if ([view isKindOfClass:UIView.class] && !CGRectIsEmpty([view frame])) return view;
    }
    return nil;
}
static BOOL CSTimeReadTimestamp(id object, NSString *name, unsigned int *value) {
    SEL selector=NSSelectorFromString(name);
    NSMethodSignature *signature=[object methodSignatureForSelector:selector];
    if (signature.numberOfArguments!=2) return NO;
    double raw=0;
    if (strcmp(signature.methodReturnType,@encode(unsigned int))==0)
        raw=((unsigned int (*)(id,SEL))objc_msgSend)(object,selector);
    else if (strcmp(signature.methodReturnType,@encode(double))==0)
        raw=((double (*)(id,SEL))objc_msgSend)(object,selector);
    else return NO;
    if (!isfinite(raw) || raw<1 || raw>UINT_MAX) return NO;
    *value=(unsigned int)raw;return YES;
}
BOOL CSMessageTimeReadTimestamp(id model, unsigned int *timestamp) {
    if (!timestamp) return NO;
    *timestamp=0;
    id logical=CSMessageNativeObject(model,@"parentModel") ?: model;
    id wrap=CSMessageNativeObject(logical,@"messageWrap");
    return CSTimeReadTimestamp(wrap,@"m_uiCreateTime",timestamp) ||
        CSTimeReadTimestamp(logical,@"createTime",timestamp);
}
NSString *CSMessageTimeText(unsigned int timestamp, NSUserDefaults *defaults) {
    if (!timestamp) return nil;
    NSArray *keys=@[@"showYear",@"showMonth",@"showDay",@"showHour",@"showMinute",@"showSecond"];
    NSArray *formats=@[@"yyyy",@"MM",@"dd",@"HH",@"mm",@"ss"];
    NSMutableArray *date=[NSMutableArray array],*time=[NSMutableArray array];
    for (NSUInteger i=0;i<keys.count;i++)
        if ([defaults boolForKey:[@"com.wechat.enhance.messageTime." stringByAppendingString:keys[i]]])
            [(i<3 ? date : time) addObject:formats[i]];
    if (!date.count && !time.count) [time addObjectsFromArray:@[@"HH",@"mm"]];
    NSString *separator=[defaults boolForKey:@"com.wechat.enhance.messageTime.singleLine"] ? @" " : @"\n";
    NSMutableArray *parts=[NSMutableArray array];
    if (date.count) [parts addObject:[date componentsJoinedByString:@"-"]];
    if (time.count) [parts addObject:[time componentsJoinedByString:@":"]];
    NSString *format=[parts componentsJoinedByString:separator];
    // Per-thread formatter: no cross-thread mutable formatter and no formatter per cell.
    NSMutableDictionary *thread=NSThread.currentThread.threadDictionary;
    NSDateFormatter *formatter=thread[@"CSMessageTimeFormatter"];
    if (!formatter) { formatter=[NSDateFormatter new];thread[@"CSMessageTimeFormatter"]=formatter; }
    if (![formatter.dateFormat isEqual:format]) formatter.dateFormat=format;
    formatter.timeZone=NSTimeZone.localTimeZone;
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
}
