#import <Foundation/Foundation.h>
#import "CSAutomationStore.h"
#import "CSAutomationEventAdapter.h"
#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <limits.h>
static NSUInteger Checks;
static void Check(BOOL value,NSString *message){Checks++;if(!value){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
// These fixtures keep the production ABI helper's checked invocation contract.
BOOL CSMessageNativeSupports(id object,NSString *name,NSString *result,NSArray *arguments){NSMethodSignature *s=[object methodSignatureForSelector:NSSelectorFromString(name)];if(!s || s.numberOfArguments!=arguments.count+2)return NO;if(result.length && s.methodReturnType[0]!=[result characterAtIndex:0])return NO;return YES;}
id CSMessageNativeInvoke(id object,NSString *name,NSArray *arguments){NSMethodSignature *s=[object methodSignatureForSelector:NSSelectorFromString(name)];if(!s)return nil;NSInvocation *i=[NSInvocation invocationWithMethodSignature:s];i.target=object;i.selector=NSSelectorFromString(name);for(NSUInteger n=0;n<arguments.count;n++){id a=arguments[n];[i setArgument:&a atIndex:n+2];}[i invoke];if(s.methodReturnType[0]=='@'){__unsafe_unretained id v=nil;[i getReturnValue:&v];return v;}unsigned long long v=0;[i getReturnValue:&v];return @(v);}
id CSMessageActionNativeObject(id object,NSString *name){return CSMessageNativeSupports(object,name,@"@",@[])?CSMessageNativeInvoke(object,name,@[]):nil;}
unsigned long long CSMessageNativeUnsigned(id object,NSString *name){return [CSMessageNativeInvoke(object,name,@[]) unsignedLongLongValue];}
@interface AutoWrap:NSObject
@property NSString *m_nsFromUsr,*m_nsToUsr,*m_nsRealChatUsr,*m_nsContent,*m_nsAtUserList,*m_nsMsgSource,*m_nsSpecifiedChatName;
@property unsigned int m_uiMessageType,m_uiMesLocalID,m_uiCreateTime;
@property long long m_n64MesSvrID;
@end
@implementation AutoWrap @end
@interface AutoPat:NSObject
@property NSString *fromUserName,*pattedUserName;
@property long long serverId;
@property unsigned long long createTime;
@end
@implementation AutoPat @end
@interface AutoThrowingPatXML : AutoWrap @end
@implementation AutoThrowingPatXML
- (NSString *)m_nsContent{[NSException raise:@"UnavailableNativeXML" format:@"fixture getter unavailable"];return nil;}
@end
static NSString *PatXML(NSString *sender,NSString *chat,NSString *target){
    return [NSString stringWithFormat:@"<sysmsg type=\"pat\"><pat><fromusername><![CDATA[%@]]></fromusername><chatusername><![CDATA[%@]]></chatusername><pattedusername><![CDATA[%@]]></pattedusername><template><![CDATA[原生拍动文案]]></template></pat></sysmsg>",sender,chat,target];
}
static AutoWrap *RawPatOfClass(Class cls){
    AutoWrap *wrap=[cls new];wrap.m_uiMessageType=10002;wrap.m_n64MesSvrID=9223372036854775684LL;wrap.m_uiCreateTime=1794384000;
    wrap.m_nsFromUsr=@"room@chatroom";wrap.m_nsToUsr=@"me";wrap.m_nsContent=PatXML(@"friend",@"room@chatroom",@"me");return wrap;
}
static AutoWrap *RawPat(void){return RawPatOfClass(AutoWrap.class);}
static NSDictionary *RawPatEvent(AutoWrap *wrap,NSString *session,NSString *account){
    NSDictionary *parsed=CSAutomationPatFromXMLMessage(wrap,session);return parsed?CSAutomationEventFromPat(parsed[@"pat"],account,parsed[@"conversation"]):nil;
}
static void TestRawPatXML(void){
    AutoWrap *wrap=RawPat();NSString *original=[wrap.m_nsContent copy];
    NSDictionary *parsed=CSAutomationPatFromXMLMessage(wrap,@"room@chatroom");id pat=parsed[@"pat"];
    Check(parsed!=nil && [parsed[@"conversation"] isEqual:@"room@chatroom"],@"raw 10002 XML yields the native group conversation without a compound model");
    Check(CSMessageNativeSupports(pat,@"serverId",@"q",@[]) && CSMessageNativeSupports(pat,@"createTime",@"Q",@[]),@"raw pat snapshot keeps exact signed ID and unsigned 64-bit millisecond getter ABI");
    Check([CSMessageActionNativeObject(pat,@"fromUserName") isEqual:@"friend"] && [CSMessageActionNativeObject(pat,@"pattedUserName") isEqual:@"me"],@"native schema CDATA identities survive the raw parser");
    Check([CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue]==wrap.m_n64MesSvrID && CSMessageNativeUnsigned(pat,@"createTime")==1794384000000ULL,@"outer full-width server ID and seconds supply the pat identity and milliseconds");
    NSDictionary *event=CSAutomationEventFromPat(pat,@"me",parsed[@"conversation"]);
    Check([event[@"identifiers"] isEqual:@[@"me|room@chatroom|pat:9223372036854775684"]] && [event[@"created"] doubleValue]==1794384000 && [event[@"group"] boolValue] && [event[@"sender"] isEqual:@"friend"],@"real event adapter accepts raw group pat with exact account identity and time");
    Check([wrap.m_nsContent isEqual:original] && [wrap.m_nsFromUsr isEqual:@"room@chatroom"] && [wrap.m_nsToUsr isEqual:@"me"] && wrap.m_n64MesSvrID==9223372036854775684LL && wrap.m_uiCreateTime==1794384000,@"raw normalization does not mutate native input content or envelope");
    Check(![pat respondsToSelector:NSSelectorFromString(@"setFromUserName:")] && ![pat respondsToSelector:NSSelectorFromString(@"setPattedUserName:")] && ![pat respondsToSelector:NSSelectorFromString(@"setServerId:")] && ![pat respondsToSelector:NSSelectorFromString(@"setCreateTime:")],@"raw snapshot has no mutable native pat setters");
    wrap.m_nsContent=PatXML(@"other",@"room@chatroom",@"me");wrap.m_n64MesSvrID=1;wrap.m_uiCreateTime=1;
    Check([CSMessageActionNativeObject(pat,@"fromUserName") isEqual:@"friend"] && [CSMessageNativeInvoke(pat,@"serverId",@[]) longLongValue]==9223372036854775684LL && CSMessageNativeUnsigned(pat,@"createTime")==1794384000000ULL,@"later raw wrap changes cannot rewrite an admitted immutable snapshot");
    AutoPat *native=[AutoPat new];native.fromUserName=@"friend";native.pattedUserName=@"me";native.serverId=9223372036854775684LL;native.createTime=1794384000000ULL;
    Check([CSAutomationEventFromPat(native,@"me",@"room@chatroom")[@"identifiers"] isEqual:event[@"identifiers"]],@"raw XML and native insertion observations share the durable dedup key");
    wrap=RawPat();wrap.m_uiCreateTime=UINT_MAX;parsed=CSAutomationPatFromXMLMessage(wrap,@"");
    Check(CSMessageNativeUnsigned(parsed[@"pat"],@"createTime")==((unsigned long long)UINT_MAX)*1000ULL,@"seconds-to-milliseconds conversion widens before multiplication");

    wrap=RawPat();wrap.m_nsFromUsr=@"friend";wrap.m_nsContent=PatXML(@"friend",@"me",@"me");
    for(NSString *session in @[@"",@"friend",@"me"]){event=RawPatEvent(wrap,session,@"me");Check([event[@"conversation"] isEqual:@"friend"] && ![event[@"group"] boolValue],@"incoming private raw chat naming the recipient normalizes to sender");}
    wrap.m_nsSpecifiedChatName=@"me";Check(RawPatEvent(wrap,@"friend",@"me")!=nil,@"private native specified chat may retain the raw recipient");
    wrap.m_nsSpecifiedChatName=nil;wrap.m_nsContent=PatXML(@"friend",@"friend",@"me");Check(RawPatEvent(wrap,@"friend",@"me")!=nil,@"private native XML may already name the sender");
    wrap.m_nsSpecifiedChatName=@"unrelated";Check(!CSAutomationPatFromXMLMessage(wrap,@"friend"),@"private specified chat cannot redirect a pat to another peer");wrap.m_nsSpecifiedChatName=nil;
    Check(!CSAutomationPatFromXMLMessage(wrap,@"unrelated"),@"private ingress session cannot redirect the normalized conversation");
    wrap.m_nsFromUsr=@"other";Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"private XML sender must match the outer sender");
    wrap=RawPat();Check(!RawPatEvent(wrap,@"",@"other"),@"raw pat recipient is rebound to the actual manager account");
    wrap.m_nsContent=PatXML(@"me",@"room@chatroom",@"me");Check(!RawPatEvent(wrap,@"",@"me"),@"raw self patting self cannot create an automatic action");
    wrap.m_nsToUsr=@"other";wrap.m_nsContent=PatXML(@"friend",@"room@chatroom",@"other");Check(!RawPatEvent(wrap,@"",@"me"),@"raw other-person target cannot create an action for me");
    wrap=RawPat();wrap.m_nsFromUsr=@"other@chatroom";Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"group XML chat must match the actual outer group");
    wrap=RawPat();wrap.m_nsToUsr=@"other";Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"group XML target must match the envelope recipient");
    wrap=RawPat();Check(!CSAutomationPatFromXMLMessage(wrap,@"other@chatroom"),@"group ingress session must match its raw XML group");
    wrap.m_nsSpecifiedChatName=@"other@chatroom";Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"group specified native chat must match its raw XML group");
    wrap=RawPat();wrap.m_nsFromUsr=@"friend";wrap.m_nsSpecifiedChatName=@"room@chatroom";
    Check(RawPatEvent(wrap,@"",@"me")!=nil && RawPatEvent(wrap,@"room@chatroom",@"me")!=nil,@"native specified group routes an individual outer sender to the exact XML group");
    wrap.m_nsSpecifiedChatName=@"other@chatroom";Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"contradictory specified group wins routing and cannot be overridden by the ingress session");

    NSString *body=@"<pat><fromusername>friend</fromusername><chatusername>room@chatroom</chatusername><pattedusername>me</pattedusername><template>原生拍动文案</template></pat>";
    NSString *templateTag=@"<template><![CDATA[原生拍动文案]]></template>";
    NSArray *invalidXML=@[
        [NSString stringWithFormat:@"<msg type=\"pat\">%@</msg>",body],
        [NSString stringWithFormat:@"<sysmsg type=\"revoke\">%@</sysmsg>",body],
        [NSString stringWithFormat:@"<sysmsg>%@</sysmsg>",body],
        [NSString stringWithFormat:@"<sysmsg type=\"pat\"><quoted>%@</quoted></sysmsg>",body],
        [NSString stringWithFormat:@"<sysmsg xmlns=\"urn:unrelated\" type=\"pat\">%@</sysmsg>",body],
        [NSString stringWithFormat:@"<x:sysmsg xmlns:x=\"urn:unrelated\" type=\"pat\">%@</x:sysmsg>",body],
        @"<sysmsg type=\"pat\" xmlns:x=\"urn:unrelated\"><pat><x:fromusername>friend</x:fromusername><chatusername>room@chatroom</chatusername><pattedusername>me</pattedusername><template>原生拍动文案</template></pat></sysmsg>",
        [NSString stringWithFormat:@"<!DOCTYPE sysmsg [<!ENTITY identity SYSTEM 'file:///etc/passwd'>]><sysmsg type=\"pat\">%@</sysmsg>",body],
        @"<!DOCTYPE sysmsg [<!ENTITY identity 'friend'>]><sysmsg type=\"pat\"><pat><fromusername>&identity;</fromusername><chatusername>room@chatroom</chatusername><pattedusername>me</pattedusername><template>原生拍动文案</template></pat></sysmsg>",
        [NSString stringWithFormat:@"<sysmsg type=\"pat\">%@%@</sysmsg>",body,body],
        @"<sysmsg type=\"pat\"><pat><fromusername>friend</fromusername><fromusername>friend</fromusername><chatusername>room@chatroom</chatusername><pattedusername>me</pattedusername><template>原生拍动文案</template></pat></sysmsg>",
        @"<sysmsg type=\"pat\"><pat><fromusername><nested>friend</nested></fromusername><chatusername>room@chatroom</chatusername><pattedusername>me</pattedusername><template>原生拍动文案</template></pat></sysmsg>",
        @"<sysmsg type=\"pat\"><pat><fromusername>friend</fromusername><chatusername>room@chatroom</chatusername><template>原生拍动文案</template></pat></sysmsg>",
        @"<sysmsg type=\"pat\"><pat><fromusername>friend</fromusername><chatusername>room@chatroom</chatusername><pattedusername>me</pattedusername><template>原生拍动文案</template></pat>",
        [original stringByReplacingOccurrencesOfString:templateTag withString:@""],
        [original stringByReplacingOccurrencesOfString:templateTag withString:@"<template/>"],
        [original stringByReplacingOccurrencesOfString:templateTag withString:@"<template> \n\t</template>"],
        [original stringByReplacingOccurrencesOfString:templateTag withString:@"<template>first</template><template>second</template>"],
        PatXML(@"friend|forged",@"room@chatroom",@"me"),PatXML(@"friend\n",@"room@chatroom",@"me"),PatXML(@"",@"room@chatroom",@"me"),
        PatXML([@"x" stringByPaddingToLength:257 withString:@"x" startingAtIndex:0],@"room@chatroom",@"me"),
        [original stringByPaddingToLength:65537 withString:@" " startingAtIndex:0]
    ];
    NSUInteger invalidIndex=0;for(NSString *xml in invalidXML){wrap=RawPat();wrap.m_nsContent=xml;Check(!CSAutomationPatFromXMLMessage(wrap,@""),[NSString stringWithFormat:@"raw XML malformed/schema/identity boundary %lu rejects",(unsigned long)++invalidIndex]);}
    for(NSNumber *type in @[@1,@49,@10000]){wrap=RawPat();wrap.m_uiMessageType=type.unsignedIntValue;Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"only the raw system-message type can enter the XML pat parser");}
    for(NSNumber *identity in @[@0,@(-1)]){wrap=RawPat();wrap.m_n64MesSvrID=identity.longLongValue;Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"raw pat needs a positive native server ID");}
    wrap=RawPat();wrap.m_uiCreateTime=0;Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"raw pat needs a nonzero native creation time");
    wrap=RawPat();wrap.m_nsFromUsr=nil;Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"raw pat needs an outer sender");
    wrap=RawPat();wrap.m_nsToUsr=nil;Check(!CSAutomationPatFromXMLMessage(wrap,@""),@"raw pat needs an outer recipient");
    id missingRaw=nil;Check(!CSAutomationPatFromXMLMessage(missingRaw,@"") && !CSAutomationPatFromXMLMessage(RawPat(),(id)@7),@"invalid raw envelope and non-string ingress session fail closed");
    Check(!CSAutomationPatFromXMLMessage(RawPatOfClass(AutoThrowingPatXML.class),@""),@"unavailable native getter exceptions cannot escape raw normalization");
    NSArray *wrongABI=@[@[@"AutoRawPatWideType",@"m_uiMessageType",@"Q16@0:8"],@[@"AutoRawPatUnsignedID",@"m_n64MesSvrID",@"Q16@0:8"],@[@"AutoRawPatWideTime",@"m_uiCreateTime",@"Q16@0:8"],@[@"AutoRawPatScalarContent",@"m_nsContent",@"I16@0:8"]];
    for(NSArray *spec in wrongABI){Class cls=objc_allocateClassPair(AutoWrap.class,[spec[0] UTF8String],0);Method method=class_getInstanceMethod(AutoWrap.class,NSSelectorFromString(spec[1]));Check(cls && method && class_addMethod(cls,NSSelectorFromString(spec[1]),method_getImplementation(method),[spec[2] UTF8String]),@"register isolated native getter ABI mismatch");objc_registerClassPair(cls);Check(!CSAutomationPatFromXMLMessage(RawPatOfClass(cls),@""),@"raw pat parser rejects an incompatible native getter ABI");}
    printf("Raw pat XML: real parser and event adapter cover schema, native identity/time, immutable snapshot, account/conversation links and failure boundaries\n");
}
static NSMutableDictionary *Config(void){return [NSPropertyListSerialization propertyListWithData:[NSPropertyListSerialization dataWithPropertyList:CSAutomationDefaultConfiguration() format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL] options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];}
static void TestPatEventBoundaries(void){
    AutoWrap *wrap=RawPat();
    NSDictionary *parsed=CSAutomationPatFromXMLMessage(wrap,@"room@chatroom");
    Check([parsed[@"conversation"] isEqual:@"room@chatroom"],@"raw pat normalizes to the expected conversation");
    NSDictionary *event=CSAutomationEventFromPat(parsed[@"pat"],@"me",parsed[@"conversation"]);
    Check([event[@"identifiers"] isEqual:@[@"me|room@chatroom|pat:9223372036854775684"]] && [event[@"created"] doubleValue]==wrap.m_uiCreateTime,@"normalized pat retains the exact durable identity and native creation time");
    wrap.m_nsContent=@"PRIVATE_XML_BODY_SENTINEL";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"malformed XML cannot produce a pat");
    wrap=RawPat();wrap.m_nsToUsr=@"PRIVATE_ACCOUNT_SENTINEL";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"envelope target mismatch cannot produce a pat");
    Check(!CSAutomationPatFromXMLMessage(RawPatOfClass(AutoThrowingPatXML.class),@""),@"unavailable native getters are contained and cannot produce a pat");
    AutoPat *pat=[AutoPat new];pat.fromUserName=@"friend";pat.pattedUserName=@"PRIVATE_OTHER_TARGET_SENTINEL";pat.serverId=42;pat.createTime=100123;
    Check(!CSAutomationEventFromPat(pat,@"me",@"room@chatroom"),@"native pat for another target cannot produce an event");
    pat.pattedUserName=@"me";pat.serverId=-1;
    Check(!CSAutomationEventFromPat(pat,@"me",@"room@chatroom"),@"negative native pat identity cannot produce an event");
    Check([CSAutomationEventFromPat(parsed[@"pat"],@"me",parsed[@"conversation"])[@"identifiers"] isEqual:event[@"identifiers"]],@"a later valid pat retains its identity after previous inputs were rejected");
}
static void TestXMLParserBoundaries(void){
    NSString *base=RawPat().m_nsContent,*template=@"<template><![CDATA[原生拍动文案]]></template>";
    NSMutableString *deep=[NSMutableString string];
    for(NSUInteger index=0;index<16;index++)[deep appendString:@"<extension>"];
    for(NSUInteger index=0;index<16;index++)[deep appendString:@"</extension>"];
    NSString *nul=[[NSString alloc]initWithBytes:"\0" length:1 encoding:NSUTF8StringEncoding];
    NSArray *cases=@[
        @[@"truncated XML",@"<sysmsg type=\"pat\"><pat>PRIVATE_XML_SYNTAX_SENTINEL"],
        @[@"trailing NUL",[base stringByAppendingString:nul]],
        @[@"namespace",[base stringByReplacingOccurrencesOfString:@"type=\"pat\"" withString:@"type=\"pat\" xmlns=\"urn:fixture\""]],
        @[@"missing root type",[base stringByReplacingOccurrencesOfString:@" type=\"pat\"" withString:@""]],
        @[@"wrong root",@"<other type=\"pat\"><pat/></other>"],
        @[@"duplicate pat",[base stringByReplacingOccurrencesOfString:@"</sysmsg>" withString:@"<pat/></sysmsg>"]],
        @[@"duplicate identity",[base stringByReplacingOccurrencesOfString:@"</fromusername>" withString:@"</fromusername><fromusername>PRIVATE_DUPLICATE_SENTINEL</fromusername>"]],
        @[@"nested identity",[base stringByReplacingOccurrencesOfString:@"<fromusername><![CDATA[friend]]></fromusername>" withString:@"<fromusername>friend<nested/></fromusername>"]],
        @[@"nested template",[base stringByReplacingOccurrencesOfString:template withString:@"<template>wording<span>decoration</span></template>"]],
        @[@"excessive depth",[base stringByReplacingOccurrencesOfString:@"</pat>" withString:[deep stringByAppendingString:@"</pat>"]]],
        @[@"oversized identity",PatXML([@"x" stringByPaddingToLength:257 withString:@"x" startingAtIndex:0],@"room@chatroom",@"me")],
        @[@"oversized template",[base stringByReplacingOccurrencesOfString:template withString:[NSString stringWithFormat:@"<template>%@</template>",[@"x" stringByPaddingToLength:12001 withString:@"x" startingAtIndex:0]]]],
        @[@"missing pat",@"<sysmsg type=\"pat\"><extension/></sysmsg>"]
    ];
    for(NSArray *spec in cases){
        AutoWrap *wrap=RawPat();wrap.m_nsContent=spec[1];
        Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),[NSString stringWithFormat:@"XML %@ cannot produce a pat",spec[0]]);
    }
    NSArray *accepted=@[
        [@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>" stringByAppendingString:base],
        [base stringByReplacingOccurrencesOfString:@"type=\"pat\"" withString:@"type=\"pat\" xmlns=\"\""],
        [base stringByReplacingOccurrencesOfString:@"</pat>" withString:@"<!--comment--><extension><nested>ok</nested></extension></pat>"],
        [base stringByReplacingOccurrencesOfString:template withString:@"<template>before<![CDATA[middle]]>after</template>"]
    ];
    for(NSString *content in accepted){AutoWrap *wrap=RawPat();wrap.m_nsContent=content;
        NSDictionary *event=RawPatEvent(wrap,@"room@chatroom",@"me");
        Check([event[@"identifiers"] isEqual:@[@"me|room@chatroom|pat:9223372036854775684"]] && [event[@"sender"] isEqual:@"friend"] && [event[@"created"] doubleValue]==wrap.m_uiCreateTime,@"valid XML forms preserve the account, sender, durable identity and creation time");}
}
static void TestXMLInputBoundaries(void){
    AutoWrap *wrap=RawPat();
    NSDictionary *event=RawPatEvent(wrap,@"room@chatroom",@"me");
    Check([event[@"account"] isEqual:@"me"] && [event[@"conversation"] isEqual:@"room@chatroom"] && [event[@"sender"] isEqual:@"friend"] && [event[@"identifiers"] isEqual:@[@"me|room@chatroom|pat:9223372036854775684"]],@"complete native XML produces the exact account-bound pat event");
    wrap.m_nsContent=@"PRIVATE_NICKNAME_SYNTAX_SENTINEL";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"plain malformed body cannot produce a pat");
    wrap.m_nsContent=@"<sysmsg type=\"pat\"><pat><fromusername>PRIVATE_ACCOUNT_SENTINEL";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"truncated typed pat cannot produce an event");
    wrap.m_nsContent=@"<PRIVATE_ROOT_ACCOUNT type=\"pat\"><pat/></PRIVATE_ROOT_ACCOUNT>";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"an arbitrary root cannot produce a pat");
    wrap.m_nsContent=@"<sysmsg type=\"PRIVATE_TYPE_VALUE\"><pat/></sysmsg>";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"unexpected system type cannot produce a pat");
    wrap.m_nsContent=@"<sysmsg><pat/></sysmsg>";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"missing system type cannot produce a pat");
    wrap.m_nsContent=@"<PRIVATE_PREFIX:sysmsg xmlns:PRIVATE_PREFIX=\"urn:PRIVATE_NAMESPACE\" type=\"pat\"><pat/></PRIVATE_PREFIX:sysmsg>";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"a namespaced root cannot produce a pat");
    wrap.m_nsContent=@"<xml:sysmsg type=\"pat\"><pat/></xml:sysmsg>";
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"the reserved XML namespace root cannot produce a pat");
    NSString *base=RawPat().m_nsContent;unichar zero=0;
    wrap.m_nsContent=[base stringByAppendingString:[NSString stringWithCharacters:&zero length:1]];
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"a trailing NUL invalidates the XML event");
    wrap.m_nsContent=[@"PRIVATE_SENDER_PREFIX:\n" stringByAppendingString:base];
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"a group sender prefix that contradicts XML cannot produce a pat");
    wrap.m_nsContent=[base stringByPaddingToLength:65537 withString:@" " startingAtIndex:0];
    Check(!CSAutomationPatFromXMLMessage(wrap,@"room@chatroom"),@"oversized XML body cannot produce a pat");
    id absentWrap=nil;
    Check(!CSAutomationPatFromXMLMessage(absentWrap,@"room@chatroom"),@"an absent native wrap cannot produce a pat");
}
static NSDictionary *Event(BOOL own,BOOL mention){return @{@"conversation":@"room@chatroom",@"sender":own?@"me":@"friend",@"text":@"hello",@"own":@(own),@"mentioned":@(mention),@"group":@YES};}
static BOOL ModeIs(NSURL *url,mode_t mode){struct stat metadata;return lstat(url.fileSystemRepresentation,&metadata)==0 && (metadata.st_mode&07777)==mode;}
int main(int argc,const char **argv){@autoreleasepool{
    Check(argc==2,@"isolated root argument");NSURL *root=[NSURL fileURLWithPath:@(argv[1])];
    TestRawPatXML();TestPatEventBoundaries();TestXMLParserBoundaries();TestXMLInputBoundaries();
    NSMutableDictionary *c=Config();Check(CSAutomationValidateConfiguration(c),@"valid default configuration");
    Check(c[@"mentionReply"][@"friends"]==nil && [c[@"mentionReply"] count]==5,@"mention reply canonical configuration has groups only");
    for(NSString *name in @[@"patBack",@"patReply",@"mentionReply",@"keywordReply"]){Check(![c[name][@"enabled"] boolValue],@"modules default disabled");NSMutableDictionary *bad=Config();bad[name][@"delay"]=@301;Check(!CSAutomationValidateConfiguration(bad),@"delay range");bad[name][@"delay"]=@1.5;Check(!CSAutomationValidateConfiguration(bad),@"fractional delay");bad[name][@"delay"]=@0;Check(CSAutomationValidateConfiguration(bad),@"zero delay");bad[name][@"friends"]=@[@"room@chatroom"];Check(!CSAutomationValidateConfiguration(bad),@"separate friends/groups");}
    c[@"keywordReply"][@"rules"]=@[@{@"id":NSUUID.UUID.UUIDString,@"keyword":@"hello",@"match":@"exact",@"contents":@[@"world"]}];
    NSDictionary *goodRule=c[@"keywordReply"][@"rules"][0];
    NSMutableDictionary *bad=Config();bad[@"keywordReply"][@"rules"]=@[[goodRule mutableCopy]];bad[@"keywordReply"][@"rules"][0][@"keyword"]=@" \n";Check(!CSAutomationValidateConfiguration(bad),@"blank keyword rejected");
    bad=Config();bad[@"patReply"][@"contents"]=@[@" "];Check(!CSAutomationValidateConfiguration(bad),@"blank content rejected");
    bad=Config();bad[@"patReply"][@"contents"]=[@"x" stringByPaddingToLength:4001 withString:@"x" startingAtIndex:0];Check(!CSAutomationValidateConfiguration(bad),@"contents must be array");
    Check(!CSAutomationDecisions(c,Event(NO,YES),NO).count,@"off by default");
    c[@"keywordReply"][@"enabled"]=@YES;c[@"keywordReply"][@"groups"]=@[@"room@chatroom"];
    Check([CSAutomationDecisions(c,Event(NO,NO),NO).firstObject[@"ruleID"] isEqual:goodRule[@"id"]],@"per keyword reply decision");
    Check(!CSAutomationDecisions(c,Event(YES,NO),NO).count,@"own default off");c[@"keywordReply"][@"own"]=@YES;c[@"keywordReply"][@"others"]=@NO;
    Check(CSAutomationDecisions(c,Event(YES,NO),NO).count==1 && !CSAutomationDecisions(c,Event(NO,NO),NO).count,@"own/others independent");
    c[@"keywordReply"][@"others"]=@YES;c[@"mentionReply"][@"enabled"]=@YES;c[@"mentionReply"][@"groups"]=@[@"room@chatroom"];c[@"mentionReply"][@"contents"]=@[@"mention"];
    Check([CSAutomationDecisions(c,Event(NO,YES),NO).firstObject[@"module"] isEqual:@"mentionReply"],@"mention priority");Check([CSAutomationDecisions(c,Event(NO,NO),NO).firstObject[@"module"] isEqual:@"keywordReply"],@"no real mention falls through");
    NSMutableDictionary *legacy=Config();legacy[@"mentionReply"][@"enabled"]=@YES;legacy[@"mentionReply"][@"friends"]=@[@"friend"];legacy[@"mentionReply"][@"groups"]=@[@"room@chatroom"];legacy[@"mentionReply"][@"contents"]=@[@"保留群回复"];legacy[@"mentionReply"][@"delay"]=@9;
    Check(CSAutomationValidateConfiguration(legacy),@"valid 2.5-1 mention friends field remains importable");
    NSDictionary *normalized=CSAutomationNormalizeConfiguration(legacy);Check(normalized[@"mentionReply"][@"friends"]==nil && [normalized[@"mentionReply"][@"groups"] isEqual:legacy[@"mentionReply"][@"groups"]] && [normalized[@"mentionReply"][@"contents"] isEqual:legacy[@"mentionReply"][@"contents"]] && [normalized[@"mentionReply"][@"delay"] isEqual:@9],@"legacy normalization removes only mention friends and preserves group settings");
    for(NSString *module in @[@"patBack",@"patReply",@"keywordReply"])Check([normalized[module] isEqual:legacy[module]],@"legacy normalization preserves every other module");
    Check([legacy[@"mentionReply"][@"friends"] isEqual:@[@"friend"]],@"normalization leaves imported source unchanged");
    NSDictionary *privateMention=@{@"conversation":@"friend",@"sender":@"friend",@"own":@NO,@"group":@NO,@"mentioned":@YES,@"text":@"hello"};
    Check(!CSAutomationDecisions(legacy,privateMention,NO).count,@"legacy private mention selection never creates a reply");
    Check([CSAutomationDecisions(legacy,Event(NO,YES),NO).firstObject[@"module"] isEqual:@"mentionReply"],@"legacy groups still reply to native mention");
    NSMutableDictionary *unknown=Config();unknown[@"mentionReply"][@"unsupported"]=@[];Check(!CSAutomationNormalizeConfiguration(unknown),@"unknown field is not mistaken for a legacy friends field");
    NSMutableDictionary *rule=[goodRule mutableCopy];rule[@"id"]=NSUUID.UUID.UUIDString;rule[@"keyword"]=@"he";rule[@"match"]=@"prefix";c[@"keywordReply"][@"rules"]=@[rule,goodRule];Check([CSAutomationDecisions(c,Event(NO,NO),NO).firstObject[@"ruleID"] isEqual:rule[@"id"]],@"first matching rule");
    rule[@"keyword"]=@"ell";rule[@"match"]=@"contains";Check(CSAutomationDecisions(c,Event(NO,NO),NO).count==1,@"contains matching");rule[@"match"]=@"exact";c[@"keywordReply"][@"rules"]=@[rule];Check(!CSAutomationDecisions(c,Event(NO,NO),NO).count,@"exact does not trim or fuzzy match");
    for(NSString *name in @[@"patBack",@"patReply"]){c[name][@"enabled"]=@YES;c[name][@"groups"]=@[@"room@chatroom"];}c[@"patReply"][@"contents"]=@[@"pat"];
    Check(CSAutomationDecisions(c,Event(NO,NO),YES).count==2,@"pat back and text independent");Check(!CSAutomationDecisions(c,Event(YES,NO),YES).count,@"self pat excluded");
    NSURL *url=CSAutomationFileURL(root,@"me");NSDictionary *state=@{@"schema":@1,@"account":@"me",@"configuration":c};NSError *error=nil;
    Check(CSAutomationWriteState(state,url,@"me",&error) && !error,@"durable config write");Check([CSAutomationReadState(url,@"me",&error) isEqual:state],@"read back exact configuration");Check(!CSAutomationReadState(url,@"other",&error) && error,@"wrong account rejected");Check(![CSAutomationFileURL(root,@"other") isEqual:url],@"account paths isolated");
    Check(ModeIs(url,0600) && ModeIs(url.URLByDeletingLastPathComponent,0700) && ModeIs([NSURL fileURLWithPath:[url.path stringByAppendingString:@".lock"]],0600),@"automation files and lock are private; directory is owner only");
    NSURL *legacyURL=CSAutomationFileURL(root,@"legacy");NSDictionary *legacyState=@{@"schema":@1,@"account":@"legacy",@"configuration":legacy};NSData *legacyBytes=[NSPropertyListSerialization dataWithPropertyList:legacyState format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL];
    Check([legacyBytes writeToURL:legacyURL atomically:YES],@"write raw pre-upgrade account fixture");chmod(legacyURL.fileSystemRepresentation,0644);chmod(legacyURL.URLByDeletingLastPathComponent.fileSystemRepresentation,0755);
    NSDictionary *migrated=CSAutomationReadState(legacyURL,@"legacy",&error);Check([migrated[@"configuration"] isEqual:normalized] && [[NSData dataWithContentsOfURL:legacyURL] isEqual:legacyBytes],@"read normalizes old configuration without rewriting its bytes");
    Check(ModeIs(legacyURL,0600) && ModeIs(legacyURL.URLByDeletingLastPathComponent,0700),@"existing automation file and directory permissions upgrade in place");
    Check(CSAutomationWriteState(legacyState,legacyURL,@"legacy",&error),@"saving a valid legacy configuration succeeds");NSDictionary *written=[NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfURL:legacyURL] options:NSPropertyListImmutable format:NULL error:&error];Check([written[@"configuration"] isEqual:normalized] && written[@"configuration"][@"mentionReply"][@"friends"]==nil,@"new persistent state omits retired private selection");
    NSData *corrupt=[@"broken" dataUsingEncoding:NSUTF8StringEncoding];[corrupt writeToURL:url atomically:YES];error=nil;Check(!CSAutomationWriteState(state,url,@"me",&error) && error,@"corrupt config not overwritten");Check([[NSData dataWithContentsOfURL:url] isEqual:corrupt],@"corrupt bytes preserved");
    NSURL *ledgerURL=[root URLByAppendingPathComponent:@"ledger.plist"];CSAutomationLedger *ledger=[[CSAutomationLedger alloc]initWithURL:ledgerURL account:@"me" error:&error];NSDate *now=NSDate.date;
    Check([ledger claimIdentifiers:@[@"me|friend|l:1:10"] action:@"text" now:now error:&error],@"first action durable claim");
    error=nil;Check(![ledger claimIdentifiers:@[@"me|friend|l:1:10",@"me|friend|s:100"] action:@"text" now:now error:&error] && !error,@"local/server aliases merge as duplicate");
    ledger=[[CSAutomationLedger alloc]initWithURL:ledgerURL account:@"me" error:&error];Check([ledger hasIdentifiers:@[@"me|friend|s:100"] action:@"text"],@"dedup survives reconstructed wrapper and restart");
    Check([ledger claimIdentifiers:@[@"me|friend|s:100"] action:@"patBack" now:now error:&error],@"separate pat action");Check(![ledger claimIdentifiers:@[@"other|friend|s:100"] action:@"text" now:now error:&error],@"foreign account identity rejected");
    Check([ledger claimIdentifiers:@[@"me|friend|s:200"] action:@"text" now:now error:&error],@"second identity");Check(![ledger claimIdentifiers:@[@"me|friend|s:100",@"me|friend|s:200",@"me|friend|s:300"] action:@"text" now:now error:&error],@"identity bridge never creates a send");Check([ledger hasIdentifiers:@[@"me|friend|s:300"] action:@"text"],@"bridge alias retained");
    NSString *ledgerLock=[ledgerURL.path stringByAppendingString:@".lock"];int held=open(ledgerLock.fileSystemRepresentation,O_RDWR);Check(held>=0 && flock(held,LOCK_EX|LOCK_NB)==0,@"hold a real ledger lock");NSData *beforeClaim=[NSData dataWithContentsOfURL:ledgerURL];error=nil;
    Check(![ledger claimIdentifiers:@[@"me|friend|s:350"] action:@"text" now:now error:&error] && CSAutomationStorageErrorIsRetryable(error) && [error.userInfo[@"operation"] isEqual:@"flock"] && [error.userInfo[@"errno"] intValue]==EWOULDBLOCK,@"contended durable claim reports retryable real I/O with errno");
    Check([[NSData dataWithContentsOfURL:ledgerURL] isEqual:beforeClaim] && ![ledger hasIdentifiers:@[@"me|friend|s:350"] action:@"text"],@"failed claim leaves disk and memory ownership unchanged");flock(held,LOCK_UN);close(held);
    Check([ledger claimIdentifiers:@[@"me|friend|s:350"] action:@"text" now:now error:&error],@"same admission can claim after transient lock contention ends");
    [corrupt writeToURL:ledgerURL atomically:YES];error=nil;Check(![ledger claimIdentifiers:@[@"me|friend|s:400"] action:@"text" now:now error:&error] && error && !CSAutomationStorageErrorIsRetryable(error),@"corrupt ledger fails closed as permanent format error");Check([[NSData dataWithContentsOfURL:ledgerURL] isEqual:corrupt],@"runtime corruption preserved");
    AutoWrap *wrap=[AutoWrap new];wrap.m_nsFromUsr=@"room@chatroom";wrap.m_nsToUsr=@"me";wrap.m_nsRealChatUsr=@"friend";wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=5;wrap.m_uiCreateTime=100;wrap.m_nsContent=@"friend:\n hello ";
    NSDictionary *event=CSAutomationEventFromWrap(wrap,@"me",@"room@chatroom");Check([event[@"text"] isEqual:@" hello "],@"preserve exact match whitespace");Check(![event[@"mentioned"] boolValue],@"visible @ prose not a real mention");
    wrap.m_nsMsgSource=@"<msgsource><atuserlist><![CDATA[me,notify@all]]></atuserlist></msgsource>";Check([CSAutomationEventFromWrap(wrap,@"me",@"")[@"mentioned"] boolValue],@"native XML real mention");wrap.m_nsAtUserList=@"notify@all";Check(![CSAutomationEventFromWrap(wrap,@"me",@"")[@"mentioned"] boolValue],@"at all alone excluded");
    Check(!CSAutomationEventFromWrap(wrap,@"me",@"else"),@"session mismatch");wrap.m_uiMessageType=49;wrap.m_nsContent=@"<msg><appmsg><title>reply body</title><type>57</type><refermsg><title>old text</title></refermsg></appmsg></msg>";Check([CSAutomationEventFromWrap(wrap,@"me",@"")[@"text"] isEqual:@"reply body"],@"quote body excludes cited content");
    wrap.m_nsContent=@"<!DOCTYPE msg [<!ENTITY x SYSTEM 'file:///etc/passwd'>]><msg><appmsg><title>&x;</title><type>57</type></appmsg></msg>";Check(!CSAutomationEventFromWrap(wrap,@"me",@""),@"external entities rejected");CSAutomationMarkOwnedSend(wrap);Check(!CSAutomationEventFromWrap(wrap,@"me",@""),@"plugin outbound object excluded");
    AutoPat *pat=[AutoPat new];pat.fromUserName=@"friend";pat.pattedUserName=@"me";pat.createTime=100123;pat.serverId=42;event=CSAutomationEventFromPat(pat,@"me",@"friend");Check(fabs([event[@"created"] doubleValue]-100.123)<0.001,@"pat timestamp milliseconds");Check([event[@"identifiers"][0] hasSuffix:@"pat:42"],@"individual pat server identity");pat.serverId=-1;Check(!CSAutomationEventFromPat(pat,@"me",@"friend"),@"negative pat ID rejected");pat.serverId=42;pat.pattedUserName=@"other";Check(!CSAutomationEventFromPat(pat,@"me",@"friend"),@"other person patting another person cannot target me");pat.fromUserName=@"me";pat.pattedUserName=@"me";Check(!CSAutomationEventFromPat(pat,@"me",@"room@chatroom"),@"self patting self cannot create an automatic pat action");
    AutoWrap *nested=[AutoWrap new];nested.m_nsFromUsr=@"room@chatroom";nested.m_nsToUsr=@"me";nested.m_nsRealChatUsr=@"friend";nested.m_uiMessageType=49;nested.m_uiMesLocalID=8;nested.m_uiCreateTime=100;nested.m_nsContent=@"<msg><appmsg><title>own reply</title><type>57</type><refermsg><appmsg><title>old keyword</title></appmsg></refermsg></appmsg></msg>";nested.m_nsMsgSource=@"<msgsource><extension><atuserlist>me</atuserlist></extension></msgsource>";
    NSDictionary *nestedEvent=CSAutomationEventFromWrap(nested,@"me",@"");Check([nestedEvent[@"text"] isEqual:@"own reply"],@"nested quoted appmsg cannot enter own body");Check(![nestedEvent[@"mentioned"] boolValue],@"extension atuserlist is not native mention metadata");
    AutoWrap *out=[AutoWrap new];out.m_nsFromUsr=@"me";out.m_nsToUsr=@"friend";out.m_uiMessageType=1;out.m_uiMesLocalID=6;out.m_uiCreateTime=200;out.m_nsContent=@"hello";
    Check(CSAutomationEventFromWrap(out,@"me",@"friend")!=nil,@"manual own messages remain eligible");CSAutomationMarkOwnedSend(out);CSAutomationRememberOwnedSend(out,@"me",@"friend");
    AutoWrap *rebuilt=[AutoWrap new];rebuilt.m_nsFromUsr=@"me";rebuilt.m_nsToUsr=@"friend";rebuilt.m_uiMessageType=1;rebuilt.m_uiMesLocalID=6;rebuilt.m_uiCreateTime=200;rebuilt.m_nsContent=@"hello";
    Check(!CSAutomationEventFromWrap(rebuilt,@"me",@"friend"),@"rebuilt own local ID stays excluded");out.m_n64MesSvrID=900;Check(!CSAutomationEventFromWrap(out,@"me",@"friend"),@"tagged late callback retains server alias");rebuilt.m_uiMesLocalID=0;rebuilt.m_n64MesSvrID=900;
    Check(!CSAutomationEventFromWrap(rebuilt,@"me",@"friend"),@"server-only rebuilt owned event excluded");
    NSURL *ownedURL=[CSAutomationFileURL(root,@"me").URLByDeletingPathExtension URLByAppendingPathExtension:@"owned.plist"];
    [corrupt writeToURL:ownedURL atomically:YES];out.m_uiMesLocalID=7;out.m_n64MesSvrID=901;CSAutomationRememberOwnedSend(out,@"me",@"friend");
    // Restore a structurally valid older file to model a failed write that
    // leaves its previous content intact. The in-memory barrier still holds.
    [[NSPropertyListSerialization dataWithPropertyList:@{@"schema":@1,@"account":@"me",@"records":@[]} format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL] writeToURL:ownedURL atomically:YES];rebuilt.m_n64MesSvrID=901;
    Check(!CSAutomationEventFromWrap(rebuilt,@"me",@"friend"),@"owned write failure blocks fresh own triggers despite valid old file");
    AutoWrap *original=[AutoWrap new];original.m_nsFromUsr=@"mine";original.m_nsToUsr=@"friend";original.m_uiMessageType=1;original.m_uiMesLocalID=30;original.m_uiCreateTime=300;original.m_nsContent=@"hello";CSAutomationMarkOwnedSend(original);CSAutomationRememberOwnedSend(original,@"mine",@"friend");
    NSURL *mineOwned=[CSAutomationFileURL(root,@"mine").URLByDeletingPathExtension URLByAppendingPathExtension:@"owned.plist"];
    NSString *mineLock=[mineOwned.path stringByAppendingString:@".lock"];int lockFD=open(mineLock.fileSystemRepresentation,O_RDWR);Check(lockFD>=0 && flock(lockFD,LOCK_EX|LOCK_NB)==0,@"hold owned write lock in isolated fixture");
    AutoWrap *late=[AutoWrap new];late.m_nsFromUsr=@"mine";late.m_nsToUsr=@"friend";late.m_uiMessageType=1;late.m_uiMesLocalID=30;late.m_uiCreateTime=300;late.m_n64MesSvrID=930;late.m_nsContent=@"hello";
    Check(!CSAutomationEventFromWrap(late,@"mine",@"friend"),@"reconstructed alias remains owned when merge lock fails");flock(lockFD,LOCK_UN);close(lockFD);late.m_uiMesLocalID=0;
    Check(!CSAutomationEventFromWrap(late,@"mine",@"friend"),@"failed alias merge blocks later server-only own trigger");
    printf("PASS: %lu automation core checks\n",(unsigned long)Checks);
}return 0;}
