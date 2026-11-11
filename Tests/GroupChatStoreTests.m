#import <Foundation/Foundation.h>
#import "CSGroupChatStore.h"
#include <sys/file.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

static unsigned checks;
static BOOL failFileSync,failDirectorySync;
static NSMutableString *syncOrder;
static void Check(BOOL value,NSString *detail){checks++;if(!value){fprintf(stderr,"FAIL: %s\n",detail.UTF8String);exit(1);}}
// Only CSGroupChatStore.m is compiled with its fsync calls redirected here.
// This proves that a failed file barrier preserves the old bytes and that a
// failed directory barrier is reported as an uncertain commit after rename.
int CSGroupChatStoreTestFsync(int descriptor){
    struct stat metadata;if(fstat(descriptor,&metadata))return -1;
    BOOL directory=S_ISDIR(metadata.st_mode);[syncOrder appendString:directory?@"D":@"F"];
    if((directory && failDirectorySync) || (!directory && failFileSync)){errno=EIO;return -1;}
    return fsync(descriptor);
}
static NSDictionary *State(NSString *text){NSMutableDictionary *configuration=[CSGroupChatDefaultConfiguration() mutableCopy];configuration[@"welcomeTemplate"]=text;return @{@"schema":@1,@"account":@"alice",@"configuration":configuration};}
static BOOL NoTemporaryFiles(NSURL *directory){for(NSString *name in [NSFileManager.defaultManager contentsOfDirectoryAtPath:directory.path error:NULL])if([name hasPrefix:@".group-chat-"])return NO;return YES;}
int main(void){@autoreleasepool{
    NSURL *root=[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString] isDirectory:YES];
    NSURL *url=CSGroupChatFileURL(root,@"alice"),*directory=url.URLByDeletingLastPathComponent;
    NSDictionary *original=State(@"欢迎@昵称"),*changed=State(@"新的欢迎@昵称");NSError *error=nil;syncOrder=[NSMutableString string];
    Check(CSGroupChatWriteState(original,url,@"alice",&error),error.description?:@"initial durable write");
    Check([syncOrder isEqual:@"FD"],@"file sync precedes containing directory sync");
    struct stat metadata;Check(stat(url.fileSystemRepresentation,&metadata)==0 && (metadata.st_mode&0777)==0600,@"private file mode");
    NSData *before=[NSData dataWithContentsOfURL:url];failFileSync=YES;[syncOrder setString:@""];
    Check(!CSGroupChatWriteState(changed,url,@"alice",&error) && error!=nil,@"file sync failure reported");
    Check([[NSData dataWithContentsOfURL:url] isEqual:before],@"failed file barrier preserves original bytes");
    Check([syncOrder isEqual:@"F"] && NoTemporaryFiles(directory),@"failed temporary file cleaned without directory commit");
    failFileSync=NO;failDirectorySync=YES;[syncOrder setString:@""];
    Check(!CSGroupChatWriteState(changed,url,@"alice",&error) && [error.localizedDescription containsString:@"已替换"],@"directory sync failure reports uncertain replacement");
    Check([CSGroupChatReadState(url,@"alice",NULL) isEqual:changed],@"uncertain replacement exposes actual new bytes");
    Check([syncOrder isEqual:@"FD"] && NoTemporaryFiles(directory),@"replacement attempts directory barrier and cleans temporary path");
    failDirectorySync=NO;Check(CSGroupChatWriteState(original,url,@"alice",&error),@"lock released after sync failure");
    int lock=open([[url.path stringByAppendingString:@".lock"] fileSystemRepresentation],O_RDWR|O_NOFOLLOW);
    Check(lock>=0 && flock(lock,LOCK_EX|LOCK_NB)==0,@"external lock fixture acquired");
    Check(!CSGroupChatWriteState(changed,url,@"alice",&error) && [[NSData dataWithContentsOfURL:url] isEqual:before],@"locked state cannot be overwritten");
    flock(lock,LOCK_UN);close(lock);
    NSData *corrupt=[@"invalid property list" dataUsingEncoding:NSUTF8StringEncoding];Check([corrupt writeToURL:url atomically:YES],@"corrupt fixture");
    Check(!CSGroupChatWriteState(changed,url,@"alice",&error) && [[NSData dataWithContentsOfURL:url] isEqual:corrupt],@"corrupt config is never overwritten");
    Check(!CSGroupChatWriteState(nil,url,@"alice",&error) && [[NSData dataWithContentsOfURL:url] isEqual:corrupt],@"corrupt config is never reset");
    Check(unlink(url.fileSystemRepresentation)==0,@"remove only isolated corrupt fixture");
    NSURL *target=[root URLByAppendingPathComponent:@"protected.plist"];Check([before writeToURL:target atomically:YES],@"symlink target fixture");
    Check(symlink(target.fileSystemRepresentation,url.fileSystemRepresentation)==0,@"symlink fixture");
    Check(!CSGroupChatWriteState(changed,url,@"alice",&error) && [[NSData dataWithContentsOfURL:target] isEqual:before],@"symlink target preserved");
    Check(!CSGroupChatWriteState(nil,url,@"alice",&error) && lstat(url.fileSystemRepresentation,&metadata)==0 && S_ISLNK(metadata.st_mode),@"symlink cannot be reset");
    Check(unlink(url.fileSystemRepresentation)==0 && CSGroupChatWriteState(original,url,@"alice",&error),@"restore isolated valid fixture");
    failDirectorySync=YES;[syncOrder setString:@""];
    Check(!CSGroupChatWriteState(nil,url,@"alice",&error) && [error.localizedDescription containsString:@"已删除"],@"delete barrier failure reports uncertain deletion");
    Check([syncOrder isEqual:@"D"] && access(url.fileSystemRepresentation,F_OK)!=0,@"deletion attempts directory barrier after unlink");
    failDirectorySync=NO;Check(CSGroupChatWriteState(original,url,@"alice",&error),@"write after uncertain deletion");[syncOrder setString:@""];
    Check(CSGroupChatWriteState(nil,url,@"alice",&error) && [syncOrder isEqual:@"D"],@"durable deletion synchronizes directory");
    Check(CSGroupChatWriteState(nil,url,@"alice",&error),@"missing state reset is idempotent");
    Check(NoTemporaryFiles(directory),@"no temporary files remain");
    [NSFileManager.defaultManager removeItemAtURL:root error:NULL];printf("Group chat store: %u checks passed\n",checks);return 0;
}}
