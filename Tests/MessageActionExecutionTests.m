#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSMessageActionCoordinator.h"
#import "CSMessageSendAdapter.h"
#import "CSVoiceForwardAdapter.h"
#import "CSMessageActionMenuAdapter.h"
static NSUInteger checks=0;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); exit(1); } } while(0)
static void Drain(void) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:0.03]; [NSRunLoop.currentRunLoop runUntilDate:end]; }
static BOOL Wait(BOOL (^predicate)(void)) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:3]; while (!predicate() && end.timeIntervalSinceNow>0) Drain(); return predicate(); }
// Native payload methods live on the type extension; CMessageWrap forwards them.
@interface TestPayloadExtension : NSObject
@property(nonatomic, copy) NSString *m_nsEmoticonMD5,*m_nsAppAttachID;
@property(nonatomic) unsigned int m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag,m_uiAppDataSize;
@property(nonatomic, copy) NSData *m_dtVoice;
@property(nonatomic, strong) id m_oImageInfo;
@property(nonatomic) BOOL m_bAppAttachExistInSvr;
@end
@implementation TestPayloadExtension
@end
@interface CMessageWrap : NSObject <NSCopying>
@property(nonatomic, copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsClientMsgID,*m_nsRealChatUsr,*path,*m_nsMsgSource,*m_nsRevokeBatchId;
@property(nonatomic) unsigned int m_uiMessageType,m_uiMesLocalID,m_uiCreateTime,m_uiStatus,m_uiSendTime,m_uiIsSenderStatus,m_uiDownloadStatus;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic, strong) NSMutableDictionary *m_dicForwardParas;
@property(nonatomic) BOOL file,record;
@property(nonatomic, strong) TestPayloadExtension *m_extendInfoWithMsgType;
@property(nonatomic, copy) NSString *m_nsEmoticonMD5,*m_nsAppAttachID;
@property(nonatomic) unsigned int m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag,m_uiAppDataSize;
@property(nonatomic, copy) NSData *m_dtVoice;
@property(nonatomic, strong) id m_oImageInfo;
@property(nonatomic) BOOL m_bAppAttachExistInSvr;
- (instancetype)initWithMsgType:(unsigned int)type;
@end
@implementation CMessageWrap
@dynamic m_nsEmoticonMD5,m_nsAppAttachID,m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag,m_uiAppDataSize,m_dtVoice,m_oImageInfo,m_bAppAttachExistInSvr;
- (instancetype)initWithMsgType:(unsigned int)type { if ((self=[super init])) { _m_uiMessageType=type; _m_extendInfoWithMsgType=[TestPayloadExtension new]; } return self; }
- (id)forwardingTargetForSelector:(SEL)selector { return [_m_extendInfoWithMsgType respondsToSelector:selector] ? _m_extendInfoWithMsgType : [super forwardingTargetForSelector:selector]; }
- (id)copyWithZone:(NSZone *)zone { (void)zone; CMessageWrap *copy=[[CMessageWrap alloc] initWithMsgType:_m_uiMessageType]; copy.m_nsFromUsr=_m_nsFromUsr; copy.m_nsToUsr=_m_nsToUsr; copy.m_nsContent=_m_nsContent; copy.m_uiMesLocalID=_m_uiMesLocalID; copy.m_n64MesSvrID=_m_n64MesSvrID; copy.m_uiVoiceTime=self.m_uiVoiceTime; copy.m_uiVoiceFormat=self.m_uiVoiceFormat; copy.m_uiDownloadStatus=self.m_uiDownloadStatus; copy.m_dtVoice=self.m_dtVoice; copy.m_nsEmoticonMD5=self.m_nsEmoticonMD5; copy.m_nsAppAttachID=self.m_nsAppAttachID; copy.path=_path; copy.m_dicForwardParas=_m_dicForwardParas; copy.m_oImageInfo=self.m_oImageInfo; copy.file=_file; copy.record=_record; copy.m_uiAppDataSize=self.m_uiAppDataSize; copy.m_bAppAttachExistInSvr=self.m_bAppAttachExistInSvr; return copy; }
+ (NSString *)getPathOfAudio:(CMessageWrap *)wrap { CHECK(NSThread.isMainThread); return wrap.path; }
+ (void)GetPathOfAppDataByUserName:(NSString *)chat andMessageWrap:(CMessageWrap *)wrap retStrPath:(NSString * __autoreleasing *)path { CHECK([chat isEqualToString:@"chat"]); *path=wrap.path; }
- (BOOL)IsFileMsg { return _file; }
+ (BOOL)IsRecordOrNoteMsg:(CMessageWrap *)wrap { return wrap.record; }
@end
@interface TestWrongPayloadExtension : NSObject
@property(nonatomic, copy) NSString *m_uiVoiceTime;
@end
@implementation TestWrongPayloadExtension
@end
@interface TestWrongForwardTarget : CMessageWrap
@end
@implementation TestWrongForwardTarget
- (id)forwardingTargetForSelector:(SEL)selector { (void)selector; return [TestPayloadExtension new]; }
@end
@interface TestUnrelatedForwarder : NSObject
@property(nonatomic, strong) TestPayloadExtension *m_extendInfoWithMsgType;
@end
@implementation TestUnrelatedForwarder
- (id)forwardingTargetForSelector:(SEL)selector { (void)selector; return _m_extendInfoWithMsgType; }
@end
@interface TestImageInfo : NSObject <NSCopying>
@property(nonatomic, copy) NSString *assetId;
@end
@implementation TestImageInfo
- (id)copyWithZone:(NSZone *)zone { (void)zone; TestImageInfo *copy=[TestImageInfo new]; copy.assetId=_assetId; return copy; }
@end
@interface CaptureVideoInfo : NSObject
@property(nonatomic) BOOL m_bForward;
@property(nonatomic, copy) NSString *m_nsSpecifiedChatName;
@end
@implementation CaptureVideoInfo
@end
static NSMutableArray *factoryInputs;
@interface ForwardMsgUtil : NSObject
@end
@implementation ForwardMsgUtil
+ (id)imgMsgFromMsgWrap:(CMessageWrap *)source { [factoryInputs addObject:source]; CHECK(source.m_uiMesLocalID==42); [(TestImageInfo *)source.m_oImageInfo setAssetId:@"factory-owned"]; return [source copy]; }
+ (id)cardMsgFromMsgWrap:(CMessageWrap *)source { [factoryInputs addObject:source]; return [source copy]; }
+ (id)appMsgFromMsgWrap:(CMessageWrap *)source { [factoryInputs addObject:source]; CHECK(source.m_uiMesLocalID==42); return [source copy]; }
+ (id)GenForwardVideoFromMsgWrap:(CMessageWrap *)source { [factoryInputs addObject:source]; CHECK(!source.m_dicForwardParas[@"CaptureVideoInfo"]); CaptureVideoInfo *video=[CaptureVideoInfo new]; video.m_nsSpecifiedChatName=@"incorrect-recipient"; return video; }
@end
@interface MMMenuItem : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) id target;
@property(nonatomic) SEL action;
@property(nonatomic, strong) id iconImage;
@property(nonatomic) NSInteger linePosition,menuType;
@end
@implementation MMMenuItem
- (instancetype)initWithTitle:(NSString *)title icon:(id)icon target:(id)target action:(SEL)action { if ((self=[super init])) { _title=title; _iconImage=icon; _target=target; _action=action; } return self; }
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action { return [self initWithTitle:title icon:nil target:target action:action]; }
@end
@interface TestCell : NSObject
@property(nonatomic, strong) CMessageWrap *wrap;
@property(nonatomic) BOOL revokeAllowed;
@property(nonatomic, copy) void (^forwardHandler)(void);
- (id)getCurrentMessageWrap;
@end
@implementation TestCell
- (id)getCurrentMessageWrap { return _wrap; }
- (BOOL)canShowRevokeMsgMenuItemForMessage:(id)wrap { CHECK(wrap==_wrap); return _revokeAllowed; }
- (void)onForward:(id)sender { (void)sender; if (_forwardHandler) _forwardHandler(); }
- (void)doFavorite {}
@end
@interface TestController : NSObject
@property(nonatomic, strong) NSMutableArray *calls;
@property(nonatomic, copy) void (^confirmation)(void);
@property(nonatomic) BOOL textThrows;
@property(nonatomic, strong) id m_logicController;
@end
@implementation TestController
- (instancetype)init { if ((self=[super init])) _calls=[NSMutableArray array]; return self; }
- (void)SendTextMessage:(id)text { [_calls addObject:@[@"text",text]]; if (_textThrows) [NSException raise:@"after-text" format:@"injected after side effect"]; }
- (void)SendTextMessage:(id)text externInfo:(id)extra { (void)extra; [_calls addObject:@[@"alternate",text]]; }
- (void)deleteNode:(id)wrap withDB:(BOOL)withDB animated:(BOOL)animated { CHECK(withDB==YES && animated==YES); [_calls addObject:@[@"delete",wrap]]; }
- (void)revokeMsgByNodeView:(id)wrap { [_calls addObject:@[@"revoke",wrap]]; }
- (void)cs_confirmMessageAction:(void (^)(void))confirmation { _confirmation=confirmation; }
- (void)startReplyWithMessageWrap:(id)wrap { [_calls addObject:@[@"quote",wrap]]; }
@end
@interface TestUploader : NSObject
@property(nonatomic, strong) NSMutableArray *calls;
@property(nonatomic) BOOL throws;
@end
@implementation TestUploader
- (instancetype)init { if ((self=[super init])) _calls=[NSMutableArray array]; return self; }
- (void)ResendVoiceMsg:(NSString *)chat MsgWrap:(id)wrap { [_calls addObject:@[chat,wrap]]; if (_throws) [NSException raise:@"after-upload" format:@"injected"]; }
@end
@interface TestAudio : NSObject
@property(nonatomic, strong) TestUploader *uploader;
@property(nonatomic) NSUInteger unsafeCalls;
@end
@implementation TestAudio
- (id)uploaderForMsgWrap:(id)wrap { CHECK(CSMessageNativeUnsigned(wrap,@"m_uiMesLocalID")==0); return _uploader; }
- (void)ResendVoiceMsg:(id)chat MsgWrap:(id)wrap { (void)chat; (void)wrap; _unsafeCalls++; }
@end
@interface TestManager : NSObject
@property(nonatomic, strong) NSMutableArray *calls;
@property(nonatomic) BOOL insertThrows;
@end
@implementation TestManager
- (instancetype)init { if ((self=[super init])) _calls=[NSMutableArray array]; return self; }
- (void)AddLocalMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap { CHECK(wrap.m_uiMesLocalID==0); [_calls addObject:@[@"insert",chat,wrap]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+100; if (_insertThrows) [NSException raise:@"after-insert" format:@"injected"]; }
- (void)AddMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap { [_calls addObject:@[@"add",chat,wrap]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+200; }
- (void)AddEmoticonMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap { [_calls addObject:@[@"emoji",chat,wrap]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+300; }
- (id)AddVideoMsg:(NSString *)from ToUsr:(NSString *)to VideoInfo:(CaptureVideoInfo *)video MsgType:(unsigned int)type { CHECK(type==43 && [from isEqual:@"me"] && [to isEqual:video.m_nsSpecifiedChatName] && video.m_bForward); [_calls addObject:@[@"video",to,video]]; CMessageWrap *output=[[CMessageWrap alloc] initWithMsgType:type]; output.m_uiMesLocalID=(unsigned)_calls.count+400; output.m_nsToUsr=to; return output; }
- (void)AddAppMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap Data:(NSData *)data Scene:(unsigned int)scene { CHECK(scene==1 && wrap.m_uiMesLocalID==0); [_calls addObject:@[@"app-data",chat,wrap,data ?: NSNull.null]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+500; }
- (void)AddAppMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap DataPath:(NSString *)path Scene:(unsigned int)scene { CHECK(scene==1 && wrap.m_uiMesLocalID==0); [_calls addObject:@[@"app-path",chat,wrap,path]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+600; }
- (void)AddRecordMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap { CHECK(wrap.m_uiMesLocalID==0); [_calls addObject:@[@"record",chat,wrap]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+700; }
@end
@interface TestEnvironment : NSObject <CSMessageActionEnvironment>
@property(nonatomic, copy) NSString *account;
@property(nonatomic, strong) NSMutableDictionary *services;
@property(nonatomic, weak) TestController *controller;
@end
@implementation TestEnvironment
- (instancetype)init { if ((self=[super init])) { _account=@"me"; _services=[NSMutableDictionary dictionary]; } return self; }
- (NSString *)currentAccountID { return _account; }
- (id)serviceNamed:(NSString *)name { return _services[name]; }
- (id)controllerForCell:(id)cell { (void)cell; return _controller; }
@end
@interface TestContact : NSObject
@property(nonatomic, copy) NSString *m_nsUsrName;
@end
@implementation TestContact
@end
static TestContact *Contact(NSString *name) { TestContact *contact=[TestContact new]; contact.m_nsUsrName=name; return contact; }
@interface TestLogic : NSObject
@property(nonatomic, copy) NSArray *targets;
@end
@implementation TestLogic
- (id)getToContacts { return _targets; }
@end
@interface HeldMedia : CSMessageMediaProvider
@property(nonatomic, strong) NSMutableDictionary *callbacks;
@end
@implementation HeldMedia
- (instancetype)init { if ((self=[super init])) _callbacks=[NSMutableDictionary dictionary]; return self; }
- (void)prepareVoiceForContext:(CSMessageActionContext *)context operationID:(NSString *)identifier completion:(void (^)(CSMessageVoiceResource *))completion { (void)context; _callbacks[identifier]=[completion copy]; }
// Preserve cancelled callbacks to inject genuinely late native completion events.
- (void)cancelOperationID:(NSString *)identifier { (void)identifier; }
- (void)finish:(NSString *)identifier { void (^callback)(CSMessageVoiceResource *)=_callbacks[identifier]; if (callback) callback([[CSMessageVoiceResource alloc] initWithData:[@"audio" dataUsingEncoding:NSUTF8StringEncoding] durationMilliseconds:1234 format:0]); }
@end
@interface RecordingSender : CSMessageSendAdapter
@property(nonatomic, strong) NSMutableArray *calls;
@end
@implementation RecordingSender
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment { if ((self=[super initWithEnvironment:environment])) _calls=[NSMutableArray array]; return self; }
- (CSMessagePreparedSend *)prepareContext:(CSMessageActionContext *)context targetID:(NSString *)target voice:(CSMessageVoiceResource *)voice { (void)context; CHECK(voice.durationMilliseconds==1234); return [[CSMessagePreparedSend alloc] initWithWrap:nil routeName:@"host-test-native-boundary" submission:^{ [self.calls addObject:target]; return [target isEqualToString:@"A"] ? CSMessageActionSubmissionStateAccepted : CSMessageActionSubmissionStateFailedBeforeAcceptance; }]; }
@end
static TestCell *Cell(unsigned int type) { TestCell *cell=[TestCell new]; cell.wrap=[[CMessageWrap alloc] initWithMsgType:type]; cell.wrap.m_nsFromUsr=@"chat"; cell.wrap.m_nsToUsr=@"me"; cell.wrap.m_uiMesLocalID=42; cell.wrap.m_n64MesSvrID=900; cell.wrap.m_nsContent=@"Unicode 你好\nline 2"; return cell; }
static CSMessageActionContext *Context(TestCell *cell,TestController *controller) { return [CSMessageActionContext contextWithCell:cell controller:controller accountID:@"me" accountEpoch:1 conversationID:@"chat" bindingGeneration:1]; }
static CSMessageActionPreferences *Preferences(NSUserDefaults *defaults) { [defaults setBool:YES forKey:CSMessageActionGestureEnabledKey]; [defaults setBool:YES forKey:CSMessageActionRepeatEnabledKey]; [defaults setBool:YES forKey:CSMessageActionVoiceForwardEnabledKey]; return [[CSMessageActionPreferences alloc] initWithDefaults:defaults]; }
static void TestNativeBoundary(void) {
    TestController *controller=[TestController new]; TestCell *cell=Cell(1); CSMessageActionContext *context=Context(cell,controller); CHECK(context);
    CHECK(CSMessageNativeSupports(controller,@"deleteNode:withDB:animated:",@"v",(@[@"@",@"B",@"B"])));
    CHECK(!CSMessageNativeSupports(controller,@"deleteNode:withDB:animated:",@"v",(@[@"@",@"@",@"@"])));
    CSMessageNativeInvoke(controller,@"deleteNode:withDB:animated:",@[cell.wrap,@YES,@YES]); CHECK(controller.calls.count==1);
    CMessageWrap *forwarded=Cell(34).wrap;
    CHECK(!class_getInstanceMethod(CMessageWrap.class,@selector(m_uiVoiceTime)));
    CHECK(!CSMessageActionObjectGetter(forwarded,@selector(m_dtVoice))); // Core context boundary stays concrete-only.
    CHECK(CSMessageNativeSupports(forwarded,@"setM_uiVoiceTime:",@"v",(@[@"I"])));
    CHECK(!CSMessageNativeSupports(forwarded,@"setM_uiVoiceTime:",@"v",(@[@"@"])));
    CHECK(CSMessageNativeSet(forwarded,@"setM_uiVoiceTime:",@1234,YES)); CHECK(forwarded.m_uiVoiceTime==1234);
    CHECK(CSMessageNativeUnsigned(forwarded,@"m_uiVoiceTime")==1234);
    NSData *payload=[@"forwarded-audio" dataUsingEncoding:NSUTF8StringEncoding]; forwarded.m_dtVoice=payload;
    CHECK([CSMessageActionNativeObject(forwarded,@"m_dtVoice") isEqual:payload]);
    CHECK(!CSMessageActionNativeObject(forwarded,@"m_uiVoiceTime"));
    CHECK(!CSMessageNativeSupports([[TestWrongForwardTarget alloc] initWithMsgType:34],@"m_dtVoice",@"@",@[]));
    TestUnrelatedForwarder *unrelated=[TestUnrelatedForwarder new]; unrelated.m_extendInfoWithMsgType=[TestPayloadExtension new];
    CHECK(!CSMessageNativeSupports(unrelated,@"m_dtVoice",@"@",@[]));
    forwarded.m_extendInfoWithMsgType=(TestPayloadExtension *)[TestWrongPayloadExtension new];
    CHECK(!CSMessageNativeSupports(forwarded,@"m_uiVoiceTime",@"I",@[])); CHECK(!CSMessageNativeUnsigned(forwarded,@"m_uiVoiceTime"));
    CSMessageNativeActionAdapter *adapter=[CSMessageNativeActionAdapter new]; __block BOOL valid=YES; __block NSInteger state=-99;
    [adapter performAction:CSMessageActionDelete context:context valid:^BOOL{ return valid; } completion:^(CSMessageActionSubmissionState result){ state=result; }];
    CHECK(controller.confirmation); valid=NO; controller.confirmation(); CHECK(state==CSMessageActionSubmissionStateCancelled); CHECK(controller.calls.count==1);
    TestCell *outgoing=Cell(1); outgoing.wrap.m_nsFromUsr=@"me"; outgoing.wrap.m_nsToUsr=@"chat"; outgoing.revokeAllowed=YES; CSMessageActionContext *sent=Context(outgoing,controller); CHECK([adapter canPerformAction:CSMessageActionRevoke context:sent]);
    valid=YES; [adapter performAction:CSMessageActionRevoke context:sent valid:^BOOL{ return valid; } completion:^(CSMessageActionSubmissionState result){state=result;}];
    outgoing.revokeAllowed=NO; controller.confirmation(); CHECK(controller.calls.count==1); CHECK(state==CSMessageActionSubmissionStateCancelled);
}
static void TestSendRoutes(void) {
    TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller; TestCell *cell=Cell(1); CSMessageSendAdapter *sender=[[CSMessageSendAdapter alloc] initWithEnvironment:env];
    controller.textThrows=YES; CSMessagePreparedSend *text=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(text); CHECK([text submit]==CSMessageActionSubmissionStateUnknown); CHECK(controller.calls.count==1); CHECK([text submit]==CSMessageActionSubmissionStateUnknown); CHECK(controller.calls.count==1); CHECK([controller.calls[0][0] isEqual:@"text"]);
    TestManager *manager=[TestManager new]; TestUploader *uploader=[TestUploader new]; TestAudio *audio=[TestAudio new]; audio.uploader=uploader; env.services[@"CMessageMgr"]=manager; env.services[@"AudioSender"]=audio;
    cell=Cell(34); CSMessageActionContext *context=Context(cell,controller); CSMessageVoiceResource *voice=[[CSMessageVoiceResource alloc] initWithData:[@"audio" dataUsingEncoding:NSUTF8StringEncoding] durationMilliseconds:1234 format:0];
    CSMessagePreparedSend *a=[sender prepareContext:context targetID:@"A" voice:voice], *b=[sender prepareContext:context targetID:@"B" voice:voice]; CHECK(a && b); CHECK(a.outputWrap!=b.outputWrap && a.outputWrap!=cell.wrap); CHECK(CSMessageNativeUnsigned(a.outputWrap,@"m_uiVoiceTime")==1234); CHECK(CSMessageNativeUnsigned(a.outputWrap,@"m_uiVoiceFormat")==0);
    CHECK([a submit]==CSMessageActionSubmissionStateUnknown); CHECK([b submit]==CSMessageActionSubmissionStateUnknown); CHECK(manager.calls.count==2 && uploader.calls.count==2 && !audio.unsafeCalls); CHECK(cell.wrap.m_uiMesLocalID==42 && cell.wrap.m_n64MesSvrID==900 && [cell.wrap.m_nsFromUsr isEqual:@"chat"] && [cell.wrap.m_nsToUsr isEqual:@"me"]);
    manager.insertThrows=YES; CSMessagePreparedSend *c=[sender prepareContext:context targetID:@"C" voice:voice]; CHECK([c submit]==CSMessageActionSubmissionStateUnknown); CHECK(manager.calls.count==3 && uploader.calls.count==2 && !audio.unsafeCalls);
    manager.insertThrows=NO; uploader.throws=YES; CSMessagePreparedSend *d=[sender prepareContext:context targetID:@"D" voice:voice]; CHECK([d submit]==CSMessageActionSubmissionStateUnknown); CHECK(manager.calls.count==4 && uploader.calls.count==3);
    cell=Cell(48); CSMessagePreparedSend *location=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(location); [location submit]; CHECK([manager.calls.lastObject[0] isEqual:@"add"]); CHECK(cell.wrap.m_uiMesLocalID==42);
    cell=Cell(47); cell.wrap.m_nsContent=@"<emoji md5=\"0123456789abcdef0123456789abcdef\"/>"; CSMessagePreparedSend *emoji=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(emoji); [emoji submit]; CHECK([manager.calls.lastObject[0] isEqual:@"emoji"]); CHECK([[[(CMessageWrap *)emoji.outputWrap m_nsEmoticonMD5] description] isEqual:@"0123456789abcdef0123456789abcdef"]);
}
static void TestOrdinaryPayloadRoutes(void) {
    factoryInputs=[NSMutableArray array]; TestEnvironment *env=[TestEnvironment new]; TestManager *manager=[TestManager new]; env.services[@"CMessageMgr"]=manager; TestController *controller=[TestController new]; env.controller=controller;
    CSMessageSendAdapter *sender=[[CSMessageSendAdapter alloc] initWithEnvironment:env];
    TestCell *cell=Cell(3); TestImageInfo *info=[TestImageInfo new]; info.assetId=@"historical-asset"; cell.wrap.m_oImageInfo=info;
    CSMessagePreparedSend *image=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil];
    CHECK(image && factoryInputs.lastObject!=cell.wrap); CHECK([info.assetId isEqual:@"historical-asset"]); CHECK(image.outputWrap!=cell.wrap); CHECK(CSMessageNativeUnsigned(image.outputWrap,@"m_uiMesLocalID")==0 && CSMessageNativeUnsigned(image.outputWrap,@"m_n64MesSvrID")==0); [image submit]; CHECK([manager.calls.lastObject[0] isEqual:@"add"]); CHECK(cell.wrap.m_uiMesLocalID==42 && [info.assetId isEqual:@"historical-asset"]);
    cell=Cell(42); CSMessagePreparedSend *card=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(card && card.outputWrap!=cell.wrap); [card submit]; CHECK([manager.calls.lastObject[0] isEqual:@"add"]);
    cell=Cell(43); CaptureVideoInfo *cached=[CaptureVideoInfo new]; cached.m_nsSpecifiedChatName=@"historical-target"; cell.wrap.m_dicForwardParas=[@{@"CaptureVideoInfo":cached} mutableCopy];
    CSMessagePreparedSend *video=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(video); CHECK(cell.wrap.m_dicForwardParas[@"CaptureVideoInfo"]==cached && [cached.m_nsSpecifiedChatName isEqual:@"historical-target"] && !cached.m_bForward); [video submit]; CHECK([manager.calls.lastObject[0] isEqual:@"video"]); CHECK(video.outputWrap && video.outputWrap!=cell.wrap); CHECK([CSMessageActionObjectGetter(video.outputWrap,NSSelectorFromString(@"m_nsToUsr")) isEqual:@"chat"]);
    cell=Cell(49); cell.wrap.record=YES; CSMessagePreparedSend *record=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(record); [record submit]; CHECK([manager.calls.lastObject[0] isEqual:@"record"]);
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]; NSData *data=[@"attachment-data" dataUsingEncoding:NSUTF8StringEncoding]; CHECK([data writeToFile:path atomically:YES]); cell=Cell(49); cell.wrap.file=YES; cell.wrap.path=path; CSMessageActionContext *fileContext=Context(cell,controller);
    __block NSUInteger reads=0; CSMessageMediaProvider *provider=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){ CHECK(!NSThread.isMainThread); reads++; return [NSData dataWithContentsOfFile:file]; }];
    __block BOOL fileReady=NO; __block NSString *preparedPath=nil;
    [provider prepareAppDataForContext:fileContext operationID:@"file" completion:^(NSData *bytes,NSString *resolved){ CHECK(!bytes && [resolved isEqual:path]); preparedPath=resolved; fileReady=YES; }]; CHECK(!fileReady); CHECK(Wait(^BOOL{ return fileReady; })); CHECK(!reads);
    CSMessagePreparedSend *file=[sender prepareContext:fileContext targetID:@"chat" voice:nil appData:nil appDataPath:preparedPath]; CHECK(file); [file submit]; CHECK([manager.calls.lastObject[0] isEqual:@"app-path"] && [manager.calls.lastObject[3] isEqual:path]); CHECK([NSFileManager.defaultManager fileExistsAtPath:path] && cell.wrap.m_uiMesLocalID==42);
    cell.wrap.file=NO; cell.wrap.m_uiAppDataSize=(unsigned)data.length; __block NSData *preparedData=nil; __block BOOL dataReady=NO;
    [provider prepareAppDataForContext:fileContext operationID:@"data" completion:^(NSData *bytes,NSString *resolved){ CHECK([resolved isEqual:path]); preparedData=bytes; dataReady=YES; }]; CHECK(Wait(^BOOL{ return dataReady; })); CHECK(reads==1 && [preparedData isEqual:data]);
    CSMessagePreparedSend *app=[sender prepareContext:fileContext targetID:@"chat" voice:nil appData:preparedData appDataPath:path]; CHECK(app); [app submit]; CHECK([manager.calls.lastObject[0] isEqual:@"app-data"] && [manager.calls.lastObject[3] isEqual:data]); CHECK(cell.wrap.m_uiMesLocalID==42);
    cell.wrap.m_uiAppDataSize=99; CHECK(![sender prepareContext:fileContext targetID:@"chat" voice:nil appData:nil appDataPath:nil]);
    cell.wrap.m_nsAppAttachID=@"remote-attachment"; CHECK([sender prepareContext:fileContext targetID:@"chat" voice:nil appData:nil appDataPath:nil]);
    cell=Cell(987); CSMessagePreparedSend *generic=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(generic && generic.outputWrap!=cell.wrap); CHECK([CSMessageActionObjectGetter(generic.outputWrap,NSSelectorFromString(@"m_nsContent")) isEqual:cell.wrap.m_nsContent]); [generic submit]; CHECK([manager.calls.lastObject[0] isEqual:@"add"] && cell.wrap.m_uiMesLocalID==42);
    [NSFileManager.defaultManager removeItemAtPath:path error:nil]; factoryInputs=nil;
}
static void TestMenuSnapshots(NSUserDefaults *defaults) {
    TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller;
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:Preferences(defaults) mediaProvider:[CSMessageMediaProvider new]];
    coordinator.feedbackHandler=^(__unused NSString *message){};
    CSMessageActionMenuAdapter *menu=[[CSMessageActionMenuAdapter alloc] initWithCoordinator:coordinator]; TestCell *cell=Cell(1);
    NSObject *hostItem=[NSObject new]; NSArray *items=[menu itemsByAddingActionsForCell:cell items:@[hostItem]]; CHECK(items.count==2 && items[0]==hostItem); MMMenuItem *repeat=items.lastObject; CHECK([repeat.title isEqual:@"复读"]); CHECK([menu canPerformSelector:repeat.action cell:cell]); CHECK([menu itemsByAddingActionsForCell:cell items:items].count==2);
    // Retain old item, rebuild a menu on a reused cell, then click OLD target. The production target
    // owns its original snapshot and must not send either the replacement or historical message.
    cell.wrap=Cell(1).wrap; cell.wrap.m_uiMesLocalID=123; cell.wrap.m_n64MesSvrID=456; [menu itemsByAddingActionsForCell:cell items:@[]];
    CSMessageNativeInvoke(repeat.target,NSStringFromSelector(repeat.action),@[NSNull.null]); Drain(); CHECK(!controller.calls.count);
    TestCell *voice=Cell(34); NSArray *voiceItems=[menu itemsByAddingActionsForCell:voice items:@[]]; CHECK(voiceItems.count==2); CHECK([((MMMenuItem *)voiceItems[0]).title isEqual:@"语音转发"] && [((MMMenuItem *)voiceItems[1]).title isEqual:@"复读"]);
    TestCell *card=Cell(42); CHECK([menu itemsByAddingActionsForCell:card items:@[]].count==0); CHECK([coordinator canExecuteContext:[coordinator captureContextForCell:card controller:controller bindingGeneration:1] action:CSMessageActionRepeat entry:CSMessageActionEntryGesture]);
}
static void TestCoordinator(NSUserDefaults *defaults) {
    TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller;
    HeldMedia *media=[HeldMedia new]; RecordingSender *sender=[[RecordingSender alloc] initWithEnvironment:env]; CSMessageActionPreferences *preferences=Preferences(defaults);
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:preferences mediaProvider:media sendAdapter:sender nativeAdapter:[CSMessageNativeActionAdapter new]];
    NSMutableArray *feedback=[NSMutableArray array]; coordinator.feedbackHandler=^(NSString *message){ [feedback addObject:message]; };
    TestCell *cell=Cell(34); CSMessageActionContext *context=[coordinator captureContextForCell:cell controller:controller bindingGeneration:7]; CHECK(context);
    TestLogic *logicA=[TestLogic new],*logicB=[TestLogic new]; logicA.targets=@[Contact(@"A"),Contact(@"B"),Contact(@"A")]; logicB.targets=@[Contact(@"Z")];
    [coordinator withForwardContext:context entry:CSMessageActionEntryNativeForward perform:^{ [coordinator bindForwardLogic:logicA source:cell.wrap]; }];
    CSMessageForwardBinding *binding=[[CSVoiceForwardAdapter new] bindingForLogic:logicA]; NSString *identifier=binding.operationID; CHECK(identifier.length);
    [coordinator confirmForwardLogic:logicA]; CHECK([coordinator resultsForOperationID:identifier].count==2);
    CHECK(![coordinator handleForwardLogic:logicB source:cell.wrap target:logicB.targets[0]]); CHECK(!sender.calls.count);
    CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"Z")]); CHECK(!sender.calls.count);
    CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"A")]); CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"B")]);
    [media finish:identifier]; CHECK(sender.calls.count==2); NSDictionary *results=[coordinator resultsForOperationID:identifier]; CHECK([results[@"A"] integerValue]==CSMessageActionSubmissionStateAccepted && [results[@"B"] integerValue]==CSMessageActionSubmissionStateFailedBeforeAcceptance);
    CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"A")]); [media finish:identifier]; CHECK(sender.calls.count==2); CHECK(feedback.count==1); [coordinator finishForwardLogic:logicA cancelled:NO]; CHECK([[CSVoiceForwardAdapter new] bindingForLogic:logicA].closed); CHECK(![[CSVoiceForwardAdapter new] bindingForLogic:logicA].context); CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"A")]); CHECK(sender.calls.count==2); CHECK([coordinator resultsForOperationID:identifier].count==2);
    // Opening through the public facade and binding native logic share one operation ID.
    TestLogic *facadeLogic=[TestLogic new]; facadeLogic.targets=@[Contact(@"A")];
    __weak TestCell *weakCell=cell; __weak CSMessageActionCoordinator *weakCoordinator=coordinator;
    cell.forwardHandler=^{ [weakCoordinator bindForwardLogic:facadeLogic source:weakCell.wrap]; };
    NSString *facadeID=[coordinator executeContext:context action:CSMessageActionForward entry:CSMessageActionEntryGesture];
    CHECK([facadeID isEqual:[[CSVoiceForwardAdapter new] bindingForLogic:facadeLogic].operationID]);
    [coordinator finishForwardLogic:facadeLogic cancelled:YES]; [media finish:facadeID]; CHECK(sender.calls.count==2); cell.forwardHandler=nil;
    TestCell *different=Cell(34); different.wrap.m_uiMesLocalID=555; different.wrap.m_n64MesSvrID=9999;
    CHECK(![coordinator handleForwardLogic:logicA source:different.wrap target:Contact(@"A")]);
    // Cancel before media readiness, then inject the retained late callback. No submit.
    NSString *cancelled=[coordinator executeContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryGesture]; CHECK(cancelled); [coordinator cancelOperationID:cancelled]; [media finish:cancelled]; CHECK(sender.calls.count==2); CHECK([[coordinator resultsForOperationID:cancelled][@"chat"] integerValue]==CSMessageActionSubmissionStateCancelled);
    NSString *oldAccount=[coordinator executeContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryGesture]; CHECK(oldAccount); env.account=@"other"; [coordinator accountDidChange]; [media finish:oldAccount]; CHECK(sender.calls.count==2); CHECK(![coordinator validateContext:context]); env.account=@"me"; [coordinator accountDidChange]; CHECK(![coordinator validateContext:context]);
    [coordinator accountWillChange]; CHECK(![coordinator captureContextForCell:cell controller:controller bindingGeneration:8]); CHECK(![coordinator validateContext:context]);
    [coordinator accountDidChange];
    context=[coordinator captureContextForCell:cell controller:controller bindingGeneration:8]; TestLogic *disabled=[TestLogic new]; disabled.targets=@[Contact(@"A")];
    [coordinator withForwardContext:context entry:CSMessageActionEntryNativeForward perform:^{ [coordinator bindForwardLogic:disabled source:cell.wrap]; }];
    NSString *disabledID=[[CSVoiceForwardAdapter new] bindingForLogic:disabled].operationID; [coordinator confirmForwardLogic:disabled]; [defaults setBool:NO forKey:CSMessageActionVoiceForwardEnabledKey]; [preferences requestRefresh]; CHECK(Wait(^BOOL{ return !coordinator.settings.voiceForwardEnabled; }));
    [media finish:disabledID]; CHECK(sender.calls.count==2); CHECK([coordinator handleForwardLogic:disabled source:cell.wrap target:Contact(@"A")]); [coordinator finishForwardLogic:disabled cancelled:YES]; CHECK([[CSVoiceForwardAdapter new] bindingForLogic:disabled].closed); CHECK(![[CSVoiceForwardAdapter new] bindingForLogic:disabled].context);
    // Weak page lifetime is not extended by a captured source context.
    __weak TestController *weakController=nil; CSMessageActionContext *weakContext=nil;
    @autoreleasepool { TestController *temporary=[TestController new]; weakController=temporary; weakContext=[coordinator captureContextForCell:cell controller:temporary bindingGeneration:9]; }
    CHECK(!weakController && !weakContext.controller); CHECK(![coordinator validateContext:weakContext]);
    // A stale cell binding is rejected before native confirmation.
    cell.wrap=Cell(34).wrap; cell.wrap.m_uiMesLocalID=99; cell.wrap.m_n64MesSvrID=999; CHECK(![coordinator validateContext:context]);
}
static void TestMedia(void) {
    TestCell *cell=Cell(34); TestController *controller=[TestController new]; cell.wrap.m_uiVoiceTime=1234; cell.wrap.m_uiVoiceFormat=0; cell.wrap.m_uiDownloadStatus=0;
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]; NSData *audio=[@"audio" dataUsingEncoding:NSUTF8StringEncoding]; CHECK([audio writeToFile:path atomically:YES]); cell.wrap.path=path; cell.wrap.m_nsContent=@"<voicemsg voicelength=\"1234\" voiceformat=\"0\" length=\"5\"/>";
    __block NSUInteger reads=0,downloads=0,callbacks=0; CSMessageMediaProvider *provider=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){ CHECK(!NSThread.isMainThread); reads++; return [NSData dataWithContentsOfFile:file]; }];
    provider.requestDownload=^(CSMessageActionContext *context){ CHECK(context.sourceWrap==cell.wrap); downloads++; };
    CSMessageActionContext *context=Context(cell,controller);
    [provider prepareVoiceForContext:context operationID:@"one" completion:^(CSMessageVoiceResource *resource){ CHECK(resource.durationMilliseconds==1234 && resource.format==0 && resource.data.length==5); callbacks++; }];
    [provider prepareVoiceForContext:context operationID:@"two" completion:^(__unused CSMessageVoiceResource *resource){ callbacks++; }]; CHECK(downloads==1 && reads==0);
    [provider cancelOperationID:@"two"];
    [provider downloadCompletedForAccount:@"other" epoch:1 chat:@"chat" localID:42 serverID:900]; Drain(); CHECK(!callbacks);
    [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"wrong" localID:42 serverID:900]; Drain(); CHECK(!callbacks);
    [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"chat" localID:42 serverID:900]; CHECK(Wait(^BOOL{ return callbacks==1; })); CHECK(reads==1);
    [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"chat" localID:42 serverID:900]; Drain(); CHECK(callbacks==1);
    // Native status without full byte evidence does not accept a partial file.
    cell.wrap.m_uiDownloadStatus=1; cell.wrap.m_nsContent=@"<voicemsg voicelength=\"1234\" voiceformat=\"0\" length=\"500\"/>"; __block BOOL partialAccepted=NO;
    [provider prepareVoiceForContext:context operationID:@"partial" completion:^(CSMessageVoiceResource *resource){ partialAccepted=resource!=nil; }]; CHECK(Wait(^BOOL{ return downloads==2; })); CHECK(!partialAccepted); [provider cancelOperationID:@"partial"];
    // Cancel during an actual off-main read: released operation receives no late completion.
    dispatch_semaphore_t entered=dispatch_semaphore_create(0), release=dispatch_semaphore_create(0);
    CSMessageMediaProvider *racing=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){ dispatch_semaphore_signal(entered); dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC)); return [NSData dataWithContentsOfFile:file]; }];
    cell.wrap.m_uiDownloadStatus=1; cell.wrap.m_nsContent=@"<voicemsg voicelength=\"1234\" voiceformat=\"0\" length=\"5\"/>";
    __block NSUInteger cancelledCallbacks=0;
    [racing prepareVoiceForContext:context operationID:@"racing" completion:^(__unused CSMessageVoiceResource *resource){ cancelledCallbacks++; }];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0); [racing cancelOperationID:@"racing"]; dispatch_semaphore_signal(release); Drain(); Drain(); CHECK(!cancelledCallbacks);
    // Checked native out-object ABI resolves the historical app path before identity reset.
    CHECK([CSMessageNativeAppDataPath(context) isEqual:path]);
    [NSFileManager.defaultManager removeItemAtPath:path error:nil];
}
static void TestVoiceFlags(void) {
    TestCell *cell=Cell(34); TestController *controller=[TestController new]; CSMessageActionContext *context=Context(cell,controller);
    cell.wrap.m_uiDownloadStatus=1; cell.wrap.m_uiVoiceTime=1234; cell.wrap.m_uiVoiceFormat=0; cell.wrap.m_dtVoice=[@"audio" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]; CHECK([cell.wrap.m_dtVoice writeToFile:path atomically:YES]); cell.wrap.path=path;
    for (NSUInteger scenario=0;scenario<3;scenario++) {
        // Otherwise complete bytes must not defeat endflag0 or cancelflag1.
        cell.wrap.m_nsContent=scenario!=1 ? @"<voicemsg voicelength='1234' voiceformat='0' length='5' endflag='0' cancelflag='0'/>" : @"<voicemsg voicelength='1234' voiceformat='0' length='5' endflag='1' cancelflag='1'/>";
        CSMessageMediaProvider *provider=[CSMessageMediaProvider new]; __block NSUInteger downloads=0,callbacks=0; __block BOOL accepted=NO;
        provider.requestDownload=^(__unused CSMessageActionContext *source){ downloads++; };
        [provider prepareVoiceForContext:context operationID:@"flags" completion:^(CSMessageVoiceResource *resource){ callbacks++; accepted=resource!=nil; }];
        CHECK(Wait(^BOOL{ return callbacks || downloads; })); CHECK(!accepted);
        if (scenario==0) { CHECK(downloads==1 && !callbacks); [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"chat" localID:42 serverID:900]; CHECK(Wait(^BOOL{ return callbacks==1; })); CHECK(accepted); }
        else { if (scenario==2) cell.wrap.m_nsContent=@"<voicemsg voicelength='1234' voiceformat='0' length='5' endflag='0' cancelflag='1'/>"; [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"chat" localID:42 serverID:900]; Drain(); CHECK(callbacks==1 && !accepted); CHECK(downloads==(scenario==2 ? 1 : 0)); }
    }
    // Flags can change while bytes are being read; acceptance must use fresh metadata.
    cell.wrap.m_dtVoice=nil;
    dispatch_semaphore_t entered=dispatch_semaphore_create(0),release=dispatch_semaphore_create(0);
    CSMessageMediaProvider *racing=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){ dispatch_semaphore_signal(entered); dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC)); return [NSData dataWithContentsOfFile:file]; }];
    cell.wrap.m_nsContent=@"<voicemsg voicelength='1234' voiceformat='0' length='5' endflag='1'/>"; __block NSUInteger callbacks=0; __block BOOL accepted=NO;
    [racing prepareVoiceForContext:context operationID:@"metadata-race" completion:^(CSMessageVoiceResource *resource){ callbacks++; accepted=resource!=nil; }];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    cell.wrap.m_nsContent=@"<voicemsg voicelength='1234' voiceformat='0' length='5' endflag='1' cancelflag='1'/>"; dispatch_semaphore_signal(release);
    CHECK(Wait(^BOOL{ return callbacks==1; })); CHECK(!accepted); [NSFileManager.defaultManager removeItemAtPath:path error:nil];
}
int main(void) { @autoreleasepool { NSString *suite=[@"CSMessageActionExecutionTests." stringByAppendingString:NSUUID.UUID.UUIDString]; NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite]; if (getenv("CS_TEST_VOICE_FLAGS_ONLY")) { TestVoiceFlags(); return 0; } TestNativeBoundary(); TestSendRoutes(); TestOrdinaryPayloadRoutes(); TestMenuSnapshots(defaults); TestCoordinator(defaults); TestMedia(); TestVoiceFlags(); [defaults removePersistentDomainForName:suite]; printf("PASS: %lu production action/coordinator/native/media checks (host doubles, no native sends)\n",(unsigned long)checks); } return 0; }
