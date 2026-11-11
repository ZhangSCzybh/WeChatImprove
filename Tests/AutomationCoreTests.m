#import <Foundation/Foundation.h>
#import "CSAutomationStore.h"
#import "CSAutomationEventAdapter.h"
#import "CSMessageNativeActionAdapter.h"
#import <objc/runtime.h>
#include <sys/file.h>
#include <fcntl.h>
#include <unistd.h>
static NSUInteger Checks;
static void Check(BOOL value,NSString *message){Checks++;if(!value){fprintf(stderr,"FAIL: %s\n",message.UTF8String);exit(1);}}
// These fixtures keep the production ABI helper's checked invocation contract.
BOOL CSMessageNativeSupports(id object,NSString *name,NSString *result,NSArray *arguments){NSMethodSignature *s=[object methodSignatureForSelector:NSSelectorFromString(name)];if(!s || s.numberOfArguments!=arguments.count+2)return NO;if(result.length && s.methodReturnType[0]!=[result characterAtIndex:0])return NO;return YES;}
id CSMessageNativeInvoke(id object,NSString *name,NSArray *arguments){NSMethodSignature *s=[object methodSignatureForSelector:NSSelectorFromString(name)];if(!s)return nil;NSInvocation *i=[NSInvocation invocationWithMethodSignature:s];i.target=object;i.selector=NSSelectorFromString(name);for(NSUInteger n=0;n<arguments.count;n++){id a=arguments[n];[i setArgument:&a atIndex:n+2];}[i invoke];if(s.methodReturnType[0]=='@'){__unsafe_unretained id v=nil;[i getReturnValue:&v];return v;}unsigned long long v=0;[i getReturnValue:&v];return @(v);}
id CSMessageActionNativeObject(id object,NSString *name){return CSMessageNativeSupports(object,name,@"@",@[])?CSMessageNativeInvoke(object,name,@[]):nil;}
unsigned long long CSMessageNativeUnsigned(id object,NSString *name){return [CSMessageNativeInvoke(object,name,@[]) unsignedLongLongValue];}
@interface AutoWrap:NSObject
@property NSString *m_nsFromUsr,*m_nsToUsr,*m_nsRealChatUsr,*m_nsContent,*m_nsAtUserList,*m_nsMsgSource;
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
static NSMutableDictionary *Config(void){return [NSPropertyListSerialization propertyListWithData:[NSPropertyListSerialization dataWithPropertyList:CSAutomationDefaultConfiguration() format:NSPropertyListBinaryFormat_v1_0 options:0 error:NULL] options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];}
static NSDictionary *Event(BOOL own,BOOL mention){return @{@"conversation":@"room@chatroom",@"sender":own?@"me":@"friend",@"text":@"hello",@"own":@(own),@"mentioned":@(mention),@"group":@YES};}
int main(int argc,const char **argv){@autoreleasepool{
    Check(argc==2,@"isolated root argument");NSURL *root=[NSURL fileURLWithPath:@(argv[1])];
    NSMutableDictionary *c=Config();Check(CSAutomationValidateConfiguration(c),@"valid default configuration");
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
    NSMutableDictionary *rule=[goodRule mutableCopy];rule[@"id"]=NSUUID.UUID.UUIDString;rule[@"keyword"]=@"he";rule[@"match"]=@"prefix";c[@"keywordReply"][@"rules"]=@[rule,goodRule];Check([CSAutomationDecisions(c,Event(NO,NO),NO).firstObject[@"ruleID"] isEqual:rule[@"id"]],@"first matching rule");
    rule[@"keyword"]=@"ell";rule[@"match"]=@"contains";Check(CSAutomationDecisions(c,Event(NO,NO),NO).count==1,@"contains matching");rule[@"match"]=@"exact";c[@"keywordReply"][@"rules"]=@[rule];Check(!CSAutomationDecisions(c,Event(NO,NO),NO).count,@"exact does not trim or fuzzy match");
    for(NSString *name in @[@"patBack",@"patReply"]){c[name][@"enabled"]=@YES;c[name][@"groups"]=@[@"room@chatroom"];}c[@"patReply"][@"contents"]=@[@"pat"];
    Check(CSAutomationDecisions(c,Event(NO,NO),YES).count==2,@"pat back and text independent");Check(!CSAutomationDecisions(c,Event(YES,NO),YES).count,@"self pat excluded");
    NSURL *url=CSAutomationFileURL(root,@"me");NSDictionary *state=@{@"schema":@1,@"account":@"me",@"configuration":c};NSError *error=nil;
    Check(CSAutomationWriteState(state,url,@"me",&error) && !error,@"durable config write");Check([CSAutomationReadState(url,@"me",&error) isEqual:state],@"read back exact configuration");Check(!CSAutomationReadState(url,@"other",&error) && error,@"wrong account rejected");Check(![CSAutomationFileURL(root,@"other") isEqual:url],@"account paths isolated");
    NSData *corrupt=[@"broken" dataUsingEncoding:NSUTF8StringEncoding];[corrupt writeToURL:url atomically:YES];error=nil;Check(!CSAutomationWriteState(state,url,@"me",&error) && error,@"corrupt config not overwritten");Check([[NSData dataWithContentsOfURL:url] isEqual:corrupt],@"corrupt bytes preserved");
    NSURL *ledgerURL=[root URLByAppendingPathComponent:@"ledger.plist"];CSAutomationLedger *ledger=[[CSAutomationLedger alloc]initWithURL:ledgerURL account:@"me" error:&error];NSDate *now=NSDate.date;
    Check([ledger claimIdentifiers:@[@"me|friend|l:1:10"] action:@"text" now:now error:&error],@"first action durable claim");
    error=nil;Check(![ledger claimIdentifiers:@[@"me|friend|l:1:10",@"me|friend|s:100"] action:@"text" now:now error:&error] && !error,@"local/server aliases merge as duplicate");
    ledger=[[CSAutomationLedger alloc]initWithURL:ledgerURL account:@"me" error:&error];Check([ledger hasIdentifiers:@[@"me|friend|s:100"] action:@"text"],@"dedup survives reconstructed wrapper and restart");
    Check([ledger claimIdentifiers:@[@"me|friend|s:100"] action:@"patBack" now:now error:&error],@"separate pat action");Check(![ledger claimIdentifiers:@[@"other|friend|s:100"] action:@"text" now:now error:&error],@"foreign account identity rejected");
    Check([ledger claimIdentifiers:@[@"me|friend|s:200"] action:@"text" now:now error:&error],@"second identity");Check(![ledger claimIdentifiers:@[@"me|friend|s:100",@"me|friend|s:200",@"me|friend|s:300"] action:@"text" now:now error:&error],@"identity bridge never creates a send");Check([ledger hasIdentifiers:@[@"me|friend|s:300"] action:@"text"],@"bridge alias retained");
    [corrupt writeToURL:ledgerURL atomically:YES];error=nil;Check(![ledger claimIdentifiers:@[@"me|friend|s:400"] action:@"text" now:now error:&error] && error,@"corrupt ledger fails closed");Check([[NSData dataWithContentsOfURL:ledgerURL] isEqual:corrupt],@"runtime corruption preserved");
    AutoWrap *wrap=[AutoWrap new];wrap.m_nsFromUsr=@"room@chatroom";wrap.m_nsToUsr=@"me";wrap.m_nsRealChatUsr=@"friend";wrap.m_uiMessageType=1;wrap.m_uiMesLocalID=5;wrap.m_uiCreateTime=100;wrap.m_nsContent=@"friend:\n hello ";
    NSDictionary *event=CSAutomationEventFromWrap(wrap,@"me",@"room@chatroom");Check([event[@"text"] isEqual:@" hello "],@"preserve exact match whitespace");Check(![event[@"mentioned"] boolValue],@"visible @ prose not a real mention");
    wrap.m_nsMsgSource=@"<msgsource><atuserlist><![CDATA[me,notify@all]]></atuserlist></msgsource>";Check([CSAutomationEventFromWrap(wrap,@"me",@"")[@"mentioned"] boolValue],@"native XML real mention");wrap.m_nsAtUserList=@"notify@all";Check(![CSAutomationEventFromWrap(wrap,@"me",@"")[@"mentioned"] boolValue],@"at all alone excluded");
    Check(!CSAutomationEventFromWrap(wrap,@"me",@"else"),@"session mismatch");wrap.m_uiMessageType=49;wrap.m_nsContent=@"<msg><appmsg><title>reply body</title><type>57</type><refermsg><title>old text</title></refermsg></appmsg></msg>";Check([CSAutomationEventFromWrap(wrap,@"me",@"")[@"text"] isEqual:@"reply body"],@"quote body excludes cited content");
    wrap.m_nsContent=@"<!DOCTYPE msg [<!ENTITY x SYSTEM 'file:///etc/passwd'>]><msg><appmsg><title>&x;</title><type>57</type></appmsg></msg>";Check(!CSAutomationEventFromWrap(wrap,@"me",@""),@"external entities rejected");CSAutomationMarkOwnedSend(wrap);Check(!CSAutomationEventFromWrap(wrap,@"me",@""),@"plugin outbound object excluded");
    AutoPat *pat=[AutoPat new];pat.fromUserName=@"friend";pat.pattedUserName=@"me";pat.createTime=100123;pat.serverId=42;event=CSAutomationEventFromPat(pat,@"me",@"friend");Check(fabs([event[@"created"] doubleValue]-100.123)<0.001,@"pat timestamp milliseconds");Check([event[@"identifiers"][0] hasSuffix:@"pat:42"],@"individual pat server identity");pat.serverId=-1;Check(!CSAutomationEventFromPat(pat,@"me",@"friend"),@"negative pat ID rejected");pat.serverId=42;pat.pattedUserName=@"other";Check(!CSAutomationEventFromPat(pat,@"me",@"friend"),@"pat must target me");
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
