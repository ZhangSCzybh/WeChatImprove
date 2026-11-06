#import "CSBubbleTextColors.h"
#import "CSChatNativeBridge.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char CSCellTextKey, CSTextOwnerKey;

@interface CSBubbleTextNode : NSObject
@property(nonatomic, weak) UIView *view;
@property(nonatomic) SEL getter, setter;
@property(nonatomic, strong) id nativeColor, generatedColor;
@property(nonatomic, copy) NSAttributedString *nativeText, *generatedText;
@property(nonatomic) BOOL applying;
@end
@implementation CSBubbleTextNode @end

static BOOL CSCanSet(id target, SEL setter) {
    Method method=class_getInstanceMethod([target class],setter);
    if (!method || method_getNumberOfArguments(method)!=3) return NO;
    char result[16]={0},arg[16]={0};method_getReturnType(method,result,sizeof(result));
    method_getArgumentType(method,2,arg,sizeof(arg));return result[0]=='v' && arg[0]=='@';
}
static BOOL CSCanGetColor(id target) {
    Method method=class_getInstanceMethod([target class],NSSelectorFromString(@"oTextColor"));
    if (!method || method_getNumberOfArguments(method)!=2) return NO;
    char result[16]={0};method_getReturnType(method,result,sizeof(result));return result[0]=='@';
}
static void CSSet(id target, SEL setter, id value) {
    ((void(*)(id,SEL,id))objc_msgSend)(target,setter,value);
}
static id CSObjectIvar(id target, const char *name) {
    Ivar slot=class_getInstanceVariable([target class],name);
    const char *type=slot ? ivar_getTypeEncoding(slot) : NULL;
    return type && type[0]=='@' ? object_getIvar(target,slot) : nil;
}
static NSAttributedString *CSColoredText(NSAttributedString *text, UIColor *color) {
    if (!text.length) return text;
    NSMutableAttributedString *copy=[text mutableCopy];
    [text enumerateAttributesInRange:NSMakeRange(0,text.length) options:0 usingBlock:^(NSDictionary *attributes, NSRange range, BOOL *stop) {
        // Preserve links, attachments, fonts, paragraph styles and the text itself.
        if (!attributes[NSLinkAttributeName] && !attributes[NSAttachmentAttributeName])
            [copy addAttribute:NSForegroundColorAttributeName value:color range:range];
    }];
    return copy;
}
static void CSRestoreNode(CSBubbleTextNode *node) {
    UIView *view=node.view;if (!view) return;
    if (objc_getAssociatedObject(view,&CSTextOwnerKey)!=node) return;
    node.applying=YES;
    UILabel *label=[view isKindOfClass:UILabel.class] ? (UILabel *)view : nil;
    NSAttributedString *currentText=label.attributedText;
    BOOL ownsText=node.generatedText && [currentText isEqualToAttributedString:node.generatedText];
    id current=CSMessageNativeObject(view,NSStringFromSelector(node.getter));
    if (node.generatedColor && current==node.generatedColor) CSSet(view,node.setter,node.nativeColor);
    // UILabel may rewrite attributed foreground colors when textColor changes.
    // Preserve a native content replacement even while restoring our base color.
    if (currentText) label.attributedText=ownsText ? node.nativeText : currentText;
    node.applying=NO;
    if (objc_getAssociatedObject(view,&CSTextOwnerKey)==node) objc_setAssociatedObject(view,&CSTextOwnerKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [view setNeedsDisplay];
}
void CSBubbleTextColorsRestore(UIView *cell) {
    if (!NSThread.isMainThread || !cell) return;
    NSArray *nodes=objc_getAssociatedObject(cell,&CSCellTextKey);
    for (CSBubbleTextNode *node in nodes) CSRestoreNode(node);
    objc_setAssociatedObject(cell,&CSCellTextKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static void CSAddTarget(NSMutableArray *targets, id view) {
    if (![view isKindOfClass:UIView.class] || [targets containsObject:view]) return;
    if ([view isKindOfClass:UILabel.class] ||
        (CSCanGetColor(view) && CSCanSet(view,NSSelectorFromString(@"setOTextColor:"))))
        [targets addObject:view];
}
static void CSCollectCallText(NSMutableArray *targets, UIView *content) {
    // Native getContentView excludes names/time. Bound the compatibility walk to
    // this small call-content subtree; never traverse the message cell or table.
    NSMutableArray *queue=[NSMutableArray arrayWithObject:content];
    for (NSUInteger i=0;i<queue.count && i<32;i++) {
        UIView *view=queue[i];NSUInteger before=targets.count;CSAddTarget(targets,view);
        if (targets.count!=before) continue;
        for (UIView *child in view.subviews) { if (queue.count>=32) break;[queue addObject:child]; }
    }
}
void CSBubbleTextColorsApply(UIView *cell, UIColor *color, BOOL callRecord) {
    if (!NSThread.isMainThread || !cell) return;
    if (!color) { CSBubbleTextColorsRestore(cell);return; }
    NSMutableArray *targets=[NSMutableArray array];
    CSAddTarget(targets,CSMessageNativeObject(cell,@"getRichTextView"));
    id reply=CSMessageNativeObject(cell,@"getMsgReplyView");
    CSAddTarget(targets,CSMessageNativeObject(reply,@"richTextView"));
    CSAddTarget(targets,CSObjectIvar(cell,"m_secLabel"));
    if (callRecord && !targets.count) {
        id content=CSMessageNativeObject(cell,@"getContentView");
        if ([content isKindOfClass:UIView.class] && content!=cell && [content isDescendantOfView:cell]) CSCollectCallText(targets,content);
    }
    NSArray<CSBubbleTextNode *> *previous=objc_getAssociatedObject(cell,&CSCellTextKey);
    NSMutableArray *nodes=[NSMutableArray array];
    for (UIView *view in targets) {
        CSBubbleTextNode *node=nil;
        for (CSBubbleTextNode *old in previous) if (old.view==view) { node=old;break; }
        if (!node) {
            node=[CSBubbleTextNode new];node.view=view;
            BOOL label=[view isKindOfClass:UILabel.class];
            node.getter=NSSelectorFromString(label ? @"textColor" : @"oTextColor");
            node.setter=NSSelectorFromString(label ? @"setTextColor:" : @"setOTextColor:");
            if (!CSCanSet(view,node.setter)) continue;
            objc_setAssociatedObject(view,&CSTextOwnerKey,node,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [nodes addObject:node];
        id current=CSMessageNativeObject(view,NSStringFromSelector(node.getter));
        if (!node.generatedColor || current!=node.generatedColor) node.nativeColor=current;
        UILabel *label=[view isKindOfClass:UILabel.class] ? (UILabel *)view : nil;
        NSAttributedString *attributed=label.attributedText;
        BOOL newText=attributed!=node.generatedText;
        if (newText) node.nativeText=attributed;
        BOOL changed=![current isEqual:color];
        node.applying=YES;
        if (changed) CSSet(view,node.setter,color);
        node.generatedColor=CSMessageNativeObject(view,NSStringFromSelector(node.getter));
        if (label && (newText || changed)) {
            if (node.nativeText) label.attributedText=CSColoredText(node.nativeText,color);
            node.generatedText=label.attributedText;
        }
        node.applying=NO;
        if (changed || (label && newText)) [view setNeedsDisplay];
    }
    for (CSBubbleTextNode *node in previous) if (![nodes containsObject:node]) CSRestoreNode(node);
    objc_setAssociatedObject(cell,&CSCellTextKey,nodes,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
id CSBubbleTextColorAssignment(id view, id nativeColor) {
    if (!NSThread.isMainThread) return nativeColor;
    CSBubbleTextNode *node=objc_getAssociatedObject(view,&CSTextOwnerKey);
    if (!node || node.applying || !node.generatedColor) return nativeColor;
    if (nativeColor!=node.generatedColor) node.nativeColor=nativeColor;
    return node.generatedColor;
}
