#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import "CSFavoriteVoiceMediaProvider.h"

static NSUInteger checks,decodes,lengthCalculations,legacyDecodes,opusDecodes,wrongABICalls;
static unsigned int decodedMilliseconds=1000;
static BOOL decoderThrows;
#define CHECK(value) do { checks++; if (!(value)) { fprintf(stderr,"FAIL %d: %s\n",__LINE__,#value); exit(1); } } while (0)
static void Drain(void) { [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]]; }
static BOOL Wait(BOOL (^ready)(void)) { NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:3]; while (!ready() && deadline.timeIntervalSinceNow>0) Drain(); return ready(); }
static NSData *VoiceBytes(void) { NSMutableData *data=[NSMutableData dataWithBytes:"\x02#!SILK_V3" length:10]; [data increaseLengthBy:32]; return data; }
static NSData *OpusBytes(void) { return [@"#!OPUS_RAW_V1xxxxxxxxxxxxxxxx" dataUsingEncoding:NSUTF8StringEncoding]; }
static NSString *MD5(NSData *data) {
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CC_MD5(data.bytes,(CC_LONG)data.length,digest);
#pragma clang diagnostic pop
    NSMutableString *value=[NSMutableString string]; for (NSUInteger i=0;i<sizeof(digest);i++) [value appendFormat:@"%02x",digest[i]]; return value;
}
@interface FavoritesItemDataField : NSObject
@property(nonatomic) int dataType;
@property(nonatomic) unsigned int duration;
@property(nonatomic) unsigned long long dataSize;
@property(nonatomic,copy) NSString *dataId,*dataMd5,*dataFmt,*path,*sourceDataPath,*cdnDataUrl,*cdnDataKey;
@property(nonatomic) BOOL recording;
@end
@implementation FavoritesItemDataField
- (BOOL)isRecording { CHECK(NSThread.isMainThread); return _recording; }
- (NSString *)dataPathForDisplay { CHECK(NSThread.isMainThread); return _path; }
- (NSString *)GetDataPath { CHECK(NSThread.isMainThread); return _path; }
- (NSString *)GetDataPathForFav { CHECK(NSThread.isMainThread); return _path; }
@end
@interface FavoritesItem : NSObject
@property(nonatomic) int type;
@property(nonatomic) unsigned int localId,favId;
@property(nonatomic,copy) NSArray *dataList;
@end
@implementation FavoritesItem
@end
@interface FakeFavoriteManager : NSObject
@property(nonatomic,strong) FavoritesItem *item;
@property(nonatomic) NSUInteger lookups,downloads;
@property(nonatomic,copy) void (^beforeLookup)(void);
@end
@implementation FakeFavoriteManager
- (id)getFavoritesItemByLocalId:(unsigned int)localID { CHECK(NSThread.isMainThread); _lookups++; if (_beforeLookup) _beforeLookup(); return _item.localId==localID ? _item : nil; }
- (id)getFavoritesItemByfavId:(unsigned int)favoriteID { CHECK(NSThread.isMainThread); _lookups++; if (_beforeLookup) _beforeLookup(); return _item.favId==favoriteID ? _item : nil; }
- (void)startDownloadFavoritesItem:(id)item IsPriority:(BOOL)priority { CHECK(NSThread.isMainThread && item==_item && priority); _downloads++; }
@end
@interface FavoriteEnvironment : NSObject <CSMessageActionEnvironment>
@property(nonatomic,copy) NSString *account;
@property(nonatomic,strong) FakeFavoriteManager *manager;
@property(nonatomic,copy) void (^onService)(void);
@end
@implementation FavoriteEnvironment
- (NSString *)currentAccountID { CHECK(NSThread.isMainThread); return _account; }
- (id)serviceNamed:(NSString *)name { CHECK(NSThread.isMainThread && [name isEqualToString:@"FavoritesMgr"]); if (_onService) _onService(); return _manager; }
- (id)controllerForCell:(id)cell { (void)cell; return nil; }
@end
// Deterministic native-decoder doubles exercise routing/format/unit decisions, not codec correctness.
@interface AudioUtil : NSObject
@end
@implementation AudioUtil
+ (unsigned int)calcVoiceTimeWithData:(NSData *)data VoiceFormat:(unsigned int)format {
    CHECK(NSThread.isMainThread); decodes++;
    if (decoderThrows) [NSException raise:NSInvalidArgumentException format:@"native decoder failed"];
    if ((format==4 && [data isEqual:VoiceBytes()]) || (format==7 && [data isEqual:OpusBytes()]) || ((format==0 || format==1) && data.length)) return decodedMilliseconds;
    return 0;
}
+ (unsigned int)calcVoiceTime:(unsigned int)size VoiceFormat:(unsigned int)format { CHECK(NSThread.isMainThread); (void)size; (void)format; lengthCalculations++; return 1000; }
@end
@interface LengthOnlyAudioUtil : NSObject
@end
@implementation LengthOnlyAudioUtil
// In 8.0.80 formats other than 0/1 return global recorder state. A matching
// nonzero value here must never validate a SILK/OPUS file without a byte decoder.
+ (unsigned int)calcVoiceTime:(unsigned int)size VoiceFormat:(unsigned int)format { CHECK(NSThread.isMainThread); (void)size; (void)format; lengthCalculations++; return 1000; }
@end
@interface LegacyAudioUtil : LengthOnlyAudioUtil
@end
@implementation LegacyAudioUtil
+ (unsigned int)calcSilkVoiceTime:(NSData *)data { CHECK(NSThread.isMainThread && [data isEqual:VoiceBytes()]); legacyDecodes++; return decodedMilliseconds; }
@end
@interface WrongReturnAudioUtil : LengthOnlyAudioUtil
@end
@implementation WrongReturnAudioUtil
+ (id)calcVoiceTimeWithData:(NSData *)data VoiceFormat:(unsigned int)format { (void)data; (void)format; wrongABICalls++; return @1000; }
+ (id)calcSilkVoiceTime:(NSData *)data { (void)data; wrongABICalls++; return @1000; }
@end
@interface WrongArgumentAudioUtil : LengthOnlyAudioUtil
@end
@implementation WrongArgumentAudioUtil
+ (unsigned int)calcVoiceTimeWithData:(unsigned int)size VoiceFormat:(unsigned int)format { (void)size; (void)format; wrongABICalls++; return 1000; }
+ (unsigned int)calcSilkVoiceTime:(unsigned int)size { (void)size; wrongABICalls++; return 1000; }
@end
@interface OpusAudioPlayer : NSObject
@end
@implementation OpusAudioPlayer
+ (unsigned int)calculateVoiceTime:(NSData *)data { CHECK(NSThread.isMainThread && [data isEqual:OpusBytes()]); opusDecodes++; return decodedMilliseconds; }
@end
@interface WrongArgumentOpusAudioPlayer : NSObject
@end
@implementation WrongArgumentOpusAudioPlayer
+ (unsigned int)calculateVoiceTime:(unsigned int)size { (void)size; wrongABICalls++; return 1000; }
@end
@interface NoNativeDecoder : NSObject
@end
@implementation NoNativeDecoder
@end
// Swap only the test class objects' metaclasses, restoring them synchronously.
// The production lookup still resolves the real selector/type metadata by name.
static void WithNativeShapes(Class utilityShape,Class opusShape,void (^test)(void)) {
    Class utilityMeta=object_getClass(AudioUtil.class),opusMeta=object_getClass(OpusAudioPlayer.class);
    Class replacementUtilityMeta=object_getClass(utilityShape),replacementOpusMeta=object_getClass(opusShape);
    object_setClass(AudioUtil.class,replacementUtilityMeta); object_setClass(OpusAudioPlayer.class,replacementOpusMeta);
    @try { test(); }
    @finally { object_setClass(AudioUtil.class,utilityMeta); object_setClass(OpusAudioPlayer.class,opusMeta); }
}
static void TestNativeDurationRouting(void) {
    CHECK(!class_getClassMethod(AudioUtil.class,NSSelectorFromString(@"calcSilkVoiceTime:")));
    NSData *bytes=VoiceBytes(); NSString *reason=nil;
    CSMessageVoiceResource *resource=CSMessageValidateVoiceData(bytes,1000,4,YES,(unsigned int)bytes.length,&reason);
    CHECK(resource && !reason && resource.durationMilliseconds==1000 && [resource.data isEqual:bytes]);
    CHECK(decodes==1 && !legacyDecodes && !lengthCalculations);
    resource=CSMessageValidateVoiceData(bytes,1000,UINT_MAX,YES,(unsigned int)bytes.length,&reason); CHECK(resource && resource.format==4);
    NSData *opus=OpusBytes(); NSUInteger opusBaseline=opusDecodes;
    resource=CSMessageValidateVoiceData(opus,1000,7,YES,(unsigned int)opus.length,&reason); CHECK(resource && resource.format==7 && opusDecodes==opusBaseline);
    decodedMilliseconds=0;
    CHECK(!CSMessageValidateVoiceData(bytes,1000,4,YES,(unsigned int)bytes.length,&reason) && [reason isEqual:@"无法读取原语音时长"]);
    CHECK(!CSMessageValidateVoiceData(opus,1000,7,YES,(unsigned int)opus.length,&reason) && opusDecodes==opusBaseline);
    CHECK(!lengthCalculations && !legacyDecodes);
    decodedMilliseconds=1000; decoderThrows=YES;
    CHECK(!CSMessageValidateVoiceData(bytes,1000,4,YES,(unsigned int)bytes.length,&reason) && !lengthCalculations); decoderThrows=NO;
    NSData *truncated=[bytes subdataWithRange:NSMakeRange(0,12)];
    CHECK(!CSMessageValidateVoiceData(truncated,1000,4,YES,(unsigned int)truncated.length,&reason) && [reason isEqual:@"无法读取原语音时长"]);
    resource=CSMessageValidateVoiceData(bytes,1120,4,YES,(unsigned int)bytes.length,&reason); CHECK(resource && resource.durationMilliseconds==1000 && [resource.data isEqual:bytes]);
    CHECK(!CSMessageValidateVoiceData(bytes,1120,4,YES,0,&reason));
    resource=CSMessageValidateVoiceData(bytes,1020,4,YES,0,&reason); CHECK(resource && resource.durationMilliseconds==1020);
    for (unsigned int format=0;format<2;format++) {
        resource=CSMessageValidateVoiceData(bytes,1000,format,YES,(unsigned int)bytes.length,&reason); CHECK(resource && resource.durationMilliseconds==1000);
        CHECK(!CSMessageValidateVoiceData(bytes,1120,format,YES,(unsigned int)bytes.length,&reason));
    }
    NSUInteger decodeBaseline=decodes;
    for (NSNumber *format in @[@2,@3,@8,@99]) CHECK(!CSMessageValidateVoiceData(bytes,1000,format.unsignedIntValue,YES,(unsigned int)bytes.length,&reason));
    CHECK(decodes==decodeBaseline);
    CHECK(!lengthCalculations && !legacyDecodes && opusDecodes==opusBaseline);
    WithNativeShapes(LegacyAudioUtil.class,OpusAudioPlayer.class,^{
        NSString *failure=nil; CSMessageVoiceResource *legacy=CSMessageValidateVoiceData(bytes,1000,4,YES,(unsigned int)bytes.length,&failure);
        CHECK(legacy && legacy.durationMilliseconds==1000 && legacyDecodes==1);
        decodedMilliseconds=0; CHECK(!CSMessageValidateVoiceData(bytes,1000,4,YES,(unsigned int)bytes.length,&failure) && !lengthCalculations); decodedMilliseconds=1000;
        CHECK(CSMessageValidateVoiceData(opus,1000,7,YES,(unsigned int)opus.length,&failure) && opusDecodes==opusBaseline+1);
    });
    for (Class shape in @[LengthOnlyAudioUtil.class,WrongReturnAudioUtil.class,WrongArgumentAudioUtil.class]) {
        WithNativeShapes(shape,NoNativeDecoder.class,^{
            NSString *failure=nil;
            for (unsigned int format=2;format<=4;format++) CHECK(!CSMessageValidateVoiceData(bytes,1000,format,YES,(unsigned int)bytes.length,&failure));
            CHECK(!CSMessageValidateVoiceData(opus,1000,7,YES,(unsigned int)opus.length,&failure));
            CHECK(!wrongABICalls && !lengthCalculations);
            for (unsigned int format=0;format<2;format++) CHECK(CSMessageValidateVoiceData(bytes,1000,format,YES,(unsigned int)bytes.length,&failure)!=nil);
        });
        CHECK(lengthCalculations==2); lengthCalculations=0;
    }
    WithNativeShapes(LengthOnlyAudioUtil.class,WrongArgumentOpusAudioPlayer.class,^{
        NSString *failure=nil; CHECK(!CSMessageValidateVoiceData(opus,1000,7,YES,(unsigned int)opus.length,&failure) && !wrongABICalls && !lengthCalculations);
    });
    CHECK([bytes isEqual:VoiceBytes()] && !lengthCalculations && !wrongABICalls);
}
static id WrongDuration(id self,SEL command) { (void)self; (void)command; return @"1000"; }
static FavoritesItem *Item(NSString *path) {
    FavoritesItemDataField *field=[FavoritesItemDataField new]; field.dataType=3; field.duration=1000; field.dataSize=VoiceBytes().length; field.dataId=@"voice-data"; field.dataMd5=MD5(VoiceBytes()); field.dataFmt=@"silk"; field.path=path; field.cdnDataUrl=@"cdn-id"; field.cdnDataKey=@"cdn-key";
    FavoritesItem *item=[FavoritesItem new]; item.type=3; item.localId=42; item.favId=101; item.dataList=@[field]; return item;
}
static CSFavoriteVoiceContext *Context(FavoritesItem *item) { return [CSFavoriteVoiceContext contextWithItem:item accountID:@"me" accountEpoch:7]; }
static CSFavoriteVoiceMediaProvider *Provider(FavoriteEnvironment *env) {
    CSFavoriteVoiceMediaProvider *provider=[[CSFavoriteVoiceMediaProvider alloc] initWithEnvironment:env];
    provider.isContextValid=^BOOL(CSFavoriteVoiceContext *context){ return context.accountEpoch==7; }; return provider;
}
static void TestContext(NSString *path) {
    FavoritesItem *item=Item(path); FavoritesItemDataField *field=item.dataList.firstObject; CSFavoriteVoiceContext *context=Context(item);
    CHECK(context && context.localID==42 && context.favoriteID==101 && context.durationMilliseconds==1000 && context.format==4 && context.expectedBytes==VoiceBytes().length);
    CHECK(context.sourceItem==item && context.dataItem==field && [context matchesItem:Item(path)]);
    FavoritesItem *other=Item(path); other.localId=43; CHECK(![context matchesItem:other]); other.localId=42; other.favId=102; CHECK(![context matchesItem:other]);
    other.favId=101; ((FavoritesItemDataField *)other.dataList.firstObject).dataId=@"different"; CHECK(![context matchesItem:other]);
    other=Item(path); ((FavoritesItemDataField *)other.dataList.firstObject).dataMd5=@"00000000000000000000000000000000"; CHECK(![context matchesItem:other]);
    item.type=18; CHECK(!Context(item)); item.type=14; CHECK(!Context(item)); item.type=3;
    field.dataType=1; CHECK(!Context(item)); field.dataType=3;
    field.recording=YES; CHECK(!Context(item)); field.recording=NO;
    item.dataList=@[field,field]; CHECK(!Context(item)); item.dataList=@[field];
    item.localId=0; item.favId=0; CHECK(!Context(item)); item.localId=42;
    field.dataId=@""; field.dataMd5=@""; CHECK(!Context(item)); field.dataMd5=MD5(VoiceBytes()); CHECK(Context(item)!=nil);
    field.dataMd5=@"not-md5"; CHECK(!Context(item)); field.dataMd5=@""; field.dataId=@"voice-data";
    NSArray *formats=@[@"amr",@"speex",@"mp3",@"wav",@"silk"];
    for (NSUInteger i=0;i<formats.count;i++) { field.dataFmt=formats[i]; context=Context(item); CHECK(context.formatKnown && context.format==i); }
    field.dataFmt=@"unknown"; CHECK(Context(item) && !Context(item).formatKnown);
    field.duration=4321; CHECK(Context(item).durationMilliseconds==4321); // Preserve m_uiVoiceTime units exactly.
    Class bad=objc_allocateClassPair(FavoritesItemDataField.class,"BadFavoriteDurationABI",0); CHECK(bad!=Nil); class_addMethod(bad,@selector(duration),(IMP)WrongDuration,"@16@0:8"); objc_registerClassPair(bad);
    id wrong=[bad new]; [wrong setDataType:3]; [wrong setDataId:@"voice-data"]; [wrong setDataMd5:MD5(VoiceBytes())]; [wrong setDataFmt:@"silk"]; [wrong setDataSize:VoiceBytes().length]; item.dataList=@[wrong]; CHECK(!Context(item));
    CHECK(![CSFavoriteVoiceContext contextWithItem:Item(path) accountID:@"" accountEpoch:7]); CHECK(![CSFavoriteVoiceContext contextWithItem:Item(path) accountID:@"me" accountEpoch:0]);
    __block BOOL rejected=NO; dispatch_semaphore_t done=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{ rejected=Context(Item(path))==nil; dispatch_semaphore_signal(done); });
    CHECK(dispatch_semaphore_wait(done,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0 && rejected);
}
static void TestLocal(FavoriteEnvironment *env,NSString *path) {
    env.manager.item=Item(path); CSFavoriteVoiceMediaProvider *provider=Provider(env); CSFavoriteVoiceContext *context=Context(env.manager.item);
    __block BOOL done=NO; __block CSMessageVoiceResource *result=nil; __block NSString *reason=nil;
    [provider prepareContext:context operationID:@"local" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(NSThread.isMainThread); result=resource; reason=failure; done=YES; }];
    CHECK(Wait(^BOOL{ return done; })); CHECK(result && !reason && result.durationMilliseconds==1000 && result.format==4 && [result.data isEqual:VoiceBytes()]);
    CHECK(env.manager.downloads==0 && [provider sourceIsCurrentForContext:context]); CHECK([[NSData dataWithContentsOfFile:path] isEqual:VoiceBytes()]);
    FavoritesItemDataField *changed=env.manager.item.dataList.firstObject;
    changed.duration=2000; CHECK([context matchesItem:env.manager.item] && ![provider sourceIsCurrentForContext:context]); changed.duration=1000;
    changed.dataFmt=@"amr"; CHECK(![provider sourceIsCurrentForContext:context]); changed.dataFmt=@"silk";
    changed.dataSize++; CHECK(![provider sourceIsCurrentForContext:context]); changed.dataSize--;
    CHECK([provider sourceIsCurrentForContext:context]);
    changed.duration=1120; done=NO; result=nil; reason=nil;
    [provider prepareContext:Context(env.manager.item) operationID:@"native-duration-ms" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(NSThread.isMainThread); result=resource; reason=failure; done=YES; }];
    CHECK(Wait(^BOOL{ return done; })); CHECK(result && !reason && result.durationMilliseconds==1000 && [result.data isEqual:VoiceBytes()]);
    CHECK(changed.duration==1120 && changed.dataSize==VoiceBytes().length && [changed.dataMd5 isEqual:MD5(VoiceBytes())] && [[NSData dataWithContentsOfFile:path] isEqual:VoiceBytes()]); changed.duration=1000;
    env.manager.item=nil; CHECK(![provider sourceIsCurrentForContext:context]);
    env.manager.item=Item(path); FavoritesItemDataField *field=env.manager.item.dataList.firstObject; field.dataMd5=@"00000000000000000000000000000000";
    done=NO; [provider prepareContext:Context(env.manager.item) operationID:@"md5" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(!resource && failure.length); done=YES; }]; CHECK(Wait(^BOOL{ return done; })); CHECK(env.manager.downloads==0);
    field.dataMd5=MD5(VoiceBytes()); field.dataSize++; done=NO;
    [provider prepareContext:Context(env.manager.item) operationID:@"size" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(!resource && failure.length); done=YES; }]; CHECK(Wait(^BOOL{ return done; })); CHECK(env.manager.downloads==0);
    env.manager.item=Item(path); field=env.manager.item.dataList.firstObject; field.dataFmt=@"mystery"; done=NO;
    [provider prepareContext:Context(env.manager.item) operationID:@"format" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(!resource && failure.length); done=YES; }]; CHECK(done && env.manager.downloads==0);
    env.manager.item=Item(path); done=NO;
    [provider prepareContext:Context(env.manager.item) operationID:@"deleted-during-io" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(!resource && failure.length); done=YES; }]; env.manager.item=nil; CHECK(Wait(^BOOL{ return done; }));
    env.manager.item=Item(path); done=NO;
    [provider prepareContext:Context(env.manager.item) operationID:@"account-during-io" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(!resource && failure.length); done=YES; }]; env.account=@"other"; CHECK(Wait(^BOOL{ return done; })); env.account=@"me";
    env.manager.item=Item(path); done=NO;
    [provider prepareContext:Context(env.manager.item) operationID:@"cancel-io" completion:^(__unused CSMessageVoiceResource *resource,__unused NSString *failure){ done=YES; }]; [provider cancelAll]; for (int i=0;i<5;i++) Drain(); CHECK(!done && !CSFavoriteHasPendingVoiceDownloads());
}
static void TestDownload(FavoriteEnvironment *env,NSString *missing) {
    env.manager.item=Item(missing); NSUInteger baseline=env.manager.downloads; CSFavoriteVoiceMediaProvider *provider=Provider(env); CSFavoriteVoiceContext *context=Context(env.manager.item);
    __block NSUInteger completions=0,waiting=0; __block CSMessageVoiceResource *result=nil;
    provider.waitingHandler=^(NSString *operation){ CHECK(operation.length); waiting++; };
    [provider prepareContext:context operationID:@"first" completion:^(__unused CSMessageVoiceResource *resource,__unused NSString *failure){ CHECK(NO); }];
    [provider prepareContext:context operationID:@"second" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(resource && !failure); result=resource; completions++; }];
    CHECK(Wait(^BOOL{ return env.manager.downloads==baseline+1; })); CHECK(waiting==2 && CSFavoriteHasPendingVoiceDownloads());
    [provider cancelOperationID:@"first"]; CHECK(CSFavoriteHasPendingVoiceDownloads());
    [provider downloadFinishedForItem:env.manager.item error:0 accountID:@"other" epoch:7];
    [provider downloadFinishedForItem:env.manager.item error:0 accountID:@"me" epoch:8];
    FavoritesItem *wrong=Item(missing); ((FavoritesItemDataField *)wrong.dataList.firstObject).dataId=@"wrong";
    [provider downloadFinishedForItem:wrong error:0 accountID:@"me" epoch:7]; CHECK(completions==0 && CSFavoriteHasPendingVoiceDownloads());
    CHECK([VoiceBytes() writeToFile:missing atomically:YES]); env.manager.item=Item(missing);
    [provider downloadFinishedForItem:env.manager.item error:0 accountID:@"me" epoch:7];
    CHECK(Wait(^BOOL{ return completions==1; })); CHECK(result && env.manager.downloads==baseline+1 && !CSFavoriteHasPendingVoiceDownloads());
    [provider downloadFinishedForItem:env.manager.item error:0 accountID:@"me" epoch:7]; CHECK(completions==1);
    NSString *another=[missing stringByAppendingString:@"-another"]; env.manager.item=Item(another); __block BOOL failed=NO;
    [provider prepareContext:Context(env.manager.item) operationID:@"download-failure" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(!resource && failure.length); failed=YES; }]; CHECK(Wait(^BOOL{ return CSFavoriteHasPendingVoiceDownloads(); }));
    [provider downloadFinishedForItem:env.manager.item error:3 accountID:@"me" epoch:7]; CHECK(failed && !CSFavoriteHasPendingVoiceDownloads()); // No chat-specific error==3 success exception.
    failed=NO; [provider prepareContext:Context(env.manager.item) operationID:@"false-success" completion:^(CSMessageVoiceResource *resource,NSString *failure){ CHECK(!resource && failure.length); failed=YES; }]; CHECK(Wait(^BOOL{ return CSFavoriteHasPendingVoiceDownloads(); })); NSUInteger requested=env.manager.downloads;
    [provider downloadFinishedForItem:env.manager.item error:0 accountID:@"me" epoch:7]; CHECK(Wait(^BOOL{ return failed; })); CHECK(env.manager.downloads==requested && !CSFavoriteHasPendingVoiceDownloads());
    __block BOOL cancelledCallback=NO; [provider prepareContext:Context(env.manager.item) operationID:@"cancel-download" completion:^(__unused CSMessageVoiceResource *resource,__unused NSString *failure){ cancelledCallback=YES; }]; CHECK(Wait(^BOOL{ return CSFavoriteHasPendingVoiceDownloads(); })); [provider cancelAll]; CHECK(!CSFavoriteHasPendingVoiceDownloads());
    [provider downloadFinishedForItem:env.manager.item error:0 accountID:@"me" epoch:7]; for (int i=0;i<5;i++) Drain(); CHECK(!cancelledCallback);
}
static void TestContentRejection(FavoriteEnvironment *env,NSString *directory) {
    for (NSNumber *truncate in @[@YES,@NO]) {
        NSString *damagedPath=[directory stringByAppendingPathComponent:truncate.boolValue ? @"truncated.silk" : @"corrupt.silk"];
        NSMutableData *damaged=[VoiceBytes() mutableCopy];
        if (truncate.boolValue) [damaged setLength:12]; else ((unsigned char *)damaged.mutableBytes)[damaged.length-1]=0xff;
        CHECK([damaged writeToFile:damagedPath atomically:YES]); env.manager.item=Item(damagedPath);
        FavoritesItemDataField *damagedField=env.manager.item.dataList.firstObject; damagedField.dataSize=damaged.length; damagedField.dataMd5=MD5(damaged);
        CSFavoriteVoiceMediaProvider *damagedProvider=Provider(env); __block BOOL rejected=NO; NSUInteger downloads=env.manager.downloads;
        [damagedProvider prepareContext:Context(env.manager.item) operationID:@"native-decode-failure" completion:^(CSMessageVoiceResource *resource,NSString *reason){ CHECK(!resource && [reason isEqual:@"无法读取原语音时长"]); rejected=YES; }];
        CHECK(Wait(^BOOL{ return rejected; })); CHECK(env.manager.downloads==downloads && !lengthCalculations);
        CHECK(damagedField.duration==1000 && damagedField.dataSize==damaged.length && [damagedField.dataMd5 isEqual:MD5(damaged)] && [[NSData dataWithContentsOfFile:damagedPath] isEqual:damaged]);
    }
    NSString *path=[directory stringByAppendingPathComponent:@"wrong-codec"];
    NSData *opus=[@"#!OPUS_RAW_V1xxxxxxxxxxxxxxxx" dataUsingEncoding:NSUTF8StringEncoding]; CHECK([opus writeToFile:path atomically:YES]);
    env.manager.item=Item(path); FavoritesItemDataField *field=env.manager.item.dataList.firstObject; field.dataSize=opus.length; field.dataMd5=MD5(opus);
    CSFavoriteVoiceMediaProvider *provider=Provider(env); __block BOOL done=NO;
    [provider prepareContext:Context(env.manager.item) operationID:@"no-codec-relabel" completion:^(CSMessageVoiceResource *resource,NSString *reason){ CHECK(!resource && reason.length); done=YES; }]; CHECK(Wait(^BOOL{ return done; }));
    NSString *symlink=[directory stringByAppendingPathComponent:@"symlink"]; CHECK([NSFileManager.defaultManager createSymbolicLinkAtPath:symlink withDestinationPath:path error:NULL]); env.manager.item=Item(symlink); done=NO; NSUInteger requested=env.manager.downloads;
    [provider prepareContext:Context(env.manager.item) operationID:@"symlink" completion:^(CSMessageVoiceResource *resource,NSString *reason){ CHECK(!resource && reason.length); done=YES; }]; CHECK(Wait(^BOOL{ return done; })); CHECK(env.manager.downloads==requested);
    env.manager.item=Item(path); field=env.manager.item.dataList.firstObject; field.dataSize=16*1024*1024+1; done=NO;
    [provider prepareContext:Context(env.manager.item) operationID:@"oversized" completion:^(CSMessageVoiceResource *resource,NSString *reason){ CHECK(!resource && reason.length); done=YES; }]; CHECK(done);
}
int main(void) { @autoreleasepool {
    NSString *directory=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]; CHECK([NSFileManager.defaultManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:NULL]);
    NSString *path=[directory stringByAppendingPathComponent:@"voice.silk"]; CHECK([VoiceBytes() writeToFile:path atomically:YES]);
    FavoriteEnvironment *env=[FavoriteEnvironment new]; env.account=@"me"; env.manager=[FakeFavoriteManager new];
    TestNativeDurationRouting(); TestContext(path); TestLocal(env,path); TestDownload(env,[directory stringByAppendingPathComponent:@"download.silk"]); TestContentRejection(env,directory);
    CHECK(decodes>=2 && !CSFavoriteHasPendingVoiceDownloads()); CHECK([NSFileManager.defaultManager removeItemAtPath:directory error:NULL]);
    printf("PASS FavoriteVoiceMediaTests: %lu checks\n",(unsigned long)checks);
} return 0; }
