#import "CSMessageTimeLayout.h"
#import "CSChatNativeBridge.h"
#import <objc/message.h>

BOOL CSMessageTimeCanToggle(BOOL enabled, BOOL tapToShow, NSString *text) {
    return enabled && tapToShow && text.length > 0 && ![text isEqualToString:@"-1"];
}

void CSMessageTimePositionLabel(UIView *label, UIView *head, UIView *content,
                               BOOL sender, BOOL belowAvatar) {
    // Tap-to-show labels need valid geometry even while hidden.
    if (!label) return;
    if (belowAvatar && head && !head.hidden && head.alpha > .01) {
        label.center = CGPointMake(CGRectGetMidX(head.frame),
            CGRectGetMaxY(head.frame)+label.bounds.size.height/2-7);
    } else if (content) {
        CGFloat x = sender ? CGRectGetMinX(content.frame)-1-label.bounds.size.width/2 :
                             CGRectGetMaxX(content.frame)+1+label.bounds.size.width/2;
        label.center = CGPointMake(x,CGRectGetMaxY(content.frame)-label.bounds.size.height/2);
    }
}

static BOOL CSTimeReadUnsigned(id object, NSString *name, unsigned int *value) {
    SEL selector=NSSelectorFromString(name);
    NSMethodSignature *signature=[object methodSignatureForSelector:selector];
    if (signature.numberOfArguments!=2 || strcmp(signature.methodReturnType,@encode(unsigned int))!=0) return NO;
    *value=((unsigned int (*)(id,SEL))objc_msgSend)(object,selector);
    return *value>0;
}
BOOL CSMessageTimeReadTimestamp(id model, unsigned int *timestamp) {
    if (!timestamp) return NO;
    *timestamp=0;
    id parent=CSMessageNativeObject(model,@"parentModel");
    id wrap=CSMessageNativeObject(model,@"messageWrap") ?: CSMessageNativeObject(parent,@"messageWrap");
    return CSTimeReadUnsigned(wrap,@"m_uiCreateTime",timestamp) ||
        CSTimeReadUnsigned(parent ?: model,@"createTime",timestamp);
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
