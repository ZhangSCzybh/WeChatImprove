#import "CSPluginStorage.h"
#include <dirent.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>

NSString *const CSPluginStorageErrorDomain = @"CSPluginStorage";
static BOOL Fail(NSError **error, NSInteger code, NSString *message) {
    if(error)*error=[NSError errorWithDomain:CSPluginStorageErrorDomain code:code
        userInfo:@{NSLocalizedDescriptionKey:message, @"errno":@(errno)}];
    return NO;
}
static BOOL IO(NSError **error) {
    return Fail(error,CSPluginStorageErrorIO,@"插件数据迁移尚未完成，旧数据已保留；解锁设备并检查存储空间后可重试。");
}
static BOOL Conflict(NSError **error, NSString *name) {
    return Fail(error,CSPluginStorageErrorConflict,[NSString stringWithFormat:@"新旧目录的 %@ 内容冲突或路径不安全，已保留两边，未覆盖。",name]);
}
static NSArray<NSString *> *Names(int fd, NSError **error) {
    // dup shares a directory offset, so open a fresh descriptor for every traversal.
    int scan=openat(fd,".",O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
    DIR *dir=scan<0?NULL:fdopendir(scan);
    if(!dir){if(scan>=0)close(scan);IO(error);return nil;}
    NSMutableArray *names=[NSMutableArray array]; struct dirent *entry;
    errno=0;
    while((entry=readdir(dir))) {
        if(!strcmp(entry->d_name,".")||!strcmp(entry->d_name,".."))continue;
        NSString *name=[NSFileManager.defaultManager stringWithFileSystemRepresentation:entry->d_name length:strlen(entry->d_name)];
        if(!name){closedir(dir);IO(error);return nil;}[names addObject:name];errno=0;
    }
    int saved=errno;closedir(dir);if(saved){errno=saved;IO(error);return nil;}
    return [names sortedArrayUsingSelector:@selector(compare:)];
}
static BOOL SameFile(int a, int b, const char *name, NSError **error) {
    int x=openat(a,name,O_RDONLY|O_NOFOLLOW),y=openat(b,name,O_RDONLY|O_NOFOLLOW);
    if(x<0||y<0){if(x>=0)close(x);if(y>=0)close(y);return IO(error);}
    struct stat sx,sy;BOOL ok=!fstat(x,&sx)&&!fstat(y,&sy)&&S_ISREG(sx.st_mode)&&S_ISREG(sy.st_mode);
    if(ok&&sx.st_size!=sy.st_size)ok=NO;
    if(ok&&(sx.st_dev!=sy.st_dev||sx.st_ino!=sy.st_ino)) {
        char bx[16384],by[16384];off_t remaining=sx.st_size;
        while(ok&&remaining>0){size_t n=(size_t)MIN(remaining,(off_t)sizeof(bx));ssize_t nx,ny;
            do{nx=read(x,bx,n);}while(nx<0&&errno==EINTR);
            do{ny=read(y,by,n);}while(ny<0&&errno==EINTR);
            if(nx!=(ssize_t)n||ny!=nx||memcmp(bx,by,n))ok=NO;else remaining-=nx;
        }
    }
    // Flush destination data before allowing removal of any source directory entry.
    if(ok&&fsync(y)) {close(x);close(y);return IO(error);}
    close(x);close(y);
    return ok?YES:Conflict(error,[NSFileManager.defaultManager stringWithFileSystemRepresentation:name length:strlen(name)]);
}
// Check all collisions before touching source; never traverse symlinks in either tree.
static BOOL CheckTree(int source, int target, NSUInteger depth, NSError **error) {
    if(depth>32)return Conflict(error,@"目录层级");
    NSArray *names=Names(source,error);if(!names)return NO;
    for(NSString *name in names){const char *n=name.fileSystemRepresentation;struct stat a,b;
        if(fstatat(source,n,&a,AT_SYMLINK_NOFOLLOW))return IO(error);
        BOOL exists=target>=0&&fstatat(target,n,&b,AT_SYMLINK_NOFOLLOW)==0;
        if(target>=0&&!exists&&errno!=ENOENT)return IO(error);
        if(S_ISDIR(a.st_mode)){
            if(exists&&!S_ISDIR(b.st_mode))return Conflict(error,name);
            int s=openat(source,n,O_RDONLY|O_DIRECTORY|O_NOFOLLOW),t=exists?openat(target,n,O_RDONLY|O_DIRECTORY|O_NOFOLLOW):-1;
            if(s<0||(exists&&t<0)){if(s>=0)close(s);if(t>=0)close(t);return IO(error);}
            BOOL ok=CheckTree(s,t,depth+1,error);close(s);if(t>=0)close(t);if(!ok)return NO;
        }else if(S_ISREG(a.st_mode)){
            if(exists&&(!S_ISREG(b.st_mode)||!SameFile(source,target,n,error)))return (error&&*error)?NO:Conflict(error,name);
        }else return Conflict(error,name);
    }return YES;
}
static BOOL MergeTree(int source,int target,NSError **error) {
    NSArray *names=Names(source,error);if(!names)return NO;
    for(NSString *name in names){const char *n=name.fileSystemRepresentation;struct stat st;
        if(fstatat(source,n,&st,AT_SYMLINK_NOFOLLOW))return IO(error);
        if(S_ISDIR(st.st_mode)){
            if(mkdirat(target,n,st.st_mode&0777)&&errno!=EEXIST)return IO(error);
            int s=openat(source,n,O_RDONLY|O_DIRECTORY|O_NOFOLLOW),t=openat(target,n,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
            if(s<0||t<0){if(s>=0)close(s);if(t>=0)close(t);return IO(error);}
            BOOL ok=MergeTree(s,t,error);close(s);close(t);if(!ok)return NO;
        }else if(S_ISREG(st.st_mode)){
            // Same-container hard links preserve encrypted bytes, protection class and xattrs;
            // no double disk allocation, partial file or overwrite is possible.
            if(linkat(source,n,target,n,0)&&errno!=EEXIST)return IO(error);
            if(!SameFile(source,target,n,error))return NO;
        }else return Conflict(error,name);
    }
    return fsync(target)?IO(error):YES;
}
static BOOL RemoveVerifiedSource(int source,int target,NSError **error) {
    NSArray *names=Names(source,error);if(!names)return NO;
    for(NSString *name in names){const char *n=name.fileSystemRepresentation;struct stat st;
        if(fstatat(source,n,&st,AT_SYMLINK_NOFOLLOW))return IO(error);
        if(S_ISDIR(st.st_mode)){
            int s=openat(source,n,O_RDONLY|O_DIRECTORY|O_NOFOLLOW),t=openat(target,n,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
            if(s<0||t<0){if(s>=0)close(s);if(t>=0)close(t);return IO(error);}
            BOOL ok=RemoveVerifiedSource(s,t,error);close(s);close(t);if(!ok)return NO;
            if(unlinkat(source,n,AT_REMOVEDIR))return IO(error);
        }else if(S_ISREG(st.st_mode)){
            if(!SameFile(source,target,n,error))return NO;
            if(unlinkat(source,n,0))return IO(error);
        }else return Conflict(error,name);
    }return fsync(source)?IO(error):YES;
}
static int ChildDirectory(int parent,const char *name,BOOL create) {
    if(create){
        if(!mkdirat(parent,name,0700)){if(fsync(parent))return -1;}
        else if(errno!=EEXIST)return -1;
    }
    return openat(parent,name,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
}
@interface CSPluginDirectoryMigration ()
@property(nonatomic) NSURL *library;
@property(nonatomic,copy) NSString *leaf;
@property(nonatomic,readwrite) NSError *lastError;
@end
@implementation CSPluginDirectoryMigration
- (instancetype)initWithLibrary:(NSURL *)library leaf:(NSString *)leaf {
    NSParameterAssert(([@[@"BackupV2",@"CloseFriends"] containsObject:leaf]));
    if((self=[super init])){
        _library=library;_leaf=[leaf copy];
        _destinationRoot=[library URLByAppendingPathComponent:[@"Preferences/WeChatImprove/" stringByAppendingString:leaf] isDirectory:YES];
        _legacyRoot=[library URLByAppendingPathComponent:[@"Application Support/WeChatImprove/" stringByAppendingString:leaf] isDirectory:YES];
    }return self;
}
- (BOOL)migrate:(NSError **)error {
    @synchronized(self){NSError *failure=nil;BOOL ok=[self relocate:&failure];self.lastError=failure;
        if(!ok&&error)*error=failure;return ok;}
}
- (BOOL)relocate:(NSError **)error {
    // Resolve only the system-supplied Library alias (/var -> /private/var), never
    // resolve plugin-controlled descendant symlinks into unrelated directories.
    for(NSString *base in @[@"Preferences",@"Application Support"]){
        NSURL *cursor=self.library;
        for(NSString *component in @[base,@"WeChatImprove",self.leaf]){
            cursor=[cursor URLByAppendingPathComponent:component];struct stat st;
            if(!lstat(cursor.fileSystemRepresentation,&st)&&S_ISLNK(st.st_mode))return Conflict(error,cursor.lastPathComponent);
        }
    }
    int lib=open(self.library.URLByResolvingSymlinksInPath.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW);
    if(lib<0)return IO(error);
    int preferences=ChildDirectory(lib,"Preferences",YES);
    int destination=preferences<0?-1:ChildDirectory(preferences,"WeChatImprove",YES);
    int support=ChildDirectory(lib,"Application Support",NO);int supportError=errno;
    int legacy=support<0?-1:ChildDirectory(support,"WeChatImprove",NO);int legacyError=errno;
    BOOL ok=NO;int s=-1,t=-1;
    do {
        if(destination<0){IO(error);break;}
        if((support<0&&supportError!=ENOENT)||(support>=0&&legacy<0&&legacyError!=ENOENT)){IO(error);break;}
        const char *leaf=self.leaf.fileSystemRepresentation;struct stat st;
        BOOL exists=legacy>=0&&fstatat(legacy,leaf,&st,AT_SYMLINK_NOFOLLOW)==0;
        if(legacy>=0&&!exists&&errno!=ENOENT){IO(error);break;}
        if(!exists){t=ChildDirectory(destination,leaf,YES);ok=t>=0;if(!ok)IO(error);break;}
        if(fsync(lib)||fsync(preferences)||fsync(destination)){IO(error);break;}
        if(!S_ISDIR(st.st_mode)){Conflict(error,self.leaf);break;}
        s=ChildDirectory(legacy,leaf,NO);if(s<0){IO(error);break;}
        struct stat targetStat;BOOL targetExists=fstatat(destination,leaf,&targetStat,AT_SYMLINK_NOFOLLOW)==0;
        if(!targetExists&&errno!=ENOENT){IO(error);break;}
        if(targetExists&&!S_ISDIR(targetStat.st_mode)){Conflict(error,self.leaf);break;}
        t=targetExists?ChildDirectory(destination,leaf,NO):-1;
        if(targetExists&&t<0){IO(error);break;}
        if(!CheckTree(s,t,0,error))break;
        if(!targetExists){
            // RENAME_EXCL never replaces even a newly appeared empty destination.
            if(renameatx_np(legacy,leaf,destination,leaf,RENAME_EXCL)){IO(error);break;}
            ok=!fsync(destination)&&!fsync(legacy);if(!ok)IO(error);break;
        }
        if(!MergeTree(s,t,error)||!CheckTree(s,t,0,error))break;
        // Source cleanup is file-by-file only after the whole merge is durable.
        // A killed process resumes from equal duplicates; never recursively remove roots.
        if(!RemoveVerifiedSource(s,t,error))break;
        struct stat current;if(fstatat(legacy,leaf,&current,AT_SYMLINK_NOFOLLOW)||current.st_ino!=st.st_ino||current.st_dev!=st.st_dev){IO(error);break;}
        if(unlinkat(legacy,leaf,AT_REMOVEDIR)||fsync(legacy)){IO(error);break;}ok=YES;
    }while(0);
    if(s>=0)close(s);if(t>=0)close(t);if(legacy>=0)close(legacy);if(support>=0)close(support);
    if(destination>=0)close(destination);if(preferences>=0)close(preferences);close(lib);
    return ok;
}
- (NSArray<NSURL *> *)readRoots {
    @synchronized(self){struct stat st;
        BOOL legacy=lstat(self.legacyRoot.fileSystemRepresentation,&st)==0||errno!=ENOENT;
        return legacy?@[self.legacyRoot,self.destinationRoot]:@[self.destinationRoot];}
}
- (NSURL *)readURLForName:(NSString *)name {
    NSParameterAssert(name.length&&[name isEqual:name.lastPathComponent]&&![name isEqual:@".."]&&![name isEqual:@"."]);
    @synchronized(self){NSURL *old=[self.legacyRoot URLByAppendingPathComponent:name];struct stat st;
        return (lstat(old.fileSystemRepresentation,&st)==0||errno!=ENOENT)?old:[self.destinationRoot URLByAppendingPathComponent:name];}
}
@end
CSPluginDirectoryMigration *CSPluginStorageMigration(NSString *leaf) {
    static NSDictionary *migrations;static dispatch_once_t once;
    dispatch_once(&once,^{NSURL *library=[NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].firstObject;
        migrations=@{@"BackupV2":[[CSPluginDirectoryMigration alloc]initWithLibrary:library leaf:@"BackupV2"],
                     @"CloseFriends":[[CSPluginDirectoryMigration alloc]initWithLibrary:library leaf:@"CloseFriends"]};});
    NSCAssert(migrations[leaf],@"Unknown plugin storage directory");return migrations[leaf];
}
