#import <Foundation/Foundation.h>
#import "CSGroupChatTemplate.h"
#import "CSGroupChatStore.h"
#import "CSGroupChatEventPolicy.h"
#include <sys/file.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

static unsigned checks,failures;
#define CHECK(value) do { checks++; if (!(value)) { failures++; fprintf(stderr,"FAIL %d: %s\n",__LINE__,#value); } } while(0)
static NSString *const Account=@"wxid_fixture_alice";
static NSString *const OtherAccount=@"wxid_fixture_bob";
static NSString *const Room=@"90001@chatroom";
static NSDictionary *Snapshot(NSArray *members,NSUInteger version,NSDate *observed,BOOL active) {
    return @{@"roomID":Room,@"version":@(version),@"members":members,@"observedAt":observed,@"active":@(active),@"joinTimes":@{}};
}
static NSDictionary *Change(NSDictionary *source,NSString *key,id value) {
    NSMutableDictionary *result=[source mutableCopy];result[key]=value;return result;
}
static BOOL ListEqual(id actual,NSArray *expected) {return [actual isKindOfClass:NSArray.class] && [actual isEqual:expected];}

static void TestTemplates(void) {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:1700000000];
    CHECK([CSGroupChatDefaultWelcome() isEqual:@"欢迎@昵称加入@群昵称"]);
    CHECK([CSGroupChatDefaultDeparture() containsString:@"@昵称 退出了群聊"]);
    CHECK([CSGroupChatEscapeXML(@"<>&\"'") isEqual:@"&lt;&gt;&amp;&quot;&apos;"]);
    CHECK([CSGroupChatEscapeXML(@"&lt;") isEqual:@"&amp;lt;"]);
    NSDictionary *values=@{@"@昵称":@"名字含@时间和@群昵称",@"@时间":@"TIME",@"@群昵称":@"群名含@昵称",@"@群人数":@"42"};
    CHECK([CSGroupChatRenderTemplate(@"@昵称|@群昵称|@时间|@群人数",values) isEqual:@"名字含@时间和@群昵称|群名含@昵称|TIME|42"]);
    CHECK([CSGroupChatRenderTemplate(@"普通@文本 @未知 @昵称",@{}) isEqual:@"普通@文本 @未知 @昵称"]);
    CHECK([CSGroupChatRenderTemplate(@"@昵称/@昵称",@{@"@昵称":@"$1\\literal"}) isEqual:@"$1\\literal/$1\\literal"]);
    NSDictionary *welcome=CSGroupChatWelcomeText(@"欢迎@昵称加入@群昵称（@群人数）",@[@"wxid_one",@"wxid_two",@"wxid_one",@"notify@all",@""],@{@"wxid_one":@"同名",@"wxid_two":@"同名"},@"测试群",3,date);
    CHECK(ListEqual(welcome[@"mentions"],(@[@"wxid_one",@"wxid_two"])));
    CHECK([welcome[@"text"] isEqual:@"欢迎@同名\u2005 @同名\u2005加入测试群（3）"]);
    NSDictionary *plain=CSGroupChatWelcomeText(@"欢迎加入@群昵称",@[@"wxid_one"],@{},@"测试群",2,date);
    CHECK(ListEqual(plain[@"mentions"],@[]));
    CHECK([plain[@"text"] isEqual:@"欢迎加入测试群"]);
    NSDictionary *repeated=CSGroupChatWelcomeText(@"@昵称 / @昵称",@[@"wxid_one"],@{},Room,2,date);
    CHECK(ListEqual(repeated[@"mentions"],(@[@"wxid_one"])));
    CHECK([repeated[@"text"] isEqual:@"@wxid_one\u2005 / @wxid_one\u2005"]);
    NSDictionary *sanitized=CSGroupChatWelcomeText(@"@昵称",@[@"wxid_one"],@{@"wxid_one":@"一\r\n二\u2005三@时间"},Room,2,date);
    CHECK([sanitized[@"text"] isEqual:@"@一  二 三@时间\u2005"]);
    CHECK(ListEqual(sanitized[@"mentions"],(@[@"wxid_one"])));
    CHECK(CSGroupChatDateText(date).length==19);
}

static void TestMemberPolicy(void) {
    NSDate *now=[NSDate dateWithTimeIntervalSince1970:1700000000];
    CHECK(CSGroupChatValidMemberID(Account));
    CHECK(!CSGroupChatValidMemberID(@"notify@all"));
    CHECK(!CSGroupChatValidMemberID(Room));
    CHECK(!CSGroupChatValidMemberID(@"bad\nname"));
    CHECK(!CSGroupChatValidMemberID(@42));
    CHECK(CSGroupChatValidatedMembers((@[Account,@"wxid_a"]),2).count==2);
    CHECK(!CSGroupChatValidatedMembers((@[Account,@"wxid_a"]),3));
    CHECK(!CSGroupChatValidatedMembers((@[Account,Account]),2));
    CHECK(!CSGroupChatValidatedMembers(@[],0));
    CHECK(!CSGroupChatValidatedMembers((@[Account,@42]),2));
    NSDictionary *v1=Snapshot(@[Account,@"wxid_a"],10,[now dateByAddingTimeInterval:-10],YES);
    NSDictionary *initial=CSGroupChatMemberDelta(nil,v1,Account);
    CHECK([initial[@"baseline"] boolValue]);CHECK(ListEqual(initial[@"joined"],@[]));CHECK(ListEqual(initial[@"left"],@[]));
    NSDictionary *same=CSGroupChatMemberDelta(v1,Change(v1,@"members",(@[@"wxid_a",Account])),Account);
    CHECK(ListEqual(same[@"joined"],@[]));CHECK(ListEqual(same[@"left"],@[]));
    NSDictionary *v2=Snapshot(@[Account,@"wxid_b"],11,now,YES);
    NSDictionary *delta=CSGroupChatMemberDelta(v1,v2,Account);
    CHECK(ListEqual(delta[@"joined"],(@[@"wxid_b"])));CHECK(ListEqual(delta[@"left"],(@[@"wxid_a"])));
    NSDictionary *duplicate=CSGroupChatMemberDelta(v2,v2,Account);
    CHECK(ListEqual(duplicate[@"joined"],@[]));CHECK(ListEqual(duplicate[@"left"],@[]));
    CHECK(!CSGroupChatMemberDelta(v2,v1,Account));
    CHECK(!CSGroupChatMemberDelta(v1,Change(v1,@"members",(@[Account,@"wxid_other"])),Account));
    CHECK(!CSGroupChatMemberDelta(v1,Change(v2,@"members",(@[Account,Account])),Account));
    CHECK(!CSGroupChatMemberDelta(v1,Change(v2,@"members",@[]),Account));
    CHECK(!CSGroupChatMemberDelta(v1,Change(v2,@"roomID",@"other@chatroom"),Account));
    // A stale response that lacks self must not invalidate a newer baseline.
    CHECK(!CSGroupChatMemberDelta(v1,Snapshot(@[@"wxid_a"],9,now,YES),Account));
    CHECK(!CSGroupChatMemberDelta(v1,Change(Snapshot(@[@"wxid_a"],11,now,YES),@"roomID",@"other@chatroom"),Account));
    NSDictionary *removed=CSGroupChatMemberDelta(v1,Snapshot(@[@"wxid_a"],11,now,YES),Account);
    CHECK([removed[@"invalidate"] boolValue]);CHECK(ListEqual(removed[@"left"],@[]));
    CHECK([CSGroupChatMemberDelta(v1,Change(v2,@"unavailable",@YES),Account)[@"invalidate"] boolValue]);
    NSDictionary *reentry=Snapshot(@[Account,@"wxid_a",@"wxid_b"],12,now,YES);
    CHECK(ListEqual(CSGroupChatMemberDelta(v2,reentry,Account)[@"joined"],(@[@"wxid_a"])));
    CHECK(ListEqual(CSGroupChatMemberDelta(reentry,Snapshot(@[Account,@"wxid_b"],13,now,YES),Account)[@"left"],(@[@"wxid_a"])));
    CHECK([CSGroupChatMemberDelta(Snapshot(@[@"wxid_a"],9,now,YES),v1,Account)[@"baseline"] boolValue]);
}

static void TestWelcomeFreshness(void) {
    NSDate *now=[NSDate dateWithTimeIntervalSince1970:1700000000];
    NSDictionary *old=Snapshot(@[Account],20,[now dateByAddingTimeInterval:-10],YES);
    NSDictionary *fresh=Snapshot(@[Account,@"wxid_new"],21,now,YES);
    CHECK(CSGroupChatMayWelcome(old,fresh,@"wxid_new",now));
    CHECK(!CSGroupChatMayWelcome(old,fresh,Account,now));
    CHECK(!CSGroupChatMayWelcome(old,fresh,@"wxid_absent",now));
    NSDictionary *noBaseline=nil;
    CHECK(!CSGroupChatMayWelcome(noBaseline,fresh,@"wxid_new",now));
    CHECK(!CSGroupChatMayWelcome(old,Change(fresh,@"active",@NO),@"wxid_new",now));
    CHECK(!CSGroupChatMayWelcome(Change(old,@"active",@NO),fresh,@"wxid_new",now));
    CHECK(CSGroupChatMayWelcome(Change(old,@"observedAt",[now dateByAddingTimeInterval:-121]),fresh,@"wxid_new",now));
    // A continuously active group can be quiet for minutes. The old baseline
    // remains useful; the newly observed complete snapshot is the fresh event.
    NSDictionary *quietBaseline=Snapshot(@[Account],20,[now dateByAddingTimeInterval:-300],YES);
    CHECK(CSGroupChatMayWelcome(quietBaseline,fresh,@"wxid_new",now));
    CHECK(!CSGroupChatMayWelcome(old,Change(fresh,@"observedAt",[now dateByAddingTimeInterval:-121]),@"wxid_new",now));
    CHECK(!CSGroupChatMayWelcome(old,Change(fresh,@"observedAt",[now dateByAddingTimeInterval:6]),@"wxid_new",now));
    CHECK(CSGroupChatMayWelcome(old,Change(fresh,@"joinTimes",@{@"wxid_new":@(now.timeIntervalSince1970-1)}),@"wxid_new",now));
    CHECK(!CSGroupChatMayWelcome(old,Change(fresh,@"joinTimes",@{@"wxid_new":@(now.timeIntervalSince1970-121)}),@"wxid_new",now));
    CHECK(!CSGroupChatMayWelcome(old,Change(fresh,@"joinTimes",@{@"wxid_new":@(now.timeIntervalSince1970+6)}),@"wxid_new",now));
    CHECK(!CSGroupChatMayWelcome(old,Change(fresh,@"joinTimes",@{@"wxid_new":@(now.timeIntervalSince1970-20)}),@"wxid_new",now));
}

static void TestStore(NSURL *root) {
    NSFileManager *fm=NSFileManager.defaultManager;NSError *error=nil;
    NSURL *first=CSGroupChatFileURL(root,Account),*second=CSGroupChatFileURL(root,OtherAccount);
    CHECK(![first isEqual:second]);CHECK([first isEqual:CSGroupChatFileURL(root,Account)]);
    CHECK(![first.lastPathComponent containsString:Account]);
    CHECK([CSGroupChatFileURL(root,@"../escape").URLByDeletingLastPathComponent isEqual:first.URLByDeletingLastPathComponent]);
    CHECK(!CSGroupChatReadState(first,Account,&error) && !error);
    NSDictionary *config=CSGroupChatDefaultConfiguration();CHECK(CSGroupChatValidateConfiguration(config));
    CHECK(!CSGroupChatValidateConfiguration(Change(config,@"unknown",@YES)));
    CHECK(!CSGroupChatValidateConfiguration(Change(config,@"welcomeDelay",@(-1))));
    CHECK(!CSGroupChatValidateConfiguration(Change(config,@"welcomeDelay",@301)));
    CHECK(!CSGroupChatValidateConfiguration(Change(config,@"welcomeDelay",@1.5)));
    CHECK(!CSGroupChatValidateConfiguration(Change(config,@"welcomeTemplate",@" \n\t")));
    CHECK(!CSGroupChatValidateConfiguration(Change(config,@"welcomeRooms",(@[Room,Room]))));
    CHECK(!CSGroupChatValidateConfiguration(Change(config,@"welcomeRooms",(@[@"not_a_room"]))));
    NSDictionary *state=@{@"schema":@1,@"account":Account,@"configuration":config};
    CHECK(CSGroupChatValidateState(state,Account,&error));
    CHECK(!CSGroupChatValidateState(state,OtherAccount,&error) && error);
    CHECK(!CSGroupChatWriteState(state,second,OtherAccount,&error) && error);
    CHECK(CSGroupChatWriteState(state,first,Account,&error) && !error);
    CHECK([CSGroupChatReadState(first,Account,&error) isEqual:state] && !error);
    NSDictionary *attrs=[fm attributesOfItemAtPath:first.path error:&error];CHECK(([attrs[NSFilePosixPermissions] unsignedIntegerValue]&0777)==0600);
    attrs=[fm attributesOfItemAtPath:first.URLByDeletingLastPathComponent.path error:&error];CHECK(([attrs[NSFilePosixPermissions] unsignedIntegerValue]&0777)==0700);
    NSData *original=[NSData dataWithContentsOfURL:first];
    CHECK([fm copyItemAtURL:first toURL:second error:&error]);
    CHECK(!CSGroupChatReadState(second,OtherAccount,&error) && error);
    CHECK([[NSData dataWithContentsOfURL:second] isEqual:original]);
    NSDictionary *otherState=Change(state,@"account",OtherAccount);
    CHECK(!CSGroupChatWriteState(otherState,second,OtherAccount,&error) && error);
    CHECK([[NSData dataWithContentsOfURL:second] isEqual:original]);
    CHECK([fm removeItemAtURL:second error:&error]);CHECK(CSGroupChatWriteState(otherState,second,OtherAccount,&error));
    NSURL *broken=CSGroupChatFileURL(root,@"wxid_fixture_corrupt");NSData *corruption=[@"corrupt-plist\x00keep-original" dataUsingEncoding:NSUTF8StringEncoding];
    CHECK([corruption writeToURL:broken options:NSDataWritingAtomic error:&error]);
    CHECK(!CSGroupChatReadState(broken,@"wxid_fixture_corrupt",&error) && error);
    CHECK([[NSData dataWithContentsOfURL:broken] isEqual:corruption]);
    CHECK(!CSGroupChatWriteState(Change(state,@"account",@"wxid_fixture_corrupt"),broken,@"wxid_fixture_corrupt",&error) && error);
    CHECK([[NSData dataWithContentsOfURL:broken] isEqual:corruption]);
    NSString *lockPath=[first.path stringByAppendingString:@".lock"];int lockfd=open(lockPath.fileSystemRepresentation,O_RDWR|O_CREAT,0600);CHECK(lockfd>=0);
    if(lockfd>=0){CHECK(flock(lockfd,LOCK_EX|LOCK_NB)==0);CHECK(!CSGroupChatWriteState(state,first,Account,&error) && error);CHECK([[NSData dataWithContentsOfURL:first] isEqual:original]);flock(lockfd,LOCK_UN);close(lockfd);}
    NSURL *directoryTarget=CSGroupChatFileURL(root,@"wxid_fixture_directory");CHECK([fm createDirectoryAtURL:directoryTarget withIntermediateDirectories:NO attributes:nil error:&error]);
    CHECK(!CSGroupChatReadState(directoryTarget,@"wxid_fixture_directory",&error) && error);
    CHECK(!CSGroupChatWriteState(Change(state,@"account",@"wxid_fixture_directory"),directoryTarget,@"wxid_fixture_directory",&error) && error);
    BOOL directory=NO;CHECK([fm fileExistsAtPath:directoryTarget.path isDirectory:&directory] && directory);
    NSURL *linked=CSGroupChatFileURL(root,@"wxid_fixture_symlink");CHECK([fm createSymbolicLinkAtURL:linked withDestinationURL:first error:&error]);
    CHECK(!CSGroupChatReadState(linked,@"wxid_fixture_symlink",&error) && error);
    CHECK(!CSGroupChatWriteState(Change(state,@"account",@"wxid_fixture_symlink"),linked,@"wxid_fixture_symlink",&error) && error);
    CHECK([[NSData dataWithContentsOfURL:first] isEqual:original]);
    CHECK(CSGroupChatWriteState(nil,first,Account,&error));CHECK(![fm fileExistsAtPath:first.path]);
    CHECK([CSGroupChatReadState(second,OtherAccount,&error) isEqual:otherState]);
    CHECK([[NSData dataWithContentsOfURL:broken] isEqual:corruption]);
}

int main(int argc,const char *argv[]) { @autoreleasepool {
    if(argc!=2){fprintf(stderr,"Usage: group-chat-core-tests TEMPORARY_FIXTURE_DIRECTORY\n");return 2;}
    NSURL *root=[NSURL fileURLWithPath:[NSString stringWithUTF8String:argv[1]] isDirectory:YES];
    NSError *error=nil;if(![NSFileManager.defaultManager createDirectoryAtURL:root withIntermediateDirectories:YES attributes:nil error:&error]){fprintf(stderr,"Fixture directory: %s\n",error.localizedDescription.UTF8String);return 2;}
    TestTemplates();TestMemberPolicy();TestWelcomeFreshness();TestStore(root);
    fprintf(stdout,"Group chat core: %u checks, %u failures (temporary fixtures only)\n",checks,failures);
    return failures?1:0;
} }
